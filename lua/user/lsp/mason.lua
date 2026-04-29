local status_ok, mason = pcall(require, "mason")
if not status_ok then
    print("Failed to load mason")
    return
end

local servers = {
    "asm_lsp",
    "bashls",
    "clangd",
    "cmake",
    "csharp_ls",
    "cssls",
    "cssmodules_ls",
    "dockerls",
    "gdscript",
    "glsl_analyzer",
    "html",
    "jsonls",
    "lemminx",
    "ltex",
    "lua_ls",
    "marksman",
    "pyright",
    "sqlls",
    "terraformls",
    "ts_ls",
    "vimls",
    "yamlls",
    "zls",
}

mason.setup({
    ui = {
        border = "none",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
})

local servers_to_enable = {}

for _, server in pairs(servers) do
    server = vim.split(server, "@")[1]

    local opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
    }

    local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
    if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    vim.lsp.config(server, opts)
    table.insert(servers_to_enable, server)
end

vim.lsp.enable(servers_to_enable)
