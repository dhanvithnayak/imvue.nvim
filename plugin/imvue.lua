local imvue = require("imvue")

local augroup = vim.api.nvim_create_augroup("ImgVue", { clear = true })

vim.api.nvim_create_autocmd('BufReadPre', {
    group = augroup,
    desc = "Open image in default application instead of opening as text in neovim",
    pattern = '*',
    callback = function(args)
        imvue.open_image(args.buf)
    end,
})
