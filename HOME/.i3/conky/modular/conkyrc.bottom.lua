-- vim: ts=4 sw=4 noet ai cindent syntax=lua

--[[
Conky, a system monitor, based on torsmo
]]

conky.config = {
    out_to_x = false,
    out_to_console = true,
    short_units = true,
    update_interval = 1
}

home = os.getenv("HOME")
dofile(home .. '/.i3/conky/modular/' .. 'jsonhelper.lua')
dofile(home .. '/.i3/conky/modular/' .. 'jsonparts.lua')

--[[
-- if you care about performance, comment-out this variable.
disabled = ''
    .. parts.mpd .. ','
    .. parts.mem .. ','
    .. parts.uptime .. ','
    .. parts.host .. ','
    .. parts.volume .. ','
    .. parts.machine
]]

enabled = ''
    .. parts.cputemp .. ',' 
    .. parts.download .. ','
    .. parts.upload .. ','
    .. parts.memory .. ','
    .. parts.cpu0 .. ','
    .. parts.battery
  
conky.text = [[ 
[ 
]] .. enabled .. [[,
]] .. parts.date .. [[, 
]] .. parts.time .. [[ 
],
]]





