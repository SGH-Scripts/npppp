


RegisterNetEvent('Rufi_ChangePlateMenu')
AddEventHandler('Rufi_ChangePlateMenu', function()

	OpenCpMenu()
	
end)




function OpenCpMenu()


AddTextEntry('FMMC_KEY_TIP1', 'Type new plate')

  DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", '', "", "", "", 8)

  while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do

  Citizen.Wait(0)

  end

 if UpdateOnscreenKeyboard() ~= 2 then

   local NewPlate = GetOnscreenKeyboardResult()
   local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
   local Plate = MathTrim(GetVehicleNumberPlateText(vehicle)) 

  Citizen.Wait(500)

	 TriggerServerEvent('Rufi_PlateChange', Plate, NewPlate)
	 SetVehicleNumberPlateText(vehicle, NewPlate)

  else

   Citizen.Wait(500)

    return nil

  end



end

MathTrim = function(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end