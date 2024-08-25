--[[ ===================================================== ]] --
--[[            MH Blackmarket Script by MaDHouSe          ]] --
--[[ ===================================================== ]] --
local script = GetCurrentResourceName()

local function checkVersion(err, responseText, headers)
    curVersion = LoadResourceFile(script, "version")
    if responseText == nil then
        print("[^6"..script.."^7] Check for script update ^1FAILED^7")
        return
    end
    if curVersion ~= responseText and tonumber(curVersion) < tonumber(responseText) then
        updateavail = true
        print("\n^1----------------------------------------------------------------------------------^7")
        print(script.." is outdated, latest version is: ^2"..responseText.."^7, installed version: ^1"..curVersion.."^7!\nupdate from https://github.com/MaDHouSe79/"..script.."")
        print("^1----------------------------------------------------------------------------------^7")
    elseif tonumber(curVersion) > tonumber(responseText) then
        print("\n^3----------------------------------------------------------------------------------^7")
        print(script.." git version is: ^2"..responseText.."^7, installed version: ^1"..curVersion.."^7!")
		print("READ THE UPDATES.md to see if you have to make any changes!!")
        print("^3----------------------------------------------------------------------------------^7")
    else
        print("\n"..script.." is up to date. (^2"..curVersion.."^7)")
    end
end

Citizen.CreateThread( function()
    PerformHttpRequest("https://raw.githubusercontent.com".."/MaDHouSe79/"..script.."/master/version", checkVersion, "GET")
end)

local QBCore = exports['qb-core']:GetCoreObject()
QBCore.Commands.Add('blackmoney', 'Check Blackmoney Balance', {}, false, function(source, _)
    local Player = QBCore.Functions.GetPlayer(source)
    local amount = Player.PlayerData.money.black_money
    TriggerClientEvent('hud:client:ShowAccounts', source, 'black_money', amount)
end)
