--[[ ===================================================== ]] --
--[[            MH Blackmarket Script by MaDHouSe          ]] --
--[[ ===================================================== ]] --
SV_Config = {}

SV_Config.Items = {
    ['shop1'] = {
        {name = "weapon_knife",        price = 500,   amount = 1},
        {name = "weapon_knuckle",      price = 1000,  amount = 1},
        {name = "weapon_golfclub",     price = 1200,  amount = 1},
        {name = "pistol_ammo",         price = 100,   amount = 1},
        {name = "handcuffs",           price = 500,   amount = 1},
        {name = "armor",               price = 300,   amount = 1},
    },
    ['shop2'] = {
        {name = "weapon_combatpistol", price = 6000,  amount = 1},
        {name = "weapon_pistol",       price = 6000,  amount = 1},
    },
    ['shop3'] = {
        {name = "ifaks",               price = 500,   amount = 10},
        {name = "trojan_usb",          price = 2000,  amount = 1},
        {name = "advancedlockpick",    price = 2000,  amount = 10},
    },
    ['shop4'] = {
        {name = "security_card_01",    price = 10000, amount = 1},
        {name = "security_card_02",    price = 10000, amount = 1},
    },
}

SV_Config.Shops = {
    {
        enable = true,                                   -- Shop enable or disable
        label  = "Blackmarket",                          -- Shop inventory label
        items  = SV_Config.Items['shop1'],               -- Shop inventory items
        blip   = {sprite = 280, color = 2, show = true}, -- Shop blip on the map
        coords = vector4(170.73, -993.54, 30.09, 76.48), -- Shop ped coords
    },
    {
        enable = true,
        label  = "Blackmarket",
        items  = SV_Config.Items['shop2'],
        blip   = {sprite = 280, color = 2, show = true},
        coords = vector4(44.8160, -1029.0225, 79.7362, 161.5302),
    },
    {
        enable = true,
        label  = "Blackmarket",
        items  = SV_Config.Items['shop3'],
        blip   = {sprite = 280, color = 2, show = true},
        coords = vector4(608.8735, -459.2349, 24.7449, 178.1611),
    },
}