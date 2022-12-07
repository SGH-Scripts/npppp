QBCore = exports['qb-core']:GetCoreObject()
local closestBank = nil
local closestLocker = nil
local inRange
local copsCalled = false
local PlayerJob = {}
local refreshed = false
CurrentCops = 0

local function ResetBankDoors()
    for k, v in pairs(Config.SmallBanks) do
        local object = GetClosestObjectOfType(Config.SmallBanks[k]["coords"]["x"], Config.SmallBanks[k]["coords"]["y"], Config.SmallBanks[k]["coords"]["z"], 5.0, Config.SmallBanks[k]["object"], false, false, false)
        if not Config.SmallBanks[k]["isOpened"] then
            SetEntityHeading(object, Config.SmallBanks[k]["heading"].closed)
        else
            SetEntityHeading(object, Config.SmallBanks[k]["heading"].open)
        end
    end
    if not Config.BigBanks["paleto"]["isOpened"] then
        local paletoObject = GetClosestObjectOfType(Config.BigBanks["paleto"]["coords"]["x"], Config.BigBanks["paleto"]["coords"]["y"], Config.BigBanks["paleto"]["coords"]["z"], 5.0, Config.BigBanks["paleto"]["object"], false, false, false)
        SetEntityHeading(paletoObject, Config.BigBanks["paleto"]["heading"].closed)
    else
        local paletoObject = GetClosestObjectOfType(Config.BigBanks["paleto"]["coords"]["x"], Config.BigBanks["paleto"]["coords"]["y"], Config.BigBanks["paleto"]["coords"]["z"], 5.0, Config.BigBanks["paleto"]["object"], false, false, false)
        SetEntityHeading(paletoObject, Config.BigBanks["paleto"]["heading"].open)
    end

    if not Config.BigBanks["pacific"]["isOpened"] then
        local pacificObject = GetClosestObjectOfType(Config.BigBanks["pacific"]["coords"][2]["x"], Config.BigBanks["pacific"]["coords"][2]["y"], Config.BigBanks["pacific"]["coords"][2]["z"], 20.0, Config.BigBanks["pacific"]["object"], false, false, false)
        SetEntityHeading(pacificObject, Config.BigBanks["pacific"]["heading"].closed)
    else
        local pacificObject = GetClosestObjectOfType(Config.BigBanks["pacific"]["coords"][2]["x"], Config.BigBanks["pacific"]["coords"][2]["y"], Config.BigBanks["pacific"]["coords"][2]["z"], 20.0, Config.BigBanks["pacific"]["object"], false, false, false)
        SetEntityHeading(pacificObject, Config.BigBanks["pacific"]["heading"].open)
    end
end
function DrawText3Ds(x, y, z, text) -- Globally used
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- Handlers
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        ResetBankDoors()
    end
end)
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = true
end)
RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    QBCore.Functions.TriggerCallback('qb-bankrobbery:server:GetConfig', function(config)
        Config = config
    end)
    onDuty = true
    ResetBankDoors()
end)
RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

-- Functions
local function OpenPaletoDoor()
    local object = GetClosestObjectOfType(Config.BigBanks["paleto"]["coords"]["x"], Config.BigBanks["paleto"]["coords"]["y"], Config.BigBanks["paleto"]["coords"]["z"], 5.0, Config.BigBanks["paleto"]["object"], false, false, false)
    local timeOut = 10
    local entHeading = Config.BigBanks["paleto"]["heading"].closed

    if object ~= 0 then
        SetEntityHeading(object, Config.BigBanks["paleto"]["heading"].open)
    end
end
local function OpenPacificDoor()
    local object = GetClosestObjectOfType(Config.BigBanks["pacific"]["coords"][2]["x"], Config.BigBanks["pacific"]["coords"][2]["y"], Config.BigBanks["pacific"]["coords"][2]["z"], 20.0, Config.BigBanks["pacific"]["object"], false, false, false)
    local timeOut = 10
    local entHeading = Config.BigBanks["pacific"]["heading"].closed

    if object ~= 0 then
        CreateThread(function()
            while true do

                if entHeading > Config.BigBanks["pacific"]["heading"].open then
                    SetEntityHeading(object, entHeading - 10)
                    entHeading = entHeading - 0.5
                else
                    break
                end

                Wait(10)
            end
        end)
    end
end
local function OnHackDone(success)
    if success then
        TriggerEvent('qb-bankrobbery:client:SetUpFleecaTrolleys', closestBank)
        local VaultWait = Config.FleecaVaultWait / 1000
        local VaultWaitMins = tonumber(VaultWait) / 60
        QBCore.Functions.Notify("Door Opening in: "..math.floor(VaultWaitMins).." Minutes", 'success')
        Wait(Config.FleecaVaultWait)
        TriggerServerEvent('qb-bankrobbery:server:setBankState', closestBank, true)
    else
		QBCore.Functions.Notify("You Suck!", 'error')
	end
end 
local function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(5)
    end
end
local function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(0)
    end
end
local function OpenBankDoor(bankId)
    local object = GetClosestObjectOfType(Config.SmallBanks[bankId]["coords"]["x"], Config.SmallBanks[bankId]["coords"]["y"], Config.SmallBanks[bankId]["coords"]["z"], 5.0, Config.SmallBanks[bankId]["object"], false, false, false)
    local timeOut = 10
    local entHeading = Config.SmallBanks[bankId]["heading"].closed
    if object ~= 0 then
        CreateThread(function()
            while true do

                if entHeading ~= Config.SmallBanks[bankId]["heading"].open then
                    SetEntityHeading(object, entHeading - 10)
                    entHeading = entHeading - 0.5
                else
                    break
                end

                Wait(10)
            end
        end)
    end
end
function IsWearingHandshoes() -- Globally Used
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == `mp_m_freemode_01` then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end
function openLocker(bankId, lockerId) -- Globally Used
    local pos = GetEntityCoords(PlayerPedId())
    if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
    end
    TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isBusy', true)
    local DrillObject = CreateObject(`hei_prop_heist_drill`, pos.x, pos.y, pos.z, true, true, true)
    if bankId == "paleto" then
        loadAnimDict("anim@heists@fleeca_bank@drilling")
        TaskPlayAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', 'drill_straight_idle' , 3.0, 3.0, -1, 1, 0, false, false, false)
        local pos = GetEntityCoords(PlayerPedId(), true)
        AttachEntityToEntity(DrillObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0, -0.01, 90.0, -90.0, 180.0, true, true, false, true, 1, true)
        IsDrilling = true
        TriggerEvent('Drilling:Start',function(Success)
            if Success then
                DetachEntity(DrillObject, true, true)
                DeleteEntity(DrillObject)
                StopAnimTask(PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
                TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isOpened', true)
                TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isBusy', false)
                TriggerServerEvent('qb-bankrobbery:server:recieveItem', 'paleto')
                QBCore.Functions.Notify("Successful!", "success")
                DrillObject = nil
                IsDrilling = false
            else
                DetachEntity(DrillObject, true, true)
                DeleteEntity(DrillObject)
                StopAnimTask(PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
                TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isBusy', false)
                QBCore.Functions.Notify("Canceled..", "error")
                DrillObject = nil
                IsDrilling = false
            end
        end)
        CreateThread(function()
            while IsDrilling do
                TriggerServerEvent('hud:server:GainStress', math.random(2, 4))
                Wait(15000)
            end
        end)
    elseif bankId == "pacific" then
        loadAnimDict("anim@heists@fleeca_bank@drilling")
        TaskPlayAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', 'drill_straight_idle' , 3.0, 3.0, -1, 1, 0, false, false, false)
        local pos = GetEntityCoords(PlayerPedId(), true)
        AttachEntityToEntity(DrillObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0, -0.01, 90.0, -90.0, 180.0, true, true, false, true, 1, true)
        TriggerEvent('Drilling:Start',function(Success)
            if Success then
                DetachEntity(DrillObject, true, true)
                DeleteEntity(DrillObject)
                StopAnimTask(PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
                TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isOpened', true)
                TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isBusy', false)
                TriggerServerEvent('qb-bankrobbery:server:recieveItem', 'pacific')
                QBCore.Functions.Notify("Successful!", "success")
                DrillObject = nil
                IsDrilling = false
            else
                DetachEntity(DrillObject, true, true)
                DeleteEntity(DrillObject)
                StopAnimTask(PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
                TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isBusy', false)
                QBCore.Functions.Notify("Canceled..", "error")
                DrillObject = nil
                IsDrilling = false
            end
        end)
        CreateThread(function()
            while IsDrilling do
                TriggerServerEvent('hud:server:GainStress', math.random(2, 4))
                Wait(15000)
            end
        end)
    else
        loadAnimDict("anim@heists@fleeca_bank@drilling")
        TaskPlayAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', 'drill_straight_idle' , 3.0, 3.0, -1, 1, 0, false, false, false)
        local pos = GetEntityCoords(PlayerPedId(), true)
        AttachEntityToEntity(DrillObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0, -0.01, 90.0, -90.0, 180.0, true, true, false, true, 1, true)
        IsDrilling = true
        TriggerEvent('Drilling:Start',function(Success)
            if Success then
                DetachEntity(DrillObject, true, true)
                DeleteEntity(DrillObject)
                StopAnimTask(PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
                TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isOpened', true)
                TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isBusy', false)
                TriggerServerEvent('qb-bankrobbery:server:recieveItem', 'small')
                QBCore.Functions.Notify("Successful!", "success")
                DrillObject = nil
                IsDrilling = false
            else
                DetachEntity(DrillObject, true, true)
                DeleteEntity(DrillObject)
                StopAnimTask(PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
                TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isBusy', false)
                QBCore.Functions.Notify("Canceled..", "error")
                DrillObject = nil
                IsDrilling = false
            end
        end)
        CreateThread(function()
            while IsDrilling do
                TriggerServerEvent('hud:server:GainStress', math.random(2, 4))
                Wait(15000)
            end
        end)
    end
end

-- Events
RegisterNetEvent('qb-bankrobbery:client:setBankState', function(bankId, state)
    if bankId == "paleto" then
        Config.BigBanks["paleto"]["isOpened"] = state
        if state then
            OpenPaletoDoor()
        end
    elseif bankId == "pacific" then
        Config.BigBanks["pacific"]["isOpened"] = state
        if state then
            OpenPacificDoor()
        end
    else
        Config.SmallBanks[bankId]["isOpened"] = state
        if state then
            OpenBankDoor(bankId)
        end
    end
end)
RegisterNetEvent('qb-bankrobbery:client:enableAllBankSecurity', function()
    for k, v in pairs(Config.SmallBanks) do
        Config.SmallBanks[k]["alarm"] = true
    end
end)
RegisterNetEvent('qb-bankrobbery:client:disableAllBankSecurity', function()
    for k, v in pairs(Config.SmallBanks) do
        Config.SmallBanks[k]["alarm"] = false
    end
end)
RegisterNetEvent('qb-bankrobbery:client:BankSecurity', function(key, status)
    Config.SmallBanks[key]["alarm"] = status
end)
RegisterNetEvent('qb-bankrobbery:client:setLockerState', function(bankId, lockerId, state, bool)
    if bankId == "paleto" then
        Config.BigBanks["paleto"]["lockers"][lockerId][state] = bool
    elseif bankId == "pacific" then
        Config.BigBanks["pacific"]["lockers"][lockerId][state] = bool
    else
        Config.SmallBanks[bankId]["lockers"][lockerId][state] = bool
    end
end)
RegisterNetEvent('qb-bankrobbery:client:ResetFleecaLockers', function(BankId)
    Config.SmallBanks[BankId]["isOpened"] = false
    for k,_ in pairs(Config.SmallBanks[BankId]["lockers"]) do
        Config.SmallBanks[BankId]["lockers"][k]["isOpened"] = false
        Config.SmallBanks[BankId]["lockers"][k]["isBusy"] = false
    end
end)
RegisterNetEvent('qb-bankrobbery:client:DrillSmallLocker', function()
    if closestBank ~= nil then
        if Config.SmallBanks[closestBank]["isOpened"] then
            for k, v in pairs(Config.SmallBanks[closestBank]["lockers"]) do
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local lockerDist = #(pos - Config.SmallBanks[closestBank]["lockers"][k]["coords"])
                if not Config.SmallBanks[closestBank]["lockers"][k]["isBusy"] then
                    if not Config.SmallBanks[closestBank]["lockers"][k]["isOpened"] then
                        if lockerDist < 5 then
                            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                if result then
                                    if CurrentCops >= Config.MinimumFleecaPolice then
                                        -- EW CRUDE Need to figure out how to correct player positioning for the drilling animations
                                        --[[
                                            SetEntityCoords(PlayerPedId(), Config.SmallBanks[closestBank]["lockers"][closestLocker]["coords"], 0, 0, 0, 0, false)
                                            SetEntityHeading(PlayerPedId(), Config.SmallBanks[closestBank]["lockers"][closestLocker]["heading"])
                                        ]]
                                        openLocker(closestBank, k)
                                    else
                                        QBCore.Functions.Notify('Minimum Of '..Config.MinimumFleecaPolice..' Police Needed', "error")
                                    end
                                else
                                    QBCore.Functions.Notify('You need a drill bro!', "error")
                                end
                            end, 'drill')
                        end
                    end
                end
            end
        else
            QBCore.Functions.Notify('How the hell are you here?!', "error")
        end
    end
end)
RegisterNetEvent('qb-bankrobbery:client:UseGreenLaptop', function(laptopData)-- Fleeca Laptop
    local ped = PlayerPedId() 
    local pos = GetEntityCoords(ped)
    if closestBank ~= nil then
        QBCore.Functions.TriggerCallback('qb-bankrobbery:server:isRobberyActive', function(isBusy)
            if not isBusy then
                local dist = #(pos - vector3(Config.SmallBanks[closestBank]['coords'].x, Config.SmallBanks[closestBank]['coords'].y, Config.SmallBanks[closestBank]['coords'].z))
                if dist < 2.5 then
                    if CurrentCops >= Config.MinimumFleecaPolice then
                        if not Config.SmallBanks[closestBank]['isOpened'] then
                            TriggerServerEvent('qb-bankrobbery:server:RemoveLaptopUse', laptopData) -- Removes a use from the laptop
                            SetEntityHeading(ped, Config.SmallBanks[closestBank]['coords'].w)
                            if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
                                TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                            end
                            QBCore.Functions.Progressbar('hack_gate', 'Connecting the laptop..', math.random(5000, 10000), false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                                animDict = 'anim@gangops@facility@servers@',
                                anim = 'hotwire',
                                flags = 16,
                            }, {}, {}, function() -- Done
                                StopAnimTask(PlayerPedId(), 'anim@gangops@facility@servers@', 'hotwire', 1.0)
                                TriggerEvent('qb-bankrobbery:client:LaptopFleeca', closestBank)
                                -- Police Alert
                                if not copsCalled then
                                    if Config.SmallBanks[closestBank]["alarm"] then
                                        cameraId = Config.SmallBanks[closestBank]['camId']
                                        bank = 'Fleeca'
                                        TriggerEvent('dispatch:fleeca:bankrobbery')
                                        copsCalled = true
                                    end
                                end
                            end, function() -- Cancel
                                StopAnimTask(PlayerPedId(), 'anim@gangops@facility@servers@', 'hotwire', 1.0)
                                QBCore.Functions.Notify("Cancelled", 'error')
                            end)
                        else
                            QBCore.Functions.Notify("Door Already Open", 'error', 5000)
                        end
                    else
                        QBCore.Functions.Notify("Not Enough LEO", 'error', 5000)
                    end
                end
            else
                QBCore.Functions.Notify("Security Lockdown", 'error', 5000)
            end
        end)
    end
end)
RegisterNetEvent('qb-bankrobbery:client:LaptopFleeca', function()-- Fleeca Laptop Animation
    local loc = {x,y,z,h}
    loc.x = Config.SmallBanks[closestBank]['coords'].x
    loc.y = Config.SmallBanks[closestBank]['coords'].y
    loc.z = Config.SmallBanks[closestBank]['coords'].z
    loc.h = Config.SmallBanks[closestBank]['coords'].w

    local animDict = 'anim@heists@ornate_bank@hack'
    RequestAnimDict(animDict)
    RequestModel('hei_prop_hst_laptop')
    RequestModel('hei_p_m_bag_var22_arm_s')

    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded('hei_prop_hst_laptop')
        or not HasModelLoaded('hei_p_m_bag_var22_arm_s') do
        Wait(100)
    end

    local ped = PlayerPedId()
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))

    SetEntityHeading(ped, loc.h)
    local animPos = GetAnimInitialOffsetPosition(animDict, 'hack_enter', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, 'hack_loop', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, 'hack_exit', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)

    FreezeEntityPosition(ped, true)
    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), targetPosition, 1, 1, 0)
    local laptop = CreateObject(GetHashKey('hei_prop_hst_laptop'), targetPosition, 1, 1, 0)

    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, 'hack_enter', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, 'hack_enter_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, 'hack_enter_laptop', 4.0, -8.0, 1)

    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, 'hack_loop', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, 'hack_loop_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, 'hack_loop_laptop', 4.0, -8.0, 1)

    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, 'hack_exit', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, 'hack_exit_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, 'hack_exit_laptop', 4.0, -8.0, 1)

    Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Wait(6300)
    NetworkStartSynchronisedScene(netScene2)
    Wait(2000)

    exports['hacking']:OpenHackingGame(Config.FleecaTime, Config.FleecaBlocks, Config.FleecaRepeat, function(bool)
        NetworkStartSynchronisedScene(netScene3)
        NetworkStopSynchronisedScene(netScene3)
        DeleteObject(bag)
        DeleteObject(laptop)
        FreezeEntityPosition(ped, false)
        OnHackDone(bool)
    end)
end)
RegisterNetEvent('qb-bankrobbery:client:UsePinkLaptop', function(laptopData) -- Practice Laptop
    TriggerServerEvent('qb-bankrobbery:server:RemoveLaptopUse', laptopData) -- Removes a use from the laptop
    QBCore.Functions.Progressbar('hack_gate', 'Connecting the laptop..', math.random(15000, 30000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        -- Trigger Mini Game
        exports['hacking']:OpenHackingGame(Config.FleecaTime, Config.FleecaBlocks, Config.FleecaRepeat, function(bool)
            if bool then
                -- Reward Heist Points on Success [To be used with the heist rep system - Progression making people practice hacking in city to progress to better banks/heists]
                QBCore.Functions.Notify("WooHoo!", "success")
                TriggerServerEvent('qb-bankrobbery:server:succesHeist', 5) -- This adds 5 Heist Rep [For future use with buying laptops based on rep!]
            else
                QBCore.Functions.Notify("You Suck!", "error")
            end
        end)
        
    end, function() -- Cancel
        QBCore.Functions.Notify("Cancelled", 'error')
    end)
end)

-- Threads
CreateThread(function()
    while true do
        Wait(1000 * 60 * 5)
        if copsCalled then
            copsCalled = false
        end
    end
end)
CreateThread(function()
    Wait(500)
    if QBCore.Functions.GetPlayerData() ~= nil then
        PlayerJob = QBCore.Functions.GetPlayerData().job
        onDuty = true
    end
end)
CreateThread(function()
    while true do
        Wait(1000)
        if inRange then
            if not refreshed then
                ResetBankDoors()
                refreshed = true
            end
        else
            refreshed = false
        end
    end
end)
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dist

        if QBCore ~= nil then
            inRange = false
            inLockerRange = false
            for k, v in pairs(Config.SmallBanks) do
                dist = #(pos - vector3(Config.SmallBanks[k]['coords'].x, Config.SmallBanks[k]['coords'].y, Config.SmallBanks[k]['coords'].z))
                if dist < 15 then
                    closestBank = k
                    for locker, _ in pairs(Config.SmallBanks) do
                        lockerDist = #(pos - vector3(Config.SmallBanks[closestBank]["lockers"][locker]["coords"].x, Config.SmallBanks[closestBank]["lockers"][locker]["coords"].y, Config.SmallBanks[closestBank]["lockers"][locker]["coords"].z))
                        if lockerDist < 1 then
                            closestLocker = locker
                        end
                    end
                    inRange = true
                end
            end

            if not inRange then
                Wait(2000)
                closestBank = nil
                closestLocker = nil 
            end
        end

        Wait(3)
    end
end)

-- Threads
if Config.Target then
        CreateThread(function() -- Fleeca Drill Spots
            for fweecybwo, _ in pairs(Config.SmallBanks) do
                for k,v in pairs(Config.SmallBanks[fweecybwo]['lockers']) do
                    exports['qb-target']:AddBoxZone('FleecaLockers'..math.random(1,200), vector3(Config.SmallBanks[fweecybwo]['lockers'][k]['coords'].x, Config.SmallBanks[fweecybwo]['lockers'][k]['coords'].y, Config.SmallBanks[fweecybwo]['lockers'][k]['coords'].z), 1.00, 0.80, {
                        name = 'FleecaLockers'..math.random(1,200), 
                        heading = Config.SmallBanks[fweecybwo]['lockers'][k]['heading'],
                        debugPoly = Config.DebugPoly,
                        minZ = Config.SmallBanks[fweecybwo]['lockers'][k]['coords'].z-1,
                        maxZ = Config.SmallBanks[fweecybwo]['lockers'][k]['coords'].z+2,
                        }, {
                        options = {
                            { 
                                type = 'client',
                                event = 'qb-bankrobbery:client:DrillSmallLocker',
                                icon = 'fas fa-bomb',
                                label = 'Drill Locker',
                            }
                        },
                        distance = 1.5,
                    })
                end
            end
        end)
else
    CreateThread(function()
        Wait(2000)
        while true do
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            if QBCore ~= nil then
                if closestBank ~= nil then
                    if Config.SmallBanks[closestBank]["isOpened"] then
                        for k, v in pairs(Config.SmallBanks[closestBank]["lockers"]) do
                            local lockerDist = #(pos - Config.SmallBanks[closestBank]["lockers"][k]["coords"])
                            if not Config.SmallBanks[closestBank]["lockers"][k]["isBusy"] then
                                if not Config.SmallBanks[closestBank]["lockers"][k]["isOpened"] then
                                    if lockerDist < 5 then
                                        DrawMarker(2, Config.SmallBanks[closestBank]["lockers"][k]["coords"].x, Config.SmallBanks[closestBank]["lockers"][k]["coords"].y, Config.SmallBanks[closestBank]["lockers"][k]["coords"].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                                        if lockerDist < 0.5 then
                                            DrawText3Ds(Config.SmallBanks[closestBank]["lockers"][k]["coords"].x, Config.SmallBanks[closestBank]["lockers"][k]["coords"].y, Config.SmallBanks[closestBank]["lockers"][k]["coords"].z + 0.3, '[E] Break open the safe')
                                            if IsControlJustPressed(0, 38) then
                                                if CurrentCops >= Config.MinimumFleecaPolice then
                                                    openLocker(closestBank, k)
                                                else
                                                    QBCore.Functions.Notify('Minimum Of '..Config.MinimumFleecaPolice..' Police Needed', "error")
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    Wait(2500)
                end
            end
    
            Wait(1)
        end
    end)
end
-- Trolleys
if Config.Target then
    CreateThread(function() -- Trolleys
        for fweecybwo, _ in pairs(Config.SmallBanks) do
            for k,v in pairs(Config.SmallBanks[fweecybwo]['trolleys']) do
                exports['qb-target']:AddBoxZone('Trolley'..math.random(1,100), vector3(Config.SmallBanks[fweecybwo]['trolleys'][k]['coords'].x, Config.SmallBanks[fweecybwo]['trolleys'][k]['coords'].y, Config.SmallBanks[fweecybwo]['trolleys'][k]['coords'].z), 0.9, 1.1, {  
                    name = 'Trolley'..math.random(1,100), 
                    heading = Config.SmallBanks[fweecybwo]['trolleys'][k]['heading'],
                    debugPoly = Config.DebugPoly,
                    minZ = Config.SmallBanks[fweecybwo]['trolleys'][k]['coords'].z-1,
                    maxZ = Config.SmallBanks[fweecybwo]['trolleys'][k]['coords'].z+1.5,
                    }, {
                    options = { 
                    { 
                        type = 'client',
                        event = 'qb-bankrobbery:client:lootfleecatrolley',
                        icon = 'fas fa-hand-paper',
                        label = 'Grab',
                    }
                    },
                    distance = 2.0,
                })
            end
        end
    end)
    CreateThread(function() -- Trolleys Paleto
        for k,v in pairs(Config.BigBanks["paleto"]['trolleys']) do
            exports['qb-target']:AddBoxZone('Trolley'..math.random(1,100), vector3(Config.BigBanks["paleto"]['trolleys'][k]['coords'].x, Config.BigBanks["paleto"]['trolleys'][k]['coords'].y, Config.BigBanks["paleto"]['trolleys'][k]['coords'].z), 0.9, 1.1, {  
                name = 'Trolley'..math.random(1,100), 
                heading = Config.BigBanks["paleto"]['trolleys'][k]['heading'],
                debugPoly = Config.DebugPoly,
                minZ = Config.BigBanks["paleto"]['trolleys'][k]['coords'].z-1,
                maxZ = Config.BigBanks["paleto"]['trolleys'][k]['coords'].z+1.5,
                }, {
                options = { 
                { 
                    type = 'client',
                    event = 'qb-bankrobbery:client:lootpaletotrolley',
                    icon = 'fas fa-hand-paper',
                    label = 'Grab',
                }
                },
                distance = 2.0,
            })
        end
    end)
    CreateThread(function() -- Trolleys Pacific
        for k,v in pairs(Config.BigBanks["pacific"]['trolleys']) do
            exports['qb-target']:AddBoxZone('Trolley'..math.random(1,100), vector3(Config.BigBanks["pacific"]['trolleys'][k]['coords'].x, Config.BigBanks["pacific"]['trolleys'][k]['coords'].y, Config.BigBanks["pacific"]['trolleys'][k]['coords'].z), 0.9, 1.1, {  
                name = 'Trolley'..math.random(1,100), 
                heading = Config.BigBanks["pacific"]['trolleys'][k]['heading'],
                debugPoly = Config.DebugPoly,
                minZ = Config.BigBanks["pacific"]['trolleys'][k]['coords'].z-1,
                maxZ = Config.BigBanks["pacific"]['trolleys'][k]['coords'].z+1.5,
                }, {
                options = { 
                { 
                    type = 'client',
                    event = 'qb-bankrobbery:client:lootpacifictrolley',
                    icon = 'fas fa-hand-paper',
                    label = 'Grab',
                }
                },
                distance = 2.0,
            })
        end
    end)
else
    CreateThread(function() -- Trolleys Fleeca
        Wait(2000)
        while true do
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local inRange = false
            if QBCore ~= nil then
                if closestBank ~= nil then
                    if Config.SmallBanks[closestBank]["isOpened"] then
                        for k, v in pairs(Config.SmallBanks[closestBank]["trolleys"]) do
                            local trolleyDist = #(pos - Config.SmallBanks[closestBank]["trolleys"][k]["coords"])
                            if not Config.SmallBanks[closestBank]["trolleys"][k]["grabbed"] then
                                if trolleyDist < 5 then
                                    inRange = true
                                    if trolleyDist < 1.5 then
                                        DrawText3Ds(Config.SmallBanks[closestBank]["trolleys"][k]["coords"].x, Config.SmallBanks[closestBank]["trolleys"][k]["coords"].y, Config.SmallBanks[closestBank]["trolleys"][k]["coords"].z + 1.1, '[E] Loot')
                                        if IsControlJustPressed(0, 38) then
                                            if CurrentCops >= Config.MinimumFleecaPolice then
                                                TriggerEvent("qb-bankrobbery:client:lootfleecatrolley")
                                            else
                                                QBCore.Functions.Notify('Minimum Of '..Config.MinimumFleecaPolice..' Police Needed', "error")
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    Wait(2500)
                end
                if not inRange then
                    Wait(2500)
                end
            end
            Wait(1)
        end
    end)
    CreateThread(function() -- Trolleys Paleto
        Wait(2000)
        while true do
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local inRange = false
            if QBCore ~= nil then
                if Config.BigBanks["paleto"]["isOpened"] then
                    for k, v in pairs(Config.BigBanks["paleto"]["trolleys"]) do
                        local trolleyDist = #(pos - Config.BigBanks["paleto"]["trolleys"][k]["coords"])
                        if not Config.BigBanks["paleto"]["trolleys"][k]["grabbed"] then
                            if trolleyDist < 5 then
                                inRange = true
                                if trolleyDist < 1.5 then
                                    DrawText3Ds(Config.BigBanks["paleto"]["trolleys"][k]["coords"].x, Config.BigBanks["paleto"]["trolleys"][k]["coords"].y, Config.BigBanks["paleto"]["trolleys"][k]["coords"].z + 1.1, '[E] Loot')
                                    if IsControlJustPressed(0, 38) then
                                        if CurrentCops >= Config.MinimumPaletoPolice then
                                            TriggerEvent("qb-bankrobbery:client:lootpaletotrolley")
                                        else
                                            QBCore.Functions.Notify('Minimum Of '..Config.MinimumPaletoPolice..' Police Needed', "error")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if not inRange then
                    Wait(2500)
                end
            end
            Wait(1)
        end
    end)
    CreateThread(function() -- Trolleys Pacific
        Wait(2000)
        while true do
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local inRange = false
            if QBCore ~= nil then
                if Config.BigBanks["pacific"]["isOpened"] then
                    for k, v in pairs(Config.BigBanks["pacific"]["trolleys"]) do
                        local trolleyDist = #(pos - Config.BigBanks["pacific"]["trolleys"][k]["coords"])
                        if not Config.BigBanks["pacific"]["trolleys"][k]["grabbed"] then
                            if trolleyDist < 5 then
                                inRange = true
                                if trolleyDist < 1.5 then
                                    DrawText3Ds(Config.BigBanks["pacific"]["trolleys"][k]["coords"].x, Config.BigBanks["pacific"]["trolleys"][k]["coords"].y, Config.BigBanks["pacific"]["trolleys"][k]["coords"].z + 1.1, '[E] Loot')
                                    if IsControlJustPressed(0, 38) then
                                        if CurrentCops >= Config.MinimumPacificPolice then
                                            TriggerEvent("qb-bankrobbery:client:lootpacifictrolley")
                                        else
                                            QBCore.Functions.Notify('Minimum Of '..Config.MinimumPacificPolice..' Police Needed', "error")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if not inRange then
                    Wait(2500)
                end
            end
            Wait(1)
        end
    end)
end

-- // Trolley Events \\ --
-- Fleeca
RegisterNetEvent('qb-bankrobbery:client:SetUpFleecaTrolleys', function(closestBank)
    for k,v in pairs(Config.SmallBanks[closestBank]['trolleys']) do
        local TrolleyChance = math.random(1,100)
        local loc = Config.SmallBanks[closestBank]['trolleys'][k]['coords']
        if TrolleyChance <= Config.FleecaTrolleyChance then
            local TrolleyLoot = math.random(1,100)
            if TrolleyLoot <= Config.FleecaGoldbarChance then 
                Trolley = CreateObject(2007413986, loc.x, loc.y, loc.z, 1, 0, 0)
                TriggerServerEvent('qb-bankrobbery:server:modelSync', closestBank, k, 2007413986)  -- Sends the loot model to the server to be stored
            else 
                Trolley = CreateObject(269934519, loc.x, loc.y, loc.z, 1, 0, 0)
                TriggerServerEvent('qb-bankrobbery:server:modelSync', closestBank, k, 269934519)  -- Sends the loot model to the server to be stored
            end
            SetEntityHeading(Trolley, v['heading'])
        end
    end
end)
RegisterNetEvent('qb-bankrobbery:client:lootfleecatrolley', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    for k,v in pairs(Config.SmallBanks[closestBank]['trolleys']) do
        if not v['grabbed'] then
            if Config.SmallBanks[closestBank]['isOpened'] then
                local TrolleyDist = #(pos - v['coords'])
                if TrolleyDist <= 1.5 then
                    LocalPlayer.state:set('inv_busy', true, true) -- Busy
                    TriggerServerEvent('qb-bankrobbery:server:lootSync', closestBank, 'trolleys', k)  -- Syncs the loot to the server so clients cannot take from something that has already been grabbed
                    local ped = PlayerPedId()
                    local pos, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
                    local trollyModel = Config.SmallBanks[closestBank]['trolleys'][k]['model']
                    local animDict = 'anim@heists@ornate_bank@grab_cash'

                    if trollyModel == 881130828 then
                        grabModel = 'ch_prop_vault_dimaondbox_01a'
                    elseif trollyModel == 2007413986 then
                        grabModel = 'ch_prop_gold_bar_01a'
                    else
                        grabModel = 'hei_prop_heist_cash_pile'
                    end

                    loadAnimDict(animDict)
                    loadModel('hei_p_m_bag_var22_arm_s')

                    sceneObject = GetClosestObjectOfType(Config.SmallBanks[closestBank]['trolleys'][k]['coords'], 2.0, trollyModel, 0, 0, 0)

                    if IsEntityPlayingAnim(sceneObject, animDict, "cart_cash_dissapear", 3) then
                        return
                    end
                    SetEntityCollision(sceneObject, true, true) -- Always set collision as anims sometimes mess it up

                    bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), pos, true, false, false)

                    while not NetworkHasControlOfEntity(sceneObject) do
                        Wait(1)
                        NetworkRequestControlOfEntity(sceneObject)
                    end

                    scene1 = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(ped, scene1, animDict, 'intro', 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(bag, scene1, animDict, 'bag_intro', 4.0, -8.0, 1)

                    scene2 = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, true, 1065353216, 0, 1.3) -- loops trolly anim so we dont need to spawn a new prop
                    NetworkAddPedToSynchronisedScene(ped, scene2, animDict, 'grab', 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(bag, scene2, animDict, 'bag_grab', 4.0, -8.0, 1)
                    NetworkAddEntityToSynchronisedScene(sceneObject, scene2, animDict, 'cart_cash_dissapear', 4.0, -8.0, 1)

                    scene3 =  NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(ped, scene3, animDict, 'exit', 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(bag, scene3, animDict, 'bag_exit', 4.0, -8.0, 1)

                    NetworkStartSynchronisedScene(scene1)
                    Wait(1750)
                    TriggerEvent('qb-bankrobbery:client:GrabFleecaTrolley', grabModel)
                    NetworkStartSynchronisedScene(scene2)
                    Wait(37000)
                    NetworkStartSynchronisedScene(scene3)
                    Wait(2000)

                    local emptyobj = 769923921
                    newTrolly = CreateObject(emptyobj, Config.SmallBanks[closestBank]['trolleys'][k]['coords'], true, false, false)
                    SetEntityRotation(newTrolly, 0, 0, GetEntityHeading(sceneObject), 1, 0)
                    DeleteObject(sceneObject)
                    DeleteObject(bag)
                    TriggerServerEvent('qb-bankrobbery:server:FleecaTrolleyReward', grabModel, pos, closestBank)
                    LocalPlayer.state:set('inv_busy', false, true) -- Not Busy
                end
            else 
                QBCore.Functions.Notify('How did you get in here?', 'error', 4500) 
            end
        end
    end
end)
RegisterNetEvent('qb-bankrobbery:client:GrabFleecaTrolley', function(grabModel)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local grabModel = GetHashKey(grabModel)

    loadModel(grabModel)
    local grabObject = CreateObject(grabModel, pos, true)

    FreezeEntityPosition(grabObject, true)
    SetEntityInvincible(grabObject, true)
    SetEntityNoCollisionEntity(grabObject, ped)
    SetEntityVisible(grabObject, false, false)
    AttachEntityToEntity(grabObject, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
    local Looting = GetGameTimer()

    CreateThread(function()
        while GetGameTimer() - Looting < 37000 do
            Wait(1)
            DisableControlAction(0, 73, true)
            if HasAnimEventFired(ped, GetHashKey('CASH_APPEAR')) then
                if not IsEntityVisible(grabObject) then
                    SetEntityVisible(grabObject, true, false)
                end
            end
            if HasAnimEventFired(ped, GetHashKey('RELEASE_CASH_DESTROY')) then
                if IsEntityVisible(grabObject) then
                    SetEntityVisible(grabObject, false, false)
                end
            end
        end
        DeleteObject(grabObject)
    end)
end)
RegisterNetEvent('qb-bankrobbery:client:modelSync', function(closestBank, k, model) -- Grabs the model from the server
    Config.SmallBanks[closestBank]['trolleys'][k]['model'] = model
end)
RegisterNetEvent('qb-bankrobbery:client:lootSync', function(closestBank, type, k) -- Pushes the stored model to the type to state 'grabbed' in the config
    if k then 
        Config.SmallBanks[closestBank][type][k]['grabbed'] = not Config.SmallBanks[closestBank][type][k]['grabbed']
    else
        Config.SmallBanks[closestBank][type]['grabbed'] = not Config.SmallBanks[closestBank][type]['grabbed']
    end
end)

-- Paleto
RegisterNetEvent('qb-bankrobbery:client:SetUpPaletoTrolleys', function()
    for k,v in pairs(Config.BigBanks["paleto"]['trolleys']) do
        local TrolleyChance = math.random(1,100)
        local loc = Config.BigBanks["paleto"]['trolleys'][k]['coords']
        if TrolleyChance <= Config.PaletoTrolleyChance then
            local TrolleyLoot = math.random(1,100)
            if TrolleyLoot <= Config.PaletoGoldbarChance then 
                Trolley = CreateObject(2007413986, loc.x, loc.y, loc.z, 1, 0, 0)
                TriggerServerEvent('qb-bankrobbery:server:modelSyncPaleto', k, 2007413986)  -- Sends the loot model to the server to be stored
            else 
                Trolley = CreateObject(269934519, loc.x, loc.y, loc.z, 1, 0, 0)
                TriggerServerEvent('qb-bankrobbery:server:modelSyncPaleto', k, 269934519)  -- Sends the loot model to the server to be stored
            end
            SetEntityHeading(Trolley, v['heading'])
        end
    end
end)
RegisterNetEvent('qb-bankrobbery:client:lootpaletotrolley', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    for k,v in pairs(Config.BigBanks["paleto"]['trolleys']) do
        if not v['grabbed'] then
            if Config.BigBanks["paleto"]['isOpened'] then
                local TrolleyDist = #(pos - v['coords'])
                if TrolleyDist <= 1.5 then
                    LocalPlayer.state:set('inv_busy', true, true) -- Busy
                    TriggerServerEvent('qb-bankrobbery:server:lootSyncPaleto', 'trolleys', k)  -- Syncs the loot to the server so clients cannot take from something that has already been grabbed
                    local ped = PlayerPedId()
                    local pos, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
                    local trollyModel = Config.BigBanks["paleto"]['trolleys'][k]['model']
                    local animDict = 'anim@heists@ornate_bank@grab_cash'

                    if trollyModel == 881130828 then
                        grabModel = 'ch_prop_vault_dimaondbox_01a'
                    elseif trollyModel == 2007413986 then
                        grabModel = 'ch_prop_gold_bar_01a'
                    else
                        grabModel = 'hei_prop_heist_cash_pile'
                    end

                    loadAnimDict(animDict)
                    loadModel('hei_p_m_bag_var22_arm_s')

                    sceneObject = GetClosestObjectOfType(Config.BigBanks["paleto"]['trolleys'][k]['coords'], 2.0, trollyModel, 0, 0, 0)

                    if IsEntityPlayingAnim(sceneObject, animDict, "cart_cash_dissapear", 3) then
                        return
                    end
                    SetEntityCollision(sceneObject, true, true) -- Always set collision as anims sometimes mess it up

                    bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), pos, true, false, false)

                    while not NetworkHasControlOfEntity(sceneObject) do
                        Wait(1)
                        NetworkRequestControlOfEntity(sceneObject)
                    end

                    scene1 = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(ped, scene1, animDict, 'intro', 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(bag, scene1, animDict, 'bag_intro', 4.0, -8.0, 1)

                    scene2 = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, true, 1065353216, 0, 1.3) -- loops trolly anim so we dont need to spawn a new prop
                    NetworkAddPedToSynchronisedScene(ped, scene2, animDict, 'grab', 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(bag, scene2, animDict, 'bag_grab', 4.0, -8.0, 1)
                    NetworkAddEntityToSynchronisedScene(sceneObject, scene2, animDict, 'cart_cash_dissapear', 4.0, -8.0, 1)

                    scene3 =  NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(ped, scene3, animDict, 'exit', 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(bag, scene3, animDict, 'bag_exit', 4.0, -8.0, 1)

                    NetworkStartSynchronisedScene(scene1)
                    Wait(1750)
                    TriggerEvent('qb-bankrobbery:client:GrabPaletoTrolley', grabModel)
                    NetworkStartSynchronisedScene(scene2)
                    Wait(37000)
                    NetworkStartSynchronisedScene(scene3)
                    Wait(2000)

                    local emptyobj = 769923921
                    newTrolly = CreateObject(emptyobj, Config.BigBanks["paleto"]['trolleys'][k]['coords'], true, false, false)
                    SetEntityRotation(newTrolly, 0, 0, GetEntityHeading(sceneObject), 1, 0)
                    DeleteObject(sceneObject)
                    DeleteObject(bag)
                    TriggerServerEvent('qb-bankrobbery:server:PaletoTrolleyReward', grabModel, pos)
                    LocalPlayer.state:set('inv_busy', false, true) -- Not Busy
                end
            else 
                QBCore.Functions.Notify('How did you get in here?', 'error', 4500) 
            end
        end
    end
end)
RegisterNetEvent('qb-bankrobbery:client:GrabPaletoTrolley', function(grabModel)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local grabModel = GetHashKey(grabModel)

    loadModel(grabModel)
    local grabObject = CreateObject(grabModel, pos, true)

    FreezeEntityPosition(grabObject, true)
    SetEntityInvincible(grabObject, true)
    SetEntityNoCollisionEntity(grabObject, ped)
    SetEntityVisible(grabObject, false, false)
    AttachEntityToEntity(grabObject, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
    local Looting = GetGameTimer()

    CreateThread(function()
        while GetGameTimer() - Looting < 37000 do
            Wait(1)
            DisableControlAction(0, 73, true)
            if HasAnimEventFired(ped, GetHashKey('CASH_APPEAR')) then
                if not IsEntityVisible(grabObject) then
                    SetEntityVisible(grabObject, true, false)
                end
            end
            if HasAnimEventFired(ped, GetHashKey('RELEASE_CASH_DESTROY')) then
                if IsEntityVisible(grabObject) then
                    SetEntityVisible(grabObject, false, false)
                end
            end
        end
        DeleteObject(grabObject)
    end)
end)
RegisterNetEvent('qb-bankrobbery:client:modelSyncPaleto', function(k, model) -- Grabs the model from the server
    Config.BigBanks["paleto"]['trolleys'][k]['model'] = model
end)
RegisterNetEvent('qb-bankrobbery:client:lootSyncPaleto', function(type, k) -- Pushes the stored model to the type to state 'grabbed' in the config
    if k then 
        Config.BigBanks["paleto"][type][k]['grabbed'] = not Config.BigBanks["paleto"][type][k]['grabbed']
    else
        Config.BigBanks["paleto"][type]['grabbed'] = not Config.BigBanks["paleto"][type]['grabbed']
    end
end)

-- Pacific
RegisterNetEvent('qb-bankrobbery:client:SetUpPacificTrolleys', function()
    for k,v in pairs(Config.BigBanks["pacific"]['trolleys']) do
        local TrolleyChance = math.random(1,100)
        local loc = Config.BigBanks["pacific"]['trolleys'][k]['coords']
        if TrolleyChance <= Config.PacificTrolleyChance then
            local TrolleyLoot = math.random(1,100)
            if TrolleyLoot <= Config.PacificGoldbarChance then 
                Trolley = CreateObject(2007413986, loc.x, loc.y, loc.z, 1, 0, 0)
                TriggerServerEvent('qb-bankrobbery:server:modelSyncPacific', k, 2007413986)  -- Sends the loot model to the server to be stored
            else 
                Trolley = CreateObject(269934519, loc.x, loc.y, loc.z, 1, 0, 0)
                TriggerServerEvent('qb-bankrobbery:server:modelSyncPacific', k, 269934519)  -- Sends the loot model to the server to be stored
            end
            SetEntityHeading(Trolley, v['heading'])
        end
    end
end)
RegisterNetEvent('qb-bankrobbery:client:lootpacifictrolley', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    for k,v in pairs(Config.BigBanks["pacific"]['trolleys']) do
        if not v['grabbed'] then
            if Config.BigBanks["pacific"]['isOpened'] then
                local TrolleyDist = #(pos - v['coords'])
                if TrolleyDist <= 1.5 then
                    LocalPlayer.state:set('inv_busy', true, true) -- Busy
                    TriggerServerEvent('qb-bankrobbery:server:lootSyncPacific', 'trolleys', k)  -- Syncs the loot to the server so clients cannot take from something that has already been grabbed
                    local ped = PlayerPedId()
                    local pos, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
                    local trollyModel = Config.BigBanks["pacific"]['trolleys'][k]['model']
                    local animDict = 'anim@heists@ornate_bank@grab_cash'

                    if trollyModel == 881130828 then
                        grabModel = 'ch_prop_vault_dimaondbox_01a'
                    elseif trollyModel == 2007413986 then
                        grabModel = 'ch_prop_gold_bar_01a'
                    else
                        grabModel = 'hei_prop_heist_cash_pile'
                    end

                    loadAnimDict(animDict)
                    loadModel('hei_p_m_bag_var22_arm_s')

                    sceneObject = GetClosestObjectOfType(Config.BigBanks["pacific"]['trolleys'][k]['coords'], 2.0, trollyModel, 0, 0, 0)

                    if IsEntityPlayingAnim(sceneObject, animDict, "cart_cash_dissapear", 3) then
                        return
                    end
                    SetEntityCollision(sceneObject, true, true) -- Always set collision as anims sometimes mess it up

                    bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), pos, true, false, false)

                    while not NetworkHasControlOfEntity(sceneObject) do
                        Wait(1)
                        NetworkRequestControlOfEntity(sceneObject)
                    end

                    scene1 = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(ped, scene1, animDict, 'intro', 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(bag, scene1, animDict, 'bag_intro', 4.0, -8.0, 1)

                    scene2 = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, true, 1065353216, 0, 1.3) -- loops trolly anim so we dont need to spawn a new prop
                    NetworkAddPedToSynchronisedScene(ped, scene2, animDict, 'grab', 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(bag, scene2, animDict, 'bag_grab', 4.0, -8.0, 1)
                    NetworkAddEntityToSynchronisedScene(sceneObject, scene2, animDict, 'cart_cash_dissapear', 4.0, -8.0, 1)

                    scene3 =  NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(ped, scene3, animDict, 'exit', 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(bag, scene3, animDict, 'bag_exit', 4.0, -8.0, 1)

                    NetworkStartSynchronisedScene(scene1)
                    Wait(1750)
                    TriggerEvent('qb-bankrobbery:client:GrabPacificTrolley', grabModel)
                    NetworkStartSynchronisedScene(scene2)
                    Wait(37000)
                    NetworkStartSynchronisedScene(scene3)
                    Wait(2000)

                    local emptyobj = 769923921
                    newTrolly = CreateObject(emptyobj, Config.BigBanks["pacific"]['trolleys'][k]['coords'], true, false, false)
                    SetEntityRotation(newTrolly, 0, 0, GetEntityHeading(sceneObject), 1, 0)
                    DeleteObject(sceneObject)
                    DeleteObject(bag)
                    TriggerServerEvent('qb-bankrobbery:server:PacificTrolleyReward', grabModel, pos)
                    LocalPlayer.state:set('inv_busy', false, true) -- Not Busy
                end
            else 
                QBCore.Functions.Notify('How did you get in here?', 'error', 4500) 
            end
        end
    end
end)
RegisterNetEvent('qb-bankrobbery:client:GrabPacificTrolley', function(grabModel)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local grabModel = GetHashKey(grabModel)

    loadModel(grabModel)
    local grabObject = CreateObject(grabModel, pos, true)

    FreezeEntityPosition(grabObject, true)
    SetEntityInvincible(grabObject, true)
    SetEntityNoCollisionEntity(grabObject, ped)
    SetEntityVisible(grabObject, false, false)
    AttachEntityToEntity(grabObject, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
    local Looting = GetGameTimer()

    CreateThread(function()
        while GetGameTimer() - Looting < 37000 do
            Wait(1)
            DisableControlAction(0, 73, true)
            if HasAnimEventFired(ped, GetHashKey('CASH_APPEAR')) then
                if not IsEntityVisible(grabObject) then
                    SetEntityVisible(grabObject, true, false)
                end
            end
            if HasAnimEventFired(ped, GetHashKey('RELEASE_CASH_DESTROY')) then
                if IsEntityVisible(grabObject) then
                    SetEntityVisible(grabObject, false, false)
                end
            end
        end
        DeleteObject(grabObject)
    end)
end)
RegisterNetEvent('qb-bankrobbery:client:modelSyncPacific', function(k, model) -- Grabs the model from the server
    Config.BigBanks["pacific"]['trolleys'][k]['model'] = model
end)
RegisterNetEvent('qb-bankrobbery:client:lootSyncPacific', function(type, k) -- Pushes the stored model to the type to state 'grabbed' in the config
    if k then 
        Config.BigBanks["pacific"][type][k]['grabbed'] = not Config.BigBanks["pacific"][type][k]['grabbed']
    else
        Config.BigBanks["pacific"][type]['grabbed'] = not Config.BigBanks["pacific"][type]['grabbed']
    end
end)