local function file_exists(name)
    local f = io.open(name, "r")
    return f ~= nil and io.close(f)
end

local mappings = {
    h = { "c", "cc", "cpp" },
    c = { "h" },
    cc = { "cc" },
    cp = { "h" },
    ml = { "mli" },
    mli = { "ml" },
}

local function switch_header_impl()
    local bufName = vim.api.nvim_buf_get_name(0)
    for key, val in pairs(mappings) do
        -- If we have a match
        local file_ext = key .. "$"
        if string.match(bufName, file_ext) then
            -- try mappings...
            for i = 1, #val do
                local new_file_name = string.gsub(bufName, file_ext, val[i])
                -- if header/implementation exists
                if file_exists(new_file_name) then
                    -- switch to it
                    vim.cmd.edit(new_file_name)
                    return
                end
            end
        end
    end
end

vim.keymap.set("n", "<leader>gh", switch_header_impl)
