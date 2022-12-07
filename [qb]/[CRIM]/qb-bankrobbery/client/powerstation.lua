-- Functions
function thermiteAnimation(k)
    RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
    RequestModel('hei_p_m_bag_var22_arm_s')
    RequestNamedPtfxAsset('scr_ornate_heist')
    while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') and not HasModelLoaded('hei_p_m_bag_var22_arm_s') and not HasNamedPtfxAssetLoaded('scr_ornate_heist') do
        Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, Config.PowerStations[k]['coords'].w)
    Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local scene1 = NetworkCreateSynchronisedScene(Config.PowerStations[k]['coords'].x, Config.PowerStations[k]['coords'].y, Config.PowerStations[k]['coords'].z, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), Config.PowerStations[k]['coords'].x, Config.PowerStations[k]['coords'].y, Config.PowerStations[k]['coords'].z,  true,  true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, scene1, 'anim@heists@ornate_bank@thermal_charge', 'thermal_charge', 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene1, 'anim@heists@ornate_bank@thermal_charge', 'bag_thermal_charge', 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(scene1)
    Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local thermiteObj = CreateObject(GetHashKey('hei_prop_heist_thermite'), x, y, z + 0.3,  true,  true, true)

    SetEntityCollision(thermiteObj, false, true)
    AttachEntityToEntity(thermiteObj, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Wait(2000)
    DeleteObject(bag)
    DetachEntity(thermiteObj, 1, 1)
    FreezeEntityPosition(thermiteObj, true)

    TriggerServerEvent('QBCore:Server:RemoveItem', 'thermite', 1)
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["thermite"], 'remove')

    NetworkStopSynchronisedScene(scene1)
    ClearPedTasks(ped)
    QBCore.Functions.Notify('Blowing up in 10...', 'primary') 
    Wait(10000)
    DeleteObject(thermiteObj)
    AddExplosion(Config.PowerStations[k]['coords'].x, Config.PowerStations[k]['coords'].y, Config.PowerStations[k]['coords'].z, 0, 1.0, true, false, 4.0)
    QBCore.Functions.Notify("The fuses are broken", "success")
    TriggerServerEvent("qb-bankrobbery:server:SetStationStatus", k, true)
end

-- Events
RegisterNetEvent('thermite:UseThermite', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            for k,v in pairs(Config.PowerStations) do
                local Dist = #(pos - vector3(v['coords'].x, v['coords'].y, v['coords'].z))
                if Dist <= 1.5 then
                    if not v['hit'] then
                        -- Minigame
                        exports["memorygame"]:thermiteminigame(Config.ThermiteBlocks, Config.ThermiteAttempts, Config.ThermiteShow, Config.ThermiteTime,
                        function()
                            -- SUCCESS
                            thermiteAnimation(k)
                        end,
                        function()
                            -- FAIL
                            --[[
                            -- Blow them up?
                            AddExplosion(Config.PowerStations[k]['coords'].x, Config.PowerStations[k]['coords'].y, Config.PowerStations[k]['coords'].z, 0, 1.0, true, false, 4.0)
                            ]]
                            QBCore.Functions.Notify('You suck!', 'error', '5000')
                            TriggerServerEvent('QBCore:Server:RemoveItem', 'thermite', 1)
                            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["thermite"], 'remove')
                        end)
                    else 
                        QBCore.Functions.Notify('Fuse blown already', 'error', '5000')
                    end
                end
            end
        else
            QBCore.Functions.Notify('You appear to be missing something...', 'error')
        end
    end, 'thermite')
end)
RegisterNetEvent('qb-bankrobbery:client:SetStationStatus', function(key, isHit)
    Config.PowerStations[key].hit = isHit
end)

-- Threads
if Config.Target then
    CreateThread(function() 
        for k,v in pairs(Config.PowerStations) do
        exports['qb-target']:AddBoxZone('PowerStation'..math.random(1,20), vector3(Config.PowerStations[k]['coords'].x, Config.PowerStations[k]['coords'].y, Config.PowerStations[k]['coords'].z), 1.5, 1.5, {
            name = 'PowerStation'..math.random(1,20), 
            heading = Config.PowerStations[k]['coords'].w,
            debugPoly = Config.DebugPoly,
            minZ = Config.PowerStations[k]['coords'].z-1,
            maxZ = Config.PowerStations[k]['coords'].z+2,
            }, {
            options = {
            { 
                type = 'client',
                event = 'thermite:UseThermite',
                icon = 'fas fa-bomb',
                label = 'Blow Up',
            }
            },
            distance = 1.5,
        })
        end
    end)
else
    CreateThread(function()
        Wait(2000)
        while true do
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local inRange = false
            for k , v in pairs(Config.PowerStations) do
                local Dist = #(pos - vector3(Config.PowerStations[k]['coords'].x, Config.PowerStations[k]['coords'].y, Config.PowerStations[k]['coords'].z))
                if Dist <= 2.5 then
                    inRange = true
                    if not v['hit'] then
                        DrawText3Ds(Config.PowerStations[k]['coords'].x, Config.PowerStations[k]['coords'].y, Config.PowerStations[k]['coords'].z, '[G] Blow Up')
                        if IsControlJustPressed(0, 58) then     
                            TriggerEvent('thermite:UseThermite')
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