--[[ ===================================================== ]] --
--[[            MH Blackmarket Script by MaDHouSe          ]] --
--[[ ===================================================== ]] --
local Translations = {
    notify = {
        ['no_blackmoney'] = "You don't have any black money with you...",
    },
    target = {
        ['talk_to'] = "Talk to MaDHouSe",
    }
}

Lang = Locale:new({
    phrases = Translations, 
    warnOnMissing = true
})
