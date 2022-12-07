-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5
-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5
-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5
-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5
-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5

------- Variables -------
ESX = nil
local QBCore
local isLoggedIn = false

------- QB & ESX -------
Citizen.CreateThread(function()
	if Config.Framework == 'ESX' then
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(0)
		end
		
		while ESX.GetPlayerData().job == nil do
			Citizen.Wait(10)
		end
		
		PlayerData = ESX.GetPlayerData()
		TriggerServerEvent('an_cbs:requestSVdata')
	elseif Config.Framework == 'QBCORE' then
		QBCore = exports['qb-core']:GetCoreObject()
		TriggerServerEvent('an_cbs:requestSVdata')
	end
end)

------- ESX -------
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	isLoggedIn = true
	PlayerData = xPlayer
end)

------- QBCore -------
RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
	isLoggedIn = true
	PlayerData = QBCore.Functions.GetPlayerData()
end)

------- OG Variables -------
local UIOpened = false
local placedSigns = {}
local signModel = 'prop_protest_sign_01'
local currSignTitle = nil
local currSignCoords = nil
local currSignContent = nil
local nearSign = nil
local signShowed = false
local signObjects = {}
-----

RegisterNetEvent('an_cbs:addSignCL')
AddEventHandler('an_cbs:addSignCL', function(svdata)
	local obj = CreateObject(signModel, svdata.coords.x, svdata.coords.y, svdata.coords.z, false, false, false)
	SetEntityHeading(obj, svdata.heading)
	PlaceObjectOnGroundProperly(obj)
	SetEntityAsMissionEntity(obj,true)
    FreezeEntityPosition(obj,true)
	signObjects[svdata.dbid] = obj
	svdata.created = true
	placedSigns[svdata.dbid] = svdata
end)

RegisterNetEvent('an_cbs:removeSignCL')
AddEventHandler('an_cbs:removeSignCL', function(signID)
	placedSigns[signID] = nil
	SetEntityAsMissionEntity(signObjects[signID], true, true)
	NetworkRegisterEntityAsNetworked(signObjects[signID])
	NetworkRequestControlOfEntity(signObjects[signID])
	DeleteEntity(signObjects[signID])
	signObjects[signID] = nil
	HideSign() -- to hide the ui sign
	nearSign = nil
end)

RegisterNetEvent('an_cbs:updateSignsCL')
AddEventHandler('an_cbs:updateSignsCL', function(svSigns)
	placedSigns = svSigns
end)

RegisterCommand('removeboard', function(src,args,rawCmd)
	local pedcoords = GetEntityCoords(PlayerPedId())
	if nearSign ~= nil then
		TriggerServerEvent('an_cbs:removeSign', placedSigns[nearSign].dbid, placedSigns[nearSign].owner)
	end
end)

if not Config.usableItem then
	RegisterCommand('createboard', function(src, args, rawCmd)
		openCBS()
	end)
end

RegisterNetEvent('an_cbs:useSignItem')
AddEventHandler('an_cbs:useSignItem', function()
	Wait(300) -- wait until the inventory closes for slow inventories
	openCBS()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local pedcoords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(placedSigns) do
			local dst = #(pedcoords - v.coords)
			if dst < 1.9 then
				nearSign = k
				break
			elseif nearSign == k then
				nearSign = nil
				HideSign()
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		local pedcoords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(placedSigns) do
			if #(pedcoords - v.coords) < 200.0 then
				if v.created == false then
					-- print('creating sign number: '..v.dbid)
					local obj = CreateObject(signModel, v.coords.x, v.coords.y, v.coords.z, false, false, false)
					SetEntityHeading(obj, v.heading)
					PlaceObjectOnGroundProperly(obj)
					SetEntityAsMissionEntity(obj,true)
					FreezeEntityPosition(obj,true)
					signObjects[v.dbid] = obj
					v.created = true
				end
			else
				if v.created == true then
					SetEntityAsMissionEntity(signObjects[v.dbid], true, true)
					NetworkRegisterEntityAsNetworked(signObjects[v.dbid])
					NetworkRequestControlOfEntity(signObjects[v.dbid])
					DeleteEntity(signObjects[v.dbid])
					v.created = false
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if not signShowed then
			if nearSign ~= nil then
				showCBS(placedSigns[nearSign].content)
			end
		end
	end
end)

function HideSign()
	if signShowed then
		SendNUIMessage({
			action = 'closeCBS',
		})
		signShowed = false
	end
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        for k, v in pairs(signObjects) do
		    SetEntityAsMissionEntity(v, true, true)
			NetworkRegisterEntityAsNetworked(v)
			NetworkRequestControlOfEntity(v)
			DeleteEntity(v)
        end
		SetPlayerControl(PlayerId(), 1, 0)
	end
end)

RegisterNetEvent('an_cbs:Notify')
AddEventHandler('an_cbs:Notify', function(msg)
	Notify(msg)
end)

-- Notification Function
function Notify(msg)
	if Config.useMythic then
		exports['mythic_notify']:SendAlert('inform', msg, 12000, { ['background-color'] = '#839129', ['color'] = '#fff' })
	elseif Config.useQBnotif then
		QBCore.Functions.Notify(msg, 'primary', 12000)
	elseif Config.useESXnotif then
		ESX.ShowNotification(msg, false)
	else
		print(msg)
	end
end

function openCBS()
    if not IsPedInAnyVehicle(PlayerPedId(), false) and not UIOpened then
        SetPlayerControl(PlayerId(), 0, 0)
        SendNUIMessage({
            action = 'openPutCBS',
        })
        UIOpened = true
        SetNuiFocus(true, true);
    end
end

RegisterNUICallback('escape', function(data, cb)
    local text = data.text
	if text == nil then text = "" end
	print('NUI:escape: '..text)
    TriggerEvent("an_cbs:close")
end)

RegisterNUICallback('emptySign', function(data, cb)
	Notify('You cannot leave it empty.')
end)

RegisterNUICallback('putCBS', function(data, cb)
    local text = data.text
	if text == nil then text = "" end
	currSignCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0)
	local pedH = GetEntityHeading(PlayerPedId())
	-- save to database
	local signData = { content = text, coords = currSignCoords, heading = pedH, created = false }
	TriggerServerEvent('an_cbs:createSign', signData)
	--
	currSignCoords = nil
    TriggerEvent("an_cbs:close")
end)

RegisterNetEvent("an_cbs:close")
AddEventHandler("an_cbs:close", function()
    SendNUIMessage({
        action = 'closeCBS'
    })
    SetPlayerControl(PlayerId(), 1, 0)
    UIOpened = false
    SetNuiFocus(false, false)
    Citizen.Wait(150)
end)

function showCBS(text)
	signShowed = true
	SendNUIMessage({
		action = 'showCBS',
		TextRead = text,
	})
end

-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5
-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5
-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5
-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5
-- Join Discord for support: https://discord.gg/f2Nbv9Ebf5