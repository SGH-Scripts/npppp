-- Functions
function OnPaletoHackDone(success)
    if success then
        TriggerEvent('qb-bankrobbery:client:SetUpPaletoTrolleys')
        local VaultWait = Config.PaletoVaultWait / 1000
        local VaultWaitMins = tonumber(VaultWait) / 60
        QBCore.Functions.Notify("Door Opening in: "..math.floor(VaultWaitMins).." Minutes", 'success')
        Wait(Config.PaletoVaultWait)
        TriggerServerEvent('qb-bankrobbery:server:setBankState', "paleto", true)
    else
		QBCore.Functions.Notify("You Suck!", 'error')
	end
end
function ThermitePaletoPlanting()
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end

    local ped = PlayerPedId()
    SetEntityHeading(ped, 313.00)
    local pos = vector3(-105.3955, 6475.019, 31.826705)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(ped)))
    local bagscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), pos.x, pos.y, pos.z,  true,  true, false)
    SetEntityCollision(bag, false, true)

    local x, y, z = table.unpack(GetEntityCoords(ped))
    local thermite = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.2,  true,  true, true)
    SetEntityCollision(thermite, false, true)
    AttachEntityToEntity(thermite, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Citizen.Wait(5000)
    DetachEntity(thermite, 1, 1)
    FreezeEntityPosition(thermite, true)
    DeleteObject(bag)
    NetworkStopSynchronisedScene(bagscene)
    Citizen.CreateThread(function()
        Citizen.Wait(15000)
        DeleteEntity(thermite)
    end)
end
function ThermitePaletoEffect()
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()
    local ptfx = vector3(-105.4855, 6475.999, 31.926705)
    Citizen.Wait(1500)
    TriggerServerEvent("qb-bankrobbery:server:ThermitePtfx", ptfx)
    Citizen.Wait(500)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Citizen.Wait(12000)
    ClearPedTasks(ped)
    Citizen.Wait(2000)
    QBCore.Functions.Notify("The lock had been melted", "success")
    TriggerServerEvent('qb-doorlock:server:updateState', Config.PaletoDoor2, false)
end

-- Events
RegisterNetEvent('qb-bankrobbery:client:UseBlueLaptop', function(laptopData) -- Laptop
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    QBCore.Functions.TriggerCallback('qb-bankrobbery:server:isRobberyActive', function(isBusy)
        if not isBusy then
            local dist = #(pos - vector3(Config.BigBanks["paleto"]['coords'].x, Config.BigBanks["paleto"]['coords'].y, Config.BigBanks["paleto"]['coords'].z))
            if dist < 2.5 then
                if CurrentCops >= Config.MinimumPaletoPolice then
                    if not Config.BigBanks["paleto"]['isOpened'] then
                        TriggerServerEvent('qb-bankrobbery:server:RemoveLaptopUse', laptopData) -- Removes a use from the laptop

                        SetEntityHeading(ped, Config.BigBanks["paleto"]['coords'].w)
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
                            StopAnimTask(ped, 'anim@gangops@facility@servers@', 'hotwire', 1.0)
                            -- Police Alert
                            if not copsCalled then
                                if Config.BigBanks["paleto"]["alarm"] then
                                    cameraId = Config.BigBanks["paleto"]['camId']
                                    bank = 'Paleto'
                                    TriggerEvent('dispatch:bankrobbery', bank, cameraId)
                                    copsCalled = true
                                end
                            end
                            TriggerEvent('qb-bankrobbery:client:LaptopPaleto')
                        end, function() -- Cancel
                            StopAnimTask(ped, 'anim@gangops@facility@servers@', 'hotwire', 1.0)
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
end)
RegisterNetEvent('qb-bankrobbery:client:LaptopPaleto', function()
    local loc = {x,y,z,h}
    loc.x = Config.BigBanks["paleto"]['coords'].x
    loc.y = Config.BigBanks["paleto"]['coords'].y
    loc.z = Config.BigBanks["paleto"]['coords'].z
    loc.h = Config.BigBanks["paleto"]['coords'].w

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

    exports['hacking']:OpenHackingGame(Config.PaletoTime, Config.PaletoBlocks, Config.PaletoRepeat, function(bool)
        NetworkStartSynchronisedScene(netScene3)
        NetworkStopSynchronisedScene(netScene3)
        DeleteObject(bag)
        DeleteObject(laptop)
        FreezeEntityPosition(ped, false)
        OnPaletoHackDone(bool)
    end)
end)
RegisterNetEvent('qb-bankrobbery:UseBankcardA', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local dist = #(pos - vector3(Config.BigBanks["paleto"]['coords'].x, Config.BigBanks["paleto"]['coords'].y, Config.BigBanks["paleto"]['coords'].z))
    if math.random(1, 100) <= 85 and not IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
    end
    if dist < 2.0 then
        if CurrentCops >= Config.MinimumPaletoPolice then
            if Config.BigBanks["paleto"]["isOpened"] then
                QBCore.Functions.Progressbar("security_pass", "Validitating card..", math.random(5000, 10000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "anim@gangops@facility@servers@",
                    anim = "hotwire",
                    flags = 16,
                }, {}, {}, function() -- Done
                    StopAnimTask(ped, "anim@gangops@facility@servers@", "hotwire", 1.0)
                    TriggerServerEvent("QBCore:Server:RemoveItem", "security_card_01", 1)
                    TriggerServerEvent('qb-doorlock:server:updateState', Config.PaletoDoor1, false)
                    if not copsCalled then
                        if Config.BigBanks["paleto"]["alarm"] then
                            cameraId = Config.BigBanks['paleto']['camId']
                            bank = 'Paleto'
                            TriggerEvent('dispatch:paleto:bankrobbery')
                            copsCalled = true
                        end
                    end
                end)
            else
                QBCore.Functions.Notify("It looks like the bank is not opened..", "error")
            end
        else
            QBCore.Functions.Notify('Minimum Of '..Config.MinimumPaletoPolice..' Police Needed', "error")
        end
    end
end)
RegisterNetEvent('qb-bankrobbery:client:DrillPaletoLocker', function()
    if Config.BigBanks["paleto"]["isOpened"] then
        for k, v in pairs(Config.BigBanks["paleto"]["lockers"]) do
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local lockerDist = #(pos - Config.BigBanks["paleto"]["lockers"][k]["coords"])
            if not Config.BigBanks["paleto"]["lockers"][k]["isBusy"] then
                if not Config.BigBanks["paleto"]["lockers"][k]["isOpened"] then
                    if lockerDist < 5 then
                        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                            if result then
                                if CurrentCops >= Config.MinimumPaletoPolice then
                                    -- EW CRUDE Need to figure out how to correct player positioning for the drilling animations
                                    --[[
                                        SetEntityCoords(ped, Config.BigBanks["paleto"]["lockers"][closestLocker]["coords"], 0, 0, 0, 0, false)
                                        SetEntityHeading(ped, Config.BigBanks["paleto"]["lockers"][closestLocker]["heading"])
                                    ]]
                                    openLocker("paleto", k)
                                else
                                    QBCore.Functions.Notify('Minimum Of '..Config.MinimumPaletoPolice..' Police Needed', "error")
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
end)
RegisterNetEvent('qb-bankrobbery:client:ThermitePaletoDoor', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    if #(pos - vector3(Config.BigBanks["paleto"]["thermite"][1]["coords"].x, Config.BigBanks["paleto"]["thermite"][1]["coords"].y, Config.BigBanks["paleto"]["thermite"][1]["coords"].z)) < 10.0 then
        if not Config.BigBanks["paleto"]["thermite"][1]["isOpened"] then
            local dist = #(pos - vector3(Config.BigBanks["paleto"]["thermite"][1]["coords"].x, Config.BigBanks["paleto"]["thermite"][1]["coords"].y, Config.BigBanks["paleto"]["thermite"][1]["coords"].z))
            if dist < 1 then
                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                    if result then
                        if math.random(1, 100) <= 85 and not IsWearingHandshoes() then
                            TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                        end
                        TriggerServerEvent('QBCore:Server:RemoveItem', 'thermite', 1)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["thermite"], 'remove')
                        ThermitePaletoPlanting()
                        -- Thermite Game
                        exports["memorygame"]:thermiteminigame(Config.ThermiteBlocks, Config.ThermiteAttempts, Config.ThermiteShow, Config.ThermiteTime,
                        function()
                            -- SUCCESS
                            ThermitePaletoEffect()
                        end,
                        function()
                            -- FAIL
                            QBCore.Functions.Notify('You suck!', 'error', '5000')
                        end)
                    else
                        QBCore.Functions.Notify('You don\'t have any thermite!', 'error', '5000')
                    end
                end, 'thermite')
            end
        end
    end
end)
RegisterNetEvent("qb-bankrobbery:client:ThermitePtfx", function(coords)-- Thermite Sparkles
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", coords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(10000)
    StopParticleFxLooped(effect, 0)
end)

-- Threads
if Config.Target then
    CreateThread(function() -- Drill Spots
        for bank, _ in pairs(Config.BigBanks) do
            for k,v in pairs(Config.BigBanks["paleto"]['lockers']) do
                exports['qb-target']:AddBoxZone('PaletoLockers'..math.random(1,200), vector3(Config.BigBanks["paleto"]['lockers'][k]['coords'].x, Config.BigBanks["paleto"]['lockers'][k]['coords'].y, Config.BigBanks["paleto"]['lockers'][k]['coords'].z), 1.00, 0.80, {
                    name = 'PaletoLockers'..math.random(1,200), 
                    heading = Config.BigBanks["paleto"]['lockers'][k]['heading'],
                    debugPoly = Config.DebugPoly,
                    minZ = Config.BigBanks["paleto"]['lockers'][k]['coords'].z-1,
                    maxZ = Config.BigBanks["paleto"]['lockers'][k]['coords'].z+2,
                    }, {
                    options = {
                        { 
                            type = 'client',
                            event = 'qb-bankrobbery:client:DrillPaletoLocker',
                            icon = 'fas fa-bomb',
                            label = 'Drill Locker',
                        }
                    },
                    distance = 1.5,
                })
            end
        end
    end)
    CreateThread(function() -- Thermite Spots
        for bank, _ in pairs(Config.BigBanks) do
            for k,v in pairs(Config.BigBanks["paleto"]['thermite']) do
                exports['qb-target']:AddBoxZone('PaletoThermite'..math.random(1,200), vector3(Config.BigBanks["paleto"]['thermite'][k]['coords'].x, Config.BigBanks["paleto"]['thermite'][k]['coords'].y, Config.BigBanks["paleto"]['thermite'][k]['coords'].z), 1.00, 0.80, {
                    name = 'PaletoThermite'..math.random(1,200), 
                    heading = Config.BigBanks["paleto"]['thermite'][k]['heading'],
                    debugPoly = Config.DebugPoly,
                    minZ = Config.BigBanks["paleto"]['thermite'][k]['coords'].z-1,
                    maxZ = Config.BigBanks["paleto"]['thermite'][k]['coords'].z+2,
                    }, {
                    options = {
                        { 
                            type = 'client',
                            event = 'qb-bankrobbery:client:ThermitePaletoDoor',
                            icon = 'fas fa-bomb',
                            label = 'Blow Door',
                        }
                    },
                    distance = 1.5,
                })
            end
        end
    end)
else
    CreateThread(function() -- Drill Spots
        Wait(2000)
        while true do
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local inRange = false
            if QBCore ~= nil then
                if Config.BigBanks["paleto"]["isOpened"] then
                    for k, v in pairs(Config.BigBanks["paleto"]["lockers"]) do
                        local lockerDist = #(pos - Config.BigBanks["paleto"]["lockers"][k]["coords"])
                        if not Config.BigBanks["paleto"]["lockers"][k]["isBusy"] then
                            if not Config.BigBanks["paleto"]["lockers"][k]["isOpened"] then
                                if lockerDist < 5 then
                                    inRange = true
                                    DrawMarker(2, Config.BigBanks["paleto"]["lockers"][k]["coords"].x, Config.BigBanks["paleto"]["lockers"][k]["coords"].y, Config.BigBanks["paleto"]["lockers"][k]["coords"].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                                    if lockerDist < 0.5 then
                                        DrawText3Ds(Config.BigBanks["paleto"]["lockers"][k]["coords"].x, Config.BigBanks["paleto"]["lockers"][k]["coords"].y, Config.BigBanks["paleto"]["lockers"][k]["coords"].z + 0.3, '[E] Break open the safe')
                                        if IsControlJustPressed(0, 38) then
                                            if CurrentCops >= Config.MinimumPaletoPolice then
                                                openLocker("paleto", k)
                                            else
                                                QBCore.Functions.Notify('Minimum Of '..Config.MinimumPaletoPolice..' Police Needed', "error")
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                for k, v in pairs(Config.BigBanks["paleto"]["thermite"]) do
                    local thermiteDist = #(pos - Config.BigBanks["paleto"]["thermite"][k]["coords"])
                    if thermiteDist < 2 then
                        inRange = true
                        if thermiteDist < 1.0 then
                            if not Config.BigBanks["paleto"]["thermite"][k]["isOpened"] then
                                DrawText3Ds(Config.BigBanks["paleto"]["thermite"][k]["coords"].x, Config.BigBanks["paleto"]["thermite"][k]["coords"].y, Config.BigBanks["paleto"]["thermite"][k]["coords"].z + 0.3, '[G] Blow Up Door')
                                if IsControlJustPressed(0, 58) then
                                    if CurrentCops >= Config.MinimumPaletoPolice then
                                        door = k
                                        TriggerEvent('qb-bankrobbery:client:ThermitePaletoDoor')
                                    else
                                        QBCore.Functions.Notify('Minimum Of '..Config.MinimumPaletoPolice..' Police Needed', "error")
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

RegisterCommand('setupPaleto', function()
    OnPaletoHackDone(true)
end)