#!/usr/bin/env sh
# Instalador de ccx. Copia el repo a ~/.ccx y deja 'ccx' en ~/.ccx/bin.
# Uso:   sh install.sh        (o CCX_PREFIX=/ruta sh install.sh)
set -eu

PREFIX="${CCX_PREFIX:-$HOME/.ccx}"
SRC=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

mkdir -p "$PREFIX/bin" "$PREFIX/templates"
cp "$SRC/bin/ccx" "$PREFIX/bin/ccx"
chmod +x "$PREFIX/bin/ccx"
if [ -d "$SRC/templates" ]; then
  cp "$SRC/templates/"* "$PREFIX/templates/" 2>/dev/null || true
fi

printf '\033[32m\342\234\223\033[0m ccx instalado en %s\n' "$PREFIX"

case ":$PATH:" in
  *":$PREFIX/bin:"*)
    printf 'El PATH ya incluye %s/bin. Listo: escribe "ccx help".\n' "$PREFIX" ;;
  *)
    printf '\nAñade esto a tu ~/.bashrc o ~/.zshrc y reabre la terminal:\n'
    printf '\n  export PATH="%s/bin:$PATH"\n\n' "$PREFIX"
    printf 'Luego comprueba con: ccx help\n' ;;
esac
