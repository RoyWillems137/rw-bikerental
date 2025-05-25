local spawnedBikes = {}

-- Fietsen spawnen op basis van serverevent
RegisterNetEvent('rw-bikerental:spawnStaticBike', function(index, modelName, coords)
    local model = joaat(modelName)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end

    local bike = CreateVehicle(model, coords.xyz, coords.w, false, false)
    SetEntityAsMissionEntity(bike, true, true)
    SetVehicleColours(bike, 111, 111)
    SetVehicleExtraColours(bike, 0, 0)
    SetVehicleEnveffScale(bike, 0.0)
    FreezeEntityPosition(bike, true)
    SetVehicleDoorsLocked(bike, 2)
    SetVehicleNumberPlateText(bike, "RENTAL")

    spawnedBikes[index] = {entity = bike, model = modelName, coords = coords}

    exports.ox_target:addLocalEntity(bike, {
        {
            label = 'Huur fiets',
            icon = 'fa-solid fa-bicycle',
            onSelect = function()
                openRentalMenu(index)
            end
        }
    })
end)

-- Krijg spawns van server
CreateThread(function()
    TriggerServerEvent('rw-bikerental:requestBikeSpawns')
end)
-- Blips aanmaken voor alle locaties
RegisterNetEvent('rw-bikerental:createBlip', function(coords)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, Config.BlipSprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, Config.BlipColor)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.BlipName)
    EndTextCommandSetBlipName(blip)
end)

-- Menu openen
function openRentalMenu(index)
    local menuOptions = {}

    for _, opt in pairs(Config.RentalOptions) do
        table.insert(menuOptions, {
            title = opt.label,
            icon = 'fa-solid fa-clock',
            onSelect = function()
                checkAndStartRental(index, opt)
            end
        })
    end

    lib.registerContext({
        id = 'bike_rental_menu',
        title = 'Kies huurperiode',
        options = menuOptions
    })

    lib.showContext('bike_rental_menu')
end

-- Checken of speler kan betalen
function checkAndStartRental(index, rentalData)
    ESX.TriggerServerCallback('rw-bikerental:canAfford', function(canAfford)
        if canAfford then
            startRental(index, rentalData)
        else
            lib.notify({
                title = 'Fiets verhuur',
                description = 'Je hebt niet genoeg geld (€' .. rentalData.price .. ')',
                position = 'center-left',
                icon = 'fa-solid fa-bicycle',
                duration = 5000,
            })
        end
    end, rentalData.price)
end

-- Fiets geven
function startRental(index, rentalData)
    local data = spawnedBikes[index]
    if not data then return end

    local coords = GetEntityCoords(data.entity)
    local heading = GetEntityHeading(data.entity)
    local model = data.model

    DeleteEntity(data.entity)

    local modelHash = joaat(model)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do Wait(0) end

    local rentedBike = CreateVehicle(modelHash, coords, heading, true, false)
    SetEntityAsMissionEntity(rentedBike, true, true)
    SetVehicleNumberPlateText(rentedBike, 'RENTAL')
    SetVehicleColours(rentedBike, 111, 111)
    SetVehicleExtraColours(rentedBike, 0, 0)
    SetVehicleEnveffScale(rentedBike, 0.0)
    TaskWarpPedIntoVehicle(PlayerPedId(), rentedBike, -1)

    TriggerServerEvent('rw-bikerental:pay', rentalData.price)

    lib.notify({
        title = 'Fiets verhuur',
        description = 'Je hebt de fiets gehuurd voor €' .. rentalData.price,
        position = 'center-left',
        icon = 'fa-solid fa-bicycle',
        duration = 5000,
    })

    CreateThread(function()
        Wait(rentalData.time * 60000)
        if DoesEntityExist(rentedBike) then
            lib.notify({
                title = 'Fiets verhuur',
                description = 'Je huurfiets is verlopen.',
                position = 'center-left',
                icon = 'fa-solid fa-bicycle',
                duration = 5000,
            })
            DeleteEntity(rentedBike)
        end
        -- Vraag server om fiets terug te plaatsen
        TriggerServerEvent('rw-bikerental:respawnBike', index)
    end)
end
