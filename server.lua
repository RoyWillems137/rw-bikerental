ESX.RegisterServerCallback('rw-bikerental:canAfford', function(source, cb, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getMoney() >= price)
end)

RegisterNetEvent('rw-bikerental:pay', function(price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
    end
end)
