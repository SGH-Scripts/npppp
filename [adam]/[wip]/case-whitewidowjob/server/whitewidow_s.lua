-------------------------------
---------- CASE#2506 ----------
-------------------------------

local QBCore = exports['qb-core']:GetCoreObject()


-- White widow trim weed
RegisterServerEvent('case-whitewidowjob:server:TrimWeed', function(args) 
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local args = tonumber(args)
    local removeAmount = 3
    local returnAmount = math.random (14,28)
    local baggieAmount = 28
    local packageTime = 7500
    if args == 1 then 
        local skunk = Player.Functions.GetItemByName("weed_skunk_cbd_crop") 
        if skunk ~= nil then
            if skunk.amount >= removeAmount then
                local baggies = Player.Functions.GetItemByName("empty_weed_bag") 
                if baggies ~= nil then
                    if baggies.amount >= baggieAmount then
                        Player.Functions.RemoveItem("weed_skunk_cbd_crop", removeAmount)
						Player.Functions.RemoveItem("empty_weed_bag", returnAmount)
                        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weed_skunk_cbd_crop'], "remove", removeAmount)
						TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['empty_weed_bag'], "remove", returnAmount)
                        TriggerClientEvent('pogressBar:drawBar', src, packageTime, 'Trimming weed..')
                        SetTimeout(packageTime, function()
                            if Player.Functions.AddItem('weed_skunk_cbd', returnAmount, nil, info, {["quality"] = 100}) then
                                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_skunk_cbd"], "add", returnAmount)
								TriggerClientEvent('QBCore:Notify', src, 'You cut a crop of CBD Skunk!', 'success')
                                TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
                            else
                                TriggerClientEvent('QBCore:Notify', src, 'Your pockets are full..', 'error')
                            end
                        end)
                    else
                        TriggerClientEvent('QBCore:Notify', src, "You need atleast 28 baggies..", 'error')
                        TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
                    end
                else
                    TriggerClientEvent('QBCore:Notify', src, "You dont have any baggies..", "error")
                    TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You dont have enough CBD Skunk crops..", 'error')
                TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You dont have any CBD Skunk crops..", "error")
            TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
        end
	elseif args == 2 then 
        local ogkush = Player.Functions.GetItemByName("weed_og-kush_cbd_crop") 
        if ogkush ~= nil then
            if ogkush.amount >= removeAmount then
                local baggies = Player.Functions.GetItemByName("empty_weed_bag") 
                if baggies ~= nil then
                    if baggies.amount >= baggieAmount then
                        Player.Functions.RemoveItem("weed_og-kush_cbd_crop", removeAmount)
						Player.Functions.RemoveItem("empty_weed_bag", returnAmount)
                        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weed_og-kush_cbd_crop'], "remove", removeAmount)
						TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['empty_weed_bag'], "remove", returnAmount)
                        TriggerClientEvent('pogressBar:drawBar', src, packageTime, 'Trimming weed..')
                        SetTimeout(packageTime, function()
                            if Player.Functions.AddItem('weed_og-kush_cbd', returnAmount, nil, info, {["quality"] = 100}) then
                                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_og-kush_cbd"], "add", returnAmount)
								TriggerClientEvent('QBCore:Notify', src, 'You cut a crop of CBD OG Kush!', 'success')
                                TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
                            else
                                TriggerClientEvent('QBCore:Notify', src, 'Your pockets are full..', 'error')
                            end
                        end)
                    else
                        TriggerClientEvent('QBCore:Notify', src, "You need atleast 28 baggies..", 'error')
                        TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
                    end
                else
                    TriggerClientEvent('QBCore:Notify', src, "You dont have any baggies..", "error")
                    TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You dont have enough CBD OG Kush crops..", 'error')
                TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You dont have any CBD OG Kush crops..", "error")
            TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
        end
	elseif args == 3 then 
        local whitewidow = Player.Functions.GetItemByName("weed_white-widow_cbd_crop") 
        if whitewidow ~= nil then
            if whitewidow.amount >= removeAmount then
                local baggies = Player.Functions.GetItemByName("empty_weed_bag") 
                if baggies ~= nil then
                    if baggies.amount >= baggieAmount then
                        Player.Functions.RemoveItem("weed_white-widow_cbd_crop", removeAmount)
						Player.Functions.RemoveItem("empty_weed_bag", returnAmount)
                        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weed_white-widow_cbd_crop'], "remove", removeAmount)
						TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['empty_weed_bag'], "remove", returnAmount)
                        TriggerClientEvent('pogressBar:drawBar', src, packageTime, 'Trimming weed..')
                        SetTimeout(packageTime, function()
                            if Player.Functions.AddItem('weed_white-widow_cbd', returnAmount, nil, info, {["quality"] = 100}) then
                                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_white-widow_cbd"], "add", returnAmount)
								TriggerClientEvent('QBCore:Notify', src, 'You cut a crop of CBD White Widow!', 'success')
                                TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
                            else
                                TriggerClientEvent('QBCore:Notify', src, 'Your pockets are full..', 'error')
                            end
                        end)
                    else
                        TriggerClientEvent('QBCore:Notify', src, "You need atleast 28 baggies..", 'error')
                        TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
                    end
                else
                    TriggerClientEvent('QBCore:Notify', src, "You dont have any baggies..", "error")
                    TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You dont have enough CBD White Widow crops..", 'error')
                TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You dont have any CBD White Widow crops..", "error")
            TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
        end
    elseif args == 4 then 
        local ak47 = Player.Functions.GetItemByName("weed_ak47_cbd_crop") 
        if ak47 ~= nil then
            if ak47.amount >= removeAmount then
                local baggies = Player.Functions.GetItemByName("empty_weed_bag") 
                if baggies ~= nil then
                    if baggies.amount >= baggieAmount then
                        Player.Functions.RemoveItem("weed_ak47_cbd_crop", removeAmount)
						Player.Functions.RemoveItem("empty_weed_bag", returnAmount)
                        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weed_ak47_cbd_crop'], "remove", removeAmount)
						TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['empty_weed_bag'], "remove", returnAmount)
                        TriggerClientEvent('pogressBar:drawBar', src, packageTime, 'Trimming weed..')
                        SetTimeout(packageTime, function()
                            if Player.Functions.AddItem('weed_ak47_cbd', returnAmount, nil, info, {["quality"] = 100}) then
                                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_ak47_cbd"], "add", returnAmount)
								TriggerClientEvent('QBCore:Notify', src, 'You cut a crop of CBD AK47!', 'success')
                                TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
                            else
                                TriggerClientEvent('QBCore:Notify', src, 'Your pockets are full..', 'error')
                            end
                        end)
                    else
                        TriggerClientEvent('QBCore:Notify', src, "You need atleast 28 baggies..", 'error')
                        TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
                    end
                else
                    TriggerClientEvent('QBCore:Notify', src, "You dont have any baggies..", "error")
                    TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You dont have enough CBD AK47 crops..", 'error')
                TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You dont have any CBD AK47 crops..", "error")
            TriggerClientEvent('case-whitewidow:client:TrimmingMenu', src)
        end
    end
end)
-- White widow roll joints
RegisterServerEvent('case-whitewidowjob:server:RollJoints', function(args) 
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local args = tonumber(args)
    local removeAmount = 1
    local returnAmount = 3
    local packageTime = 7500
    if args == 1 then 
        local skunk = Player.Functions.GetItemByName("weed_skunk_cbd") 
        if skunk ~= nil then
            if skunk.amount >= removeAmount then
                local baggies = Player.Functions.GetItemByName("rolling_paper") 
                if baggies ~= nil then
                    if baggies.amount >= returnAmount then
                        Player.Functions.RemoveItem("weed_skunk_cbd", removeAmount)
						Player.Functions.RemoveItem("rolling_paper", returnAmount)
                        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weed_skunk_cbd'], "remove", removeAmount)
						TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['rolling_paper'], "remove", returnAmount)
                        TriggerClientEvent('pogressBar:drawBar', src, packageTime, 'Rolling up some cbd skunk..')
                        SetTimeout(packageTime, function()
                            if Player.Functions.AddItem('weed_skunk_cbd_joint', returnAmount, nil, info, {["quality"] = 100}) then
                                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_skunk_cbd_joint"], "add", returnAmount)
								TriggerClientEvent('QBCore:Notify', src, 'You rolled up some CBD Skunk!', 'success')
                                TriggerClientEvent('case-whitewidow:client:RollJoints', src)
                            else
                                TriggerClientEvent('QBCore:Notify', src, 'Your pockets are full..', 'error')
                            end
                        end)
                    else
                        TriggerClientEvent('QBCore:Notify', src, "You don't have enough rolling papers..", 'error')
                        TriggerClientEvent('case-whitewidow:client:RollJoints', src)
                    end
                else
                    TriggerClientEvent('QBCore:Notify', src, "You don't have any rolling papers..", "error")
                    TriggerClientEvent('case-whitewidow:client:RollJoints', src)
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You dont have enough bags of CBD Skunk..", 'error')
                TriggerClientEvent('case-whitewidow:client:RollJoints', src)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You dont have any bags of CBD Skunk..", "error")
            TriggerClientEvent('case-whitewidow:client:RollJoints', src)
        end
	elseif args == 2 then 
        local ogkush = Player.Functions.GetItemByName("weed_og-kush_cbd") 
        if ogkush ~= nil then
            if ogkush.amount >= removeAmount then
                local baggies = Player.Functions.GetItemByName("rolling_paper") 
                if baggies ~= nil then
                    if baggies.amount >= returnAmount then
                        Player.Functions.RemoveItem("weed_og-kush_cbd", removeAmount)
						Player.Functions.RemoveItem("rolling_paper", returnAmount)
                        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weed_og-kush_cbd'], "remove", removeAmount)
						TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['rolling_paper'], "remove", returnAmount)
                        TriggerClientEvent('pogressBar:drawBar', src, packageTime, 'Rolling up some cbd og-kush..')
                        SetTimeout(packageTime, function()
                            if Player.Functions.AddItem('weed_og-kush_cbd_joint', returnAmount, nil, info, {["quality"] = 100}) then
                                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_og-kush_cbd_joint"], "add", returnAmount)
								TriggerClientEvent('QBCore:Notify', src, 'You rolled up some CBD OG-Kush!', 'success')
                                TriggerClientEvent('case-whitewidow:client:RollJoints', src)
                            else
                                TriggerClientEvent('QBCore:Notify', src, 'Your pockets are full..', 'error')
                            end
                        end)
                    else
                        TriggerClientEvent('QBCore:Notify', src, "You don't have enough rolling papers..", 'error')
                        TriggerClientEvent('case-whitewidow:client:RollJoints', src)
                    end
                else
                    TriggerClientEvent('QBCore:Notify', src, "You don't have any rolling papers..", "error")
                    TriggerClientEvent('case-whitewidow:client:RollJoints', src)
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You dont have enough bags of CBD OG-Kush..", 'error')
                TriggerClientEvent('case-whitewidow:client:RollJoints', src)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You dont have any bags of CBD OG-Kush..", "error")
            TriggerClientEvent('case-whitewidow:client:RollJoints', src)
        end
	elseif args == 3 then 
        local whitewidow = Player.Functions.GetItemByName("weed_white-widow_cbd") 
        if whitewidow ~= nil then
            if whitewidow.amount >= removeAmount then
                local baggies = Player.Functions.GetItemByName("rolling_paper") 
                if baggies ~= nil then
                    if baggies.amount >= returnAmount then
                        Player.Functions.RemoveItem("weed_white-widow_cbd", removeAmount)
						Player.Functions.RemoveItem("rolling_paper", returnAmount)
                        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weed_white-widow_cbd'], "remove", removeAmount)
						TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['rolling_paper'], "remove", returnAmount)
                        TriggerClientEvent('pogressBar:drawBar', src, packageTime, 'Rolling up some cbd white-widow..')
                        SetTimeout(packageTime, function()
                            if Player.Functions.AddItem('weed_white-widow_cbd_joint', returnAmount, nil, info, {["quality"] = 100}) then
                                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_white-widow_cbd_joint"], "add", returnAmount)
								TriggerClientEvent('QBCore:Notify', src, 'You rolled up some CBD White-Widow!', 'success')
                                TriggerClientEvent('case-whitewidow:client:RollJoints', src)
                            else
                                TriggerClientEvent('QBCore:Notify', src, 'Your pockets are full..', 'error')
                            end
                        end)
                    else
                        TriggerClientEvent('QBCore:Notify', src, "You don't have enough rolling papers..", 'error')
                        TriggerClientEvent('case-whitewidow:client:RollJoints', src)
                    end
                else
                    TriggerClientEvent('QBCore:Notify', src, "You don't have any rolling papers..", "error")
                    TriggerClientEvent('case-whitewidow:client:RollJoints', src)
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You dont have enough bags of CBD White-Widow..", 'error')
                TriggerClientEvent('case-whitewidow:client:RollJoints', src)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You dont have any bags of CBD White-Widow..", "error")
            TriggerClientEvent('case-whitewidow:client:RollJoints', src)
        end
    elseif args == 4 then 
        local ak47 = Player.Functions.GetItemByName("weed_ak47_cbd") 
        if ak47 ~= nil then
            if ak47.amount >= removeAmount then
                local baggies = Player.Functions.GetItemByName("rolling_paper") 
                if baggies ~= nil then
                    if baggies.amount >= returnAmount then
                        Player.Functions.RemoveItem("weed_ak47_cbd", removeAmount)
						Player.Functions.RemoveItem("rolling_paper", returnAmount)
                        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weed_ak47_cbd'], "remove", removeAmount)
						TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['rolling_paper'], "remove", returnAmount)
                        TriggerClientEvent('pogressBar:drawBar', src, packageTime, 'Rolling up some cbd ak-47..')
                        SetTimeout(packageTime, function()
                            if Player.Functions.AddItem('weed_ak47_cbd_joint', returnAmount, nil, info, {["quality"] = 100}) then
                                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_ak47_cbd_joint"], "add", returnAmount)
								TriggerClientEvent('QBCore:Notify', src, 'You cut a crop of CBD AK47!', 'success')
                                TriggerClientEvent('case-whitewidow:client:RollJoints', src)
                            else
                                TriggerClientEvent('QBCore:Notify', src, 'Your pockets are full..', 'error')
                            end
                        end)
                    else
                        TriggerClientEvent('QBCore:Notify', src, "You don't have enough rolling papers..", 'error')
                        TriggerClientEvent('case-whitewidow:client:RollJoints', src)
                    end
                else
                    TriggerClientEvent('QBCore:Notify', src, "You don't have any rolling papers..", "error")
                    TriggerClientEvent('case-whitewidow:client:RollJoints', src)
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You dont have enough bags of CBD AK-47..", 'error')
                TriggerClientEvent('case-whitewidow:client:RollJoints', src)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You dont have any bags of CBD AK-47..", "error")
            TriggerClientEvent('case-whitewidow:client:RollJoints', src)
        end
    end
end)
-- Harvest skunk plants
RegisterServerEvent('case-whitewidowjob:server:HarvestSkunk', function() 
    local src = source
    local Player  = QBCore.Functions.GetPlayer(src)
    local quantity = math.random(1, 3)
	if (85 >= math.random(1, 100)) then
        if Player.Functions.AddItem("weed_skunk_cbd_crop", 1, slot, {["quality"] = 100}) then
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_skunk_cbd_crop"], "add", quantity)
			TriggerClientEvent('QBCore:Notify', src, 'You successfully harvested a cbd skunk plant!', 'success')
		end	
	else
        TriggerClientEvent('QBCore:Notify', src, 'You damaged the plant trying to harvest..', 'error')
	end
end)
-- Harvest og-kush plants
RegisterServerEvent('case-whitewidowjob:server:HarvestOGKush', function() 
    local src = source
    local Player  = QBCore.Functions.GetPlayer(src)
    local quantity = math.random(1, 3)
	if (30 >= math.random(1, 100)) then
        if Player.Functions.AddItem("weed_og-kush_cbd_crop", 1, slot, {["quality"] = 100}) then
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_og-kush_cbd_crop"], "add", quantity)
			TriggerClientEvent('QBCore:Notify', src, 'You successfully harvested a cbd og-kush plant!', 'success')
		end
	else
        TriggerClientEvent('QBCore:Notify', src, 'You damaged the plant trying to harvest..', 'error')
	end
end)
-- Harvest white-widow plants
RegisterServerEvent('case-whitewidowjob:server:HarvestWhiteWidow', function() 
    local src = source
    local Player  = QBCore.Functions.GetPlayer(src)
    local quantity = math.random(1, 3)
	if (75 >= math.random(1, 100)) then
        if  Player.Functions.AddItem("weed_white-widow_cbd_crop", 1, slot, {["quality"] = 100}) then
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_white-widow_cbd_crop"], "add", quantity)
			TriggerClientEvent('QBCore:Notify', src, 'You successfully harvested a cbd white-widow plant!', 'success')
		end	
	else
        TriggerClientEvent('QBCore:Notify', src, 'You damaged the plant trying to harvest..', 'error')
	end
end)
-- Harvest og-kush plants
RegisterServerEvent('case-whitewidowjob:server:HarvestAK47', function() 
    local src = source
    local Player  = QBCore.Functions.GetPlayer(src)
    local quantity = math.random(1, 3)
	if (10 >= math.random(1, 100)) then
        if Player.Functions.AddItem("weed_ak47_cbd_crop", 1, slot, {["quality"] = 100}) then
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_ak47_cbd_crop"], "add", quantity)
			TriggerClientEvent('QBCore:Notify', src, 'You successfully harvested a cbd ak47 plant!', 'success')
		end	
	else
        TriggerClientEvent('QBCore:Notify', src, 'You damaged the plant trying to harvest..', 'error')
	end
end)
-- White widow billing
RegisterServerEvent("case-whitewidowjob:client:WhiteWidowPay:player")
AddEventHandler("case-whitewidowjob:client:WhiteWidowPay:player", function(playerId, amount)
        local biller = QBCore.Functions.GetPlayer(source)
        local billed = QBCore.Functions.GetPlayer(tonumber(playerId))
        local amount = tonumber(amount)
        if biller.PlayerData.job.name == 'whitewidow' then
            if billed ~= nil then
                if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                    if amount and amount > 0 then
                        exports.oxmysql:insert('INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (@citizenid, @amount, @society, @sender, @sendercitizenid)', {
                            ['@citizenid'] = billed.PlayerData.citizenid,
                            ['@amount'] = amount,
                            ['@society'] = biller.PlayerData.job.name,
                            ['@sender'] = biller.PlayerData.charinfo.firstname,
                            ['@sendercitizenid'] = biller.PlayerData.citizenid
                        })
                        TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
                        TriggerClientEvent('QBCore:Notify', source, 'Invoice Successfully Sent', 'success')
                        TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'New Invoice Received')
                    else
                        TriggerClientEvent('QBCore:Notify', source, 'Must Be A Valid Amount Above 0', 'error')
                    end
                else
                    TriggerClientEvent('QBCore:Notify', source, 'You Cannot Bill Yourself', 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', source, 'Player Not Online', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'No Access', 'error')
        end
end)
-- White widow spawn vehicle
RegisterServerEvent('case-whitewidowjob:server:SpawnVehicle')
AddEventHandler('case-whitewidowjob:server:SpawnVehicle', function()
		local src = source
    	local Player = QBCore.Functions.GetPlayer(src)
		local carprice = Player.PlayerData.money["bank"]
		if carprice >= Config.VehicleDeposit then
			Player.Functions.RemoveMoney('bank', Config.VehicleDeposit) 
			TriggerClientEvent('case-whitewidowjob:client:SpawnVehicle', src)
		else
			TriggerClientEvent('QBCore:Notify', src, 'You need $'..Config.VehicleDeposit..' to take out a vehicle', "error")   
		end
end)
-- White widow return vehicle
RegisterServerEvent('case-whitewidowjob:server:DespawnVehicle')
AddEventHandler('case-whitewidowjob:server:DespawnVehicle', function()
		local src = source
    	local Player = QBCore.Functions.GetPlayer(src)
		TriggerClientEvent('case-whitewidowjob:client:DespawnVehicle', src)
end)
-- Use joints
QBCore.Functions.CreateUseableItem("weed_skunk_cbd_joint", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("case-whitewidowjob:client:UseSkunkJoint", source)
    end
end)
QBCore.Functions.CreateUseableItem("weed_og-kush_cbd_joint", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("case-whitewidowjob:client:UseOGKushJoint", source)
    end
end)
QBCore.Functions.CreateUseableItem("weed_white-widow_cbd_joint", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("case-whitewidowjob:client:UseWhiteWidowJoint", source)
    end
end)
QBCore.Functions.CreateUseableItem("weed_ak47_cbd_joint", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("case-whitewidowjob:client:UseAK47Joint", source)
    end
end)