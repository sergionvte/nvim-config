-- coc-settings.json is static JSON — it can't do "find gopls wherever this
-- machine happens to have it installed". This computes the OS-dependent bits
-- (LSP binary paths, JDK home) at startup by resolving them through $PATH /
-- the OS's own tools, and injects them via g:coc_user_config, which coc.nvim
-- merges on top of coc-settings.json. That's what makes the same config work
-- on macOS, Linux and Windows without editing paths per machine.
local user_config = {}

local function exepath(name)
  local path = vim.fn.exepath(name)
  return path ~= '' and path or nil
end

-- go.goplsPath / kotlin.languageServer.path: point coc-go/coc-kotlin at an
-- already-installed binary when there is one, instead of letting them
-- silently download and manage their own private copy on first use.
local gopls = exepath('gopls')
if gopls then
  user_config['go.goplsPath'] = gopls
end

local kotlin_ls = exepath('kotlin-language-server')
if kotlin_ls then
  user_config['kotlin.languageServer.path'] = kotlin_ls
end

-- java.jdt.ls.java.home: JDT-LS (coc-java) needs a JDK 17+ to run itself,
-- regardless of what a given project targets. $JAVA_HOME is the portable
-- source of truth if set; macOS additionally has /usr/libexec/java_home,
-- which correctly resolves Homebrew's nested `libexec/openjdk.jdk/Contents/
-- Home` layout (naively deriving it from the `java` binary's own path does
-- not, on macOS). Elsewhere, `<JAVA_HOME>/bin/java(.exe)` is flat enough
-- that going up two directories from the resolved binary works fine.
--
-- /usr/libexec/java_home spawns a real subprocess (~20ms) and this file
-- must run before lazy.setup(), i.e. on every single startup — so the
-- result is cached to disk and only re-detected if the cached path stops
-- existing (e.g. after a JDK upgrade moves it).
local cache_file = vim.fn.stdpath('cache') .. '/coc_portable_java_home.txt'

local function cached_java_home()
  if vim.fn.filereadable(cache_file) == 1 then
    local cached = vim.fn.readfile(cache_file, '', 1)[1]
    if cached and cached ~= '' and vim.fn.isdirectory(cached) == 1 then
      return cached
    end
  end
  return nil
end

local function detect_java_home()
  local java_home = vim.fn.getenv('JAVA_HOME')
  if java_home ~= vim.NIL and java_home ~= '' then
    return java_home
  end

  local cached = cached_java_home()
  if cached then
    return cached
  end

  local function detected()
    if vim.fn.has('mac') == 1 and vim.fn.executable('/usr/libexec/java_home') == 1 then
      local result = vim.fn.system('/usr/libexec/java_home'):gsub('%s+$', '')
      if vim.v.shell_error == 0 and result ~= '' then
        return result
      end
    end

    local java_bin = exepath('java')
    if java_bin then
      local home = vim.fn.fnamemodify(java_bin, ':h:h')
      if vim.fn.isdirectory(home) == 1 then
        return home
      end
    end

    return nil
  end

  local home = detected()
  if home then
    vim.fn.writefile({ home }, cache_file)
  end
  return home
end

local java_home = detect_java_home()
if java_home then
  user_config['java.jdt.ls.java.home'] = java_home
  user_config['java.configuration.runtimes'] = {
    { name = 'JavaSE-21', path = java_home, default = true },
  }
end

if next(user_config) ~= nil then
  vim.g.coc_user_config = vim.tbl_deep_extend('force', vim.g.coc_user_config or {}, user_config)
end
