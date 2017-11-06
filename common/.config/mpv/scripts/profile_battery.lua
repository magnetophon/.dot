-- If the laptop is on battery, the profile set in the config will be choosen,
-- else the one defined with „hqprofile“ is used.
local hqprofile = "opengl-hq"
local utils = require 'mp.utils'
if mp.get_property_bool("option-info/profile/set-from-commandline") == true then
    return
end
t = {}
t.args = {"cat", "/sys/class/power_supply/AC/online"}
res = utils.subprocess(t)
if res.stdout ~= "0\n" then
    mp.msg.info("On AC, setting high-quality options.")
    mp.commandv("apply-profile", hqprofile)
end
