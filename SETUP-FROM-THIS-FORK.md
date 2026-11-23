# Dựng lại đúng con nodecode đang chạy ở đây, trên một VPS mới

Tài liệu này tái tạo **bản cài đặt đang chạy trên box `boxes`** (2026-11-23): nodecode `0.1.16+c78fef6`, 35 cell, 428 tệp ký ức + skill, cấu hình và gateway chạy nền.

Đọc kèm `snapshots/2026-11-23/` — đó là phần "linh hồn" (ký ức, skill, cấu hình đã che khoá) lấy từ chính máy này.

> **Repo này đang là private.** Mọi lệnh `git clone` bên dưới cần token GitHub. Bản thân nodecode và các cell cài từ hub **không** phụ thuộc repo này — chỉ nhánh B (build từ source của fork) mới cần.

---

## 0. VPS cần gì

| Thứ | Yêu cầu |
|---|---|
| Máy | Linux x86_64 (amd64). arm64 chưa được hỗ trợ cho bản dump này |
| RAM | 8 GB nếu **build** từ source (dump SBCL cần heap 8 GB); 2 GB là đủ nếu chỉ **chạy** bản phát hành |
| Quyền | user thường, không cần root; systemd **user** session (có `loginctl`) |
| Gói | `git`, `curl`, `tar`, `python3`, `bash` |
| Mạng ra ngoài | `nodecode.ai`, `github.com`, `api.nodecode.ai`, và API của provider bạn dùng |

```sh
sudo apt-get update && sudo apt-get install -y git curl tar python3 ca-certificates
loginctl enable-linger "$USER"      # để gateway sống tiếp sau khi SSH thoát
```

---

## 1. Cài nodecode — chọn một trong hai nhánh

### Nhánh A (khuyến nghị): bản phát hành chính thức

`install.sh` cài bản phát hành mới nhất của **kênh bạn theo** (box này để `update.channel = "nightly"`, `update.mode = "off"`, và đang chạy `c78fef6`; bản stable mới nhất là tag `v0.1.16`, 13/11). Bản này đủ để dựng một home y như vậy; nếu muốn **đúng từng byte** `c78fef6` thì sau khi cài:

```sh
nodecode update c78fef6     # ghim đúng commit; bỏ qua nếu bản cài đã là nó
```

```sh
curl -fsSL https://nodecode.ai/install.sh | env -u NODECODE_HOME sh
export PATH="$HOME/.local/bin:$PATH"     # script tự thêm vào ~/.bashrc và ~/.profile
nodecode --version                       # phải in: nodecode 0.1.16+c78fef6
```

### Nhánh B: build từ source của fork (khi cần commit riêng của fork, ví dụ `box/free-lane`)

Toolchain cài hết trong `~/.local`, không cần root. **SBCL phải đúng 2.6.0** — 2.3.8/2.4/2.6.10 đều chết ở bước load với lỗi thiếu symbol (`SOCKOPT-ERROR`, `CLOCK-MONOTONIC`, `UNIX-IOCTL`).

```sh
mkdir -p ~/.local && cd ~/.local
curl -fsSL -o sbcl.tgz 'https://sourceforge.net/projects/sbcl/files/sbcl/2.6.0/sbcl-2.6.0-x86-64-linux-binary.tar.bz2/download' \
  && tar xf sbcl.tgz && bash sbcl-2.6.0-x86-64-linux-binary/install.sh --prefix=$HOME/.local
curl -fsSL -o quicklisp.lisp https://beta.quicklisp.org/quicklisp.lisp
sbcl --non-interactive --load quicklisp.lisp \
     --eval '(quicklisp-quickstart:install :path (merge-pathnames "quicklisp/" (user-homedir-pathname)))'
# just: tải binary tĩnh của casey/just vào ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"
```

Clone (private → cần token; tạo PAT scope `repo` rồi):

```sh
git clone https://VagabondKingsman:<TOKEN>@github.com/VagabondKingsman/nodecode.git
cd nodecode
# nếu clone không kèm token, gắn credential helper đọc một tệp 0600:
#   git config --global --add credential.https://github.com.helper ''
#   git config --global --add credential.https://github.com.helper '!f() { echo username=x-access-token; echo password=$(cat $HOME/.nodecode/gh-token); }; f'

just release     # tự pull các cell shipped (từ nodecode-ai/cells, pin trong cells/bundle.json) rồi dump ./nodecode
./nodecode --version
```

Đặt bản vừa build vào chỗ mà unit và `current` đang trỏ tới:

```sh
H=$(git rev-parse --short=9 HEAD)
D=~/.local/share/nodecode/$H
mkdir -p "$D" && cp ./nodecode "$D/" && cp -r src "$D/" && chmod 700 "$D/nodecode"
ln -sfn "$H" ~/.local/share/nodecode/current
~/.local/share/nodecode/current/nodecode --version
```

`~/.local/share/nodecode/<hash>/` chứa đúng hai thứ: `nodecode` (binary) và `src`; `current` là symlink sang bản đang dùng. Muốn quay lại: `ln -sfn <hash-cũ> ~/.local/share/nodecode/current` rồi restart gateway.

**Lưu ý:** bản đặt tay như trên thì `nodecode update` trả lời *"no installer travels with this build, so it cannot stage a release"* — cập nhật bằng cách `git pull && just release` rồi lặp lại ba lệnh trên (đúng cách box này đang làm).

---

## 2. Khôi phục home `~/.nodecode`

### 2.1 Cấu hình

```sh
cp snapshots/2026-11-23/config.redacted.jsonc ~/.nodecode/config.jsonc
```

Rồi điền lại chỗ đã che. Trên máy này cấu hình có 4 provider; khoá **không** nằm trong config mà ở `~/.nodecode/auth.json` (hoặc biến môi trường):

```jsonc
// ~/.nodecode/auth.json  (chmod 600)
{ "api_keys": {
    "nodecode":        { "key": "…" },   // lấy bằng: nodecode login
    "nodecode-free":  { "key": "…" },   // cùng một khoá free lane
    "experientiallabs":{ "key": "…" },
    "opencodex":       { "key": "…" }    // provider tự dựng trên tailnet, xem §4
} }
```

Cách khác: biến môi trường `<ID>_API_KEY` (ví dụ `EXPERIENTIALLABS_API_KEY`), hoặc `nodecode secrets split` — tách mỗi khoá ra `~/.nodecode/secrets/providers.<id>.api_key` (0600) và để `auth.json` lại phần đăng nhập; `nodecode secrets list` liệt kê tên tệp, không in giá trị.

Các mục **phải sửa theo máy mới** trong config:

- `prs.token_file` → đường dẫn tới GitHub token của bạn (`"$HOME/.nodecode/gh-token"`), tệp 0600, PAT scope `repo`.
- `rea.pwntools-python` → đường dẫn venv python có `pwntools` (xem §4), hoặc bỏ mục `rea` nếu không dùng cell `rea`.
- `general.default_model` / `auxiliary_model` / `failover.chain` → giữ nguyên nếu bạn có cùng provider; nếu không, đổi sang provider bạn có.

### 2.2 Cell — ba loại, ba cách

Trạng thái thật trên box này (`~/.nodecode/cells`, 35 cell):

**(a) 18 cell "shipped"** — đi kèm bản phát hành, nguồn là `nodecode-ai/cells` ở commit pin trong `cells/bundle.json`; `just release` (hoặc chính `install.sh`) đã đặt chúng. Không phải làm gì:

```
board channel-discord channel-kit channel-slack channel-telegram chrome context cron
cyber-security experience goal guard link mcp prs qa team web websearch
```

**(b) 13 cell lấy từ hub** — cài bằng một lệnh, tên không cần tiền tố `nodecode-`:

```sh
for c in undo pstack rea tinyfish heartbeat live-time ports telemetry toolaria tool-break doc-markdown subagents google-antigravity; do
  nodecode add "nc://$c" --yes
done
```

(`subagents` đến từ `drvova/nodecode-subagents`, 12 cái còn lại từ `nodecode-ai/cells`; `nodecode add` in ra repo + commit trước khi cài.)

**(c) 4 cell local, không có trên hub** — chép thư mục nguyên văn từ máy cũ:

```
antigravity            cell nhỏ, giữ 1 ký ức về Antigravity + .asd
cursor-agent           cell do lần import Cursor sinh ra (59 tệp .lisp)
cursor-agent-memory    cell tri thức: toàn bộ ký ức + skill  ← xem §2.3
nodecode               cell một ký ức (free-lane-fence-loses-the-form)
```

### 2.3 Ký ức và skill

Đây là phần làm nên "con" này. Mỗi ký ức/skill là một tệp `.lisp`, chỉ mục đọc tệp nên chép vào là **lượt sau** đã thấy:

```sh
D=~/.nodecode/cells/cursor-agent-memory
mkdir -p "$D"
cp snapshots/2026-11-23/memory/*.lisp "$D/"
cp snapshots/2026-11-23/memory-cell.asd "$D/cursor-agent-memory.asd"
```

Tên cell phải khớp tên trong `.asd` (`defsystem "cursor-agent-memory"`). Nếu bạn muốn đặt tên theo máy (`<tên-máy>-memory`), sửa cả hai chỗ.

### 2.4 Gateway chạy nền

```sh
nodecode gateway on          # tạo ~/.config/systemd/user/nodecode-gateway.service và bật ở mọi lần login
nodecode gateway status      # phải nói đang serving, đúng build
nodecode gateway logs -f     # khi cần soi
```

Unit do nodecode tự sinh, dạng:

```ini
[Service]
ExecStart="/…/~/.local/share/nodecode/current/nodecode" gateway run
Environment="NODECODE_HOME=/home/<user>/.nodecode"
Restart=always
```

Muốn chạy không cần systemd (container, VPS không có user session): `nohup nodecode serve >~/.nodecode/serve.log 2>&1 &`.

---

## 3. Kiểm tra đã đủ chưa

```sh
nodecode --version                                  # nodecode 0.1.16+c78fef6
nodecode gateway status                             # serving, đúng build
ls ~/.nodecode/cells | wc -l                        # 35
ls ~/.nodecode/cells/cursor-agent-memory/*.lisp | wc -l   # 428
```

Rồi mở một phiên (`nodecode`) và:

- `(help)` — phải thấy các verb của các cell vừa cài (ports, prs, rea, tinyfish, pstack, subagents, toolaria…).
- `(index "osa")` — phải thấy ký ức cũ hiện ra: chứng minh cell tri thức đã vào chỉ mục.
- hỏi một câu ngắn để chắc model trả lời được (provider + khoá đúng).

---

## 4. Những thứ riêng của box này — sửa hay bỏ khi dựng máy mới

| Thứ | Trên box này | Trên VPS mới |
|---|---|---|
| `~/.nodecode/cells/nodecode-*` | **symlink** vào `/home/boxes/nodecode/cells/…` (để sửa cell là ăn ngay vào bản đang chạy) | không cần; bản phát hành tự dùng cell shipped. Muốn y như cũ: clone fork về **đúng path** rồi symlink lại |
| provider `opencodex` | `http://100.112.118.106:10100/v1` — IP tailnet của một máy khác | đổi sang endpoint của bạn, hoặc xoá provider + đổi default_model |
| `rea.pwntools-python` | `/home/boxes/.local/venvs/rea/bin/python` | `python3 -m venv ~/.local/venvs/rea && ~/.local/venvs/rea/bin/pip install pwntools` |
| cell `chrome` | dùng Chrome profile `~/.nodecode/chrome-profile` (đăng nhập sẵn) | cần Chrome/Chromium trên máy; đăng nhập lại |
| `gh-token` | PAT của GitHub, đọc bởi `prs` cell và credential helper | tạo PAT mới, `chmod 600 ~/.nodecode/gh-token` |
| keep-awake / watchdog | hai unit `systemd --user` riêng của box boxes.dev (`box-keepawake`, `box-watchdog`) | bỏ, trừ khi VPS cũng tự ngủ |
| `~/.nodecode/history.db` | 327 MB lịch sử hội thoại | không chép (không nằm trong git); muốn giữ thì `scp` riêng |
| node trong `PATH` của unit | `/home/boxes/.local/bin:/opt/devbox-tools/bin:…` | nodecode ghi PATH hiện tại lúc `gateway on`; kiểm lại trong unit nếu thiếu lệnh |

---

## 5. Về sau: cập nhật và sao lưu

- **Cập nhật bản chạy:** `nodecode update` (bản chính thức), hoặc `just release` + đổi symlink `current` + `nodecode gateway restart --force` (bản tự build).
- **Merge upstream vào fork:** `git fetch upstream && git merge upstream/main` trên `main`; các thư mục `snapshots/` không đụng tới `src/` nên merge sạch.
- **Chụp bản mới của home lên fork:** theo đúng cách `snapshots/2026-11-23` được làm ra — xem `snapshots/2026-11-23/manifest.md` và `README.md` cùng thư mục. Bản chất: sinh `memory/`, `cells.txt`, `config.redacted.jsonc`, `version.txt`, rồi commit vào `main`.
- **Bí mật không bao giờ vào git:** `auth.json`, `gh-token`, `secrets/`, `operator-token`, `history.db`, ảnh snapshot nhị phân, `chrome-profile`.
