--[[ ===================================================== ]] --
--[[            MH Blackmarket Script by MaDHouSe          ]] --
--[[ ===================================================== ]] --
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData, blips, peds, isLoggedIn = {}, {}, {}, false

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

local function LoadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
end

local function SetPedOutfit(ped, outfit)
    local data = CL_Config.Outfit
    if outfit ~= nil then data = outfit end
    if data["hair"] ~= nil then SetPedComponentVariation(ped, 2, data["hair"].item, data["hair"].texture, 0) end
    if data["beard"] ~= nil then SetPedComponentVariation(ped, 1, data["beard"].item, data["beard"].texture, 0) end
    if data["pants"] ~= nil then SetPedComponentVariation(ped, 4, data["pants"].item, data["pants"].texture, 0) end
    if data["arms"] ~= nil then SetPedComponentVariation(ped, 3, data["arms"].item, data["arms"].texture, 0) end
    if data["t-shirt"] ~= nil then SetPedComponentVariation(ped, 8, data["t-shirt"].item, data["t-shirt"].texture, 0) end
    if data["vest"] ~= nil then SetPedComponentVariation(ped, 9, data["vest"].item, data["vest"].texture, 0) end
    if data["torso2"] ~= nil then SetPedComponentVariation(ped, 11, data["torso2"].item, data["torso2"].texture, 0) end
    if data["shoes"] ~= nil then SetPedComponentVariation(ped, 6, data["shoes"].item, data["shoes"].texture, 0) end
    if data["bag"] ~= nil then SetPedComponentVariation(ped, 5, data["bag"].item, data["bag"].texture, 0) end
    if data["decals"] ~= nil then SetPedComponentVariation(ped, 10, data["decals"].item, data["decals"].texture, 0) end
    if data["mask"] ~= nil then SetPedComponentVariation(ped, 1, data["mask"].item, data["mask"].texture, 0) end
    if data["bag"] ~= nil then SetPedComponentVariation(ped, 5, data["bag"].item, data["bag"].texture, 0) end
    if data["hat"] ~= nil and data["hat"].item ~= -1 and data["hat"].item ~= 0 then SetPedPropIndex(ped, 0, data["hat"].item, data["hat"].texture, true) end
    if data["glass"] ~= nil and data["glass"].item ~= -1 and data["glass"].item ~= 0 then SetPedPropIndex(ped, 1, data["glass"].item, data["glass"].texture, true) end
    if data["ear"] ~= nil and data["ear"].item ~= -1 and data["ear"].item ~= 0 then SetPedPropIndex(ped, 2, data["ear"].item, data["ear"].texture, true) end
end

local function CreateShopPed(data)
    local model = "g_m_y_korean_01"
    if CL_Config.UseCustumPedModel then model = "mp_m_freemode_01" end
    local current = GetHashKey(model)
    LoadModel(current)
    local ped = CreatePed(0, current, data.shop.coords.x, data.shop.coords.y, data.shop.coords.z - 1, data.shop.coords.w, false, false)
    peds[#peds + 1] = ped
    if CL_Config.UseCustumPedModel then SetPedOutfit(ped, CL_Config.Outfit) end
    SetEntityAsMissionEntity(ped, true, true)
    SetEntityHeading(ped, data.shop.coords.w)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_MOBILE", true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetPedKeepTask(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    exports['qb-target']:AddTargetEntity(ped, {
        options = {{
            label = Lang:t('target.talk_to'),
            icon = 'fa-solid fa-stash',
            action = function()
                TriggerServerEvent('mh-blackmarket:server:openShop', data)
            end,
            canInteract = function(entity, distance, data)
                if not isLoggedIn then return false end
                return true
            end
        }},
        distance = 2.0
    })
end

local function Init(config)
    if not isLoggedIn then
        isLoggedIn = true
        DeletePeds()
        DeleteBlips()
        for id, shop in pairs(config) do
            if shop.enable then
                if shop.blip.show then
                    local blip = AddBlipForCoord(v.coords)
                    SetBlipSprite(blip, shop.blip.sprite)
                    SetBlipDisplay(blip, 4)
                    SetBlipScale(blip, 0.7)
                    SetBlipAsShortRange(blip, true)
                    SetBlipColour(blip, v.blip.color)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentSubstringPlayerName(shop.label)
                    EndTextCommandSetBlipName(blip)
                    blips[#blips + 1] = blip
                end
                CreateShopPed({id = id, shop = shop})
            end
        end
    end
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent('mh-blackmarket:server:onjoin')
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
    isLoggedIn = false
    DeleteBlips()
    DeletePeds()
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        PlayerData = {}
        isLoggedIn = false
        DeleteBlips()
        DeletePeds()
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        PlayerData = QBCore.Functions.GetPlayerData()
        TriggerServerEvent('mh-blackmarket:server:onjoin')
    end
end)

RegisterNetEvent('mh-blackmarket:client:sendConfig', function(config)
    Init(config)
end)
