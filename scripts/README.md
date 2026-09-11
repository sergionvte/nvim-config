# Setup scripts

Preparan una máquina nueva para usar esta config de Neovim: instalan las
herramientas que necesitan los lenguajes configurados (Python, JS/TS, Java,
Go, Kotlin, C/C++), clonan esta config, e instalan los plugins/extensiones.
Se pueden correr de nuevo sin problema.

## macOS

```bash
curl -fsSL https://raw.githubusercontent.com/sergionvte/nvim-config/main/scripts/setup-macos.sh | bash
```

O clonando primero:

```bash
git clone https://github.com/sergionvte/nvim-config.git ~/.config/nvim
bash ~/.config/nvim/scripts/setup-macos.sh
```

Probado de punta a punta.

## Windows

Desde PowerShell:

```powershell
git clone https://github.com/sergionvte/nvim-config.git "$env:LOCALAPPDATA\nvim"
& "$env:LOCALAPPDATA\nvim\scripts\setup-windows.ps1"
```

Este no se pudo probar en una máquina Windows real — si algo falla, avisá
para ajustarlo. Después de correrlo, abrí Neovim y ejecutá `:CheckTools`
para confirmar qué quedó pendiente.

## Después de cualquiera de los dos

Dentro de Neovim:

```
:CheckTools
```

Te dice, por lenguaje, si falta algo. Silencioso si está todo instalado.
