vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
  callback = function(ev)
    local bufnr = ev.buf
    local edit_watch = function()
      require("chezmoi.commands.__edit").watch(bufnr)
    end
    vim.schedule(edit_watch)
  end,
})

local actions = require('lir.actions')

require('lir').setup({
  mappings = {
    ['l'] = actions.edit,
    ['-'] = actions.up,
    ['h'] = actions.up,
    ['q'] = actions.quit,
    ['K'] = actions.mkdir,
    ['N'] = actions.newfile,
    ['R'] = actions.rename,
    ['Y'] = actions.yank_path,
    ['.'] = actions.toggle_show_hidden
  }
})

vim.cmd "nmap - :e %:h<cr>"
vim.cmd "autocmd FileType lir nmap <buffer> e :e <C-R>=expand('%') . '/'<CR>"
