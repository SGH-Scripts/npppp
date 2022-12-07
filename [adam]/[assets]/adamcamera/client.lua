Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local player = PlayerId()
		local isInVehicle = IsPedInAnyVehicle(ped, false)

		if isInVehicle then
			local viewMode = GetFollowVehicleCamViewMode()
			if viewMode == 1 or viewMode == 2 then
				SetFollowVehicleCamViewMode(4)
			end
		else
			local viewMode = GetFollowPedCamViewMode()
			if viewMode == 1 or viewMode == 2 then
				SetFollowPedCamViewMode(4)
			end
		end

		Citizen.Wait(0)
	end
end)