--[[ ===================================================== ]] --
--[[            MH Blackmarket Script by MaDHouSe          ]] --
--[[ ===================================================== ]] --
local Translations = {
    notify = {
        ['no_blackmoney'] = "You don't have any black money with you...",
        ['shop_not_found'] = "Shop does not exist",
    },
    target = {
        ['talk_to'] = "Talk to MaDHouSe",
    }
}

if GetConvar('qb_locale', 'en') == 'en' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
