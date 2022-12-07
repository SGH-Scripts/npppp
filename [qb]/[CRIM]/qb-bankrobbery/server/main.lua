local QBCore = exports['qb-core']:GetCoreObject()
local robberyBusy = false
local timeOut = false
local blackoutActive = false

-- Functions

local function CheckStationHits()
    if Config.PowerStations[1].hit and Config.PowerStations[2].hit and Config.PowerStations[3].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 19, false)
    end
    if Config.PowerStations[3].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 18, false)
        TriggerClientEvent("police:client:SetCamera", -1, 7, false)
    end
    if Config.PowerStations[4].hit and Config.PowerStations[5].hit and Config.PowerStations[6].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 4, false)
        TriggerClientEvent("police:client:SetCamera", -1, 8, false)
        TriggerClientEvent("police:client:SetCamera", -1, 5, false)
        TriggerClientEvent("police:client:SetCamera", -1, 6, false)
    end
    if Config.PowerStations[1].hit and Config.PowerStations[2].hit and Config.PowerStations[3].hit and Config.PowerStations[4].hit and Config.PowerStations[5].hit and Config.PowerStations[6].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 1, false)
        TriggerClientEvent("police:client:SetCamera", -1, 2, false)
        TriggerClientEvent("police:client:SetCamera", -1, 3, false)
    end
    if Config.PowerStations[7].hit and Config.PowerStations[8].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 9, false)
        TriggerClientEvent("police:client:SetCamera", -1, 10, false)
    end
    if Config.PowerStations[9].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 11, false)
        TriggerClientEvent("police:client:SetCamera", -1, 12, false)
        TriggerClientEvent("police:client:SetCamera", -1, 13, false)
    end
    if Config.PowerStations[9].hit and Config.PowerStations[10].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 14, false)
        TriggerClientEvent("police:client:SetCamera", -1, 17, false)
        TriggerClientEvent("police:client:SetCamera", -1, 19, false)
    end
    if Config.PowerStations[7].hit and Config.PowerStations[9].hit and Config.PowerStations[10].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 15, false)
        TriggerClientEvent("police:client:SetCamera", -1, 16, false)
    end
    if Config.PowerStations[10].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 20, false)
    end
    if Config.PowerStations[11].hit and Config.PowerStations[1].hit and Config.PowerStations[2].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 21, false)
        TriggerClientEvent("qb-bankrobbery:client:BankSecurity", 1, false)
        TriggerClientEvent("police:client:SetCamera", -1, 22, false)
        TriggerClientEvent("qb-bankrobbery:client:BankSecurity", 2, false)
    end
    if Config.PowerStations[8].hit and Config.PowerStations[4].hit and Config.PowerStations[5].hit and Config.PowerStations[6].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 23, false)
        TriggerClientEvent("qb-bankrobbery:client:BankSecurity", 3, false)
    end
    if Config.PowerStations[12].hit and Config.PowerStations[13].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 24, false)
        TriggerClientEvent("qb-bankrobbery:client:BankSecurity", 4, false)
        TriggerClientEvent("police:client:SetCamera", -1, 25, false)
        TriggerClientEvent("qb-bankrobbery:client:BankSecurity", 5, false)
    end
end

local function AllStationsHit()
    local hit = 0
    for k, v in pairs(Config.PowerStations) do
        if Config.PowerStations[k].hit then
            hit += 1
        end
    end
    return hit >= Config.HitsNeeded
end

local function IsNearPowerStation(coords, dist)
    for k, v in pairs(Config.PowerStations) do
        if #(coords - v.coords) < dist then
            return true
        end
    end
    return false
end

-- Events

RegisterNetEvent('qb-bankrobbery:server:setBankState', function(bankId, state)
    if bankId == "paleto" then
        if not robberyBusy then
            Config.BigBanks["paleto"]["isOpened"] = state
            TriggerClientEvent('qb-bankrobbery:client:setBankState', -1, bankId, state)
            TriggerEvent('qb-scoreboard:server:SetActivityBusy', "paleto", true)
            TriggerEvent('qb-bankrobbery:server:setTimeout')
        end
    elseif bankId == "pacific" then
        if not robberyBusy then
            Config.BigBanks["pacific"]["isOpened"] = state
            TriggerClientEvent('qb-bankrobbery:client:setBankState', -1, bankId, state)
            TriggerEvent('qb-scoreboard:server:SetActivityBusy', "pacific", true)
            TriggerEvent('qb-bankrobbery:server:setTimeout')
        end
    else
        if not robberyBusy then
            Config.SmallBanks[bankId]["isOpened"] = state
            TriggerClientEvent('qb-bankrobbery:client:setBankState', -1, bankId, state)
            TriggerEvent('qb-banking:server:SetBankClosed', bankId, true)
            TriggerEvent('qb-scoreboard:server:SetActivityBusy', "bankrobbery", true)
            TriggerEvent('qb-bankrobbery:server:SetSmallbankTimeout', bankId)
        end
    end
    robberyBusy = true
end)

RegisterNetEvent('qb-bankrobbery:server:setLockerState', function(bankId, lockerId, state, bool)
    if bankId == "paleto" then
        Config.BigBanks["paleto"]["lockers"][lockerId][state] = bool
    elseif bankId == "pacific" then
        Config.BigBanks["pacific"]["lockers"][lockerId][state] = bool
    else
        Config.SmallBanks[bankId]["lockers"][lockerId][state] = bool
    end

    TriggerClientEvent('qb-bankrobbery:client:setLockerState', -1, bankId, lockerId, state, bool)
end)

RegisterNetEvent('qb-bankrobbery:server:recieveItem', function(type)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)

    if type == "small" then
        local itemType = math.random(#Config.RewardTypes)
        local WeaponChance = math.random(1, 50)
        local odd1 = math.random(1, 50)
        local tierChance = math.random(1, 100)
        local tier = 1

        if tierChance < 50 then tier = 1 elseif tierChance >= 50 and tierChance < 80 then tier = 2 elseif tierChance >= 80 and tierChance < 95 then tier = 3 else tier = 4 end
        if WeaponChance ~= odd1 then
            if tier ~= 4 then
                 if Config.RewardTypes[itemType].type == "item" then
                     local item = Config.LockerRewards["tier"..tier][math.random(#Config.LockerRewards["tier"..tier])]
                     local itemAmount = math.random(item.minAmount, item.maxAmount)
                     ply.Functions.AddItem(item.item, itemAmount)
                     TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.item], "add")
                 elseif Config.RewardTypes[itemType].type == "money" then
                    local info = {
                        worth = math.random(Config.minFleecaBagsWorth, Config.maxFleecaBagsWorth)
                    }
                    ply.Functions.AddItem('markedbills', math.random(Config.minFleecaBags ,Config.maxFleecaBags), false, info)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
                end
            else
                ply.Functions.AddItem('security_card_01', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_01'], "add")
            end
        else
            ply.Functions.AddItem('security_card_02', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_02'], "add")
        end
    elseif type == "paleto" then
        local itemType = math.random(#Config.RewardTypes)
        local tierChance = math.random(1, 100)
        local WeaponChance = math.random(1, 10)
        local odd1 = math.random(1, 10)
        local tier = 1
        if tierChance < 25 then tier = 1 elseif tierChance >= 25 and tierChance < 70 then tier = 2 elseif tierChance >= 70 and tierChance < 95 then tier = 3 else tier = 4 end
        if WeaponChance ~= odd1 then
            if tier ~= 4 then
                 if Config.RewardTypes[itemType].type == "item" then
                     local item = Config.LockerRewardsPaleto["tier"..tier][math.random(#Config.LockerRewardsPaleto["tier"..tier])]
                     local itemAmount = math.random(item.minAmount, item.maxAmount)

                     ply.Functions.AddItem(item.item, itemAmount)
                     TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.item], "add")
                 elseif Config.RewardTypes[itemType].type == "money" then
                     local info = {
                         worth = math.random(Config.minPaletoBagsWorth , Config.maxPaletoBagsWorth )
                     }
                    ply.Functions.AddItem('markedbills', math.random(Config.minPaletoBags, Config.maxPaletoBags), false, info)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
                 end
            else
                ply.Functions.AddItem('security_card_02', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_02'], "add")
            end
        else
            ply.Functions.AddItem('security_card_03', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_03'], "add")
        end
    elseif type == "pacific" then
        local itemType = math.random(#Config.RewardTypes)
        local WeaponChance = math.random(1, 100)
        local odd1 = math.random(1, 100)
        local odd2 = math.random(1, 100)
        local tierChance = math.random(1, 100)
        local tier = 1
        if tierChance < 10 then tier = 1 elseif tierChance >= 25 and tierChance < 50 then tier = 2 elseif tierChance >= 50 and tierChance < 95 then tier = 3 else tier = 4 end
        if WeaponChance ~= odd1 or WeaponChance ~= odd2 then
            if tier ~= 4 then
                if Config.RewardTypes[itemType].type == "item" then
                    local item = Config.LockerRewardsPacific["tier"..tier][math.random(#Config.LockerRewardsPacific["tier"..tier])]
                    local itemAmount = math.random(item.minAmount, item.maxAmount)
                    if tier == 3 then maxAmount = 7 elseif tier == 2 then maxAmount = 18 else maxAmount = 25 end
                    local itemAmount = math.random(maxAmount)

                    ply.Functions.AddItem(item.item, itemAmount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.item], "add")
                elseif Config.RewardTypes[itemType].type == "money" then
                     local info = {
                         worth = math.random(Config.minPacificBagsWorth, Config.maxPacificBagsWorth)
                     }
                    ply.Functions.AddItem('markedbills', math.random(Config.minPacificBags, Config.maxPacificBags), false, info)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
                end
            else
                 local info = {
                     worth = math.random(Config.minPacificBagsWorth, Config.maxPacificBagsWorth)
                 }
                ply.Functions.AddItem('markedbills', math.random(Config.minPacificBags, Config.maxPacificBags), false, info)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
                 local info = {
                     crypto = math.random(1, 3)
                 }
                 ply.Functions.AddItem("cryptostick", 1, false, info)
                 TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cryptostick'], "add")
            end
        else
            local chance = math.random(1, 2)
            local odd = math.random(1, 2)
            if chance == odd then
                ply.Functions.AddItem('security_card_03', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_03'], "add")
            else
                ply.Functions.AddItem('security_card_03', 2)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_03'], "add")
            end

        end
    elseif type == "vault" then
        local itemType = math.random(#Config.RewardTypes)
        local WeaponChance = math.random(1, 100)
        local odd1 = math.random(1, 100)
        local odd2 = math.random(1, 100)
        local tierChance = math.random(1, 100)
        local tier = 1
        if tierChance < 10 then tier = 1 elseif tierChance >= 25 and tierChance < 50 then tier = 2 elseif tierChance >= 50 and tierChance < 95 then tier = 3 else tier = 4 end
        if WeaponChance ~= odd1 or WeaponChance ~= odd2 then
            if tier ~= 4 then
                if Config.RewardTypes[itemType].type == "item" then
                    local item = Config.LockerRewardsVault["tier"..tier][math.random(#Config.LockerRewardsVault["tier"..tier])]
                    local itemAmount = math.random(item.minAmount, item.maxAmount)
                    if tier == 3 then maxAmount = 7 elseif tier == 2 then maxAmount = 18 else maxAmount = 25 end
                    local itemAmount = math.random(maxAmount)

                    ply.Functions.AddItem(item.item, itemAmount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.item], "add")
                elseif Config.RewardTypes[itemType].type == "money" then
                     local info = {
                         worth = math.random(Config.minVaultBagsWorth, Config.maxVaultBagsWorth)
                     }
                    ply.Functions.AddItem('markedbills', math.random(Config.minVaultBags,Config.maxVaultBags), false, info)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
                end
            else
                 local info = {
                     worth = math.random(Config.minVaultBagsWorth, Config.maxVaultBagsWorth)
                 }
                ply.Functions.AddItem('markedbills', math.random(Config.minVaultBags,Config.maxVaultBags), false, info)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
                 local info = {
                     crypto = math.random(1, 3)
                 }
                 ply.Functions.AddItem("cryptostick", 1, false, info)
                 TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cryptostick'], "add")
            end
        else
            local chance = math.random(1, 2)
            local odd = math.random(1, 2)
            if chance == odd then
                ply.Functions.AddItem('goldbar', math.random(1, 2))
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], "add")
            else
                ply.Functions.AddItem('goldbar', math.random(2, 4))
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], "add")
            end

        end
    end
end)

RegisterNetEvent('qb-bankrobbery:server:setTimeout', function()
    if not robberyBusy then
        if not timeOut then
            timeOut = true
            CreateThread(function()
                Wait(Config.BigBankTimer * (60 * 1000))
                timeOut = false
                robberyBusy = false
                TriggerEvent('qb-scoreboard:server:SetActivityBusy', "bankrobbery", false)
                TriggerEvent('qb-scoreboard:server:SetActivityBusy', "pacific", false)

                for k, v in pairs(Config.BigBanks["pacific"]["lockers"]) do
                    Config.BigBanks["pacific"]["lockers"][k]["isBusy"] = false
                    Config.BigBanks["pacific"]["lockers"][k]["isOpened"] = false
                end

                for k, v in pairs(Config.BigBanks["paleto"]["lockers"]) do
                    Config.BigBanks["paleto"]["lockers"][k]["isBusy"] = false
                    Config.BigBanks["paleto"]["lockers"][k]["isOpened"] = false
                end

                TriggerClientEvent('qb-bankrobbery:client:ClearTimeoutDoors', -1)
                Config.BigBanks["paleto"]["isOpened"] = false
                Config.BigBanks["pacific"]["isOpened"] = false
            end)
        end
    end
end)

RegisterNetEvent('qb-bankrobbery:server:SetSmallbankTimeout', function(BankId)
    if not robberyBusy then
        if not timeOut then
            timeOut = true
            CreateThread(function()
                Wait(Config.SmallBankTimer * (60 * 1000))
                timeOut = false
                robberyBusy = false

                for k, v in pairs(Config.SmallBanks[BankId]["lockers"]) do
                    Config.SmallBanks[BankId]["lockers"][k]["isOpened"] = false
                    Config.SmallBanks[BankId]["lockers"][k]["isBusy"] = false
                end

                timeOut = false
                robberyBusy = false
            	TriggerClientEvent('qb-bankrobbery:client:ResetFleecaLockers', -1, BankId)
            	TriggerEvent('qb-banking:server:SetBankClosed', BankId, false)
            end)
		end
    end
end)

RegisterNetEvent('qb-bankrobbery:server:SetStationStatus', function(key, isHit)
    Config.PowerStations[key].hit = isHit
    TriggerClientEvent("qb-bankrobbery:client:SetStationStatus", -1, key, isHit)
    if AllStationsHit() then
        TriggerEvent("qb-weathersync:server:toggleBlackout")
        TriggerClientEvent("police:client:DisableAllCameras", -1)
        TriggerClientEvent("qb-bankrobbery:client:disableAllBankSecurity", -1)
        blackoutActive = true
    else
        CheckStationHits()
    end
end)

RegisterServerEvent('qb-bankrobbery:server:RemoveLaptopUse', function(itemData)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.PlayerData.items[itemData.slot].info.uses == nil then
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[itemData.name], 'remove')
        Player.Functions.RemoveItem(itemData.name, 1)
    elseif Player.PlayerData.items[itemData.slot].info.uses - 1 == 0 then
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[itemData.name], 'remove')
        Player.Functions.RemoveItem(itemData.name, 1)
    else
        Player.PlayerData.items[itemData.slot].info.uses = Player.PlayerData.items[itemData.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

-- Event to give heist rep can use this to disable certain laptops until a rep amount is hit.
RegisterServerEvent('qb-bankrobbery:server:succesHeist', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local curRep = Player.PlayerData.metadata.heistrep

	SetTimeout(math.random(1000, 2000), function()
	--  TriggerClientEvent('QBCore:Notify', src, '+HEIST REP!', 'success')
		Player.Functions.SetMetaData('heistrep', (curRep + amount))
	end)
end)

-- Purchase Events for Laptops adds use amounts
RegisterServerEvent('qb-bankrobbery:server:laptop_pink', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    info = {uses = 30}
    if Player.PlayerData.money.cash >= Config.PinkLaptopPrice then
        Player.Functions.RemoveMoney('cash', Config.PinkLaptopPrice)
        Player.Functions.AddItem("laptop_pink", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["laptop_pink"], "add")
        TriggerClientEvent('QBCore:Notify', src, "You purchased a laptop for "..Config.PinkLaptopPrice, "success", 3000)
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash.", "error", 3000)
    end
end)

RegisterServerEvent('qb-bankrobbery:server:laptop_green', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    info = {uses = 3}
    if Player.PlayerData.money.cash >= Config.GreenLaptopPrice then
        Player.Functions.RemoveMoney('cash', Config.GreenLaptopPrice)
        Player.Functions.AddItem("laptop_green", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["laptop_green"], "add")
        TriggerClientEvent('QBCore:Notify', src, "You purchased a laptop for "..Config.GreenLaptopPrice, "success", 3000)
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash.", "error", 3000)
    end
end)

RegisterServerEvent('qb-bankrobbery:server:laptop_blue', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    info = {uses = 3}
    if Player.PlayerData.money.cash >= Config.BlueLaptopPrice then
        Player.Functions.RemoveMoney('cash', Config.BlueLaptopPrice)
        Player.Functions.AddItem("laptop_blue", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["laptop_blue"], "add")
        TriggerClientEvent('QBCore:Notify', src, "You purchased a laptop for "..Config.BlueLaptopPrice, "success", 3000)
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash.", "error", 3000)
    end
end)

RegisterServerEvent('qb-bankrobbery:server:laptop_red', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    info = {uses = 3}
    if Player.PlayerData.money.cash >= Config.RedLaptopPrice then
        Player.Functions.RemoveMoney('cash', Config.RedLaptopPrice)
        Player.Functions.AddItem("laptop_red", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["laptop_red"], "add")
        TriggerClientEvent('QBCore:Notify', src, "You purchased a laptop for "..Config.RedLaptopPrice, "success", 3000)
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash.", "error", 3000)
    end
end)

RegisterServerEvent('qb-bankrobbery:server:laptop_gold', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    info = {uses = 3}
    if Player.PlayerData.money.cash >= Config.GoldLaptopPrice then
        Player.Functions.RemoveMoney('cash', Config.GoldLaptopPrice)
        Player.Functions.AddItem("laptop_gold", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["laptop_gold"], "add")
        TriggerClientEvent('QBCore:Notify', src, "You purchased a laptop for "..Config.GoldLaptopPrice, "success", 3000)
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash.", "error", 3000)
    end
end)

-- Thermite Particles for Server
RegisterServerEvent('qb-bankrobbery:server:ThermitePtfx', function(coords)
    TriggerClientEvent('qb-bankrobbery:client:ThermitePtfx', -1, coords)
end)

-- Callbacks

QBCore.Functions.CreateCallback('qb-bankrobbery:server:isRobberyActive', function(source, cb)
    cb(robberyBusy)
end)

QBCore.Functions.CreateCallback('qb-bankrobbery:server:GetConfig', function(source, cb)
    cb(Config)
end)

-- Items

QBCore.Functions.CreateUseableItem("security_card_01", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('security_card_01') ~= nil then
        TriggerClientEvent("qb-bankrobbery:UseBankcardA", source)
    end
end)

QBCore.Functions.CreateUseableItem("security_card_02", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('security_card_02') ~= nil then
        TriggerClientEvent("qb-bankrobbery:UseBankcardB", source)
    end
end)

QBCore.Functions.CreateUseableItem("security_card_03", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('security_card_03') ~= nil then
        TriggerClientEvent("qb-bankrobbery:UseBankcardC", source)
    end
end)

-- Practice
QBCore.Functions.CreateUseableItem('laptop_pink', function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('laptop_pink') ~= nil then
        TriggerClientEvent('qb-bankrobbery:client:UsePinkLaptop', source, item)
    end
end)

-- Fleeca
QBCore.Functions.CreateUseableItem('laptop_green', function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('laptop_green') ~= nil then
        TriggerClientEvent('qb-bankrobbery:client:UseGreenLaptop', source, item)
    end
end)

-- Paleto
QBCore.Functions.CreateUseableItem('laptop_blue', function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('laptop_blue') ~= nil then
        TriggerClientEvent('qb-bankrobbery:client:UseBlueLaptop', source, item)
    end
end)

-- Pacific
QBCore.Functions.CreateUseableItem('laptop_red', function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('laptop_red') ~= nil then
        TriggerClientEvent('qb-bankrobbery:client:UseRedLaptop', source, item)
    end
end)

-- Lowervault
QBCore.Functions.CreateUseableItem('laptop_gold', function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('laptop_gold') ~= nil then
        TriggerClientEvent('qb-bankrobbery:client:UseGoldLaptop', source, item)
    end
end)

-- Threads

CreateThread(function()
    while true do
        Wait(1000 * 60 * 10)
        if blackoutActive then
            TriggerEvent("qb-weathersync:server:toggleBlackout")
            TriggerClientEvent("police:client:EnableAllCameras", -1)
            TriggerClientEvent("qb-bankrobbery:client:enableAllBankSecurity", -1)
            blackoutActive = false
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1000 * 60 * 30)
        TriggerClientEvent("qb-bankrobbery:client:enableAllBankSecurity", -1)
        TriggerClientEvent("police:client:EnableAllCameras", -1)
    end
end)

-- // Trolleys \\ --
RegisterServerEvent('qb-bankrobbery:server:modelSync', function(closestBank, k, model) -- Stores the loot model from the client and pushes it to all clients
    TriggerClientEvent('qb-bankrobbery:client:modelSync', -1, closestBank, k, model)
end)
RegisterServerEvent('qb-bankrobbery:server:lootSync', function(closestBank, type, k) -- Grabs the type from the client that is being looted
    TriggerClientEvent('qb-bankrobbery:client:lootSync', -1, closestBank, type, k) -- Pushes the type back to the config to be looted
end)
RegisterNetEvent('qb-bankrobbery:server:FleecaTrolleyReward', function(Trolley, pos, closestBank) -- Reward for the fleeca Trolley
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local item

    local FleecaDist = #(pos - vector3(Config.SmallBanks[closestBank]['coords'].x, Config.SmallBanks[closestBank]['coords'].y, Config.SmallBanks[closestBank]['coords'].z ))
    if FleecaDist <= 15 then 

        local MarkedBags = math.random(Config.minFleecaBags, Config.maxFleecaBags)
        local info = {worth = math.random(Config.minFleecaBagsWorth, Config.maxFleecaBagsWorth)}
        local GoldBars = math.random(Config.minFleecaGoldBars, Config.maxFleecaGoldBars)

        if Trolley == 'ch_prop_gold_bar_01a' then 
            local item = 'goldbar'
            Player.Functions.AddItem(item, GoldBars, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You got ' .. GoldBars .. ' Gold Bars')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bank Robbery', 'green', '**Goldbars**:\n'..GoldBars..'\n**Person**:\n'..GetPlayerName(src))

        elseif Trolley == 'hei_prop_heist_cash_pile' then 
            local item = 'markedbills'
            Player.Functions.AddItem(item, MarkedBags, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You got ' .. MarkedBags .. ' bags of inked money')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bank Robbery', 'green', '**Cash**:\n'..MarkedBags..' worth $'..info.worth..'\n**Person**:\n'..GetPlayerName(src))
        end

    end
end)

-- Paleto
RegisterServerEvent('qb-bankrobbery:server:modelSyncPaleto', function(k, model) -- Stores the loot model from the client and pushes it to all clients
    TriggerClientEvent('qb-bankrobbery:client:modelSyncPaleto', -1, k, model)
end)
RegisterServerEvent('qb-bankrobbery:server:lootSyncPaleto', function(type, k) -- Grabs the type from the client that is being looted
    TriggerClientEvent('qb-bankrobbery:client:lootSyncPaleto', -1, type, k) -- Pushes the type back to the config to be looted
end)
RegisterNetEvent('qb-bankrobbery:server:PaletoTrolleyReward', function(Trolley, pos) -- Reward for the fleeca Trolley
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local item

    local PaletoDist = #(pos - vector3(Config.BigBanks["paleto"]['coords'].x, Config.BigBanks["paleto"]['coords'].y, Config.BigBanks["paleto"]['coords'].z ))
    if PaletoDist <= 25 then 

        local MarkedBags = math.random(Config.minPaletoBags, Config.maxPaletoBags)
        local info = {worth = math.random(Config.minPaletoBagsWorth, Config.maxPaletoBagsWorth)}
        local GoldBars = math.random(Config.minPaletoGoldBars, Config.maxPaletoGoldBars)

        if Trolley == 'ch_prop_gold_bar_01a' then 
            local item = 'goldbar'
            Player.Functions.AddItem(item, GoldBars, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You got ' .. GoldBars .. ' Gold Bars')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bank Robbery', 'green', '**Goldbars**:\n'..GoldBars..'\n**Person**:\n'..GetPlayerName(src))

        elseif Trolley == 'hei_prop_heist_cash_pile' then 
            local item = 'markedbills'
            Player.Functions.AddItem(item, MarkedBags, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You got ' .. MarkedBags .. ' bags of inked money')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bank Robbery', 'green', '**Cash**:\n'..MarkedBags..' worth $'..info.worth..'\n**Person**:\n'..GetPlayerName(src))
        end

    end
end)

-- Pacific
RegisterServerEvent('qb-bankrobbery:server:modelSyncPacific', function(k, model) -- Stores the loot model from the client and pushes it to all clients
    TriggerClientEvent('qb-bankrobbery:client:modelSyncPacific', -1, k, model)
end)
RegisterServerEvent('qb-bankrobbery:server:lootSyncPacific', function(type, k) -- Grabs the type from the client that is being looted
    TriggerClientEvent('qb-bankrobbery:client:lootSyncPacific', -1, type, k) -- Pushes the type back to the config to be looted
end)
RegisterNetEvent('qb-bankrobbery:server:PacificTrolleyReward', function(Trolley, pos) -- Reward for the fleeca Trolley
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local item
    local PacificDist = #(pos - vector3(Config.BigBanks["pacific"]['coords'][2].x, Config.BigBanks["pacific"]['coords'][2].y, Config.BigBanks["pacific"]['coords'][2].z ))
    if PacificDist <= 50 then 
        local MarkedBags = math.random(Config.minPacificBags, Config.maxPacificBags)
        local info = {worth = math.random(Config.minPacificBagsWorth, Config.maxPacificBagsWorth)}
        local GoldBars = math.random(Config.minPacificGoldBars, Config.maxPacificGoldBars)

        if Trolley == 'ch_prop_gold_bar_01a' then
            local item = 'goldbar'
            Player.Functions.AddItem(item, GoldBars, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You got ' .. GoldBars .. ' Gold Bars')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bank Robbery', 'green', '**Goldbars**:\n'..GoldBars..'\n**Person**:\n'..GetPlayerName(src))
        elseif Trolley == 'hei_prop_heist_cash_pile' then
            local item = 'markedbills'
            Player.Functions.AddItem(item, MarkedBags, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You got ' .. MarkedBags .. ' bags of inked money')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bank Robbery', 'green', '**Cash**:\n'..MarkedBags..' worth $'..info.worth..'\n**Person**:\n'..GetPlayerName(src))
        end

    end
end)