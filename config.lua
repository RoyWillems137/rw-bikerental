Config = {}

Config.BlipName = 'Fietsverhuur'
Config.BlipColor = 3
Config.BlipSprite = 376

Config.BikeSpawns = { -- Locaties
    -- Gemeentehuis
    {
        blip = vec3(-1251.3761, -588.4656, 26.9864),
        coords = {
            vec4(-1254.5735, -586.2518, 26.8379, 332.0375),
            vec4(-1253.8599, -587.2860, 26.7505, 341.4640),
            vec4(-1252.8944, -588.0619, 26.6702, 348.0526),
            vec4(-1251.5516, -589.0251, 26.5657, 349.9010),
            vec4(-1250.3866, -589.8725, 26.4727, 347.6130),
            vec4(-1249.0789, -591.3270, 26.3370, 351.5002)
        },
        model = {'scorcher', 'scorcher', 'bmx', 'bmx', 'cruiser', 'cruiser'}
    },

    -- Blokkenpark
    {
        blip = vec3(201.0289, -798.6146, 30.7674),
        coords = {
            vec4(201.0289, -798.6146, 30.3674, 112.5794),
            vec4(201.2957, -796.8524, 30.4351, 115.6655),
            vec4(201.7723, -795.2485, 30.4999, 108.2994),
            vec4(202.2116, -793.5944, 30.5707, 114.7252),
            vec4(202.8095, -791.9761, 30.6359, 107.5762),
            vec4(202.9833, -790.3405, 30.7034, 104.9205)
        },
        model = {'scorcher', 'scorcher', 'bmx', 'bmx', 'cruiser', 'cruiser'}
    },

    -- Ziekenhuis
    {
        blip = vec3(-881.0453, -1204.9440, 4.3013),
        coords = {
            vec4(-881.0453, -1204.9440, 3.9013, 354.0046),
            vec4(-879.6347, -1204.1821, 3.8660, 356.2488),
            vec4(-878.3563, -1203.5167, 3.8501, 352.7317),
            vec4(-876.9141, -1202.6768, 3.8319, 354.2267),
            vec4(-875.6309, -1201.8213, 3.8491, 350.9879),
            vec4(-874.2129, -1201.2091, 3.8590, 340.5943)
        },
        model = {'scorcher', 'scorcher', 'bmx', 'bmx', 'cruiser', 'cruiser'}
    }
}


Config.RentalOptions = { -- time in minuten
    {label = "1 minuut (€50)", time = 1, price = 50},
    {label = "15 minuten (€500)", time = 15, price = 500},
    {label = "30 minuten (€800)", time = 30, price = 800}
}
