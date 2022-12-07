-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5
-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5
-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5
-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5
-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5

ESX = nil
local QBCore

if Config.Framework == 'ESX' then
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif Config.Framework == 'QBCORE' then
	QBCore = exports['qb-core']:GetCoreObject()
end

local svPlacedSigns = {}

Citizen.CreateThread(function()
	local result = MySQL.Sync.fetchAll('SELECT * FROM `an_chalkboard_signs`')
	for k,v in pairs(result) do
		local dbid = v.id
		local owner = v.owner
		local signData = json.decode(v.data)
		local rawData = { content = signData.content, coords = vector3(signData.coords.x, signData.coords.y, signData.coords.z), heading = signData.heading, owner = owner, dbid = dbid, created = false }
		svPlacedSigns[dbid] = rawData
	end
end)

RegisterServerEvent('an_cbs:requestSVdata')
AddEventHandler('an_cbs:requestSVdata', function()
	TriggerClientEvent('an_cbs:updateSignsCL', source, svPlacedSigns)
end)

RegisterServerEvent('an_cbs:createSign')
AddEventHandler('an_cbs:createSign', function(signData)
	local src = source
	local identifier = GetPlayerIdentifiers(src)[1]
	local rawData = { content = signData.content, coords = signData.coords, heading = signData.heading, owner = identifier }
	MySQL.Async.insert('INSERT INTO an_chalkboard_signs (data, owner) VALUES (@data, @owner)', { ['data'] = json.encode(rawData), ['owner'] = identifier },
	function(insID)
		svPlacedSigns[insID] = rawData
		-- update all clients
		rawData.created = false
		rawData.dbid = insID
		TriggerClientEvent('an_cbs:addSignCL', -1, rawData)
		TriggerClientEvent('an_cbs:Notify', src, 'Your board was successfully placed!')
	end)
end)

RegisterServerEvent('an_cbs:removeSign')
AddEventHandler('an_cbs:removeSign', function(signID, owner)
	local src = source
	local identifier = GetPlayerIdentifiers(src)[1]
	if identifier == owner then
		svPlacedSigns[signID] = nil
		MySQL.Sync.execute('DELETE FROM an_chalkboard_signs WHERE `id` = @id', { ['id'] = signID })
		TriggerClientEvent('an_cbs:removeSignCL', -1, signID)
		if Config.Framework == 'ESX' then
			local xPlayer = ESX.GetPlayerFromId(src)
			xPlayer.addInventoryItem('chalkboardsign', 1)
		elseif Config.Framework == 'QBCORE' then
			local Player = QBCore.Functions.GetPlayer(src)
			Player.Functions.AddItem('chalkboardsign', 1, false)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["chalkboardsign"], "add")
		end
		TriggerClientEvent('an_cbs:Notify', src, 'Your board was removed.')
	else
		TriggerClientEvent('an_cbs:Notify', src, 'You are not the owner of this board.')
	end
end)


if Config.usableItem then
	if Config.Framework == 'ESX' then
		ESX.RegisterUsableItem('chalkboardsign', function(source)
			local src = source
			local xPlayer = ESX.GetPlayerFromId(src)
			TriggerClientEvent('an_cbs:useSignItem', src)
			xPlayer.removeInventoryItem('chalkboardsign', 1)
		end)
	elseif Config.Framework == 'QBCORE' then
		QBCore.Functions.CreateUseableItem('chalkboardsign', function(source)
			local src = source
			local Player = QBCore.Functions.GetPlayer(src)
			TriggerClientEvent('an_cbs:useSignItem', src)
			Player.Functions.RemoveItem("chalkboardsign", 1)
		end)
	end
end

RegisterServerEvent('an_cbs:addBoardItem')
AddEventHandler('an_cbs:addBoardItem', function()
	if Config.Framework == 'ESX' then
		local src = source
		local xPlayer = ESX.GetPlayerFromId(src)
		xPlayer.addInventoryItem('chalkboardsign', 1)
	elseif Config.Framework == 'QBCORE' then
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)
		Player.Functions.AddItem("chalkboardsign", 1)
	end
end)

-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5
-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5
-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5
-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5
-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5