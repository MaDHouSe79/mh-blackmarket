local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add('blackmoney', 'Check Blackmoney Balance', {}, false, function(source, _)
    local Player = QBCore.Functions.GetPlayer(source)
    local amount = Player.PlayerData.money.black_money
    TriggerClientEvent('hud:client:ShowAccounts', source, 'black_money', amount)
end)