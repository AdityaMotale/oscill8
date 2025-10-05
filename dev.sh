#!/usr/bin/env bash

SRC="main.asm"
OBJ="oscill8.o"
EXE="oscill8"

# ---
# Nasm
# ---

echo "[+] Assembling $SRC -> $OBJ"
nasm -f elf64 -Ox -g "$SRC" -o "$OBJ"

if [ $? -ne 0 ]; then
    echo "[-] nasm error (＞﹏＜)"
    exit 1
fi

# ---
# ld (linking)
# ---

echo "[+] Linking $OBJ -> $EXE"
ld -o "$EXE" "$OBJ" --relax

if [ $? -ne 0 ]; then
    echo "[-] ld error (≧ ﹏ ≦)"
    exit 2
fi

# ---
# Oscill8
# ---

echo "[+] Running $EXE with args: $*"
./"$EXE" "$@"

EXIT_CODE=$?

# ---
# Handling errors
# ---

case $EXIT_CODE in
    0)
        echo ""
        ;;
    10)
        echo "[🫤] Invalid input!"
        ;;
    *)
        echo "[💀] Unknown error! exit code: $EXIT_CODE"
        ;;
esac
