local M = {}

local default_extensions = {
    png = true,
    jpg = true,
    jpeg = true,
    gif = true,
    svg = true,
    webp = true,
    bmp = true,
    tiff = true,
}

M.setup = function(config)
    config = config or {}
    local use_defaults = config.use_default_extensions ~= false

    M.image_extensions = {}

    if use_defaults then
        for ext, _ in pairs(default_extensions) do
            M.image_extensions[ext] = true
        end
    end

    local extensions = config.extensions or {}

    if vim.isarray(extensions) then
        for _, ext in ipairs(extensions) do
            M.image_extensions[ext:lower()] = true
        end
    else
        vim.notify('Incorrect config format', vim.log.levels.WARN)
    end
end

M.open_image = function(bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local full_path = vim.fn.fnamemodify(bufname, ':p')
    local extension = full_path:match('%.([^%.]+)$')

    if not extension or not M.image_extensions[extension:lower()] then
        return
    end

    local cmd
    if vim.fn.has('mac') == 1 then
        cmd = 'open'
    elseif vim.fn.has('unix') == 1 then
        cmd = 'xdg-open'
    elseif vim.fn.has('win32') == 1 then
        cmd = 'start'
    else
        vim.notify('Unsupported OS for opening images', vim.log.levels.ERROR)
        return
    end

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

return M
