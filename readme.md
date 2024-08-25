<p align="center">
    <img width="140" src="https://icons.iconarchive.com/icons/iconarchive/red-orb-alphabet/128/Letter-M-icon.png" />  
    <h1 align="center">Hi 👋, I'm MaDHouSe</h1>
    <h3 align="center">A passionate allround developer </h3>    
</p>

<p align="center">
  <a href="https://github.com/MaDHouSe79/mh-blackmarket/issues">
    <img src="https://img.shields.io/github/issues/MaDHouSe79/mh-blackmarket"/> 
  </a>
  <a href="https://github.com/MaDHouSe79/mh-blackmarket/watchers">
    <img src="https://img.shields.io/github/watchers/MaDHouSe79/mh-blackmarket"/> 
  </a> 
  <a href="https://github.com/MaDHouSe79/mh-blackmarket/network/members">
    <img src="https://img.shields.io/github/forks/MaDHouSe79/mh-blackmarket"/> 
  </a>  
  <a href="https://github.com/MaDHouSe79/mh-blackmarket/stargazers">
    <img src="https://img.shields.io/github/stars/MaDHouSe79/mh-blackmarket?color=white"/> 
  </a>
  <a href="https://github.com/MaDHouSe79/mh-blackmarket/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/MaDHouSe79/mh-blackmarket?color=white"/> 
  </a>      
</p>

# My Youtube and Discord Channel
- [Subscribe](https://www.youtube.com/c/@MaDHouSe79) 
- [Discord](https://discord.gg/vJ9EukCmJQ)

# MH-BlackMarket
- just an easy blackmarket that uses blackmoney to buy stuff.

# Dependencies
- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-inventory](https://github.com/qbcore-framework/qb-inventory)
- [qb-target](https://github.com/qbcore-framework/qb-target)

# Install
- Step 1: Create a folder `[mh]` in `resources`. 
- Step 2: Put `mh-blackmarket` in to `resources/[mh]`.
- Step 3: Add in sever.cfg after `ensure [standalone]` add -> `ensure [mh]`
- Step 4: Restart the server.

# NOTE FOR Blackmoney in qb-core
- You need to edit `qb-core/config.lua` to this below and add `black_money` to this tables.
```lua
QBConfig.Money.MoneyTypes = { cash = 500, bank = 5000, crypto = 0, black_money = 0 }
QBConfig.Money.DontAllowMinus = { 'cash', 'crypto', 'black_money' }
```

# Replace Code in qb-inventory
- in `qb-inventory/server/main.lua` around 336
```lua
QBCore.Functions.CreateCallback('qb-inventory:server:attemptPurchase', function(source, cb, data)
    local itemInfo = data.item
    local amount = data.amount
    local shop = string.gsub(data.shop, 'shop%-', '')
    local price = itemInfo.price * amount
    local Player = QBCore.Functions.GetPlayer(source)

    if not Player then
        cb(false)
        return
    end

    local shopInfo = RegisteredShops[shop]
    if not shopInfo then
        cb(false)
        return
    end

    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)
    if shopInfo.coords then
        local shopCoords = vector3(shopInfo.coords.x, shopInfo.coords.y, shopInfo.coords.z)
        if #(playerCoords - shopCoords) > 10 then
            cb(false)
            return
        end
    end

    if not CanAddItem(source, itemInfo.name, amount) then
        TriggerClientEvent('QBCore:Notify', source, 'Cannot hold item', 'error')
        cb(false)
        return
    end

    local cashType = 'cash'
    local purchase = 'shop-purchase'
    if data.shop:find('blackShop-') then 
        cashType = 'black_money'
        purchase = 'blackmarket-purchase'
    end

    if Player.PlayerData.money[cashType] >= price then
        Player.Functions.RemoveMoney(cashType, price, purchase)
        AddItem(source, itemInfo.name, amount, nil, itemInfo.info, purchase)
        TriggerEvent('qb-shops:server:UpdateShopItems', shop, itemInfo, amount)
        cb(true)
    else
        if cashType == 'black_money' then
            TriggerClientEvent('QBCore:Notify', source, 'You do not have enough blackmoney', 'error')
        else
            TriggerClientEvent('QBCore:Notify', source, 'You do not have enough money', 'error')
        end
        cb(false)
    end
end)
```

# How to change marketbills to black_money 
- The black_money uses the item amount as a number, 
- and the marketbills uses the item amount as a table.
- so you need to edit that part of the code.

- From 
```lua
local worth = {value=10} -- table
Player.Functions.AddItem('marketbills', worth)    -- to add marketbills
Player.Functions.RemoveItem('marketbills', worth) -- to remove marketbills
```
- To
```lua
local amount = 10 -- number
Player.Functions.AddMoney('black_money', amount, nil)    -- to add blackmoney
Player.Functions.RemoveMoney('black_money', amount, nil) -- to remove blackmoney
```

# LICENSE
[GPL LICENSE](./LICENSE)<br />
&copy; [MaDHouSe79](https://www.youtube.com/@MaDHouSe79)
