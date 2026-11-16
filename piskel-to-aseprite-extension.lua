-- Piskel Importer para Aseprite (1.3+)
-- Lee archivos .piskel (JSON) y crea un sprite con sus capas, frames,
-- opacidad de capa, FPS y una paleta (colores usados o archivo .gpl).

------------------------------------------------------------------------
-- Idiomas / Languages
------------------------------------------------------------------------
-- English is the default. Spanish is used only when Aseprite's interface
-- language is Spanish (Preferences > General > Language).

local STR = {
  en = {
    err_open_file = "Could not open file: %s",
    err_tmp_write = "Could not write the temporary file",
    err_png = "Could not read an embedded PNG inside the .piskel file",
    err_grid = "Empty or invalid frame in legacy format",
    err_empty = "The file is empty",
    err_not_json = "The file is not valid JSON",
    err_not_piskel = "This doesn't look like a valid .piskel file",
    err_no_layers = "The file contains no layers",
    err_no_frames = "The file contains no layers or frames",
    err_no_size = "Could not determine the sprite size",
    err_no_export_layers = "The sprite has no exportable layers (tilemap and reference layers don't exist in Piskel)",
    err_write = "Could not write the file: %s",
    warn_palfile_read = "Could not read the palette file; the default palette was kept.",
    warn_palfile_none = "No palette file was chosen; the default palette was kept.",
    json_err = "Invalid JSON (%s) at position %d",
    json_unclosed = "unterminated string",
    json_bad_u = "invalid \\u escape",
    json_bad_esc = "invalid escape",
    json_key = "expected a key",
    json_colon = "expected ':'",
    json_comma_obj = "expected ',' or '}'",
    json_comma_arr = "expected ',' or ']'",
    json_value = "unexpected value",
    json_trailing = "trailing text",
    mode_used = "Colors used in the sprite",
    mode_file = "Palette file (.gpl, .pal, ...)",
    mode_none = "Leave default palette",
    title_open_err = "Error opening Piskel file",
    title_import_err = "Error importing",
    title_save_err = "Error saving as Piskel",
    title_save_err2 = "Error saving",
    title_saved = "Saved as Piskel",
    dlg_saveas = "Save As",
    dlg_import = "Import Piskel",
    dlg_save_piskel = "Save as Piskel",
    dlg_prefs = "Piskel: preferences",
    lbl_file = "File:",
    lbl_piskel_file = "Piskel file (.piskel):",
    lbl_palette = "Palette:",
    lbl_palette_file = "Palette file:",
    lbl_hidden = "Hidden frames:",
    lbl_palopen = "Palette when opening:",
    txt_hidden_import = "Import them too",
    chk_custom_open = "File > Open: use the extension's dialog that lists .piskel (adds an extra window)",
    chk_custom_saveas = "File > Save As: use the extension's dialog that allows .piskel (adds an extra window)",
    dlg_open = "Open file",
    btn_open = "Open",
    chk_hidden_open = "Import hidden frames when opening",
    chk_gpl = "When saving, also write the palette (.gpl)",
    btn_save = "Save",
    btn_cancel = "Cancel",
    btn_import = "Import",
    btn_ok = "OK",
    btn_overwrite = "Overwrite",
    msg_exists = "The file already exists. Overwrite it?",
    msg_choose = "Choose a .piskel file.",
    note_durations = "Frames have different durations; Piskel uses a single FPS (%d).",
    note_skipped = "%d tilemap/reference layer(s) were not exported.",
    cmd_import = "Import Piskel file (.piskel)...",
    cmd_saveas = "Save as Piskel (.piskel)...",
    cmd_prefs = "Piskel: preferences...",
  },
  es = {
    err_open_file = "No se pudo abrir el archivo: %s",
    err_tmp_write = "No se pudo escribir el archivo temporal",
    err_png = "No se pudo leer un PNG incrustado en el archivo .piskel",
    err_grid = "Frame vacío o inválido en formato antiguo",
    err_empty = "El archivo está vacío",
    err_not_json = "El archivo no es un JSON válido",
    err_not_piskel = "No parece un archivo .piskel válido",
    err_no_layers = "El archivo no contiene capas",
    err_no_frames = "El archivo no contiene capas o frames",
    err_no_size = "No se pudo determinar el tamaño del sprite",
    err_no_export_layers = "El sprite no tiene capas exportables (las capas de tilemap y de referencia no existen en Piskel)",
    err_write = "No se pudo escribir el archivo: %s",
    warn_palfile_read = "No se pudo leer el archivo de paleta; se dejó la paleta por defecto.",
    warn_palfile_none = "No se eligió archivo de paleta; se dejó la paleta por defecto.",
    json_err = "JSON inválido (%s) en la posición %d",
    json_unclosed = "string sin cerrar",
    json_bad_u = "escape \\u inválido",
    json_bad_esc = "escape inválido",
    json_key = "se esperaba una clave",
    json_colon = "se esperaba ':'",
    json_comma_obj = "se esperaba ',' o '}'",
    json_comma_arr = "se esperaba ',' o ']'",
    json_value = "valor inesperado",
    json_trailing = "texto sobrante",
    mode_used = "Colores usados en el sprite",
    mode_file = "Archivo de paleta (.gpl, .pal, ...)",
    mode_none = "No tocar (paleta por defecto)",
    title_open_err = "Error al abrir el archivo Piskel",
    title_import_err = "Error al importar",
    title_save_err = "Error al guardar como Piskel",
    title_save_err2 = "Error al guardar",
    title_saved = "Guardado como Piskel",
    dlg_saveas = "Guardar como",
    dlg_import = "Importar Piskel",
    dlg_save_piskel = "Guardar como Piskel",
    dlg_prefs = "Piskel: preferencias",
    lbl_file = "Archivo:",
    lbl_piskel_file = "Archivo Piskel (.piskel):",
    lbl_palette = "Paleta:",
    lbl_palette_file = "Archivo de paleta:",
    lbl_hidden = "Frames ocultos:",
    lbl_palopen = "Paleta al abrir:",
    txt_hidden_import = "Importarlos también",
    chk_custom_open = "File > Open: usar el diálogo de la extensión que lista .piskel (añade una ventana extra)",
    chk_custom_saveas = "File > Save As: usar el diálogo de la extensión que permite .piskel (añade una ventana extra)",
    dlg_open = "Abrir archivo",
    btn_open = "Abrir",
    chk_hidden_open = "Importar frames ocultos al abrir",
    chk_gpl = "Al guardar, escribir también la paleta (.gpl)",
    btn_save = "Guardar",
    btn_cancel = "Cancelar",
    btn_import = "Importar",
    btn_ok = "Aceptar",
    btn_overwrite = "Sobrescribir",
    msg_exists = "El archivo ya existe. ¿Sobrescribirlo?",
    msg_choose = "Elige un archivo .piskel.",
    note_durations = "Los frames tienen duraciones distintas; Piskel usa un solo FPS (%d).",
    note_skipped = "%d capa(s) de tilemap/referencia no se exportaron.",
    cmd_import = "Importar archivo Piskel (.piskel)...",
    cmd_saveas = "Guardar como Piskel (.piskel)...",
    cmd_prefs = "Piskel: preferencias...",
  },
}

local function currentLanguage()
  local ok, lang = pcall(function() return app.preferences.general.language end)
  if ok and type(lang) == "string" and lang:lower():match("^es") then return "es" end
  return "en"
end

local function T(key, ...)
  local text = STR[currentLanguage()][key] or STR.en[key] or key
  if select("#", ...) > 0 then return string.format(text, ...) end
  return text
end

------------------------------------------------------------------------
-- Utilidades
------------------------------------------------------------------------

-- Decodificador base64 (estándar y url-safe)
local B64 = {}
do
  local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  for i = 1, #chars do B64[chars:byte(i)] = i - 1 end
  B64[string.byte("-")] = 62
  B64[string.byte("_")] = 63
end

local function b64decode(data)
  local out, n = {}, 0
  local buf, bits = 0, 0
  for i = 1, #data do
    local v = B64[data:byte(i)]
    if v then
      buf = (buf << 6) | v
      bits = bits + 6
      if bits >= 8 then
        bits = bits - 8
        n = n + 1
        out[n] = string.char((buf >> bits) & 0xFF)
        buf = buf & ((1 << bits) - 1)
      end
    end
  end
  return table.concat(out)
end

local function readFile(path)
  local f = io.open(path, "rb")
  if not f then error(T("err_open_file", tostring(path))) end
  local text = f:read("a")
  f:close()
  return text
end

-- Parser JSON propio (respaldo por si json.decode de Aseprite falla con
-- archivos grandes). null se convierte en nil.
local function jsonParse(str)
  local pos = 1
  local ESC = { b = "\b", f = "\f", n = "\n", r = "\r", t = "\t",
                ['"'] = '"', ["\\"] = "\\", ["/"] = "/" }

  local function fail(msg)
    error(T("json_err", msg, pos), 0)
  end

  local function skip()
    pos = str:find("[^ \t\r\n]", pos) or (#str + 1)
  end

  local parseValue

  local function parseString()
    pos = pos + 1
    local parts = {}
    while true do
      local s = str:find('["\\]', pos)
      if not s then fail(T("json_unclosed")) end
      parts[#parts + 1] = str:sub(pos, s - 1)
      if str:sub(s, s) == '"' then
        pos = s + 1
        break
      end
      local c = str:sub(s + 1, s + 1)
      if c == "u" then
        local cp = tonumber(str:sub(s + 2, s + 5), 16)
        if not cp then pos = s; fail(T("json_bad_u")) end
        pos = s + 6
        if cp >= 0xD800 and cp <= 0xDBFF and str:sub(pos, pos + 1) == "\\u" then
          local lo = tonumber(str:sub(pos + 2, pos + 5), 16)
          if lo and lo >= 0xDC00 and lo <= 0xDFFF then
            cp = 0x10000 + ((cp - 0xD800) << 10) + (lo - 0xDC00)
            pos = pos + 6
          end
        end
        parts[#parts + 1] = utf8.char(cp)
      else
        local r = ESC[c]
        if not r then pos = s; fail(T("json_bad_esc")) end
        parts[#parts + 1] = r
        pos = s + 2
      end
    end
    return table.concat(parts)
  end

  parseValue = function()
    skip()
    local c = str:sub(pos, pos)
    if c == "{" then
      local obj = {}
      pos = pos + 1
      skip()
      if str:sub(pos, pos) == "}" then pos = pos + 1; return obj end
      while true do
        skip()
        if str:sub(pos, pos) ~= '"' then fail(T("json_key")) end
        local key = parseString()
        skip()
        if str:sub(pos, pos) ~= ":" then fail(T("json_colon")) end
        pos = pos + 1
        obj[key] = parseValue()
        skip()
        local d = str:sub(pos, pos)
        pos = pos + 1
        if d == "}" then return obj end
        if d ~= "," then pos = pos - 1; fail(T("json_comma_obj")) end
      end
    elseif c == "[" then
      local arr, n = {}, 0
      pos = pos + 1
      skip()
      if str:sub(pos, pos) == "]" then pos = pos + 1; return arr end
      while true do
        n = n + 1
        arr[n] = parseValue()
        skip()
        local d = str:sub(pos, pos)
        pos = pos + 1
        if d == "]" then return arr end
        if d ~= "," then pos = pos - 1; fail(T("json_comma_arr")) end
      end
    elseif c == '"' then
      return parseString()
    elseif str:sub(pos, pos + 3) == "true" then
      pos = pos + 4; return true
    elseif str:sub(pos, pos + 4) == "false" then
      pos = pos + 5; return false
    elseif str:sub(pos, pos + 3) == "null" then
      pos = pos + 4; return nil
    else
      local num = str:match("^-?%d+%.?%d*[eE]?[%+%-]?%d*", pos)
      if not num or num == "" then fail(T("json_value")) end
      pos = pos + #num
      return tonumber(num)
    end
  end

  local result = parseValue()
  skip()
  if pos <= #str then fail(T("json_trailing")) end
  return result
end

-- Usa json.decode de Aseprite y, si falla, el parser propio
local function decodeJson(text)
  text = (text:gsub("^\239\187\191", ""))   -- quita BOM UTF-8
  if json and json.decode then
    local ok, result = pcall(json.decode, text)
    if ok and type(result) == "table" then return result end
  end
  return jsonParse(text)
end

-- Convierte un data-URI PNG (base64) en una Image de Aseprite
local function loadPngImage(dataUri)
  local b64 = dataUri:gsub("^data:[^,]*,", "")
  local bytes = b64decode(b64)

  local tmp = app.fs.joinPath(
    app.fs.tempPath,
    string.format("piskel_import_%d_%d.png", os.time(), math.random(1, 999999)))
  local f = io.open(tmp, "wb")
  if not f then error(T("err_tmp_write")) end
  f:write(bytes)
  f:close()

  local ok, img = pcall(function() return Image{ fromFile = tmp } end)
  os.remove(tmp)
  if not ok or not img then
    error(T("err_png"))
  end
  return img
end

-- Recorta los frames de un "chunk" de Piskel (spritesheet + layout).
-- Igual que Piskel (FrameUtils.createFramesFromChunk): layout[i] es la
-- columna i, layout[i][j] es el índice del frame en la fila j, y el
-- tamaño del frame sale de (tamaño de imagen / dimensiones del layout).
local function extractChunk(chunk, frames)
  local sheet = loadPngImage(chunk.base64PNG)
  local layout = chunk.layout
  if not layout or #layout == 0 then layout = { { 0 } } end
  local fw = sheet.width // #layout
  local fh = sheet.height // #layout[1]

  for i, column in ipairs(layout) do
    for j, frameIndex in ipairs(column) do
      local img = Image(fw, fh, ColorMode.RGB)
      img:drawImage(sheet, Point(-(i - 1) * fw, -(j - 1) * fh))
      frames[frameIndex + 1] = img
    end
  end
end

-- Color de Piskel (formatos antiguos): entero ABGR o string CSS
local function parseColor(c)
  if type(c) == "number" then
    c = math.floor(c)
    return c & 0xFF, (c >> 8) & 0xFF, (c >> 16) & 0xFF, (c >> 24) & 0xFF
  elseif type(c) == "string" then
    local hex = c:match("^#(%x%x%x%x%x%x)$")
    if hex then
      return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16),
             tonumber(hex:sub(5, 6), 16), 255
    end
    hex = c:match("^#(%x%x%x)$")
    if hex then
      return tonumber(hex:sub(1, 1), 16) * 17, tonumber(hex:sub(2, 2), 16) * 17,
             tonumber(hex:sub(3, 3), 16) * 17, 255
    end
    local r, g, b, a = c:match("^rgba?%(%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*,?%s*([%d%.]*)%s*%)$")
    if r then
      a = (a ~= "") and tonumber(a) or 1
      return tonumber(r), tonumber(g), tonumber(b), math.floor(a * 255 + 0.5)
    end
  end
  return 0, 0, 0, 0
end

-- Formatos antiguos (modelVersion 0/1): rejilla de píxeles grid[x][y]
local function gridToImage(grid)
  local w = #grid
  local h = (w > 0) and #grid[1] or 0
  if w == 0 or h == 0 then error(T("err_grid")) end
  local img = Image(w, h, ColorMode.RGB)
  for x = 1, w do
    for y = 1, h do
      local r, g, b, a = parseColor(grid[x][y])
      if a > 0 then img:putPixel(x - 1, y - 1, app.pixelColor.rgba(r, g, b, a)) end
    end
  end
  return img
end

local function decodeJsonIfString(v)
  if type(v) == "string" then return decodeJson(v) end
  return v
end

-- Llena frames[indice + 1] con las imágenes de una capa, en cualquier
-- versión del formato
local function decodeLayerFrames(L, frames)
  if L.frames then                       -- modelVersion 1 / 0
    for i, f in ipairs(L.frames) do
      frames[i] = gridToImage(decodeJsonIfString(f))
    end
    return
  end
  local chunks = L.chunks
  if not chunks and L.base64PNG then     -- capa sin chunks: frames en fila
    local layout = {}
    for i = 0, (tonumber(L.frameCount) or 1) - 1 do layout[#layout + 1] = { i } end
    chunks = { { base64PNG = L.base64PNG, layout = layout } }
  end
  for _, chunk in ipairs(chunks or {}) do extractChunk(chunk, frames) end
end

local function collectColors(img, seen, list)
  for it in img:pixels() do
    local v = it()
    if app.pixelColor.rgbaA(v) > 0 and not seen[v] then
      seen[v] = true
      list[#list + 1] = v
    end
  end
end

-- Estado compartido
local prefs = {}                 -- plugin.preferences (se asigna en init)
local suppressExport = false     -- true: SaveFileCopyAs de .piskel no escribe nada
local lastCreated = nil          -- último sprite creado por la importación

local function isPiskel(filename)
  return type(filename) == "string" and filename:lower():match("%.piskel$") ~= nil
end

-- Marca el sprite como guardado en `path` SIN escribir nada: Sprite:saveAs
-- llama a SaveFileCopyAs (que nuestro hook cancela) y luego fija el nombre
-- de archivo y marca el documento como guardado.
local function markSaved(sprite, path)
  suppressExport = true
  local ok = pcall(function() sprite:saveAs(path) end)
  suppressExport = false
  return ok
end

------------------------------------------------------------------------
-- Importación
------------------------------------------------------------------------

local function importPiskelRaw(path, opts)
  local text = readFile(path)
  if #text == 0 then error(T("err_empty")) end
  local doc = decodeJson(text)
  if type(doc) ~= "table" then error(T("err_not_json")) end

  -- modelVersion 2 (actual) y 1: doc.piskel; modelVersion 0: arreglo de rejillas
  local pk
  if doc.piskel then
    pk = doc.piskel
  elseif doc[1] ~= nil then
    pk = { layers = { { name = "Layer 1", frames = doc } } }
  else
    error(T("err_not_piskel"))
  end
  if type(pk.layers) ~= "table" then error(T("err_no_layers")) end

  -- Las capas vienen como strings JSON
  local layerData = {}
  local totalFrames = 0
  for _, raw in ipairs(pk.layers) do
    local L = decodeJsonIfString(raw)
    layerData[#layerData + 1] = L
    local count = L.frames and #L.frames or tonumber(L.frameCount) or 0
    totalFrames = math.max(totalFrames, count)
  end
  if #layerData == 0 or totalFrames == 0 then
    error(T("err_no_frames"))
  end

  -- Tamaño del sprite: de los datos o, si falta (v0), del primer frame
  local w, h = pk.width, pk.height
  local fps = tonumber(pk.fps) or 12
  if fps <= 0 then fps = 12 end
  if not w or not h then                -- v0: tamaño desde el primer frame
    local probe = {}
    decodeLayerFrames(layerData[1], probe)
    local first = probe[1]
    if not first then error(T("err_no_size")) end
    w, h = first.width, first.height
  end

  -- Frames a importar (índices base 0), omitiendo los ocultos si se pidió
  local hidden = {}
  if not opts.importHidden and type(pk.hiddenFrames) == "table" then
    for _, idx in ipairs(pk.hiddenFrames) do hidden[idx] = true end
  end
  local keep = {}
  for i = 0, totalFrames - 1 do
    if not hidden[i] then keep[#keep + 1] = i end
  end
  if #keep == 0 then keep = { 0 } end

  -- Sprite
  local sprite = Sprite(w, h, ColorMode.RGB)
  lastCreated = sprite
  if opts.asDocument then
    sprite.filename = path           -- Ctrl+S volverá a guardar el .piskel
  else
    local baseName = pk.name or app.fs.fileTitle(path)
    sprite.filename = app.fs.joinPath(app.fs.filePath(path), baseName .. ".aseprite")
  end
  if pk.description and pk.description ~= "" then
    pcall(function() sprite.data = pk.description end)
  end

  for _ = 2, #keep do sprite:newEmptyFrame() end
  local duration = math.min(math.max(1 / fps, 0.001), 65.535)
  for _, fr in ipairs(sprite.frames) do fr.duration = duration end

  -- Capas (la primera de Piskel es la de abajo, igual que en Aseprite)
  local seen, colors = {}, {}
  for li, L in ipairs(layerData) do
    local layer = (li == 1) and sprite.layers[1] or sprite:newLayer()
    layer.name = L.name or ("Layer " .. li)
    local opacity = tonumber(L.opacity) or 1
    layer.opacity = math.floor(math.min(math.max(opacity, 0), 1) * 255 + 0.5)

    local frames = {}
    decodeLayerFrames(L, frames)

    for k, frameIndex in ipairs(keep) do
      local img = frames[frameIndex + 1]
      if img and not img:isEmpty() then
        sprite:newCel(layer, k, img, Point(0, 0))
        if opts.palMode == "used" then collectColors(img, seen, colors) end
      end
    end
  end

  -- Paleta
  local palWarning = nil
  if opts.palMode == "used" and #colors > 0 then
    local pal = Palette(#colors)
    for i, v in ipairs(colors) do
      pal:setColor(i - 1, Color{
        r = app.pixelColor.rgbaR(v),
        g = app.pixelColor.rgbaG(v),
        b = app.pixelColor.rgbaB(v),
        a = app.pixelColor.rgbaA(v) })
    end
    sprite:setPalette(pal)
  elseif opts.palMode == "file" then
    if opts.palFile and opts.palFile ~= "" then
      local ok, pal = pcall(function() return Palette{ fromFile = opts.palFile } end)
      if ok and pal then
        sprite:setPalette(pal)
      else
        palWarning = T("warn_palfile_read")
      end
    else
      palWarning = T("warn_palfile_none")
    end
  end

  if opts.asDocument then markSaved(sprite, path) end
  app.sprite = sprite
  app.refresh()
  return sprite, palWarning
end

-- Igual que importPiskelRaw, pero si algo falla cierra el sprite a medias
local function importPiskel(path, opts)
  lastCreated = nil
  local ok, a, b = pcall(importPiskelRaw, path, opts)
  if ok then return a, b end
  if lastCreated then pcall(function() lastCreated:close() end) end
  error(a, 0)
end

------------------------------------------------------------------------
-- Exportación a .piskel
------------------------------------------------------------------------

local B64CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

local function b64encode(data)
  local out, n = {}, 0
  for i = 1, #data, 3 do
    local a, b, c = data:byte(i, i + 2)
    local v = (a << 16) | ((b or 0) << 8) | (c or 0)
    local c1, c2 = (v >> 18) & 63, (v >> 12) & 63
    local c3, c4 = (v >> 6) & 63, v & 63
    n = n + 1
    out[n] = B64CHARS:sub(c1 + 1, c1 + 1) .. B64CHARS:sub(c2 + 1, c2 + 1)
      .. (b and B64CHARS:sub(c3 + 1, c3 + 1) or "=")
      .. (c and B64CHARS:sub(c4 + 1, c4 + 1) or "=")
  end
  return table.concat(out)
end

local JSON_ESC = { ['"'] = '\\"', ["\\"] = "\\\\", ["\n"] = "\\n", ["\r"] = "\\r",
                   ["\t"] = "\\t", ["\b"] = "\\b", ["\f"] = "\\f" }

local function jsonStr(s)
  return '"' .. s:gsub('[%c"\\]', function(ch)
    return JSON_ESC[ch] or string.format("\\u%04x", ch:byte())
  end) .. '"'
end

-- Aplana las capas (recorre grupos). Piskel no tiene grupos, tilemaps ni
-- capas de referencia: esas últimas se omiten y se cuentan.
local function collectLayers(layers, parentVisible, out)
  local skipped = 0
  for _, layer in ipairs(layers) do
    local visible = parentVisible and layer.isVisible
    if layer.isGroup then
      skipped = skipped + collectLayers(layer.layers, visible, out)
    elseif layer.isTilemap or layer.isReference then
      skipped = skipped + 1
    else
      local opacity = (layer.opacity or 255) / 255
      if not visible then opacity = 0 end   -- Piskel no guarda visibilidad
      out[#out + 1] = { layer = layer, opacity = opacity }
    end
  end
  return skipped
end

-- Dibuja una celda en una imagen RGB del tamaño del sprite (aplicando la
-- opacidad de la celda y convirtiendo desde indexado/grises)
local function renderCel(sprite, layer, cel, w, h)
  local out = Image(w, h, ColorMode.RGB)
  local mode = sprite.colorMode
  if mode == ColorMode.RGB then
    out:drawImage(cel.image, cel.position, cel.opacity)
    return out
  end

  local pal = sprite.palettes[1]
  local transparent = sprite.transparentColor
  local isBackground = layer.isBackground
  local ox, oy, celOpacity = cel.position.x, cel.position.y, cel.opacity
  for it in cel.image:pixels() do
    local x, y = ox + it.x, oy + it.y
    if x >= 0 and y >= 0 and x < w and y < h then
      local v = it()
      local r, g, b, a = 0, 0, 0, 0
      if mode == ColorMode.INDEXED then
        if not (v == transparent and not isBackground) and v < #pal then
          local col = pal:getColor(v)
          r, g, b, a = col.red, col.green, col.blue, col.alpha
        end
      else
        local gray = app.pixelColor.grayaV(v)
        r, g, b, a = gray, gray, gray, app.pixelColor.grayaA(v)
      end
      if a > 0 then
        out:putPixel(x, y, app.pixelColor.rgba(r, g, b, a * celOpacity // 255))
      end
    end
  end
  return out
end

-- Escribe `sprite` como archivo .piskel (modelVersion 2, una capa por
-- spritesheet horizontal en un solo chunk, igual que el serializador de
-- Piskel). Devuelve una tabla con avisos sobre lo que no se pudo conservar.
local function exportPiskel(sprite, path, opts)
  opts = opts or {}
  local w, h = sprite.width, sprite.height
  local nFrames = #sprite.frames

  local entries = {}
  local skipped = collectLayers(sprite.layers, true, entries)
  if #entries == 0 then
    error(T("err_no_export_layers"), 0)
  end

  -- Piskel tiene un único FPS: se usa el promedio de las duraciones
  local total, minD, maxD = 0, math.huge, 0
  for _, fr in ipairs(sprite.frames) do
    total = total + fr.duration
    minD = math.min(minD, fr.duration)
    maxD = math.max(maxD, fr.duration)
  end
  local fps = math.floor(nFrames / math.max(total, 0.001) + 0.5)
  fps = math.min(math.max(fps, 1), 32)

  local columns = {}
  for i = 0, nFrames - 1 do columns[#columns + 1] = "[" .. i .. "]" end
  local layout = "[" .. table.concat(columns, ",") .. "]"

  local tmp = app.fs.joinPath(
    app.fs.tempPath,
    string.format("piskel_export_%d_%d.png", os.time(), math.random(1, 999999)))

  local layerStrings = {}
  for _, e in ipairs(entries) do
    local sheet = Image(w * nFrames, h, ColorMode.RGB)
    for i = 1, nFrames do
      local cel = e.layer:cel(i)
      if cel then
        sheet:drawImage(renderCel(sprite, e.layer, cel, w, h), Point((i - 1) * w, 0))
      end
    end

    local ok, err = pcall(function() sheet:saveAs(tmp) end)
    if not ok then
      os.remove(tmp)
      error(err, 0)
    end
    local png = readFile(tmp)
    os.remove(tmp)

    local opacity = (string.format("%.3f", e.opacity):gsub(",", "."))
    local layerJson = '{"name":' .. jsonStr(e.layer.name)
      .. ',"opacity":' .. opacity
      .. ',"frameCount":' .. nFrames
      .. ',"chunks":[{"layout":' .. layout
      .. ',"base64PNG":' .. jsonStr("data:image/png;base64," .. b64encode(png))
      .. "}]}"
    layerStrings[#layerStrings + 1] = jsonStr(layerJson)   -- Piskel anida cada capa como string
  end

  local name = app.fs.fileTitle(path)
  local docJson = '{"modelVersion":2,"piskel":{"name":' .. jsonStr(name)
    .. ',"description":""'
    .. ',"fps":' .. fps
    .. ',"height":' .. h
    .. ',"width":' .. w
    .. ',"layers":[' .. table.concat(layerStrings, ",") .. "]"
    .. ',"hiddenFrames":[]}}'

  local f = io.open(path, "wb")
  if not f then error(T("err_write", path), 0) end
  f:write(docJson)
  f:close()

  if opts.exportGpl then
    pcall(function()
      local gpl = app.fs.joinPath(app.fs.filePath(path), app.fs.fileTitle(path) .. ".gpl")
      sprite.palettes[1]:saveAs(gpl)
    end)
  end

  return {
    variableDurations = (maxD - minD) > 0.001,
    skippedLayers = skipped,
    fps = fps }
end

------------------------------------------------------------------------
-- Abrir y guardar desde Aseprite
------------------------------------------------------------------------

local MODE_USED = T("mode_used")
local MODE_FILE = T("mode_file")
local MODE_NONE = T("mode_none")

local OPEN_TYPES = { "aseprite", "ase", "piskel", "png", "gif", "jpg", "jpeg",
                     "bmp", "webp", "pcx", "tga", "ico", "qoi", "flc", "fli" }
local SAVE_TYPES = { "piskel", "aseprite", "ase", "png", "gif", "jpg", "bmp",
                     "webp", "pcx", "tga", "ico", "qoi" }

local function fail(title, err)
  app.alert{ title = title, text = tostring(err) }
end

-- Abre un .piskel como documento (Recent Files, arrastrar y soltar,
-- línea de comandos / asociación de archivos)
local function openPiskel(path)
  local ok, err = pcall(importPiskel, path, {
    palMode = prefs.palMode or "used",
    importHidden = prefs.importHidden ~= false,
    asDocument = true })
  if not ok then fail(T("title_open_err"), err) end
end

-- Diálogos propios (opcionales): son la única forma de listar *.piskel en el
-- selector de archivos, porque el diálogo nativo de Aseprite no se puede
-- ampliar con formatos nuevos. Cada uno añade una ventana extra.
local function customOpen() return prefs.customOpen == true end
local function customSaveAs() return prefs.customSaveAs ~= false end

local function openDialog()
  local dlg = Dialog(T("dlg_open"))
  dlg:file{ id = "path", label = T("lbl_file"), open = true, entry = true,
            filetypes = OPEN_TYPES, focus = true }
  dlg:button{ id = "ok", text = T("btn_open"), focus = true }
  dlg:button{ id = "cancel", text = T("btn_cancel") }
  dlg:show()
  local data = dlg.data
  if not data.ok or not data.path or data.path == "" then return end
  if isPiskel(data.path) then
    openPiskel(data.path)
  else
    app.open(data.path)
  end
end

-- Exporta y marca como guardado (Save / Save As con extensión .piskel)
local function savePiskelTo(sprite, path, notify)
  local ok, info = pcall(exportPiskel, sprite, path, { exportGpl = prefs.exportGpl })
  if not ok then
    fail(T("title_save_err"), info)
    return false
  end
  markSaved(sprite, path)

  if notify then
    local notes = {}
    if info.variableDurations then
      notes[#notes + 1] = T("note_durations", info.fps)
    end
    if info.skippedLayers > 0 then
      notes[#notes + 1] = T("note_skipped", info.skippedLayers)
    end
    if #notes > 0 then
      app.alert{ title = T("title_saved"), text = notes }
    end
  end
  return true
end

local function saveAsDialog(sprite)
  local initial = sprite.filename
  local dlg = Dialog(T("dlg_saveas"))
  dlg:file{ id = "path", label = T("lbl_file"), open = false, save = true, entry = true,
            filename = initial, filetypes = SAVE_TYPES, focus = true }
  dlg:button{ id = "ok", text = T("btn_save"), focus = true }
  dlg:button{ id = "cancel", text = T("btn_cancel") }
  dlg:show()
  local data = dlg.data
  if not data.ok or not data.path or data.path == "" then return end

  local path = data.path
  if not path:match("%.[%w]+$") then path = path .. ".aseprite" end

  if app.fs.isFile(path) and path ~= initial then
    local r = app.alert{ title = T("dlg_saveas"), text = T("msg_exists"),
                         buttons = { T("btn_overwrite"), T("btn_cancel") } }
    if r ~= 1 then return end
  end

  if isPiskel(path) then
    savePiskelTo(sprite, path, true)
  else
    local ok, err = pcall(function() sprite:saveAs(path) end)
    if not ok then fail(T("title_save_err2"), err) end
  end
end

------------------------------------------------------------------------
-- Enganche de comandos
------------------------------------------------------------------------
-- IMPORTANTE: ev.stopPropagation() se llama siempre al FINAL del manejador,
-- porque trabajar dentro del manejador (Sprite:saveAs, importación) dispara
-- eventos anidados que reinician la bandera de cancelación.
--
-- Por defecto File > Open NO se modifica (selector nativo). Siempre se
-- interceptan los OpenFile que ya traen un nombre .piskel (Recent Files,
-- arrastrar y soltar, línea de comandos). Con prefs.customOpen, File > Open
-- sin nombre muestra el diálogo propio que lista .piskel.

local function handleOpenFile(params)
  local fn = params.filename
  if isPiskel(fn) then
    openPiskel(fn)
    return true
  end
  if (not fn or fn == "") and customOpen() then
    openDialog()
    return true
  end
  return false
end

local function handleSaveFile()
  local sprite = app.sprite
  if not sprite then return false end
  if isPiskel(sprite.filename) then
    savePiskelTo(sprite, sprite.filename, false)
    return true
  end
  if customSaveAs() and not sprite.hasAssociatedFile then
    saveAsDialog(sprite)
    return true
  end
  return false
end

local function handleSaveFileAs(params)
  local sprite = app.sprite
  if not sprite then return false end
  local fn = params.filename
  if fn and fn ~= "" then
    if isPiskel(fn) then
      savePiskelTo(sprite, fn, true)
      return true
    end
    return false
  end
  if customSaveAs() then
    saveAsDialog(sprite)
    return true
  end
  return false
end

-- Lo usan Sprite:saveAs()/saveCopyAs() y otros scripts
local function handleSaveFileCopyAs(params)
  local fn = params.filename
  if not isPiskel(fn) then return false end
  if suppressExport then return true end   -- solo marcar como guardado
  local sprite = app.sprite
  if sprite then
    local ok, err = pcall(exportPiskel, sprite, fn, { exportGpl = prefs.exportGpl })
    if not ok then fail(T("title_save_err"), err) end
  end
  return true
end

local HANDLERS = {
  OpenFile = handleOpenFile,
  SaveFile = handleSaveFile,
  SaveFileAs = handleSaveFileAs,
  SaveFileCopyAs = handleSaveFileCopyAs,
}

local function onBeforeCommand(ev)
  local handler = HANDLERS[ev.name]
  if not handler then return end
  local ok, stop = pcall(handler, ev.params or {})
  if not ok then
    -- Fallo inesperado del enganche: se deja actuar al comando original
    return
  end
  if stop then ev.stopPropagation() end
end

------------------------------------------------------------------------
-- Comandos y preferencias
------------------------------------------------------------------------

local function showImportDialog()
  local dlg = Dialog(T("dlg_import"))
  dlg:file{
    id = "path", label = T("lbl_piskel_file"), open = true,
    filetypes = { "piskel", "json" }, focus = true }
  dlg:combobox{
    id = "palmode", label = T("lbl_palette"), option = MODE_USED,
    options = { MODE_USED, MODE_FILE, MODE_NONE } }
  dlg:file{
    id = "palfile", label = T("lbl_palette_file"), open = true,
    filetypes = { "gpl", "pal", "act", "hex", "png", "ase", "aseprite" } }
  dlg:check{
    id = "hidden", label = T("lbl_hidden"), text = T("txt_hidden_import"),
    selected = true }
  dlg:separator()
  dlg:button{ id = "ok", text = T("btn_import"), focus = true }
  dlg:button{ id = "cancel", text = T("btn_cancel") }
  dlg:show()

  local data = dlg.data
  if not data.ok then return end
  if not data.path or data.path == "" then
    app.alert(T("msg_choose"))
    return
  end

  local palMode = "none"
  if data.palmode == MODE_USED then palMode = "used"
  elseif data.palmode == MODE_FILE then palMode = "file" end

  local ok, result, warn = pcall(importPiskel, data.path, {
    palMode = palMode,
    palFile = data.palfile,
    importHidden = data.hidden })

  if not ok then
    fail(T("title_import_err"), result)
  elseif warn then
    app.alert(warn)
  end
end

local function showSaveAsPiskel()
  local sprite = app.sprite
  if not sprite then return end
  local dlg = Dialog(T("dlg_save_piskel"))
  dlg:file{ id = "path", label = T("lbl_piskel_file"), open = false, save = true, entry = true,
            filename = app.fs.joinPath(app.fs.filePath(sprite.filename),
                                       app.fs.fileTitle(sprite.filename) .. ".piskel"),
            filetypes = { "piskel" }, focus = true }
  dlg:button{ id = "ok", text = T("btn_save"), focus = true }
  dlg:button{ id = "cancel", text = T("btn_cancel") }
  dlg:show()
  local data = dlg.data
  if not data.ok or not data.path or data.path == "" then return end
  local path = data.path
  if not isPiskel(path) then path = path .. ".piskel" end
  savePiskelTo(sprite, path, true)
end

local function showPreferences()
  local dlg = Dialog(T("dlg_prefs"))
  dlg:check{ id = "customopen", text = T("chk_custom_open"),
             selected = customOpen() }
  dlg:check{ id = "customsaveas", text = T("chk_custom_saveas"),
             selected = customSaveAs() }
  dlg:combobox{ id = "palmode", label = T("lbl_palopen"),
                option = (prefs.palMode == "none") and MODE_NONE or MODE_USED,
                options = { MODE_USED, MODE_NONE } }
  dlg:check{ id = "hidden", text = T("chk_hidden_open"),
             selected = prefs.importHidden ~= false }
  dlg:check{ id = "gpl", text = T("chk_gpl"),
             selected = prefs.exportGpl == true }
  dlg:separator()
  dlg:button{ id = "ok", text = T("btn_ok"), focus = true }
  dlg:button{ id = "cancel", text = T("btn_cancel") }
  dlg:show()
  local data = dlg.data
  if not data.ok then return end
  prefs.customOpen = data.customopen
  prefs.customSaveAs = data.customsaveas
  prefs.palMode = (data.palmode == MODE_NONE) and "none" or "used"
  prefs.importHidden = data.hidden
  prefs.exportGpl = data.gpl
end

function init(plugin)
  prefs = plugin.preferences
  -- Migración de la versión anterior (un solo ajuste para ambos diálogos)
  if prefs.customSaveAs == nil then prefs.customSaveAs = (prefs.replaceDialogs ~= false) end
  if prefs.customOpen == nil then prefs.customOpen = false end
  if prefs.importHidden == nil then prefs.importHidden = true end
  if prefs.palMode == nil then prefs.palMode = "used" end
  if prefs.exportGpl == nil then prefs.exportGpl = false end

  -- Estos dos comandos NO tienen "group": no aparecen en ningún menú.
  -- Se pueden asignar a un atajo en Edit > Keyboard Shortcuts.
  plugin:newCommand{
    id = "ImportPiskel",
    title = T("cmd_import"),
    onclick = showImportDialog
  }
  plugin:newCommand{
    id = "SaveAsPiskel",
    title = T("cmd_saveas"),
    onenabled = function() return app.sprite ~= nil end,
    onclick = showSaveAsPiskel
  }
  plugin:newCommand{
    id = "PiskelPreferences",
    title = T("cmd_prefs"),
    group = "file_scripts",
    onclick = showPreferences
  }

  app.events:on("beforecommand", onBeforeCommand)
end

function exit(plugin)
  app.events:off(onBeforeCommand)
end
