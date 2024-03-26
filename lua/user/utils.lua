-- Sed for deprecated Ansible modules
local function apply_replacement(file_path)
  local modules = {
    'apt',
    'apt_key',
    'apt_repository',
    'dpkg_selections',
    'git',
    'command',
    'copy',
    'cron',
    'debug',
    'fail',
    'file',
    'lineinfile',
    'find',
    'get_url',
    'hostname',
    'import_tasks',
    'include_tasks',
    'include_vars',
    'package_facts',
    'replace',
    'rpm_key',
    'service',
    'service_facts',
    'set_fact',
    'shell',
    'stat',
    'systemd',
    'template',
    'user',
    'yum',
    'pip',
  }

  local content = {}
  for line in io.lines(file_path) do
    for _, module in ipairs(modules) do
      line = line:gsub('^%s*' .. module .. ':', 'ansible.builtin.' .. module .. ':')
    end
    table.insert(content, line)
  end

  local file = io.open(file_path, 'w')
  for _, line in ipairs(content) do
    file:write(line .. '\n')
  end
  file:close()
end

local function process_path(path)
  local lfs = require 'lfs' -- LuaFileSystem, should be available in Neovim
  local attr = lfs.attributes(path)
  if not attr then
    print('The specified path does not exist: ' .. path)
    return
  end

  if attr.mode == 'directory' then
    for file in lfs.dir(path) do
      local file_path = path .. '/' .. file
      if lfs.attributes(file_path, 'mode') == 'file' then
        apply_replacement(file_path)
      end
    end
  elseif attr.mode == 'file' then
    apply_replacement(path)
  else
    print('The specified path is neither a directory nor a file: ' .. path)
  end

  print 'Replacement complete.'
end

-- Neovim command definition
vim.api.nvim_create_user_command('AnsibleReplaceDeprecated', function(input)
  process_path(input.args)
end, { nargs = 1 })
