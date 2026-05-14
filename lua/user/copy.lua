local M = {}

local function copy(text)
    -- Copy to system clipboard
    vim.fn.setreg("+", text)
    -- Copy to neovim clipboard
    vim.fn.setreg('"', text)
    vim.notify("Copied: " .. text)
end

-- Absolute path with line number: /home/user/project/module/main.py:86
M.absolute_path = function()
    local path = vim.fn.expand("%:p")
    if path == "" then
        vim.notify("No file in current buffer", vim.log.levels.WARN)
        return
    end
    copy(path .. ":" .. vim.fn.line("."))
end

-- Relative path with line number: module/main.py:86
M.relative_path = function()
    local path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
    if path == "" then
        vim.notify("No file in current buffer", vim.log.levels.WARN)
        return
    end
    copy(path .. ":" .. vim.fn.line("."))
end

-- File name with line number: main.py:86
M.file_name = function()
    local name = vim.fn.expand("%:t")
    if name == "" then
        vim.notify("No file in current buffer", vim.log.levels.WARN)
        return
    end
    copy(name .. ":" .. vim.fn.line("."))
end

-- Entire file contents
M.file_contents = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local contents = table.concat(lines, "\n")
    vim.fn.setreg("+", contents)
    vim.fn.setreg('"', contents)
    vim.notify("Copied entire file contents (" .. #lines .. " lines)")
end

return M
