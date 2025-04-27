local image_extensions = {
  png = true,
  jpg = true,
  jpeg = true,
  gif = true,
  svg = true,
  webp = true,
  bmp = true,
  tiff = true,
}

local augroup = vim.api.nvim_create_augroup("ImgVue", { clear = true})

local function open_image(bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local full_path = vim.fn.fnamemodify(bufname, ':p')
    local extension = full_path:match('%.([^%.]+)$')

    if not extension or not image_extensions[extension:lower()] then
        return
    end

    local cmd = 'xdg-open'
    vim.fn.jobstart({ cmd, full_path }, { detach = true })

    vim.schedule(function()
        local buffers = vim.api.nvim_list_bufs()
        local is_only = #buffers == 1 and buffers[1] == bufnr

        if is_only then
            vim.cmd('enew')
        end

        pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
    end)
end

local function setup()
    vim.api.nvim_create_autocmd('BufReadPre', {
        group = augroup,
        desc = "Open image in default application when opened in neovim",
        pattern = '*',
        callback = function(args)
            open_image(args.buf)
        end,
    })
end

return { setup = setup }
