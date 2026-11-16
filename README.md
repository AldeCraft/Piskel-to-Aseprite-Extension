<div align="center">
<img src="./piskeltoaseprite_500.png" width="200">
  
</div>

# Piskel To Aseprite


<br>

# Piskel Importer for Aseprite

Open and save [Piskel](https://www.piskelapp.com/) (`.piskel`) files directly in
Aseprite: layers, frames, layer opacity, FPS and palette.

Requires **Aseprite 1.3 or newer**. The interface is in **English**; it switches
to **Spanish** only when Aseprite's own language is Spanish
(*Edit > Preferences > General > Language*).

[Versión en español más abajo](#español)

---

## Features

- **Open** `.piskel` files as normal documents (Recent Files, drag and drop,
  command line / "Open with Aseprite"). *File > Open* is **not** modified.
- **Save** with `Ctrl+S` back to the `.piskel`, or *File > Save As* and type a
  name ending in `.piskel`.
- Reads every Piskel format version (model 2, 1 and 0), including layers without
  `chunks` and hidden frames.
- Palette: built from the colors used, or loaded from a `.gpl` file (Piskel does
  not store palettes inside `.piskel` files). When saving it can also write the
  palette as `.gpl` next to the file.

### What is lost when saving to `.piskel`

Piskel has a single FPS (frame durations are averaged), no blend modes, no groups
(they are flattened), no tilemap/reference layers (skipped) and no layer
visibility (hidden layers are saved with opacity 0).

## Build

An Aseprite extension is a ZIP file renamed to `.aseprite-extension`, with
`package.json` and the Lua script at the root. **There is nothing to compile**;
"building" means packaging those two files.

Pick one:

| System | Command |
| --- | --- |
| Any (Python 3.6+) | `python build.py` |
| Windows (PowerShell) | `powershell -ExecutionPolicy Bypass -File build.ps1` |
| Linux / macOS | `./build.sh` (needs `zip`) |

The result is `dist/piskel-to-aseprite-extension.aseprite-extension`.

Manual alternative: select `package.json` and `piskel-to-aseprite-extension.lua`, compress
them into a ZIP (the two files must be at the root of the ZIP, not inside a
folder) and rename it to `piskel-to-aseprite-extension.aseprite-extension`.

## Install

1. Open Aseprite and go to *Edit > Preferences > Extensions > Add Extension*
   (or double-click the `.aseprite-extension` file).
2. Pick `dist/piskel-to-aseprite-extension.aseprite-extension` and restart Aseprite.

### Development install (no packaging)

Copy this folder (with `package.json` and `piskel-to-aseprite-extension.lua`) to the
extensions directory and restart Aseprite after each change:

- Windows: `%APPDATA%\Aseprite\extensions\piskel-to-aseprite-extension\`
- macOS: `~/Library/Application Support/Aseprite/extensions/piskel-to-aseprite-extension/`
- Linux: `~/.config/aseprite/extensions/piskel-to-aseprite-extension/`

Aseprite may ask for file access permission the first time (the script reads
`.piskel` files and writes temporary PNGs to decode/encode layers).

## Usage

- *File > Scripts > Piskel: preferences...* opens the settings: the two optional
  dialogs below, palette on open, hidden frames, and writing a `.gpl` palette
  when saving.
- Two commands have **no menu entry** but can be bound to a shortcut in
  *Edit > Keyboard Shortcuts*: "Import Piskel file (.piskel)..." (with palette
  options) and "Save as Piskel (.piskel)...".
- By default *File > Open* uses Aseprite's native dialog, which cannot list or
  open `.piskel` files. Open them with drag and drop, Recent Files, the command
  line (`aseprite file.piskel`) or the shortcut-only import command above.

### Native dialogs vs. dialogs that list `.piskel`

Aseprite's native file dialogs only list formats built into Aseprite, and a Lua
extension cannot add one or see the name picked there. The only way to show
`*.piskel` in a file picker is a dialog of the extension's own, which means one
extra window (a small window with a file field; the native picker opens from
it). Each dialog can be switched on or off independently in the preferences:

| Setting | Default | Effect |
| --- | --- | --- |
| *File > Open*: extension dialog | off | Lists `.piskel` in the picker (extra window) |
| *File > Save As*: extension dialog | on | Lets you save a `.piskel` from Save As (extra window) |

With *Save As* off you get Aseprite's native dialog (no `.piskel` there); `Ctrl+S`
still writes back to a `.piskel` that was opened from one.

## How it works

`piskel-to-aseprite-extension.lua` is a single script:

| Section | What it does |
| --- | --- |
| Languages | `STR` table (`en`, `es`) and `T(key, ...)`; language read from `app.preferences.general.language` |
| Utilities | Base64 decoder, JSON parser (fallback for `json.decode`), PNG loading through a temp file |
| Import | Piskel model 2/1/0 to an Aseprite sprite (layers, cels, durations, palette) |
| Export | Aseprite sprite to Piskel model 2 (one horizontal spritesheet per layer) |
| Command hook | `app.events:on("beforecommand")` handles `OpenFile`, `SaveFile`, `SaveFileAs` and `SaveFileCopyAs` for `.piskel` paths |

Aseprite's Lua API cannot register new file formats, so `.piskel` support works
by intercepting those commands. `ev.stopPropagation()` is always called at the
end of a handler because nested commands reset Aseprite's cancel flag.

To add a language, add a table to `STR` with the same keys as `en` and extend
`currentLanguage()`.

## Continuous integration

`.github/workflows/build.yml` runs on every push and pull request: it checks the
Lua syntax (`luac5.4 -p`), builds the extension with `build.py`, verifies the
package contents and uploads it as a build artifact. Pushing a tag such as
`v1.4.0` (it must match the `version` in `package.json`) also publishes a GitHub
Release with the `.aseprite-extension` attached:

```
git tag v1.0.0
git push origin v1.0.0
```

## License

MIT, see `LICENSE`. Piskel is a separate project by its own authors; the `.piskel`
format was read from its public source code.

---

# Español

Abre y guarda archivos de [Piskel](https://www.piskelapp.com/) (`.piskel`)
directamente en Aseprite: capas, frames, opacidad de capa, FPS y paleta.

Requiere **Aseprite 1.3 o superior**. La interfaz está en **inglés** y cambia a
**español** solo cuando el idioma de Aseprite es español
(*Edit > Preferences > General > Language*).

## Funciones

- **Abrir** `.piskel` como documentos normales (Recent Files, arrastrar y soltar,
  línea de comandos / "Abrir con Aseprite"). *File > Open* **no** se modifica.
- **Guardar** con `Ctrl+S` sobre el mismo `.piskel`, o *File > Save As*
  escribiendo un nombre que termine en `.piskel`.
- Lee todas las versiones del formato de Piskel (modelo 2, 1 y 0), incluyendo
  capas sin `chunks` y frames ocultos.
- Paleta: se genera con los colores usados o se carga desde un `.gpl` (los
  `.piskel` no guardan paletas). Al guardar puede escribir también la paleta
  como `.gpl` junto al archivo.

### Qué se pierde al guardar como `.piskel`

Piskel tiene un único FPS (se promedian las duraciones), no tiene modos de
mezcla, ni grupos (se aplanan), ni capas de tilemap/referencia (se omiten), ni
visibilidad de capa (las capas ocultas se guardan con opacidad 0).

## Compilar

Una extensión de Aseprite es un ZIP renombrado a `.aseprite-extension`, con
`package.json` y el script Lua en la raíz. **No hay nada que compilar**:
"compilar" es empaquetar esos dos archivos.

Elige una opción:

| Sistema | Comando |
| --- | --- |
| Cualquiera (Python 3.6+) | `python build.py` |
| Windows (PowerShell) | `powershell -ExecutionPolicy Bypass -File build.ps1` |
| Linux / macOS | `./build.sh` (necesita `zip`) |

El resultado queda en `dist/piskel-to-aseprite-extension.aseprite-extension`.

Alternativa manual: selecciona `package.json` y `piskel-to-aseprite-extension.lua`, comprímelos
en un ZIP (los dos archivos deben quedar en la raíz del ZIP, no dentro de una
carpeta) y renombra el ZIP a `piskel-to-aseprite-extension.aseprite-extension`.

## Instalar

1. En Aseprite: *Edit > Preferences > Extensions > Add Extension* (o doble clic
   sobre el archivo `.aseprite-extension`).
2. Elige `dist/piskel-to-aseprite-extension.aseprite-extension` y reinicia Aseprite.

### Instalación para desarrollo (sin empaquetar)

Copia esta carpeta (con `package.json` y `piskel-to-aseprite-extension.lua`) al directorio de
extensiones y reinicia Aseprite tras cada cambio:

- Windows: `%APPDATA%\Aseprite\extensions\piskel-to-aseprite-extension\`
- macOS: `~/Library/Application Support/Aseprite/extensions/piskel-to-aseprite-extension/`
- Linux: `~/.config/aseprite/extensions/piskel-to-aseprite-extension/`

La primera vez Aseprite puede pedir permiso de acceso a archivos (el script lee
los `.piskel` y escribe PNG temporales para decodificar o codificar las capas).

## Uso

- *File > Scripts > Piskel: preferencias...* abre los ajustes: los dos diálogos
  opcionales de abajo, paleta al abrir, frames ocultos y escribir la paleta
  `.gpl` al guardar.
- Dos comandos **no tienen entrada en ningún menú**, pero puedes asignarlos a un
  atajo en *Edit > Keyboard Shortcuts*: "Importar archivo Piskel (.piskel)..."
  (con opciones de paleta) y "Guardar como Piskel (.piskel)...".
- Por defecto *File > Open* usa el diálogo nativo de Aseprite, que no puede
  listar ni abrir `.piskel`. Ábrelos con arrastrar y soltar, Recent Files, la
  línea de comandos (`aseprite archivo.piskel`) o el comando de importar asignado
  a un atajo.

### Diálogos nativos vs. diálogos que listan `.piskel`

Los diálogos de archivo nativos de Aseprite solo listan los formatos integrados
en Aseprite, y una extensión Lua no puede añadir uno ni ver el nombre elegido
ahí. La única forma de mostrar `*.piskel` en un selector de archivos es un
diálogo propio de la extensión, lo que implica una ventana extra (una ventana
pequeña con un campo de archivo, desde la que se abre el selector nativo). Cada
diálogo se activa o desactiva por separado en las preferencias:

| Ajuste | Por defecto | Efecto |
| --- | --- | --- |
| *File > Open*: diálogo de la extensión | desactivado | Lista `.piskel` en el selector (ventana extra) |
| *File > Save As*: diálogo de la extensión | activado | Permite guardar un `.piskel` desde Save As (ventana extra) |

Con *Save As* desactivado se usa el diálogo nativo de Aseprite (sin `.piskel`);
`Ctrl+S` sigue escribiendo sobre un `.piskel` que se abrió desde uno.

## Cómo funciona

`piskel-to-aseprite-extension.lua` es un solo script:

| Sección | Qué hace |
| --- | --- |
| Idiomas | Tabla `STR` (`en`, `es`) y `T(clave, ...)`; el idioma sale de `app.preferences.general.language` |
| Utilidades | Decodificador base64, parser JSON (respaldo de `json.decode`), carga de PNG mediante archivo temporal |
| Importación | Modelo Piskel 2/1/0 a sprite de Aseprite (capas, celdas, duraciones, paleta) |
| Exportación | Sprite de Aseprite a modelo Piskel 2 (un spritesheet horizontal por capa) |
| Enganche de comandos | `app.events:on("beforecommand")` maneja `OpenFile`, `SaveFile`, `SaveFileAs` y `SaveFileCopyAs` para rutas `.piskel` |

La API Lua de Aseprite no permite registrar formatos de archivo nuevos, por eso el
soporte de `.piskel` se hace interceptando esos comandos. `ev.stopPropagation()`
se llama siempre al final del manejador porque los comandos anidados reinician la
bandera de cancelación de Aseprite.

Para añadir un idioma, agrega una tabla a `STR` con las mismas claves que `en` y
amplía `currentLanguage()`.

## Integración continua

`.github/workflows/build.yml` se ejecuta en cada push y pull request: revisa la
sintaxis de Lua (`luac5.4 -p`), compila la extensión con `build.py`, verifica el
contenido del paquete y lo sube como artefacto. Si subes una etiqueta como
`v1.4.0` (debe coincidir con el `version` de `package.json`) también publica un
Release de GitHub con el `.aseprite-extension` adjunto:

```
git tag v1.0.0
git push origin v1.0.0
```

## Licencia

MIT, ver `LICENSE`. Piskel es otro proyecto con sus propios autores; el formato
`.piskel` se leyó de su código fuente público.
