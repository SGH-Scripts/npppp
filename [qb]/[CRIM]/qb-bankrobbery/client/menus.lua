if Config.Laptops then
    RegisterNetEvent('qb-bankrobbery:client:laptop_menu', function()
        exports['qb-menu']:openMenu({
            {
                header = "Pink Laptop",
                txt = "$"..Config.PinkLaptopPrice,
                params = {
                    event = "qb-bankrobbery:client:laptop_pink",
                },
            },
            {
                header = "Green Laptop",
                txt = "$"..Config.GreenLaptopPrice,
                params = {
                    event = "qb-bankrobbery:client:laptop_green",
                },
            },
            {
                header = "Blue Laptop",
                txt = "$"..Config.BlueLaptopPrice,
                params = {
                    event = "qb-bankrobbery:client:laptop_blue",
                },
            },
            {
                header = "Red Laptop",
                txt = "$"..Config.RedLaptopPrice,
                params = {
                    event = "qb-bankrobbery:client:laptop_red",
                },
            },
            {
                header = "Gold Laptop",
                txt = "$"..Config.GoldLaptopPrice,
                params = {
                    event = "qb-bankrobbery:client:laptop_gold",
                },
            },
        })
    end)
    RegisterNetEvent('qb-bankrobbery:client:laptop_pink', function()
        TriggerServerEvent("qb-bankrobbery:server:laptop_pink")
    end)
    RegisterNetEvent('qb-bankrobbery:client:laptop_green', function()
        TriggerServerEvent("qb-bankrobbery:server:laptop_green")
    end)
    RegisterNetEvent('qb-bankrobbery:client:laptop_blue', function()
        TriggerServerEvent("qb-bankrobbery:server:laptop_blue")
    end)
    RegisterNetEvent('qb-bankrobbery:client:laptop_red', function()
        TriggerServerEvent("qb-bankrobbery:server:laptop_red")
    end)
    RegisterNetEvent('qb-bankrobbery:client:laptop_gold', function()
        TriggerServerEvent("qb-bankrobbery:server:laptop_gold")
    end)
    CreateThread(function()
        -- Create Ped
        RequestModel(GetHashKey('a_m_y_business_03'))
        while not HasModelLoaded(GetHashKey('a_m_y_business_03')) do
            Wait(1)
        end
        created_ped = CreatePed(5, GetHashKey('a_m_y_business_03') , Config.LaptopPedLoc.x, Config.LaptopPedLoc.y, Config.LaptopPedLoc.z, Config.LaptopPedLoc.w, false, true)
        FreezeEntityPosition(created_ped, true)
        SetEntityInvincible(created_ped, true)
        SetBlockingOfNonTemporaryEvents(created_ped, true)
        TaskStartScenarioInPlace(created_ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
        if Config.Target then
            -- Make Polyzone around Ped
            exports['qb-target']:AddBoxZone('LaptopDude', vector3(Config.LaptopPedLoc.x, Config.LaptopPedLoc.y, Config.LaptopPedLoc.z), 0.75, 0.75, {  
                name = 'LaptopDude', 
                heading = 300.0,
                debugPoly = false,
                minZ = 21.30 - 1,
                maxZ = 21.30 + 1.5,
                }, {
                options = { 
                { 
                    type = 'client',
                    event = 'qb-bankrobbery:client:laptop_menu',
                    icon = 'fas fa-clipboard',
                    label = 'Buy Goods',
                }
                },
                distance = 2.0,
            })
        else
            CreateThread(function() -- Laptop Menu
                Wait(2000)
                while true do
                    local ped = PlayerPedId()
                    local pos = GetEntityCoords(ped)
                    local inRange = false
                    if QBCore ~= nil then
                        local pedDist = #(pos - vector3(Config.LaptopPedLoc.x, Config.LaptopPedLoc.y, Config.LaptopPedLoc.z))
                            if pedDist < 5 then
                                inRange = true
                                if pedDist < 1.5 then
                                    DrawText3Ds(Config.LaptopPedLoc.x, Config.LaptopPedLoc.y, Config.LaptopPedLoc.z + 1.0, '[E] Buy')
                                    if IsControlJustPressed(0, 38) then
                                        TriggerEvent("qb-bankrobbery:client:laptop_menu")
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
    end)
end