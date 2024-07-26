#!/bin/bash
set -e

if [ ! -f disk.img ]; then
    fallocate -l 200M disk.img
    sfdisk disk.img <<EOF
label: gpt
label-id: BBDC7FF2-9902-4CA5-94D1-93DA773FE2E2
device: disk.img
unit: sectors
first-lba: 2048
last-lba: 409566
sector-size: 512

disk.img1 : start=        2048, size=      405504, type=9E1A2D38-C612-4316-AA26-8B49521E5A8B, uuid=C9F0415A-90E4-43F3-98B1-70A62DF3619C
EOF
fi

cargo +nightly build --release --target powerpc-unknown-linux-gnu
dd if=target/powerpc-unknown-linux-gnu/release/openfirmware-basic-entry of=disk.img bs=512 seek=2048 conv=notrunc

qemu-system-ppc64 -M pseries -m 512 --drive file=disk.img
