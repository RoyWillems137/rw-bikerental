-- Checkt of de speler het huurbedrag kan betalen
ESX.RegisterServerCallback('rw-bikerental:canAfford', function(source, cb, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getMoney() >= price)
end)

-- Laat de speler betalen
RegisterNetEvent('rw-bikerental:pay', function(price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
    end
end)

-- Stuur alle bikes naar de client
RegisterNetEvent('rw-bikerental:requestBikeSpawns', function()
    local src = source
    for i, loc in pairs(Config.BikeSpawns) do
        for j = 1, #loc.coords do
            local key = tostring(i) .. "_" .. tostring(j)
            TriggerClientEvent('rw-bikerental:spawnStaticBike', src, key, loc.model[j], loc.coords[j])
        end

        -- Blip laten maken
        TriggerClientEvent('rw-bikerental:createBlip', src, loc.blip)
    end
end)

-- Vraag om een fiets opnieuw te spawnen
RegisterNetEvent('rw-bikerental:respawnBike', function(index)
    for i, loc in pairs(Config.BikeSpawns) do
        for j = 1, #loc.coords do
            local key = tostring(i) .. "_" .. tostring(j)
            if key == index then
                TriggerClientEvent('rw-bikerental:spawnStaticBike', source, key, loc.model[j], loc.coords[j])
                return
            end
        end
    end
end)
