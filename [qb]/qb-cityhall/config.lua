Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.Cityhalls = {
    { -- Cityhall 1
        coords = vector3(-552.97, -192.04, 38.22),
        showBlip = true,
        blipData = {
            sprite = 58,
            display = 4,
            scale = 0.9,
            colour = 2,
            title = "Newport City Hall & Job Center"
        },
        licenses = {
            ["id_card"] = {
                label = "ID Card",
                cost = 250,
            },
            ["driver_license"] = {
                label = "Driver License",
                cost = 250,
                metadata = "driver"
            },
            ["weaponlicense"] = {
                label = "Weapon License",
                cost = 2500,
                metadata = "weapon"
            },
            ['permit'] = {
                label = "Permit",
                cost = 250,
                metadata = 'permit'
            },
        }
    },
}

-- Config.DrivingSchools = {
--     { -- Driving School 1
--         coords = vector3(-573.49, -254.39, 35.76),
--         showBlip = true,
--         blipData = {
--             sprite = 225,
--             display = 4,
--             scale = 0.8,
--             colour = 2,
--             title = "DMV"
--         },
--         instructors = {
--             "DJD56142",
--             "DXT09752",
--             "SRI85140",
--         }
--     },
-- }

Config.Peds = {
    -- Cityhall Ped
    {
        model = 'a_m_m_hasjew_01',
        coords = vector4(-552.97, -192.04, 37.22, 208.3),
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        cityhall = true,
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = false
        }
    },
    -- Driving School Ped
    {
        model = 'a_m_m_eastsa_02',
        coords = vector4(-573.49, -254.39, 34.76, 81.21),
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        drivingschool = true,
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0
        }
    }
}
