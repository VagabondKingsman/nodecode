#!/bin/bash
# Dựng lại image đã đóng băng. Dùng: ./restore.sh [HOME_ĐÍCH]   (mặc định: /tmp/restored)
set -eu
D=$(cd "$(dirname "$0")" && pwd)
HOME2=${1:-/tmp/restored}
[ -f "$D/SHA256SUMS" ] && ( cd "$D" && sha256sum -c SHA256SUMS ) && echo "checksums OK"
mkdir -p "$HOME2"
tar xzf "$D/home-portable.tar.gz" -C "$HOME2"          # config + layer + cells(+git)
[ -f "$D/home-rest.tar.gz" ] && tar xzf "$D/home-rest.tar.gz" -C "$HOME2"   # context, hub, generations, secrets
[ -d "$D/store" ] && { mkdir -p "$HOME2/.nodecode"; cp -a "$D/store/." "$HOME2/.nodecode/"; }
[ -f "$D/heap-snapshot.tar.gz" ] && tar xzf "$D/heap-snapshot.tar.gz" -C "$HOME2/.nodecode/snapshots"
echo "home dựng tại $HOME2"
echo "khởi động lại:  NODECODE_HOME=$HOME2/.nodecode \\"
echo "                 $D/release-98dd6dc80/nodecode serve --store $HOME2/.nodecode/history.db"
echo "hoặc mở shell:  NODECODE_HOME=$HOME2/.nodecode $D/release-98dd6dc80/nodecode"
