-------------------------------
---------- CASE#2506 ----------
-------------------------------	

local QBCore = exports['qb-core']:GetCoreObject()

isLoggedIn = false
PlayerJob = {}
local onDuty = false

-- Creates blip for white widow
Citizen.CreateThread(function()
    whitewidow = AddBlipForCoord(193.24, -244.53, 54.07)
    SetBlipSprite (whitewidow, 469)
    SetBlipDisplay(whitewidow, 4)
    SetBlipScale  (whitewidow, 1.0)
    SetBlipAsShortRange(whitewidow, true)
    SetBlipColour(whitewidow, 52)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("White Widow")
    EndTextCommandSetBlipName(whitewidow)
end)
-- Gets player job information on player load
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == "whitewidow" then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)
end) 
-- Targeting for white widow duty menu
exports['qb-target']:AddBoxZone("whitewidowduty", Config.WhiteWidowDuty, 1.0, 10.0, {
    name="whitewidowduty",
    heading= 181.63,
    debugPoly=false,
    minZ=53.66,
    maxZ=54.64
    }, {
    options = {
        {
            event = "case-whitewidowjob:client:WhiteWidowDutyMenu",
            icon = "fas fa-clock", 
            label = "Clock In/Out",
			job = "whitewidow",
        },
    },
    distance = 1.0
})
-- White widow duty menu
RegisterNetEvent('case-whitewidowjob:client:WhiteWidowDutyMenu', function(data)
    exports['qb-menu']:openMenu({
        { 
            header = "On/Off Duty",
            isMenuHeader = true
        },
        { 
            header = "• Clock In/Out",
            txt = "Don't forget to clock in and out!",
            params = {
                event = "case-whitewidowjob:client:SetDuty",
            }
        },
        {
            header = "< Exit",
            txt = "", 
            params = { 
                event = "qb-menu:client:closeMenu"
            }
        },
    })
end)
-- Whitewidow On/off duty settings
RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)
RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)
RegisterNetEvent("case-whitewidowjob:client:SetDuty")
AddEventHandler("case-whitewidowjob:client:SetDuty", function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)
-- Targeting for white widow storage location
exports['qb-target']:AddBoxZone("whitewidowstorage", Config.WhiteWidowStorage, 1.0, 40.0, {
        name ="whitewidowstorage",
        heading = 338.36,
        debugPoly = false,
        minZ=52.80,
        maxZ=55.00,
    }, {
        options = {
            {
                event = "case-whitewidowjob:client:WhiteWidowStorage",
                icon = "fas fa-box",
                label = "Storage",
                job = "whitewidow",
            },
        },
        distance = 1.5
    })
-- White widow storage
RegisterNetEvent("case-whitewidowjob:client:WhiteWidowStorage")
AddEventHandler("case-whitewidowjob:client:WhiteWidowStorage", function()
    TriggerEvent("inventory:client:SetCurrentStash", "whitewidowstorage")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "whitewidowstorage", {
        maxweight = 500000,
        slots = 40,
    })
end)
-- Targeting for white widow cash register
exports['qb-target']:AddBoxZone("whitewidowpay", Config.WhiteWidowPay, 1.0, 40.0, {
    name="whitewidowpay",
    heading= 253.36,
    debugPoly=false,
    minZ=52.664,
    maxZ=56.664
    }, {
    options = {
        {
            event = "case-whitewidowjob:client:WhiteWidowPay",
            parms = "1",
            icon = "fas fa-credit-card",
            label = "Charge Customer",
            job = "whitewidow",
        },
    },
    distance = 1.0
})
-- Targeting for white widow cash register2
exports['qb-target']:AddBoxZone("whitewidowpay2", Config.WhiteWidowPay2, 1.0, 100.0, {
    name="whitewidowpay2",
    heading= 251.71,
    debugPoly=false,
    minZ=52.664,
    maxZ=56.664
    }, {
    options = {
        {
            event = "case-whitewidowjob:client:WhiteWidowPay",
            parms = "1",
            icon = "fas fa-credit-card",
            label = "Charge Customer",
            job = "whitewidow",
        },
    },
    distance = 1.0
})
-- Targeting for white widow cash register3
exports['qb-target']:AddBoxZone("whitewidowpay3", Config.WhiteWidowPay3, 1.0, 100.0, {
    name="whitewidowpay3",
    heading= 116.55,
    debugPoly=false,
    minZ=52.664,
    maxZ=56.664
    }, {
    options = {
        {
            event = "case-whitewidowjob:client:WhiteWidowPay",
            parms = "1",
            icon = "fas fa-credit-card",
            label = "Charge Customer",
            job = "whitewidow",
        },
    },
    distance = 1.0
})
-- White widow cash register requires qb-input
RegisterNetEvent("case-whitewidowjob:client:WhiteWidowPay", function()
    local dialog = exports['qb-input']:ShowInput({
        header = "Till",
        submitText = "Bill Person",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'id',
                text = 'paypal id'
            },
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = '$ amount!'
            }
        }
    })
    if dialog then
        if not dialog.id or not dialog.amount then return end
        TriggerServerEvent("case-whitewidowjob:client:WhiteWidowPay:player", dialog.id, dialog.amount)
    end
end)
-- Targeting for white widow shop
exports['qb-target']:AddBoxZone("whitewidowshop", Config.WhiteWidowShop, 1.0, 10.0, {
    name="whitewidowshop",
    heading= 347.32,
    debugPoly=false,
    minZ=53.664,
    maxZ=54.664
    }, {
    options = {
        {
            event = "inventory:client:OpenWhiteWidowShop",
            icon = "fas fa-box", 
            label = "Open Store",
			job = "whitewidow",
        },
    },
    distance = 1.0
})
-- Open white widow store customise items in config.lua
RegisterNetEvent('inventory:client:OpenWhiteWidowShop')
AddEventHandler('inventory:client:OpenWhiteWidowShop', function()
    local ShopItems = {}
    ShopItems.label = "White Widow"
    ShopItems.items = Config.WhiteWidowItems
    ShopItems.slots = #Config.WhiteWidowItems
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "White Widow", ShopItems)
end)
-- Targeting for white widow trimming location
exports['qb-target']:AddBoxZone("whitewidowtrim", Config.WhiteWidowTrim, 1.0, 10.0, {
    name="whitewidowtrim",
    heading= 165.24,
    debugPoly=false,
    minZ=49.664,
    maxZ=51.664
    }, {
    options = {
        {
            event = "case-whitewidow:client:TrimmingMenu",
            icon = "fas fa-cannabis", 
            label = "Trim CBD Weed",
			job = "whitewidow",
        },
    },
    distance = 1.0
})
-- Whitewidow weed trimming menu
RegisterNetEvent('case-whitewidow:client:TrimmingMenu', function()
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 3500, false)
    exports['qb-menu']:openMenu({
        {
            header = "Weed Trimming",
            txt = "Requires:</p>28x Baggies</p>3x CBD Weed Crop",
            isMenuHeader = true
        },
        {
            header = "Skunk",
            txt = "Process CBD Skunk crops into bags.",
            params = {
                event = "case-whitewidowjob:server:TrimWeed",
                isServer = true,
                args = 1
            }
        },
        {
            header = "OG-Kush",
            txt = "Process CBD OG Kush crops into bags.",
            params = {
                event = "case-whitewidowjob:server:TrimWeed",
                isServer = true,
                args = 2
            }
        },
		{ 
            header = "White Widow",
            txt = "Process CBD White Widow crops into bags.",
            params = {
                event = "case-whitewidowjob:server:TrimWeed",
                isServer = true,
                args = 3
            }
        },
		{ 
            header = "AK47",
            txt = "Process CBD AK47 crops into bags.",
            params = {
                event = "case-whitewidowjob:server:TrimWeed",
                isServer = true,
                args = 4
            }
        },
        {
            header = "< Exit",
            params = {
                event = "case-whitewidowjob:client:StopMenu"
            }
        },
    })
end)
-- Targeting for whitewidow joint station
exports['qb-target']:AddBoxZone("whitewidowjoints", Config.WhiteWidowJoints, 1.0, 10.0, {
    name="whitewidowjoints",
    heading= 70.72,
    debugPoly=false,
    minZ=53.664,
    maxZ=55.664
    }, {
    options = {
        {
            event = "case-whitewidow:client:RollJoints",
            icon = "fas fa-cannabis", 
            label = "Roll Joints",
			job = "whitewidow",
        },
    },
    distance = 1.0
})
-- Whitewidow roll joints menu
RegisterNetEvent('case-whitewidow:client:RollJoints', function()
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 3500, false)
    exports['qb-menu']:openMenu({
        {
            header = "Joint Rolling Station",
            txt = "Requires:</p>1x 2g Bag of CBD Weed</p>3x Rolling Papers",
            isMenuHeader = true
        },
        {
            header = "CBD Skunk",
            txt = "Roll up some CBD Skunk.",
            params = {
                event = "case-whitewidowjob:server:RollJoints",
                isServer = true,
                args = 1
            }
        },
        {
            header = "CBD OG-Kush",
            txt = "Roll up some CBD OG-Kush.",
            params = {
                event = "case-whitewidowjob:server:RollJoints",
                isServer = true,
                args = 2
            }
        },
		{ 
            header = "CBD White-Widow",
            txt = "Roll up some CBD White-Widow",
            params = {
                event = "case-whitewidowjob:server:RollJoints",
                isServer = true,
                args = 3
            }
        },
		{ 
            header = "CBD AK-47",
            txt = "Roll up some CBD AK-47.",
            params = {
                event = "case-whitewidowjob:server:RollJoints",
                isServer = true,
                args = 4
            }
        },
        {
            header = "< Exit",
            params = {
                event = "case-whitewidowjob:client:StopMenu"
            }
        },
    })
end)
-- Targeting for white widow snacks table
exports['qb-target']:AddBoxZone("whitewidowsnacks", Config.WhiteWidowSnacks, 1.0, 10.0, {
    name="whitewidowsnacks",
    heading= 73.10,
    debugPoly=false,
    minZ=53.664,
    maxZ=55.664
    }, {
    options = {
        {
            event = "inventory:client:OpenWhiteWidowSnackTable",
            icon = "fas fa-box", 
            label = "Purchase Snacks",
        },
    },
    distance = 1.0
})
-- Open vanilla unicorn store customise items in config.lua
RegisterNetEvent('inventory:client:OpenWhiteWidowSnackTable')
AddEventHandler('inventory:client:OpenWhiteWidowSnackTable', function()
    local ShopItems = {}
    ShopItems.label = "White Widow"
    ShopItems.items = Config.WhiteWidowSnackTable
    ShopItems.slots = #Config.WhiteWidowSnackTable
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "White Widow Snacks", ShopItems)
end)
-- Targeting for white widow sales tray
exports['qb-target']:AddBoxZone("whitewidowtray", Config.WhiteWidowTray, 1.0, 10.0, {
    name="whitewidowtray",
    heading= 161.12,
    debugPoly=false,
    minZ=53.664,
    maxZ=55.664
    }, {
    options = {
        {
            event = "case-whitewidowjob:client:OpenTray",
            icon = "fas fa-box", 
            label = "Collect Order",
        },
    },
    distance = 1.0
})
RegisterNetEvent("case-whitewidowjob:client:OpenTray")
AddEventHandler("case-whitewidowjob:client:OpenTray", function()
    TriggerEvent("inventory:client:SetCurrentStash", "whitewidowtray")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "whitewidowtray", {
        maxweight = 20000,
        slots = 5,
    })
end)

-- Targeting for skunk plants
exports['qb-target']:AddBoxZone("skunkplants", Config.WhiteWidowWeed1, 1.0, 40.0, {
    name="skunkplants",
    heading= 249.81,
    debugPoly=false,
    minZ=49.664,
    maxZ=51.664
    }, {
    options = {
        {
            event = "case-whitewidowjob:client:HarvestSkunk",
            icon = "fas fa-cannabis", 
            label = "Harvest CBD Skunk",
        },
    },
    distance = 1.5
})
-- Targeting for og-kush plants
exports['qb-target']:AddBoxZone("ogplants", Config.WhiteWidowWeed2, 1.0, 40.0, {
    name="ogplants",
    heading= 68.70,
    debugPoly=false,
    minZ=49.664,
    maxZ=50.664
    }, {
    options = {
        {
            event = "case-whitewidowjob:client:HarvestOGKush",
            icon = "fas fa-cannabis", 
            label = "Harvest CBD OG-Kush",
        },
    },
    distance = 1.5
})
-- Targeting for white-widow plants
exports['qb-target']:AddBoxZone("whitewidowplants", Config.WhiteWidowWeed3, 1.0, 50.0, {
    name="whitewidowplants",
    heading= 71.90,
    debugPoly=false,
    minZ=49.664,
    maxZ=50.664
    }, {
    options = {
        {
            event = "case-whitewidowjob:client:HarvestWhiteWidow",
            icon = "fas fa-cannabis", 
            label = "Harvest CBD White-Widow",
        },
    },
    distance = 2.0
})
-- Targeting for ak-47 plants
exports['qb-target']:AddBoxZone("akplants", Config.WhiteWidowWeed4, 1.0, 40.0, {
    name="akplants",
    heading= 68.20,
    debugPoly=false,
    minZ=49.664,
    maxZ=50.664
    }, {
    options = {
        {
            event = "case-whitewidowjob:client:HarvestAK47",
            icon = "fas fa-cannabis", 
            label = "Harvest CBD AK-47",
        },
    },
    distance = 1.5
})
-- Harvest og-kush plants
RegisterNetEvent('case-whitewidowjob:client:HarvestWhiteWidow', function()
	local playerPed = PlayerPedId()
    playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 35000)
	local finished = exports["reload-skillbar"]:taskBar(math.random(5000,5001),math.random(2,4))
    if finished ~= 100 then
		QBCore.Functions.Notify("Failed to harvest cbd white-widow..", "error", 3500)
		ClearPedTasks(playerPed)
    else
		local finished2 = exports["reload-skillbar"]:taskBar(math.random(5000,5001),math.random(2,4))
        if finished2 ~= 100 then
			QBCore.Functions.Notify("Failed to harvest cbd white-widow..", "error", 3500)
			ClearPedTasks(playerPed)
        else
			local finished3 = exports["reload-skillbar"]:taskBar(math.random(5000,5001),math.random(2,4))
            if finished3 ~= 100 then
				QBCore.Functions.Notify("Failed to harvest cbd white-widow..", "error", 3500)
				ClearPedTasks(playerPed)
            else
				local HarvestTime = math.random(5000,20000)
                FreezeEntityPosition(playerPed, true)
                TriggerEvent('pogressBar:drawBar', HarvestTime, 'Harvesting CBD White Widow..') 
                Wait(HarvestTime)
                TriggerServerEvent('case-whitewidowjob:server:HarvestWhiteWidow')
                ClearPedTasks(playerPed)
                FreezeEntityPosition(playerPed, false)
            end
        end
    end
end)
-- Harvest og-kush plants
RegisterNetEvent('case-whitewidowjob:client:HarvestAK47', function()
	local playerPed = PlayerPedId()
    playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 35000)
	local finished = exports["reload-skillbar"]:taskBar(math.random(5000,5001),math.random(2,4))
    if finished ~= 100 then
		QBCore.Functions.Notify("Failed to harvest cbd ak47..", "error", 3500)
		ClearPedTasks(playerPed)
    else
		local finished2 = exports["reload-skillbar"]:taskBar(math.random(5000,5001),math.random(2,4))
        if finished2 ~= 100 then
			QBCore.Functions.Notify("Failed to harvest cbd ak47..", "error", 3500)
			ClearPedTasks(playerPed)
        else
			local finished3 = exports["reload-skillbar"]:taskBar(math.random(5000,5001),math.random(2,4))
            if finished3 ~= 100 then
				QBCore.Functions.Notify("Failed to harvest cbd ak47..", "error", 3500)
				ClearPedTasks(playerPed)
            else
				local HarvestTime = math.random(5000,20000)
                FreezeEntityPosition(playerPed, true)
                TriggerEvent('pogressBar:drawBar', HarvestTime, 'Harvesting CBD AK47..') 
                Wait(HarvestTime)
                TriggerServerEvent('case-whitewidowjob:server:HarvestAK47')
                ClearPedTasks(playerPed)
                FreezeEntityPosition(playerPed, false)
            end
        end
    end
end)
-- Harvest og-kush plants
RegisterNetEvent('case-whitewidowjob:client:HarvestWhiteWidow', function()
	local playerPed = PlayerPedId()
    playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 35000)
	local finished = exports["reload-skillbar"]:taskBar(math.random(5000,7500),math.random(2,4))
    if finished ~= 100 then
		QBCore.Functions.Notify("Failed to harvest cbd white-widow..", "error", 3500)
		ClearPedTasks(playerPed)
    else
		local finished2 = exports["reload-skillbar"]:taskBar(math.random(2500,5000),math.random(3,5))
        if finished2 ~= 100 then
			QBCore.Functions.Notify("Failed to harvest cbd white-widow..", "error", 3500)
			ClearPedTasks(playerPed)
        else
			local finished3 = exports["reload-skillbar"]:taskBar(math.random(900,2000),math.random(5,7))
            if finished3 ~= 100 then
				QBCore.Functions.Notify("Failed to harvest cbd white-widow..", "error", 3500)
				ClearPedTasks(playerPed)
            else
				local HarvestTime = math.random(15000,20000)
                FreezeEntityPosition(playerPed, true)
                TriggerEvent('pogressBar:drawBar', HarvestTime, 'Harvesting CBD White Widow..') 
                Wait(HarvestTime)
                TriggerServerEvent('case-whitewidowjob:server:HarvestWhiteWidow')
                ClearPedTasks(playerPed)
                FreezeEntityPosition(playerPed, false)
            end
        end
    end
end)
-- Harvest og-kush plants
RegisterNetEvent('case-whitewidowjob:client:HarvestAK47', function()
	local playerPed = PlayerPedId()
    playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 35000)
	local finished = exports["reload-skillbar"]:taskBar(math.random(5000,7500),math.random(2,4))
    if finished ~= 100 then
		QBCore.Functions.Notify("Failed to harvest cbd ak47..", "error", 3500)
		ClearPedTasks(playerPed)
    else
		local finished2 = exports["reload-skillbar"]:taskBar(math.random(2500,5000),math.random(3,5))
        if finished2 ~= 100 then
			QBCore.Functions.Notify("Failed to harvest cbd ak47..", "error", 3500)
			ClearPedTasks(playerPed)
        else
			local finished3 = exports["reload-skillbar"]:taskBar(math.random(900,2000),math.random(5,7))
            if finished3 ~= 100 then
				QBCore.Functions.Notify("Failed to harvest cbd ak47..", "error", 3500)
				ClearPedTasks(playerPed)
            else
				local HarvestTime = math.random(15000,20000)
                FreezeEntityPosition(playerPed, true)
                TriggerEvent('pogressBar:drawBar', HarvestTime, 'Harvesting CBD AK47..') 
                Wait(HarvestTime)
                TriggerServerEvent('case-whitewidowjob:server:HarvestAK47')
                ClearPedTasks(playerPed)
                FreezeEntityPosition(playerPed, false)
            end
        end
    end
end)
-- Whitewidow garage targeting location
exports['qb-target']:AddBoxZone("whitewidowgarage", Config.WhiteWidowGarage, 1.0, 40.0, {
    name="whitewidowgarage",
    heading= 66.80,
    debugPoly=false,
    minZ=48.664,
    maxZ=51.664
    }, {
    options = {
        {
            event = "case-whitewidowjob:client:GetVehicle",
            icon = "fas fa-car", 
            label = "Take Out Vehicle",
			job = "whitewidow",
        },
    },
    distance = 1.5
})
-- Take out vehicle
RegisterNetEvent('case-whitewidowjob:client:GetVehicle', function()
    exports['qb-menu']:openMenu({
        {
            header = "White Widow Garage",
            txt = "Please return your company van after use!",
            isMenuHeader = true
        },
        {
            header = "Take out a Van",
            txt = "$"..Config.VehicleDeposit.." none refundable deposit required",
            params = {
                event = "case-whitewidowjob:server:SpawnVehicle",
                isServer = true,
            }
        },
		{
		    header = "Return Van",
            txt = "Thank you for returning the van!",
            params = {
                event = "case-whitewidowjob:server:DespawnVehicle",
                isServer = true,
            }
        },
        {
            header = "< Exit",
            params = {
                event = "case-whitewidowjob:client:StopMenu"
            }
        },
    })
end)
-- White widow vehicle spawner
RegisterNetEvent('case-whitewidowjob:client:SpawnVehicle')
AddEventHandler('case-whitewidowjob:client:SpawnVehicle', function()
	SetNewWaypoint(Config.VehicleSpawn.x, Config.VehicleSpawn.y)
		QBCore.Functions.SpawnVehicle(Config.Vehicle, function(veh)
			exports['LegacyFuel']:SetFuel(veh, 100)
			SetVehicleNumberPlateText(veh, 'WWIDOW')
			SetEntityHeading(veh, Config.VehicleSpawnHeading)
			SetEntityAsMissionEntity(veh, true, true)
			TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
			TriggerServerEvent("vehicletuning:server:SaveVehicleProps", QBCore.Functions.GetVehicleProperties(veh))
			SetEntityAsMissionEntity(veh, true, true)
			spawnedveh = veh
			rented = true
		end, Config.VehicleSpawn, false)
end)
-- Despawn vehicle
RegisterNetEvent('case-whitewidowjob:client:DespawnVehicle')
AddEventHandler('case-whitewidowjob:client:DespawnVehicle', function()
	DeleteEntity(spawnedveh)
	rented = false
end)
-- Use joint effects
-- Use joint skunk
RegisterNetEvent('case-whitewidowjob:client:UseSkunkJoint', function()
	local playerPed = PlayerPedId()
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
		if HasItem then
				isSmokingJoint = true
				exports['pogressBar']:drawBar(5000, 'Smoking some cbd skunk..') 
				TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, false)
				Wait(5500)
				ClearPedTasks(playerPed)
				Wait(1000)
				TriggerServerEvent("QBCore:Server:RemoveItem", "weed_skunk_cbd_joint", 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["weed_skunk_cbd_joint"], "remove")
				TriggerServerEvent('hud:server:RelieveStress', math.random(1,5))
				SetTimecycleModifier("drug_flying_base")
				AddArmourToPed(PlayerPedId(), math.random(1,5))
				SetPedMotionBlur(ped, true)
				SetPedMovementClipset(ped, "move_m@hipster@a", true)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.35)
				Wait(1500)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.25)
				Wait(1500)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.15)
				Wait(1500)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
				Citizen.Wait(5*1500)
				ClearTimecycleModifier()
		else		
			QBCore.Functions.Notify('You need a lighter to smoke..', 'error', 3500)
		end
	end, "lighter")
end)
-- Use joint ogkush
RegisterNetEvent('case-whitewidowjob:client:UseOGKushJoint', function()
	local playerPed = PlayerPedId()
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
		if HasItem then
				isSmokingJoint = true
				exports['pogressBar']:drawBar(5000, 'Smoking some cbd og kush..') 
				TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, false)
				Wait(5500)
				ClearPedTasks(playerPed)
				Wait(1000)
				TriggerServerEvent("QBCore:Server:RemoveItem", "weed_og-kush_cbd_joint", 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["weed_og-kush_cbd_joint"], "remove")
				TriggerServerEvent('hud:server:RelieveStress', math.random(3,8))
				SetTimecycleModifier("drug_flying_base")
				AddArmourToPed(PlayerPedId(), math.random(3,8))
				SetPedMotionBlur(ped, true)
				SetPedMovementClipset(ped, "move_m@hipster@a", true)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.35)
				Wait(1500)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.25)
				Wait(1500)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.15)
				Wait(1500)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
				Citizen.Wait(5*1500)
				ClearTimecycleModifier()
		else		
			QBCore.Functions.Notify('You need a lighter to smoke..', 'error', 3500)
		end
	end, "lighter")
end)
-- Use joint whitewidow
RegisterNetEvent('case-whitewidowjob:client:UseWhiteWidowJoint', function()
	local playerPed = PlayerPedId()
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
		if HasItem then
				isSmokingJoint = true
				exports['pogressBar']:drawBar(5000, 'Smoking some cbd white widow..') 
				TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, false)
				Wait(5500)
				ClearPedTasks(playerPed)
				Wait(1000)
				TriggerServerEvent("QBCore:Server:RemoveItem", "weed_white-widow_cbd_joint", 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["weed_white-widow_cbd_joint"], "remove")
				TriggerServerEvent('hud:server:RelieveStress', math.random(5,11))
				SetTimecycleModifier("drug_flying_base")
				AddArmourToPed(PlayerPedId(), math.random(5,11))
				SetPedMotionBlur(ped, true)
				SetPedMovementClipset(ped, "move_m@hipster@a", true)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.35)
				Wait(1500)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.25)
				Wait(1500)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.15)
				Wait(1500)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
				Citizen.Wait(5*1500)
				ClearTimecycleModifier()
		else		
			QBCore.Functions.Notify('You need a lighter to smoke..', 'error', 3500)
		end
	end, "lighter")
end)
-- Use joint ak47
RegisterNetEvent('case-whitewidowjob:client:UseAK47Joint', function()
	local playerPed = PlayerPedId()
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
		if HasItem then
				isSmokingJoint = true
				exports['pogressBar']:drawBar(5000, 'Smoking some cbd ak47..') 
				TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, false)
				Wait(5500)
				ClearPedTasks(playerPed)
				Wait(1000)
				TriggerServerEvent("QBCore:Server:RemoveItem", "weed_ak47_cbd_joint", 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["weed_ak47_cbd_joint"], "remove")
				TriggerServerEvent('hud:server:RelieveStress', math.random(9,13))
				SetTimecycleModifier("drug_flying_base")
				AddArmourToPed(PlayerPedId(), math.random(9,13))
				SetPedMotionBlur(ped, true)
				SetPedMovementClipset(ped, "move_m@hipster@a", true)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.35)
				Wait(1500)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.25)
				Wait(1500)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.15)
				Wait(1500)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
				Citizen.Wait(5*1500)
				ClearTimecycleModifier()
		else		
			QBCore.Functions.Notify('You need a lighter to smoke..', 'error', 3500)
		end
	end, "lighter")
end)
-- Do not change anything below here
-- Function to close qb-menu
RegisterNetEvent('case-whitewidowjob:client:StopMenu', function()
    ClearPedTasks(PlayerPedId())
end)
-- Animations function
function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Wait(0) 
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end
-- Floating help text
helpText = function(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end
