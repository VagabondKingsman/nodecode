;;; build-nodecode-here — define-skill recorded by session experience-s-GKPN8NDI-turn-1U7T51Z-R2J22NY7NF, 2026-11-17T07:52:56Z
(in-package :nodecode.evolved)

(define-skill build-nodecode-here
  "Build and install a local nodecode self-update on this box, without root, and keep the way back."
  ;; when a session must move this home onto source it just changed (upstream pull, a local fix), and no release carries it
  ;; evidence: `just build` failed "Component \"cl+ssl/config\" not found"; then SBCL 2.3.8 read-error "SOCKOPT-ERROR not found in SB-BSD-SOCKETS", 2.4/2.6.10 read-error "CLOCK-MONOTONIC / UNIX-IOCTL not found in SB-UNIX"; with SBCL 2.6.0 plus commit f0b4398 the same command printed "LOADED", `just release` printed "just release complete: ./nodecode", and `./nodecode --version` answered 0.1.16+a3b10f7.
  ;; confidence: high - each step's failure and the working combination are in the log of this turn; the SBCL version is narrow (2.6.0 exactly) and pinned by two missing-symbol errors on other versions.
  ;; toolchain, all inside ~/.local, no sudo: SBCL 2.6.0 binary tarball from sbcl's sourceforge files, `./install.sh --prefix=$HOME/.local`; quicklisp.lisp from beta.quicklisp.org with `(quicklisp-quickstart:install :path "$HOME/quicklisp/")`; `just` static binary into ~/.local/bin.
  ;; export PATH=$HOME/.local/bin:$PATH for every build command, and load quicklisp explicitly: `--load $HOME/quicklisp/setup.lisp` then `(ql:quickload :nodecode)` - the justfile alone cannot resolve cl+ssl.
  ;; build with `just release` (not `just build`): it pulls the cells and dumps ./nodecode.
  ;; install beside the running ones: dir ~/.local/share/nodecode/<git short HEAD>, copy nodecode + src + README.txt into it, chmod 700 the binary, then `ln -sfn <hash> ~/.local/share/nodecode/current`. When HEAD is unchanged the dir already exists: copy it to <hash>.pre-restore, overwrite the binary in place (chmod 700 again) and leave `current` alone - the gateway keeps the old inode until it next starts, which on the same version is no worse than a restart that kills the attached session.
  ;; note the release you came from first (`nodecode update <old-hash>` is the way back and holds there), then restart through the unit: `nodecode gateway restart --force` detached, because a reflection runs inside the gateway it would kill.
  ;; verify from the running surface, never from an exit code: `nodecode --version` and `nodecode gateway status` must both name the new build.
  )
