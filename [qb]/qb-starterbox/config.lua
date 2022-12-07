Config = {}
Config.AmountOfItems = 10 --how many times the script will loop
Config.OpenTime = 5000 --how long you want it to take to open the gift (in ms)

--Config.Joingiftitem = {
--    [1] =  {
--        item = "item1", -- Item name from your shared items.lua
--        minAmount = 1, --Min amount of the item you want given out
--        maxAmount = 5 --Max amount of the item you want given out
--    },
--}

Config.Joingiftitem = {
    [1] =  {item = "lockpick", minAmount = 3,  maxAmount = 5},
    [2] =  {item = "advancedrepairkit", minAmount = 1,  maxAmount = 2},
    [3] =  {item = "bandage", minAmount = 10,  maxAmount = 15},
    [4] =  {item = "phone", minAmount = 1,  maxAmount = 1},
    [5] =  {item = "radio", minAmount = 1,  maxAmount = 1},
    [6] =  {item = "casinochips", minAmount = 2000,  maxAmount = 10000},
}