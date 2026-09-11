#Requires -Version 5.1
<#
Prepara un Windows desde cero para usar esta config de Neovim: instala las
herramientas que necesitan los lenguajes configurados (via winget, y scoop
para lo que winget no tiene bien cubierto), clona esta config en la carpeta
de Neovim si no está ya ahí, y deja los plugins/extensiones instalados.
Se puede correr de nuevo sin problema.

NOTA: a diferencia del script de macOS, este no se pudo probar en una
máquina Windows real. Si algo falla, correlo de nuevo en una terminal nueva
(el PATH de programas recién instalados no siempre se actualiza en la misma
sesión) y después revisá `:CheckTools` dentro de Neovim para ver qué quedó
pendiente.
#>

$ErrorActionPreference = 'Continue'

function Info($msg) { Write-Host "==> $msg" -ForegroundColor Cyan }
function Warn($msg) { Write-Host "!! $msg" -ForegroundColor Yellow }

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Error "winget no está disponible. Instalá 'App Installer' desde la Microsoft Store y volvé a correr este script."
    exit 1
}

$RepoUrl = 'https://github.com/sergionvte/nvim-config.git'
$ConfigDir = Join-Path $env:LOCALAPPDATA 'nvim'

function Install-Winget([string]$Id) {
    Info "Instalando $Id..."
    try {
        winget install --id $Id --silent --accept-source-agreements --accept-package-agreements -e 2>&1 | Out-Null
    } catch {
        Warn "No se pudo instalar $Id automáticamente: $_"
    }
}

# Neovim + herramientas de lenguaje
Install-Winget 'Neovim.Neovim'
Install-Winget 'Git.Git'
Install-Winget 'OpenJS.NodeJS.LTS'
Install-Winget 'GoLang.Go'
Install-Winget 'Python.Python.3.12'
Install-Winget 'EclipseAdoptium.Temurin.21.JDK'
Install-Winget 'JetBrains.Kotlin'
Install-Winget 'BurntSushi.ripgrep.MSVC'
Install-Winget 'junegunn.fzf'

# Scoop: para win32yank (portapapeles), kotlin-language-server y la fuente,
# que no están bien cubiertos en winget.
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Info "Instalando Scoop..."
    try {
        Invoke-Expression (Invoke-RestMethod get.scoop.sh)
    } catch {
        Warn "No se pudo instalar Scoop automáticamente: $_"
    }
}

if (Get-Command scoop -ErrorAction SilentlyContinue) {
    scoop bucket add extras 2>$null | Out-Null
    scoop bucket add nerd-fonts 2>$null | Out-Null

    function Install-Scoop([string]$Name) {
        Info "Instalando $Name (scoop)..."
        try {
            scoop install $Name 2>&1 | Out-Null
        } catch {
            Warn "No se pudo instalar $Name con scoop: $_"
        }
    }

    Install-Scoop 'win32yank'
    Install-Scoop 'kotlin-language-server'
    Install-Scoop 'FiraCode-NF'
    # ccls (C/C++) no tiene un binario mantenido para Windows tan simple como
    # en macOS/Linux — si lo necesitás, puede que tengas que compilarlo vos
    # mismo o usar clangd en su lugar. :CheckTools te va a avisar si falta.
} else {
    Warn "Sin Scoop no puedo instalar win32yank/kotlin-language-server/la fuente automáticamente. Instalá Scoop (scoop.sh) y volvé a correr este script."
}

# Esta config
if (Test-Path (Join-Path $ConfigDir '.git')) {
    Info "Ya existe una config en $ConfigDir, no la toco."
} elseif (Test-Path $ConfigDir) {
    Warn "$ConfigDir existe pero no es un repo git — movelo o borralo y volvé a correr este script."
    exit 1
} else {
    Info "Clonando la config en $ConfigDir..."
    git clone $RepoUrl $ConfigDir
}

# pynvim (host de Python3 para Neovim)
if (Get-Command python -ErrorAction SilentlyContinue) {
    Info "Instalando pynvim..."
    python -m pip install --user --quiet pynvim
}

# Plugins de Neovim (lazy.nvim) y extensiones de coc.nvim
Info "Instalando plugins de Neovim (puede tardar unos minutos)..."
nvim --headless "+Lazy! sync" +qall

Info "Listo. Si `nvim`, `git` u otro comando recién instalado no se reconoce, cerrá y abrí una terminal nueva."
Info "Después, abrí nvim y corré :CheckTools para confirmar que no falte nada:"
Write-Host "  nvim +CheckTools"
