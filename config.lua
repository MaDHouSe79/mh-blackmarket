--[[ ===================================================== ]] --
--[[            MH Blackmarket Script by MaDHouSe          ]] --
--[[ ===================================================== ]] --
Config = {}

Config.MinAmountBlackMoney = 1 -- you need atleast this amount of blackmoney to use this shop.

Config.Items = {
    ['shop'] = {
        [1] = {name = "acetone", price = 70, amount = 10, info = {}, type = "item", slot = 1},
        [2] = {name = "joint_ak47", price = 20, amount = 10, info = {}, type = "item", slot = 2},
        [3] = {name = "armor", price = 300, amount = 5, info = {}, type = "item", slot = 3},
        [4] = {name = "weapon_combatpistol", price = 6000, amount = 5, info = {}, type = "item", slot = 4},
        [5] = {name = "lithium", price = 100, amount = 5, info = {}, type = "item", slot = 5},
        [6] = {name = "methlab", price = 100, amount = 5, info = {}, type = "item", slot = 6},
        [7] = {name = "oxy", price = 50, amount = 5, info = {}, type = "item", slot = 7},
        [8] = {name = "pistol_ammo", price = 100, amount = 5, info = {}, type = "item", slot = 8},
        [9] = {name = "trojan_usb", price = 2000, amount = 5, info = {}, type = "item", slot = 9},
        [10] = {name = "weapon_pistol", price = 6000, amount = 5, info = {}, type = "item", slot = 10},
    },
}

Config.Shops = {
    [1] = {
        enable = true,
        showBlip = true,
        label = "Blackmarket",
        senario = "WORLD_HUMAN_STAND_MOBILE",
        coords = vector3(170.73, -993.54, 30.09),
        heading = 76.48,
        items = Config.Items['shop'],
        blip = {sprite = 280, color = 2},
    },
    [2] = {
        enable = false,
        showBlip = false,
        label = "Blackmarket",
        senario = "WORLD_HUMAN_STAND_MOBILE",
        coords = vector3(-1470.28, -367.31, 40.11),
        heading = 43,
        items = Config.Items['shop'],
        blip = {sprite = 280, color = 2},
    },
    [3] = {
        enable = false,
        showBlip = false,
        label = "Blackmarket",
        senario = "WORLD_HUMAN_STAND_MOBILE",
        coords = vector3(-1470.28, -367.31, 40.11),
        heading = 43,
        items = Config.Items['shop'],
        blip = {sprite = 280, color = 2},
    }
}

-- Costum ped
Config.UseCustumPedModel = true
Config.CustumPedModel = "mp_m_freemode_01"
Config.Outfit = {
    ['hair'] = { item = 19, texture = 4 },    -- Hear
    ['beard'] = { item = 2, texture = 0 },    -- Beard
    ["pants"] = { item = 10, texture = 0 },   -- Pants
    ["arms"] = { item = 12, texture = 0 },    -- Arms
    ["t-shirt"] = { item = 21, texture = 0 }, -- T Shirt
    ["vest"] = { item = 0, texture = 0 },     -- Body Vest
    ["torso2"] = { item = 32, texture = 0 },  -- Jacket
    ["shoes"] = { item = 10, texture = 0 },   -- Shoes
    ["decals"] = { item = 0, texture = 0 },   -- Neck Accessory
    ["bag"] = { item = 0, texture = 0 },      -- Bag
    ["hat"] = { item = 0, texture = 0 },      -- Hat
    ["glass"] = { item = 23, texture = 11 },  -- Glasses
    ["mask"] = { item = 0, texture = 0 }      -- Mask
}
