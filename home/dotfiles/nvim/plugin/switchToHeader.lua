local function file_exists(name)
    local f = io.open(name, "r")
    return f ~= nil and io.close(f)
end

local function get_ext(file)
    --find index of last . in name
    local j = -1
    for i = string.len(file), 1, -1 do
        if string.match(string.sub(file, i, i), "%.") then
            j = i
            break
        end
    end
    return string.sub(file, j + 1)
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
    local extension = get_ext(bufName)
    local extensions = mappings[extension]
    if not extensions then
        print("have no extensions for " .. extension)
        return
    end
    -- try mappings...
    for i = 1, #extensions do
        local new_file_name = string.gsub(bufName, extension .. "$", extensions[i])
        -- if header/implementation exists
        if file_exists(new_file_name) then
            -- switch to it
            vim.cmd.edit(new_file_name)
            return
        end
    end
end

vim.keymap.set("n", "<leader>gh", switch_header_impl)
