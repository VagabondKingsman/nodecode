# Nodecode on boxes.dev

Run Nodecode on a [boxes.dev](https://boxes.dev/) Template box (and every
devbox that starts from its snapshot).

## What goes where

| Piece | Where |
| --- | --- |
| Binary | `~/.local/share/nodecode/current` → `~/.local/bin/nodecode` |
| Home (sessions, keys, cells) | `~/.nodecode/` |
| boxes.dev CLI on your laptop | `npm i -g @boxes-dev/cli` → `dvb` |
| On-box snapshot command | `dvb-onbox snapshot` (Template only) |

Do **not** install the workstation `dvb` CLI inside a boxes.dev machine.
Agents already on a box use `dvb-onbox`.

## Path A — Create from GitHub (fastest for this repo)

1. Sign in at https://boxes.dev/ → **Create from GitHub**.
2. Connect GitHub and select `VagabondKingsman/nodecode` (or your fork).
3. Pick a box size (4 vCPU / 8 GiB is enough for Nodecode alone). Create the project.
4. Open the Template box terminal (`dvb connect` from your laptop, or the app).
5. Run:

```sh
bash tools/boxes/setup-nodecode.sh --cells --serve
```

6. Authenticate (pick one):

```sh
nodecode login
# opens a URL — sign in at nodecode.ai and allow the machine
```

or put a provider key in **Project settings → Environment files** (preferred
over pasting into chat):

```sh
export ANTHROPIC_API_KEY=…   # or OPENAI_API_KEY / GOOGLE_API_KEY
```

7. Interactive UI needs a TTY:

```sh
nodecode
```

Headless (no TTY / keep running):

```sh
nodecode serve
```

8. Snapshot the Template so new threads inherit the install:

```sh
dvb-onbox snapshot
```

9. Optional — paste `tools/boxes/startup-snippet.sh` into
   **Project settings → Devbox lifecycle → Startup script** so every new
   box reinstalls the binary if it is missing.

## Path B — Local agent setup (ports your laptop env)

On your own computer (not inside a boxes.dev machine), copy the prompt from
boxes.dev Get started / New project:

```text
Install the boxes.dev CLI with `npm i -g @boxes-dev/cli`, then set up this
project on boxes.dev by running `dvb agent-init --login-code <code>` and
following its instructions. Run these commands yourself and ask for my
approval when needed.
```

Paste that into Claude Code / Codex in this repo. After the Template is up,
run Path A steps 5–8 on the Template.

## Cloud quirks

| Situation | What to do |
| --- | --- |
| No systemd user manager (`gateway unavailable`) | Use `nodecode serve` instead of `nodecode gateway on` |
| `nodecode` exits code 2 without a TTY | `nodecode serve` or `ssh -t` / an app terminal |
| Provider list empty in setup | Install `ca-certificates`, restart |
| Want browser UI | `nodecode add nc://web --yes`, then `nodecode web` (keep the `#t=` token private) |

## Script flags

```sh
bash tools/boxes/setup-nodecode.sh            # install + PATH
bash tools/boxes/setup-nodecode.sh --cells     # + web, websearch, guard
bash tools/boxes/setup-nodecode.sh --serve     # + background nodecode serve
bash tools/boxes/setup-nodecode.sh --cells --serve
```

## Verify

```sh
nodecode --version
nodecode gateway status    # or confirm serve is listening
pgrep -af 'nodecode serve'
```

## Giữ box khỏi tự đi ngủ

boxes.dev cho box ngủ khi không còn ai nhìn terminal (ví dụ điện thoại đã tắt app), và một task đang
chạy sẽ đứng giữa chừng. Cách chặn là **giữ** box bằng API của chính boxes.dev, tự gia hạn:

```sh
cp tools/boxes/keep-awake.sh tools/boxes/resume-heal.sh ~/.local/bin/
cp tools/boxes/systemd/box-keepawake.* tools/boxes/systemd/box-resume-heal.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now box-keepawake.timer box-resume-heal.service
```

- `box-keepawake.timer` chạy mỗi 10 phút: nếu chưa có hold đủ dài thì đặt hold 30 phút (`KEEPAWAKE_FOR`).
  Một hold tối đa 4 giờ, nên phải gia hạn; timer có `Persistent=true` nên lần bị lỡ sẽ chạy bù sau khi tỉnh.
- Cùng nhịp đó, `resume-heal.sh` kiểm OSA và gateway còn sống, hỏng thì dựng lại — để box tỉnh dậy là
  mọi thứ chạy tiếp, không phải chờ ai bấm.
- Cả hai unit dịch vụ đều `Restart=always` và `enabled` ở `default.target`: box bị *dừng* thì chúng tự lên lại.

Kiểm: `dvb-onbox devboxes keep-awake get` (cần `BOXES_CLIENT_THREAD_ID`, script tự giữ một id trong
`~/.nodecode/box-keepawake/thread-id`), log ở `~/.nodecode/box-keepawake/log`. Tắt hẳn:
`systemctl --user disable --now box-keepawake.timer` rồi `dvb-onbox devboxes keep-awake cancel --id <id>`.

Lưu ý: giữ box **tốn box-hours** theo cỡ máy; API có lúc trả `service_unavailable` (tạm thời) — script
ghi log rồi thử lại ở nhịp sau, nên đừng coi một lần hỏng là đã tắt.
