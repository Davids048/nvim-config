-- vim.g.clipboard = {
--   name = 'tmux',
--   copy = {
--     ['+'] = 'tmux load-buffer -',
--     ['*'] = 'tmux load-buffer -',
--   },
--   paste = {
--     ['+'] = 'tmux save-buffer -',
--     ['*'] = 'tmux save-buffer -',
--   },
-- }
function Copy_sys()
  if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
    require('osc52').copy_register('+')
  end
end

vim.api.nvim_create_autocmd('TextYankPost', {callback = Copy_sys})


local function copy(lines, _)
  require('osc52').copy(table.concat(lines, '\n'))
end

local function paste()
  return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
end

vim.g.clipboard = {
  name = 'osc52',
  copy = {['+'] = copy, ['*'] = copy},
  paste = {['+'] = paste, ['*'] = paste},
}

-- Now the '+' register will copy to system clipboard using OSC52
vim.keymap.set('n', '<leader>c', '"+y')
vim.keymap.set('n', '<leader>cc', '"+yy')


