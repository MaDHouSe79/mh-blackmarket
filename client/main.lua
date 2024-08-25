--[[ ===================================================== ]] --
--[[            MH Blackmarket Script by MaDHouSe          ]] --
--[[ ===================================================== ]] --
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local isLoggedIn = false
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

local function SetPedOutfit(ped, outfit)
    local data = Config.Outfit
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

local function OpenShop()
    if PlayerData.money['black_money'] < Config.MinAmountBlackMoney then
        QBCore.Functions.Notify(Lang:t('notify.no_blackmoney'))
    else
        local items = {}
        local slot = 1
        for _, item in pairs(Config.Items['shop']) do
            local itemInfo = QBCore.Shared.Items[item.name:lower()]
            if itemInfo then
                items[slot] = {
                    name = itemInfo['name'],
                    amount = tonumber(item.amount),
                    info = item.info or {},
                    label = itemInfo['label'],
                    description = itemInfo['description'] or '',
                    weight = itemInfo['weight'],
                    type = itemInfo['type'],
                    unique = itemInfo['unique'],
                    useable = itemInfo['useable'],
                    price = item.price,
                    image = itemInfo['image'],
                    slot = slot,
                }
                slot = slot + 1
            end
        end         
        local formattedInventory = {name = 'shop-blackmarket', label = "BlackMarket", maxweight = 5000000, slots = #items, inventory = items}
        TriggerEvent('qb-inventory:client:openInventory', PlayerData.items, formattedInventory)
    end
end

local function CreateShopPed(data)
    local model = "g_m_y_korean_01"
    if Config.UseCustumPedModel then model = Config.CustumPedModel end
    local current = GetHashKey(model)
    loadModel(current)
    local ped = CreatePed(0, current, data.coords.x, data.coords.y, data.coords.z - 1, data.heading, false, false)
    if Config.UseCustumPedModel then SetPedOutfit(ped, Config.Outfit) end
    SetEntityAsMissionEntity(ped, true, true)
    TaskStartScenarioInPlace(ped, data.scenario, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetPedKeepTask(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    exports['qb-target']:AddTargetEntity(ped, {
        options = {{
            label = Lang:t('target.talk_to'),
            icon = 'fa-solid fa-stash',
            action = function()
                OpenShop(data.id)
            end,
            canInteract = function(entity, distance, data)
                if not isLoggedIn then return false end
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
                SetBlipSprite(blip, v.blip.sprite)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, 0.7)
                SetBlipAsShortRange(blip, true)
                SetBlipColour(blip, v.blip.color)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentSubstringPlayerName(v.label)
                EndTextCommandSetBlipName(blip)
                blips[#blips + 1] = blip
            end
            local data = {id = k, ped = v.ped, coords = v.coords, heading = v.heading, scenario = v.scenario}
            CreateShopPed(data)
        end
    end
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    isLoggedIn = true
    Init()
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
        isLoggedIn = true
        Init()
    end
end)
