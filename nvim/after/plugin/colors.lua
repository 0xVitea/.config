function SetColorScheme(color)
    -- Setup default color scheme
    color = color or 'kanagawa'

    vim.cmd.colorscheme(color)
end

SetColorScheme()
