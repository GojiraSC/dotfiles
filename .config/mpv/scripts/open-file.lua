mp.add_key_binding("o", "open-file", function()
    local pipe = io.popen("zenity --file-selection 2>/dev/null")
    if pipe then
        local file = pipe:read("*l")
        pipe:close()
        if file and file ~= "" then
            mp.commandv("loadfile", file)
        end
    end
end)
