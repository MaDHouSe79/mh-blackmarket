local QBCore = exports['qb-core']:GetCoreObject()
local blips = {}
local peds = {}

local function DeleteBlips()
    if #blips > 0 then
        for k, v in pairs(blips) do
            RemoveBlip(v)
        end
        blips = {}
    end
end

local function DeletePeds()
    if #peds > 0 then
        for k, v in pairs(peds) do
            DeletePed(v)
            DeleteEntity(v)
        end
        peds = {}
    end
end

local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
end

local function CreateShopPed(data)
    local model = data.ped
    local current = GetHashKey(model)
    loadModel(current)
    local ped = CreatePed(0, current, data.coords.x, data.coords.y, data.coords.z - 1, data.heading, false, false)
    SetEntityAsMissionEntity(ped, true, true)
    TaskStartScenarioInPlace(ped, data.scenario, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    exports['qb-target']:AddTargetEntity(ped, {
        options = {{
            label = "Talk to STEVE-O",
            icon = 'fa-solid fa-stash',
            action = function()
                local blackmoney = exports['qb-inventory']:HasItem("blackmoney", Config.MinAmountBlackMoneyIninventory)
                if blackmoney == false then
                    return QBCore.Functions.Notify("Je hebt geen zwart geld bij je..")
                else
                    TriggerEvent('mh-blackmarket:client:openshop', data.id)
                end
            end,
            canInteract = function(entity, distance, data)
                return true
            end
        }},
        distance = 2.0
    })
    peds[#peds + 1] = ped
end

local function Init()
    DeletePeds()
    DeleteBlips()
    for k, v in pairs(Config.Shops) do
        if v.enable then
            if v.showBlip then
                local blip = AddBlipForCoord(v.coords)
                SetBlipSprite(blip, 469)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, 0.7)
                SetBlipAsShortRange(blip, true)
                SetBlipColour(blip, 2)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentSubstringPlayerName(v.label)
                EndTextCommandSetBlipName(blip)
                blips[#blips + 1] = blip
            end
            local data = {
                id = k,
                ped = v.ped,
                coords = v.coords,
                heading = v.heading,
                scenario = v.scenario
            }
            CreateShopPed(data)
        end
    end
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Init()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    DeleteBlips()
    DeletePeds()
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        DeleteBlips()
        DeletePeds()
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        Init()
    end
end)

RegisterNetEvent("mh-blackmarket:client:openshop", function(shopId)
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "market", Config.Shops[shopId])
end)
