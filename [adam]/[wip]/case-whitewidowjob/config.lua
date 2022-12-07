-------------------------------
---------- CASE#2506 ----------
-------------------------------
Config = {
WhiteWidowItems =  {-- White widow job only store this is set to 50% smoke on water prices if you use case-outdoorweed
    [1] = { name = "empty_weed_bag",       price = 1,    amount = 1000, info = {}, type = "item", slot = 1 },
    [2] = { name = "drug_scales",          price = 600, amount = 100,  info = {}, type = "item", slot = 2 },
    [3] = { name = "rolling_paper",        price = 1,    amount = 2000, info = {}, type = "item", slot = 3 },
    [4] = { name = "lighter",              price = 1,    amount = 1000, info = {}, type = "item", slot = 4 },
    [5] = { name = "weed_water",           price = 5,    amount = 1000, info = {}, type = "item", slot = 5 },
    [6] = { name = "weed_nutrition",       price = 50,  amount = 1000, info = {}, type = "item", slot = 6 },
    [7] = { name = "weed_pot",             price = 5,   amount = 1000, info = {}, type = "item", slot = 7 },
    [8] = { name = "drug_shears",         price = 50,   amount = 1000, info = {}, type = "item", slot = 8 },
},
WhiteWidowSnackTable = { -- Items list for snack table
    [1] = { name = "kurkakola",       	   price = 3,    amount = 100,  info = {}, type = "item", slot = 1 },
    [2] = { name = "water_bottle",         price = 2, 	 amount = 100,  info = {}, type = "item", slot = 2 },
    [3] = { name = "twerks_candy",         price = 2,    amount = 100,  info = {}, type = "item", slot = 3 },
    [4] = { name = "snikkel_candy",        price = 2,    amount = 100,  info = {}, type = "item", slot = 4 },
},
}
Config.WhiteWidowDuty = vector3(180.5, -251.64, 54.51) -- On duty location change heading in client
Config.WhiteWidowStorage = vector3(184.01, -245.08, 54.07) -- Stash location change heading in client
Config.WhiteWidowPay = vector3(187.61, -243.15, 54.07) -- Epos system location change heading in client
Config.WhiteWidowPay2 = vector3(188.43, -240.86, 54.07) -- Epos system 2 location change heading in client
Config.WhiteWidowPay3 = vector3(198.48, -235.48, 54.07) -- Epos system 3 location change heading in client
Config.WhiteWidowShop = vector3(194.62, -234.2, 54.07) -- White widow job shop location change heading in client
Config.WhiteWidowTrim = vector3(165.72, -235.06, 50.06) -- Trimming location location change heading in client
Config.WhiteWidowJoints = vector3(186.13, -241.8, 54.07) -- Joint rolling location change heading in client
Config.WhiteWidowSnacks = vector3(187.67, -247.74, 54.07) -- Snack table location change heading in client
Config.WhiteWidowTray = vector3(188.71, -239.83, 54.59) -- Vehicle garage location change heading in client
Config.WhiteWidowWeed1 = vector3(168.54, -247.21, 50.07) -- Skunk plants location change heading in client
Config.WhiteWidowWeed2 = vector3(167.3, -246.96, 50.07) -- OG-Kush plants location change heading in client
Config.WhiteWidowWeed3 = vector3(165.14, -244.48, 50.06) -- White-Widow plants location change heading in client
Config.WhiteWidowWeed4 = vector3(162.08, -245.01, 50.10) -- AK-47 location change heading in client
Config.WhiteWidowGarage = vector3(194.99, -267.54, 50.18) -- Vehicle garage location change heading in client
Config.Vehicle = 'rumpo' -- Change vehicle here if not using my custom whitewidow van !!ERROR WITH CUSTOM VAN HAS BEEN REMOVED WILL UPDATE WHEN FIXED REFER TO DISCORD FOR INFORMATION!!
Config.VehicleSpawn = {x = 193.14, y = -274.76, z = 48.94, h = 244.06} -- Vehicle spawn location
Config.VehicleSpawnHeading = 244.06 -- Vehicle spawn heading
Config.VehicleDeposit = 100 -- Vehicle deposit price