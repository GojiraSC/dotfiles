mp.add_key_binding("SPACE", "smart-pause", function()
    if mp.get_property("eof-reached") == "yes" then
        mp.set_property("time-pos", 0)
        mp.set_property("pause", "no")
    else
        mp.command("cycle pause")
    end
end, {repeatable = false})
