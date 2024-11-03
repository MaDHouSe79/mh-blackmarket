--[[ ===================================================== ]] --
--[[            MH Blackmarket Script by MaDHouSe          ]] --
--[[ ===================================================== ]] --
local QBCore = exports['qb-core']:GetCoreObject()

local function ExploitBan(src)
    local script = GetCurrentResourceName()
    local reason = 'You were permanently banned by the server for: Exploiting'
    MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {GetPlayerName(src), QBCore.Functions.GetIdentifier(src, 'license'), QBCore.Functions.GetIdentifier(src, 'discord'), QBCore.Functions.GetIdentifier(src, 'ip'), reason, 2147483647, script})
    TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Banned', 'red', string.format('%s was banned by %s for %s', GetPlayerName(src), script, reason), true)
    DropPlayer(src, 'You were permanently banned by the server for: Exploiting')
end

RegisterServerEvent('mh-blackmarket:server:onjoin', function()
    local src = source
    TriggerClientEvent('mh-blackmarket:client:sendConfig', src, SV_Config.Shops)
end)

RegisterServerEvent('mh-blackmarket:server:openShop', function(shopData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local coords = GetEntityCoords(GetPlayerPed(src))
        if #(vector3(shopData.shop.coords.x, shopData.shop.coords.y, shopData.shop.coords.z) - vector3(coords.x, coords.y, coords.z)) > 2.0 then
            ExploitBan(src)
        else
            if Player.PlayerData.money.black_money <= 0 then
                QBCore.Functions.Notify(src, Lang:t('notify.no_blackmoney'))
            else
                if SV_Config.Shops[shopData.id] then
                    local shopitems = {}
                    local slot = 1
                    for _, item in pairs(SV_Config.Shops[shopData.id].items) do
                        shopitems[#shopitems + 1] = { name = item.name, amount = item.amount, price = item.price, slot = slot }
                        slot = slot + 1
                    end
                    if SV_Config.UseOldInventory then
                        exports['qb-inventory']:OpenInventory('shop', 'black_market-'..shopData.id, shopitems, src)
                    elseif not SV_Config.UseOldInventory then
                        exports['qb-inventory']:CreateShop({name = 'blackmarket-'..shopData.id, label = SV_Config.Shops[shopData.id].label, slots = #shopitems, items = shopitems})
                        exports['qb-inventory']:OpenShop(src, 'blackmarket-'..shopData.id)
                    end
                else
                    QBCore.Functions.Notify(src, Lang:t('notify.shop_not_found'))
                end
            end
        end
    end
end)
