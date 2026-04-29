local status_ok, rainbow_delimiters_setup = pcall(require, "rainbow-delimiters.setup")
if not status_ok then
    print("Failed to load rainbow-delimiters")
    return
end

local status_ok, rainbow_delimiters = pcall(require, "rainbow-delimiters")
if not status_ok then
    print("Failed to load rainbow-delimiters")
    return
end

rainbow_delimiters_setup.setup({
    strategy = {
        [""] = rainbow_delimiters.strategy["global"],
        vim = rainbow_delimiters.strategy["local"],
    },
    query = {
        [""] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    priority = {
        [""] = 110,
        lua = 210,
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    },
    blacklist = {
        'NvimTree',
        'TelescopePrompt',
        'TelescopeResults',
    },
})
