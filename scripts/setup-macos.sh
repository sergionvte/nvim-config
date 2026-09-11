#!/usr/bin/env bash
# Prepara un Mac desde cero para usar esta config de Neovim: instala
# Homebrew (si falta), todas las herramientas que necesitan los lenguajes
# configurados, clona esta config en ~/.config/nvim si no está ya ahí, y
# deja Neovim con los plugins/extensiones instalados. Se puede correr de
# nuevo sin problema (todos los pasos son idempotentes).
set -euo pipefail

REPO_URL="https://github.com/sergionvte/nvim-config.git"
CONFIG_DIR="$HOME/.config/nvim"

info()  { printf '\033[1;34m==>\033[0m %s\n' "$1"; }
warn()  { printf '\033[1;33m!!\033[0m %s\n' "$1"; }

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Este script es para macOS. Para Windows usá scripts/setup-windows.ps1." >&2
  exit 1
fi

# 1. Xcode Command Line Tools (git, make, clang — Homebrew y treesitter los necesitan)
if ! xcode-select -p >/dev/null 2>&1; then
  info "Instalando Xcode Command Line Tools (te va a pedir confirmar en una ventana)..."
  xcode-select --install
  echo "Volvé a correr este script cuando termine esa instalación." >&2
  exit 1
fi

# 2. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  info "Instalando Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$('/opt/homebrew/bin/brew' shellenv 2>/dev/null || '/usr/local/bin/brew' shellenv)"
fi

# 3. Herramientas: Neovim + lo que pide cada lenguaje configurado
info "Instalando Neovim y herramientas de lenguaje vía Homebrew..."
brew install \
  neovim \
  git \
  node \
  yarn \
  fzf \
  the_silver_searcher \
  ripgrep \
  go \
  kotlin \
  kotlin-language-server \
  ccls \
  openjdk@21

# gopls no es un paquete de Homebrew separado del todo — lo instala coc-go
# solo la primera vez si hace falta, pero tenerlo también por Homebrew evita
# esa espera y lo deja disponible fuera de Neovim.
brew install gopls || true

# Java (openjdk vía Homebrew no se enlaza a /opt/homebrew/bin por defecto)
JAVA_PREFIX="$(brew --prefix openjdk@21)"
if [[ -d "$JAVA_PREFIX/bin" ]] && ! command -v java >/dev/null 2>&1; then
  warn "openjdk@21 no está en tu PATH. Agregá esta línea a tu ~/.zshrc:"
  echo "  export PATH=\"$JAVA_PREFIX/bin:\$PATH\""
fi

# 4. Fuente Nerd Font (para los iconos de nvim-tree/bufferline/lualine)
info "Instalando FiraCode Nerd Font..."
brew install --cask font-fira-code-nerd-font || true

# 5. pynvim (host de Python3 para Neovim)
if command -v python3 >/dev/null 2>&1; then
  info "Instalando pynvim..."
  python3 -m pip install --user --quiet pynvim || warn "No se pudo instalar pynvim automáticamente, instalalo con: python3 -m pip install --user pynvim"
fi

# 6. Esta config
if [[ -d "$CONFIG_DIR/.git" ]]; then
  info "Ya existe una config en $CONFIG_DIR, no la toco."
elif [[ -e "$CONFIG_DIR" ]]; then
  warn "$CONFIG_DIR existe pero no es un repo git — muévelo o borralo y volvé a correr este script."
  exit 1
else
  info "Clonando la config en $CONFIG_DIR..."
  git clone "$REPO_URL" "$CONFIG_DIR"
fi

# 7. Instalar plugins de Neovim (lazy.nvim) y extensiones de coc.nvim
info "Instalando plugins de Neovim (puede tardar unos minutos)..."
nvim --headless "+Lazy! sync" +qall

info "Listo. Abrí nvim y corré :CheckTools para confirmar que no falte nada:"
echo "  nvim +CheckTools"
