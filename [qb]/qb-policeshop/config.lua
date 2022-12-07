Config = Config or {}
Config.UsePreviewMenuSync = true -- Sync for the prewview menu when player is inside the prewview menu other players cant get inside (can prevent bugs but not have to use)
Config.UseMarkerInsteadOfMenu = false -- Want to use the marker to return the vehice? if false you can do that by opening the menu
Config.MS = 'high' -- MS for the script recommended using high if not the "close" will get a bit baggy. options high / low
Config.Job = 'police' --The job needed to open the menu

--DO NOT add vehicles that are not in your shared ! otherwise the qb-garages wont work
--You need to add all your job grades to the config, and properly add them into this simple config.

--[[
{
['vehiclename'] = "car 1 grade 0", --display name of the vehicle, add what you want here
['vehicle'] = "car1", --this must be the car's spawn name, if not no car
['price'] = 37000}, --price you want the car to be sold for
}
]]
Config.PoliceVehicles = {

    [0] = { --grade 0
        { ['vehiclename'] = "Crown Victoria",         ['npolvic'] = "Crown Victoria",          ['price'] = 37000},
    },
    [1] = { --grade 1
        { ['vehiclename'] = "Crown Victoria",         ['vehicle'] = "Crown Victoria",          ['price'] = 25000},
        { ['vehiclename'] = "Charger",         ['npolchar'] = "Charger",           ['price'] = 50000},
    },
    [2] = { --grade 2
        { ['vehiclename'] = "Mustang",         ['npolvette'] = "Mustang",          ['price'] = 180000},
        { ['vehiclename'] = "Corvette",         ['npolstang'] = "Corvette",          ['price'] = 250000},
        { ['vehiclename'] = "Motorbike",         ['npolstang'] = "Corvette",          ['price'] = 75000},
        { ['vehiclename'] = "Explorer",         ['npolexp'] = "Explorer",          ['price'] = 75000},
        { ['vehiclename'] = "Charger",         ['npolchar'] = "Charger",           ['price'] = 50000},
    },
    [3] = { --grade 2
    { ['vehiclename'] = "Mustang",         ['npolvette'] = "Mustang",          ['price'] = 180000},
    { ['vehiclename'] = "Corvette",         ['npolstang'] = "Corvette",          ['price'] = 250000},
    { ['vehiclename'] = "Motorbike",         ['npolstang'] = "Corvette",          ['price'] = 75000},
    { ['vehiclename'] = "Explorer",         ['npolexp'] = "Explorer",          ['price'] = 75000},
    { ['vehiclename'] = "Charger",         ['npolchar'] = "Charger",           ['price'] = 50000},
    },
    [4] = { --grade 2
    { ['vehiclename'] = "Mustang",         ['npolvette'] = "Mustang",          ['price'] = 180000},
    { ['vehiclename'] = "Corvette",         ['npolstang'] = "Corvette",          ['price'] = 250000},
    { ['vehiclename'] = "Motorbike",         ['npolstang'] = "Corvette",          ['price'] = 75000},
    { ['vehiclename'] = "Explorer",         ['npolexp'] = "Explorer",          ['price'] = 75000},
    { ['vehiclename'] = "Charger",         ['npolchar'] = "Charger",           ['price'] = 50000},
    },
    --ect.. ect..
}

Config.PoliceAirVehicles = {

    [0]  = {--grade 0
        { ['vehiclename'] = "car 1 grade 0",         ['vehicle'] = "heli1",         ['price'] = 37000},
        { ['vehiclename'] = "car 1 grade 0",         ['vehicle'] = "heli2",         ['price'] = 37000},
    },
    [1]  = {--grade 1
        { ['vehiclename'] = "car 1 grade 1",         ['vehicle'] = "heli1",         ['price'] = 37000},
        { ['vehiclename'] = "car 1 grade 1",         ['vehicle'] = "heli2",         ['price'] = 37000},
    },
    [2]  = {--grade 2
        { ['vehiclename'] = "car 1 grade 2",         ['vehicle'] = "heli1",         ['price'] = 37000},
        { ['vehiclename'] = "car 1 grade 2",         ['vehicle'] = "heli2",         ['price'] = 37000},
    },
    --ect.. ect..
}
