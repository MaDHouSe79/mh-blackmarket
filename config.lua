Config = {}

Config.MinAmountBlackMoneyIninventory = 1 -- you need atleast 1 blackmoney to use this shop

Config.Items = {
    ['shop'] = {
        [1] = {
            name = "acetone",
            price = 70,
            amount = 10,
            info = {},
            type = "item",
            slot = 1
        },
        [2] = {
            name = "joint_ak47",
            price = 20,
            amount = 10,
            info = {},
            type = "item",
            slot = 2
        },
        [3] = {
            name = "armor",
            price = 300,
            amount = 5,
            info = {},
            type = "item",
            slot = 3
        },
        [4] = {
            name = "weapon_combatpistol",
            price = 6000,
            amount = 5,
            info = {},
            type = "item",
            slot = 4
        },
        [5] = {
            name = "lithium",
            price = 100,
            amount = 5,
            info = {},
            type = "item",
            slot = 5
        },
        [6] = {
            name = "methlab",
            price = 100,
            amount = 5,
            info = {},
            type = "item",
            slot = 6
        },
        [7] = {
            name = "oxy",
            price = 50,
            amount = 5,
            info = {},
            type = "item",
            slot = 7
        },
        [8] = {
            name = "pistol_ammo",
            price = 100,
            amount = 5,
            info = {},
            type = "item",
            slot = 8
        },
        [9] = {
            name = "trojan_usb",
            price = 2000,
            amount = 5,
            info = {},
            type = "item",
            slot = 9
        },
        [10] = {
            name = "weapon_pistol",
            price = 6000,
            amount = 5,
            info = {},
            type = "item",
            slot = 10
        },
    },
}

Config.Shops = {
    [1] = {
        enable = true,
        showBlip = true,
        label = "Blackmarket",
        ped = "S_M_M_TRUCKER_01", -- if Config.UseCustumPedModel = true then --[[it will ignore this ped model]] end ;).
        senario = "WORLD_HUMAN_STAND_MOBILE",
        coords = vector3(170.73, -993.54, 30.09),
        heading = 76.48,
        slots = 8,
        items = Config.Items['shop'],
    },
    [2] = {
        enable = false,
        showBlip = false,
        label = "Blackmarket",
        ped = "S_M_M_TRUCKER_01", -- if Config.UseCustumPedModel = true then --[[it will ignore this ped model]] end ;).
        senario = "WORLD_HUMAN_STAND_MOBILE",
        coords = vector3(-1470.28, -367.31, 40.11),
        heading = 43,
        slots = 8,
        items = Config.Items['shop'],
    },
    [3] = {
        enable = false,
        showBlip = false,
        label = "Blackmarket",
        ped = "S_M_M_TRUCKER_01", -- if Config.UseCustumPedModel = true then --[[it will ignore this ped model]] end ;).
        senario = "WORLD_HUMAN_STAND_MOBILE",
        coords = vector3(-1470.28, -367.31, 40.11),
        heading = 43,
        slots = 8,
        items = Config.Items['shop'],
    }
}