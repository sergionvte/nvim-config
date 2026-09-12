# Mi configuración de Neovim

Config personal de Neovim armada sobre [lazy.nvim](https://github.com/folke/lazy.nvim)
(gestor de plugins) y [coc.nvim](https://github.com/neoclide/coc.nvim) (LSP,
autocompletado, formateo, snippets). Funciona en macOS, Linux y Windows.

## Instalación en una máquina nueva

Ver [scripts/README.md](scripts/README.md) — hay un script para macOS
(probado de punta a punta) y uno para Windows. Instalan todo lo necesario,
clonan este repo y dejan los plugins listos.

Dentro de Neovim, en cualquier momento:

```
:CheckTools
```

Te dice, lenguaje por lenguaje, si falta algún compilador/LSP/formateador.
Silencioso si está todo instalado; si abrís un archivo de un lenguaje al que
le falta algo, te avisa una sola vez (no en cada archivo).

## Estructura de archivos

```
init.lua                    Punto de entrada. Bootstrap de lazy.nvim, config
                             de plugins que deben leerse ANTES de que carguen
                             (ver "Un gotcha recurrente" abajo), y el orden en
                             que se cargan editor.vim/plugins.vim/lua/*.
editor.vim                   Opciones y atajos "core", no ligados a un plugin
                             específico (movimiento, edición, indentación).
plugins.vim                   Config en VimScript de los plugins que no tienen
                             su propio módulo en lua/plugins/.
coc-settings.json            Config de coc.nvim (LSP, formateo, diagnósticos).
lua/plugins/spec.lua          La lista de plugins que instala lazy.nvim.
lua/plugins/<nombre>.lua      Config en Lua de un plugin puntual.
lua/config/<nombre>.lua       Utilidades propias, sin plugin externo detrás
                             (autoguardado, chequeo de herramientas, correr
                             el archivo actual, rutas portables para coc).
UltiSnips/*.snippets          Snippets propios (formato UltiSnips), además de
                             los que ya trae honza/vim-snippets.
scripts/                     Scripts para preparar una máquina nueva.
graphify-out/, .opencode/     Metadata de herramientas de IA (no versionada,
                             ver .gitignore) — no forman parte de la config.
```

## Lenguajes soportados

| Lenguaje         | Resaltado (treesitter) | LSP (coc)                          | Formateo              | Ejecutar (Ctrl+Enter) |
|------------------|:----------------------:|-------------------------------------|------------------------|:---------------------:|
| Python           | ✓                       | coc-pyright                         | black                  | `python3`/`python`    |
| JS/TS/JSX/TSX    | ✓                       | coc-tsserver, coc-eslint, coc-tailwindcss | prettier, eslint | `node`                |
| Java             | ✓                       | coc-java (Eclipse JDT)               | integrado              | `java`                |
| Go               | ✓                       | coc-go (gopls)                       | integrado (gopls)      | `go run`              |
| Kotlin           | ✓                       | coc-kotlin (kotlin-language-server)  | integrado              | `kotlinc` + `java -jar`|
| C/C++            | —                       | coc-clangd                          | integrado (clangd)     | —                      |
| HTML/CSS/JSON    | ✓                       | coc-html, coc-css, coc-json          | prettier               | —                      |

`coc-clangd` descarga su propio `clangd` la primera vez que hace falta (o usa
el del sistema, p. ej. el de Xcode Command Line Tools en macOS) — no hace
falta instalar nada aparte para C/C++.

## Atajos principales

Leader = `\`.

**Multicursor** (estilo VSCode, vía vim-visual-multi):
- `Alt+J` / `Alt+K` — agregar cursor en la línea de abajo/arriba
- `Alt+D` — agregar cursor en la siguiente coincidencia de la palabra/selección
- `c` (con cursores activos) — reemplazar el texto en todos a la vez
- `x`/`d` — borrar en todos a la vez
- `Ctrl+X` — saltar la coincidencia actual
- `Esc` — salir del modo multicursor

**Mover líneas/bloques**: `Alt+Shift+J` / `Alt+Shift+K` (abajo/arriba).

**Envolver selección** (vim-surround, sin pasar por `S`): en modo visual,
selecciona texto y escribe directo `"`, `'`, `(`, `)`, `{`, `}`, `[` o `]`.
Los de apertura agregan espacio interno (`( texto )`), los de cierre no
(`(texto)`).

**Archivo/buffers**:
- `Ctrl+N` / `Ctrl+B` — abrir/cerrar el árbol de archivos
- `Ctrl+K` — buscar archivos (fzf)
- `Ctrl+J` — buscar texto en el proyecto (Ag)
- `Enter` (en normal) — lista de buffers abiertos
- `Tab` / `Shift+Tab` — siguiente/anterior buffer
- `Ctrl+X` / `\x` — cerrar el buffer actual

**Comentarios**: `Ctrl+C` (normal o visual) — toggle de comentario.

**Ejecutar el archivo actual**: `Ctrl+Enter` (corre y cierra el split al
salir) / `Ctrl+Alt+Enter` (deja el split abierto). Ver
[lua/config/run_file.lua](lua/config/run_file.lua).

**Capturas de código** (CodeSnap, estilo polacode): selecciona en visual y
`\cs` copia la imagen al portapapeles, `\cS` la guarda en
`~/Pictures/CodeSnap/`. Sin marca de agua, fondo transparente, con ligaduras
de FiraCode y la paleta de colores One Dark Pro.

**Formateo y autoguardado**:
- Guardar manualmente (`:w`) limpia espacios al final de línea y formatea
  con el LSP correspondiente.
- El autoguardado (2s de inactividad) es silencioso a propósito — guarda con
  `:noautocmd write`, sin tocar formato ni espacios, para no interrumpirte a
  mitad de una línea. Ver [lua/plugins/autosave.lua](lua/plugins/autosave.lua).
- `\f` — activar/desactivar el formateo al guardar.

**Otros**: `\\` recarga toda la config sin reiniciar Neovim · `\h` muestra/
oculta inlay hints · `Ctrl+F` (flash.nvim) salta a cualquier parte visible
de la pantalla escribiendo 1-2 letras.

## Apariencia

Tema **One Dark Pro** (`onedark.nvim`, estilo `darker`, fondo transparente).
Paréntesis/llaves/corchetes coloreados por nivel de anidación
(rainbow-delimiters.nvim, mismos colores de la paleta). Iconos vía
`nvim-web-devicons` — necesita una Nerd Font instalada en la terminal
(FiraCode Nerd Font en macOS, ver `scripts/setup-macos.sh`).

## Un gotcha recurrente: orden de carga

Varios plugins de VimScript (`vim-visual-multi`, `nerdcommenter`) leen su
configuración (`g:VM_maps`, `g:NERDCreateDefaultMappings`, etc.) **una sola
vez, al cargar**, no cada vez que Neovim arranca de nuevo esa variable.
`coc.nvim` (`g:coc_user_config`) también entra en esta categoría.

Si esa configuración vive en `editor.vim` o `plugins.vim` — que se cargan
recién *después* de `require('lazy').setup(...)` en `init.lua` — llega
demasiado tarde: el plugin ya leyó el valor por defecto y no vuelve a mirar
la variable después. El síntoma es sutil porque no tira error, simplemente
el plugin se comporta como si nunca hubieras puesto esa configuración.

**Regla práctica**: si agregás un plugin nuevo y necesitás configurarlo con
una variable global (`g:algo`) *antes* de que arranque, ponla en `init.lua`,
arriba de la llamada a `require('lazy').setup(...)`, no en `editor.vim` ni
`plugins.vim`. Si tenés dudas sobre si un plugin lee su config así, probá
cambiar el valor y confirmá con un test real (no alcanza con que no tire
error) — esto costó bastante tiempo de debugging más de una vez.

## Multiplataforma

Nada en esta config asume macOS: las rutas de LSPs (`gopls`,
`kotlin-language-server`, JDK) se resuelven vía `$PATH`/variables de entorno
en tiempo de arranque ([lua/config/coc_portable.lua](lua/config/coc_portable.lua)),
no están fijas a `/opt/homebrew/...`. Ídem para `python3` vs `python`, y las
rutas temporales (usa `stdpath('cache')`, no `/tmp`).
