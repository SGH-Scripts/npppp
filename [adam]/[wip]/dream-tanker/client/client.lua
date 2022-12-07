local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local JobStarted, Login, tutorial, VehicleOut, CanRopeOut, done  = false, false, false, false, false, false
local number = 1
local rope

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
	if (Config.jobrequirement and (PlayerData.job ~= nil and PlayerData.job.name == Config.jobname)) then
		CreateBossBlip(true)
	elseif not Config.jobrequirement then
		CreateBossBlip(true)
	end
	Login = true
end)

Login = true

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function()
	PlayerData.job = QBCore.Functions.GetPlayerData().job
	if (Config.jobrequirement and (PlayerData.job ~= nil and PlayerData.job.name == Config.jobname)) then
		CreateBossBlip(true)
	elseif not Config.jobrequirement then
		CreateBossBlip(true)
	else 
		CreateBossBlip(false)
	end
end)

function CreateBossBlip(type)
	if type then
		RemoveBlip(StartJobBlip)
		StartJobBlip = AddBlipForCoord(Config.tanker['BossSpawn'].Pos.x, Config.tanker['BossSpawn'].Pos.y, Config.tanker['BossSpawn'].Pos.z)
		
		SetBlipSprite (StartJobBlip, 408)
		SetBlipDisplay(StartJobBlip, 4)
		SetBlipScale  (StartJobBlip, 0.8)
		SetBlipColour (StartJobBlip, 0)
		SetBlipAsShortRange(StartJobBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Tanker Work')
		EndTextCommandSetBlipName(StartJobBlip)
	else
		RemoveBlip(StartJobBlip)
	end
end

Citizen.CreateThread(function()
	if not Config.jobrequirement then
		CreateBossBlip(true)
	end

	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		if(GetDistanceBetweenCoords(coords,Config.tanker['BossSpawn'].Pos.x, Config.tanker['BossSpawn'].Pos.y, Config.tanker['BossSpawn'].Pos.z, true) < 150.0) then
			sleep = 5
			if(GetDistanceBetweenCoords(coords,Config.tanker['BossSpawn'].Pos.x, Config.tanker['BossSpawn'].Pos.y, Config.tanker['BossSpawn'].Pos.z, true) < 100.0) then
				local ped_hash = GetHashKey(Config.tanker['BossSpawn'].Type)
				RequestModel(ped_hash)
				while not HasModelLoaded(ped_hash) do
					Citizen.Wait(1)
				end	
				BossNPC = CreatePed(1, ped_hash, Config.tanker['BossSpawn'].Pos.x, Config.tanker['BossSpawn'].Pos.y, Config.tanker['BossSpawn'].Pos.z-1, Config.tanker['BossSpawn'].Pos.h, false, true)
				SetBlockingOfNonTemporaryEvents(BossNPC, true)
				SetPedDiesWhenInjured(BossNPC, false)
				SetPedCanPlayAmbientAnims(BossNPC, true)
				SetPedCanRagdollFromPlayerImpact(BossNPC, false)
				SetEntityInvincible(BossNPC, true)
				FreezeEntityPosition(BossNPC, true)

				local ped_hash = GetHashKey(Config.tanker['TruckMan'].Type)
				RequestModel(ped_hash)
				while not HasModelLoaded(ped_hash) do
					Citizen.Wait(1)
				end	
				TruckManNPC = CreatePed(1, ped_hash, Config.tanker['TruckMan'].Pos.x, Config.tanker['TruckMan'].Pos.y, Config.tanker['TruckMan'].Pos.z-1, Config.tanker['TruckMan'].Pos.h, false, true)
				SetBlockingOfNonTemporaryEvents(TruckManNPC, true)
				SetPedDiesWhenInjured(TruckManNPC, false)
				SetPedCanPlayAmbientAnims(TruckManNPC, true)
				SetPedCanRagdollFromPlayerImpact(TruckManNPC, false)
				SetEntityInvincible(TruckManNPC, true)
				FreezeEntityPosition(TruckManNPC, true)

				local ped_hash = GetHashKey(Config.tanker['Manager'].Type)
				RequestModel(ped_hash)
				while not HasModelLoaded(ped_hash) do
					Citizen.Wait(1)
				end	
				ManagerNPC = CreatePed(1, ped_hash, Config.tanker['Manager'].Pos.x, Config.tanker['Manager'].Pos.y, Config.tanker['Manager'].Pos.z-1, Config.tanker['Manager'].Pos.h, false, true)
				SetBlockingOfNonTemporaryEvents(ManagerNPC, true)
				SetPedDiesWhenInjured(ManagerNPC, false)
				SetPedCanPlayAmbientAnims(ManagerNPC, true)
				SetPedCanRagdollFromPlayerImpact(ManagerNPC, false)
				SetEntityInvincible(ManagerNPC, true)
				FreezeEntityPosition(ManagerNPC, true)
			
				break
			end
		end
		Citizen.Wait(sleep)
	end 

	while true do
		Citizen.Wait(100)
		if Login then
			PlayerData = QBCore.Functions.GetPlayerData()
			QBCore.Functions.TriggerCallback('dream-tanker:getdatabase', function(tut)
				if tut == 'false' then
					tutorial = true
				end
			end, PlayerData)
			break
		end
	end

	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		if(GetDistanceBetweenCoords(coords,Config.tanker['BossSpawn'].Pos.x, Config.tanker['BossSpawn'].Pos.y, Config.tanker['BossSpawn'].Pos.z, true) < 4.0) then	
			sleep = 4
			if(GetDistanceBetweenCoords(coords,Config.tanker['BossSpawn'].Pos.x, Config.tanker['BossSpawn'].Pos.y, Config.tanker['BossSpawn'].Pos.z, true) < 1.5) then	
				sleep = 0
				if (Config.jobrequirement and (PlayerData.job ~= nil and PlayerData.job.name == Config.jobname)) or not Config.jobrequirement then
					if not JobStarted then						
						DrawText3Ds(Config.tanker['BossSpawn'].Pos.x, Config.tanker['BossSpawn'].Pos.y, Config.tanker['BossSpawn'].Pos.z+1.0, 'Press [~g~E~w~] to start working')
					else
						DrawText3Ds(Config.tanker['BossSpawn'].Pos.x, Config.tanker['BossSpawn'].Pos.y, Config.tanker['BossSpawn'].Pos.z+1.0, 'Press [~r~E~w~] to finish the job')
					end

					if (IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and not JobStarted) then

						local PlayerData = QBCore.Functions.GetPlayerData()
						if PlayerData.charinfo.gender == 0 then 
							SetPedComponentVariation(ped, 3, Config.Clothes.male['arms'], 0, 0) --arms
							SetPedComponentVariation(ped, 8, Config.Clothes.male['tshirt_1'], Config.Clothes.male['tshirt_2'], 0) --t-shirt
							SetPedComponentVariation(ped, 11, Config.Clothes.male['torso_1'], Config.Clothes.male['torso_2'], 0) --torso2
							SetPedComponentVariation(ped, 9, Config.Clothes.male['bproof_1'], Config.Clothes.male['bproof_2'], 0) --vest
							SetPedComponentVariation(ped, 10, Config.Clothes.male['decals_1'], Config.Clothes.male['decals_2'], 0) --decals
							SetPedComponentVariation(ped, 7, Config.Clothes.male['chain_1'], Config.Clothes.male['chain_2'], 0) --accessory
							SetPedComponentVariation(ped, 4, Config.Clothes.male['pants_1'], Config.Clothes.male['pants_2'], 0) -- pants
							SetPedComponentVariation(ped, 6, Config.Clothes.male['shoes_1'], Config.Clothes.male['shoes_2'], 0) --shoes
							SetPedPropIndex(ped, 0, Config.Clothes.male['helmet_1'], Config.Clothes.male['helmet_2'], true) --hat
							SetPedPropIndex(ped, 2, Config.Clothes.male['ears_1'], Config.Clothes.male['ears_2'], true) --ear
						else
							SetPedComponentVariation(ped, 3, Config.Clothes.female['arms'], 0, 0) --arms
							SetPedComponentVariation(ped, 8, Config.Clothes.female['tshirt_1'], Config.Clothes.female['tshirt_2'], 0) --t-shirt
							SetPedComponentVariation(ped, 11, Config.Clothes.female['torso_1'], Config.Clothes.female['torso_2'], 0) --torso2
							SetPedComponentVariation(ped, 9, Config.Clothes.female['bproof_1'], Config.Clothes.female['bproof_2'], 0) --vest
							SetPedComponentVariation(ped, 10, Config.Clothes.female['decals_1'], Config.Clothes.female['decals_2'], 0) --decals
							SetPedComponentVariation(ped, 7, Config.Clothes.female['chain_1'], Config.Clothes.female['chain_2'], 0) --accessory
							SetPedComponentVariation(ped, 4, Config.Clothes.female['pants_1'], Config.Clothes.female['pants_2'], 0) -- pants
							SetPedComponentVariation(ped, 6, Config.Clothes.female['shoes_1'], Config.Clothes.female['shoes_2'], 0) --shoes
							SetPedPropIndex(ped, 0, Config.Clothes.female['helmet_1'], Config.Clothes.female['helmet_2'], true) --hat
							SetPedPropIndex(ped, 2, Config.Clothes.female['ears_1'], Config.Clothes.female['ears_2'], true) --ear
						end	

						
							JobStarted = true
							if tutorial then 
								exports.pNotify:SendNotification({text = "<b>Boss</b></br>I see that you are here for the first time, go to the man who will get you a truck, I will mark you on the map where to look for him.", timeout = 10000})

								TruckManBlip = AddBlipForCoord(Config.tanker['TruckMan'].Pos.x, Config.tanker['TruckMan'].Pos.y, Config.tanker['TruckMan'].Pos.z)
								SetBlipSprite (TruckManBlip, 133)
								SetBlipDisplay(TruckManBlip, 4)
								SetBlipScale  (TruckManBlip, 0.8)
								SetBlipColour (TruckManBlip, 0)
								SetBlipAsShortRange(TruckManBlip, true)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString('Truck Man')
								EndTextCommandSetBlipName(TruckManBlip)
							else
								exports.pNotify:SendNotification({text = "<b>Boss</b></br>You know what to do, go get your truck.", timeout = 4000})

								TruckOutBlip = AddBlipForCoord(Config.tanker['TruckOut'].Pos.x, Config.tanker['TruckOut'].Pos.y, Config.tanker['TruckOut'].Pos.z)
								SetBlipSprite (TruckOutBlip, 477)
								SetBlipDisplay(TruckOutBlip, 4)
								SetBlipScale  (TruckOutBlip, 0.8)
								SetBlipColour (TruckOutBlip, 0)
								SetBlipAsShortRange(TruckOutBlip, true)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString('Truck Out')
								EndTextCommandSetBlipName(TruckOutBlip)	
							end
							CreateStartWork()

					elseif (IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and JobStarted) then
						JobStarted = false
						TriggerServerEvent("qb-clothes:loadPlayerSkin")
						RemoveBlip(TruckOutBlip)
						RemoveBlip(TruckManBlip)
						VehicleOut = false
						QBCore.Functions.DeleteVehicle(Vehicle)
						QBCore.Functions.DeleteVehicle(Trailer)
						RemoveBlip(ManagerBlip)
						job = false
						RemoveBlip(SemiTrailerBlip)
						RemoveBlip(RefuelingBlip)
						RemoveBlip(StationBlip)
						DeletePed(StationNPC)
						DeleteObject(tank)
						RemoveBlip(RefulingPlaceBlip)
						CanRopeOut = false
						tube = false
						RopeUnloadTextures()
						DeleteRope(rope)
						done = false
					end

				else
					DrawText3Ds(Config.tanker['BossSpawn'].Pos.x, Config.tanker['BossSpawn'].Pos.y, Config.tanker['BossSpawn'].Pos.z+1.0, 'This job is not for you')
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

function CreateStartWork()
	local Text1 = true
	local Text2 = false
	local Text3 = false
	Citizen.CreateThread(function()
		while true do
			local sleep = 500
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)

			if tutorial and JobStarted then
				if(GetDistanceBetweenCoords(coords,Config.tanker['TruckMan'].Pos.x, Config.tanker['TruckMan'].Pos.y, Config.tanker['TruckMan'].Pos.z, true) < 4.0) then	
					sleep = 4
					if(GetDistanceBetweenCoords(coords,Config.tanker['TruckMan'].Pos.x, Config.tanker['TruckMan'].Pos.y, Config.tanker['TruckMan'].Pos.z, true) < 1.5) then	
						sleep = 0
						if Text3 then
							DrawText3Ds(Config.tanker['TruckMan'].Pos.x, Config.tanker['TruckMan'].Pos.y, Config.tanker['TruckMan'].Pos.z+1.0, 'Great, pick her on your left and go to the pickup point')
						elseif Text2 then
							DrawText3Ds(Config.tanker['TruckMan'].Pos.x, Config.tanker['TruckMan'].Pos.y, Config.tanker['TruckMan'].Pos.z+1.2, 'Hello, for sure you need your first truck, you have to pay '..Config.TruckPrice..'~g~$')
							DrawText3Ds(Config.tanker['TruckMan'].Pos.x, Config.tanker['TruckMan'].Pos.y, Config.tanker['TruckMan'].Pos.z+1.0, 'Press [~g~G~w~] to pay')				
						elseif Text1 then					
							DrawText3Ds(Config.tanker['TruckMan'].Pos.x, Config.tanker['TruckMan'].Pos.y, Config.tanker['TruckMan'].Pos.z+1.0, 'Press [~g~E~w~] to start a conversation')
						end
						if (IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and Text1) then
							Text1 = false
							Text2 = true
						elseif(IsControlJustReleased(0, Keys['G']) and not IsPedInAnyVehicle(ped, false) and Text2) then
							QBCore.Functions.TriggerCallback('dream-tanker:buytruck', function(cb)
								if cb then
									Text2 = false
									Text3 = true
									tutorial = false
									
									exports.pNotify:SendNotification({text = "<b>Boss</b></br>You bought the vehicle for "..Config.TruckPrice.."$", timeout = 4500})

									TruckOutBlip = AddBlipForCoord(Config.tanker['TruckOut'].Pos.x, Config.tanker['TruckOut'].Pos.y, Config.tanker['TruckOut'].Pos.z)
									SetBlipSprite (TruckOutBlip, 477)
									SetBlipDisplay(TruckOutBlip, 4)
									SetBlipScale  (TruckOutBlip, 0.8)
									SetBlipColour (TruckOutBlip, 0)
									SetBlipAsShortRange(TruckOutBlip, true)
									BeginTextCommandSetBlipName("STRING")
									AddTextComponentString('Truck Out')
									EndTextCommandSetBlipName(TruckOutBlip)	

									RemoveBlip(TruckManBlip)
								elseif not cb then
									exports.pNotify:SendNotification({text = "<b>Boss</b></br>You don't have money for a truck.", timeout = 4500})	
								end
							end)			
						end
					end
				end
			elseif not tutorial and JobStarted then 
				if(GetDistanceBetweenCoords(coords,Config.tanker['TruckMan'].Pos.x, Config.tanker['TruckMan'].Pos.y, Config.tanker['TruckMan'].Pos.z, true) < 4.0) then	
					sleep = 4
					if(GetDistanceBetweenCoords(coords,Config.tanker['TruckMan'].Pos.x, Config.tanker['TruckMan'].Pos.y, Config.tanker['TruckMan'].Pos.z, true) < 1.5) then	
						sleep = 0
						DrawText3Ds(Config.tanker['TruckMan'].Pos.x, Config.tanker['TruckMan'].Pos.y, Config.tanker['TruckMan'].Pos.z+1.0, 'You know what to do, take the truck and work')
					end
				end
			elseif not JobStarted then
				break
			end

			if(GetDistanceBetweenCoords(coords,Config.tanker['TruckOut'].Pos.x, Config.tanker['TruckOut'].Pos.y, Config.tanker['TruckOut'].Pos.z, true) < 15.0) and not tutorial then	
				sleep = 4
				DrawMarker(27, Config.tanker['TruckOut'].Pos.x, Config.tanker['TruckOut'].Pos.y, Config.tanker['TruckOut'].Pos.z-1.20, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 123, 204, 88, 200, false, true, 2, true, false, false, false)
				if(GetDistanceBetweenCoords(coords,Config.tanker['TruckOut'].Pos.x, Config.tanker['TruckOut'].Pos.y, Config.tanker['TruckOut'].Pos.z, true) < 2.0) then
					sleep = 0
					if not VehicleOut then
						DrawText3Ds(Config.tanker['TruckOut'].Pos.x, Config.tanker['TruckOut'].Pos.y, Config.tanker['TruckOut'].Pos.z+1.0, 'Press [~g~E~w~] to get the truck out')
					else
						DrawText3Ds(Config.tanker['TruckOut'].Pos.x, Config.tanker['TruckOut'].Pos.y, Config.tanker['TruckOut'].Pos.z+1.0, 'Press [~r~E~w~] to hide the truck')
					end
					if(IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and not VehicleOut) then
						if IsSpawnPointClear(Config.tanker['TruckOut'].Pos, 2) then
							QBCore.Functions.TriggerCallback('dream-tanker:gettruck', function(cb)
								if cb then
									QBCore.Functions.SpawnVehicle(Config.tanker['TruckOut'].Vehicle, function(vehicle)
										Vehicle = vehicle
										SetVehicleNumberPlateText(vehicle, "KOX"..tostring(math.random(1000, 9999)))
										TaskWarpPedIntoVehicle(ped, vehicle, -1)
										SetVehicleEngineOn(vehicle, true, true)
										TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
										Plate = GetVehicleNumberPlateText(vehicle)
										VehicleOut = true 
										exports.pNotify:SendNotification({text = "<b>Boss</b></br>You pulled the truck for "..Config.TruckOutPrice.."$, go to the loading point.", timeout = 4500})	

										ManagerBlip = AddBlipForCoord(Config.tanker['Manager'].Pos.x, Config.tanker['Manager'].Pos.y, Config.tanker['Manager'].Pos.z)
										SetBlipSprite (ManagerBlip, 133)
										SetBlipDisplay(ManagerBlip, 4)
										SetBlipScale  (ManagerBlip, 0.8)
										SetBlipColour (ManagerBlip, 0)
										SetBlipAsShortRange(ManagerBlip, true)
										BeginTextCommandSetBlipName("STRING")
										AddTextComponentString('Manager')
										EndTextCommandSetBlipName(ManagerBlip)

										
										SetEntityAsMissionEntity(vehicle, true, true)

										CreateWork()							
									end, Config.tanker['TruckOut'].Pos, true)
								elseif not cb then
									exports.pNotify:SendNotification({text = "<b>Boss</b></br>You don't have "..Config.TruckOutPrice.."$ to get the vehicle.", timeout = 4500})	
								end
							end, 'gettruck')
						else
							exports.pNotify:SendNotification({text = "<b>Boss</b></br>There is not enough space here to pull out a truck.", timeout = 4500})
						end
					elseif(IsControlJustReleased(0, Keys['E']) and IsPedInAnyVehicle(ped, false) and VehicleOut) then
						local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
						if GetVehicleNumberPlateText(vehicle) == Plate then
							QBCore.Functions.TriggerCallback('dream-tanker:gettruck', function(cb)
								if cb then
									QBCore.Functions.DeleteVehicle(Vehicle)
									VehicleOut = false
									exports.pNotify:SendNotification({text = "<b>Boss</b></br>You hide your truck.", timeout = 4500})

									JobStarted = false
									TriggerServerEvent("qb-clothes:loadPlayerSkin")
									RemoveBlip(TruckOutBlip)
									RemoveBlip(TruckManBlip)

									RemoveBlip(TruckOutBlip)
									QBCore.Functions.DeleteVehicle(Trailer)
									RemoveBlip(ManagerBlip)
									job = false
									RemoveBlip(SemiTrailerBlip)
									RemoveBlip(StationBlip)
									DeletePed(StationNPC)
									DeleteObject(tank)
									RemoveBlip(RefulingPlaceBlip)
									CanRopeOut = false
									tube = false
									RopeUnloadTextures()
									DeleteRope(rope)
									done = false
									RemoveBlip(RefuelingBlip)
								end
							end, 'backtruck')
						else
							exports.pNotify:SendNotification({text = "<b>Boss</b></br>It's not your truck.", timeout = 4500})
						end
					end
				end
			end
			Citizen.Wait(sleep)
		end
	end)
end

function CreateWork()
	Citizen.CreateThread(function()
		while true do
			local sleep = 500
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
				if VehicleOut then
					if(GetDistanceBetweenCoords(coords,Config.tanker['Manager'].Pos.x, Config.tanker['Manager'].Pos.y, Config.tanker['Manager'].Pos.z, true) < 4.0) and not job then
						sleep = 4
						if(GetDistanceBetweenCoords(coords,Config.tanker['Manager'].Pos.x, Config.tanker['Manager'].Pos.y, Config.tanker['Manager'].Pos.z, true) < 1.5) then
							sleep = 0
							DrawText3Ds(Config.tanker['Manager'].Pos.x, Config.tanker['Manager'].Pos.y, Config.tanker['Manager'].Pos.z+1.0, 'Press [~g~E~w~] to receive information about the order')
							if(IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false)) then
								job = true
								RemoveBlip(ManagerBlip)

								exports.pNotify:SendNotification({text = "<b>Boss</b></br>Drive there and connect the trailer to the vehicle.", timeout = 5500})

								SemiTrailerBlip = AddBlipForCoord(Config.tanker['Semitrailer'].Pos.x, Config.tanker['Semitrailer'].Pos.y, Config.tanker['Semitrailer'].Pos.z)
								SetBlipSprite (SemiTrailerBlip, 479)
								SetBlipDisplay(SemiTrailerBlip, 4)
								SetBlipScale  (SemiTrailerBlip, 0.8)
								SetBlipColour (SemiTrailerBlip, 0)
								SetBlipAsShortRange(SemiTrailerBlip, true)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString('Place')
								EndTextCommandSetBlipName(SemiTrailerBlip)									
							end
						end
					elseif(GetDistanceBetweenCoords(coords,Config.tanker['Semitrailer'].Pos.x, Config.tanker['Semitrailer'].Pos.y, Config.tanker['Semitrailer'].Pos.z, true) < 15.0) and job then
						sleep = 4
						DrawMarker(27, Config.tanker['Semitrailer'].Pos.x, Config.tanker['Semitrailer'].Pos.y, Config.tanker['Semitrailer'].Pos.z-1.20, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 123, 204, 88, 200, false, true, 2, true, false, false, false)
						if(GetDistanceBetweenCoords(coords,Config.tanker['Semitrailer'].Pos.x, Config.tanker['Semitrailer'].Pos.y, Config.tanker['Semitrailer'].Pos.z, true) < 4.0) then
							sleep = 0
							DrawText3Ds(Config.tanker['Semitrailer'].Pos.x, Config.tanker['Semitrailer'].Pos.y, Config.tanker['Semitrailer'].Pos.z+1.0, 'Press [~g~E~w~] to connect a trailer.')
							if(IsControlJustReleased(0, Keys['E']) and IsPedInAnyVehicle(ped, false)) then
								local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
								if GetVehicleNumberPlateText(vehicle) == Plate then
									if GetEntityHeading(vehicle) > Config.tanker['Semitrailer'].Pos.h and GetEntityHeading(vehicle) < Config.tanker['Semitrailer'].Pos.h+20 or GetEntityHeading(vehicle) < Config.tanker['Semitrailer'].Pos.h and GetEntityHeading(vehicle) > Config.tanker['Semitrailer'].Pos.h-20 then
										if IsSpawnPointClear(Config.tanker['Semitrailer'].PosSpawn, 2) then
											QBCore.Functions.SpawnVehicle(Config.tanker['Semitrailer'].Vehicle, function(vehicle)
												Trailer = vehicle
												SetEntityAsMissionEntity(Trailer, true, true)
												AttachVehicleToTrailer(Vehicle, Trailer, 1.1)
											end, Config.tanker['Semitrailer'].PosSpawn, true)
											RemoveBlip(SemiTrailerBlip)
											exports.pNotify:SendNotification({text = "<b>Boss</b></br>Go to the place where they will fill the trailer with fuel, it's behind the building.", timeout = 4500})
											Work()
											break
										else
											exports.pNotify:SendNotification({text = "<b>Boss</b></br>There is not enough space here to pull out a tanker.", timeout = 4500})
										end
									else
										exports.pNotify:SendNotification({text = "<b>Boss</b></br>Drive backwards.", timeout = 4500})
									end
								else
									exports.pNotify:SendNotification({text = "<b>Boss</b></br>It's not your truck.", timeout = 4500})
								end
							elseif(IsControlJustReleased(0, Keys['E']) and IsPedInAnyVehicle(ped, false)) then
								exports.pNotify:SendNotification({text = "<b>Boss</b></br>Do it outside the vehicle.", timeout = 4500})
							end
						end
					end							
				elseif not VehicleOut then
					break
				end
			Citizen.Wait(sleep)
		end
	end)
end

function Work()
	RefuelingBlip = AddBlipForCoord(Config.tanker['Refueling'].Pos.x, Config.tanker['Refueling'].Pos.y, Config.tanker['Refueling'].Pos.z)
	SetBlipSprite (RefuelingBlip, 655)
	SetBlipDisplay(RefuelingBlip, 4)
	SetBlipScale  (RefuelingBlip, 0.8)
	SetBlipColour (RefuelingBlip, 0)
	SetBlipAsShortRange(RefuelingBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Refueling')
	EndTextCommandSetBlipName(RefuelingBlip)
	

	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
			if(GetDistanceBetweenCoords(coords,Config.tanker['Refueling'].Pos.x, Config.tanker['Refueling'].Pos.y, Config.tanker['Refueling'].Pos.z, true) < 30.0) then
				sleep = 4
				DrawMarker(27, Config.tanker['Refueling'].Pos.x, Config.tanker['Refueling'].Pos.y, Config.tanker['Refueling'].Pos.z-1.20, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 3.0, 123, 204, 88, 200, false, true, 2, true, false, false, false)
				if(GetDistanceBetweenCoords(coords,Config.tanker['Refueling'].Pos.x, Config.tanker['Refueling'].Pos.y, Config.tanker['Refueling'].Pos.z, true) < 3.0) then				
					DrawText3Ds(Config.tanker['Refueling'].Pos.x, Config.tanker['Refueling'].Pos.y, Config.tanker['Refueling'].Pos.z+1.0, 'Press [~g~E~w~] to fill the trailer with fuel.')
					if(IsControlJustReleased(0, Keys['E']) and IsPedInAnyVehicle(ped, false)) then
						local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
						if GetVehicleNumberPlateText(vehicle) == Plate then
							if IsVehicleAttachedToTrailer(vehicle) then
								FreezeEntityPosition(vehicle, true)
								SetVehicleDoorsLocked(vehicle, 4)
								TriggerEvent('dream-tanker:sound', 'fueling', 0.5)
								meter()					
								while true do 	
									local ped = PlayerPedId()
									local coords = GetEntityCoords(ped)
									local coords2 = GetEntityCoords(Trailer)
									if(GetDistanceBetweenCoords(coords,Config.tanker['Refueling'].Pos.x, Config.tanker['Refueling'].Pos.y, Config.tanker['Refueling'].Pos.z, true) < 15.0) then
										sleep = 0
										DrawText3Ds(coords2.x, coords2.y, coords2.z+1.0, number.."~g~%")
									end
									if number >= 100 then
										FreezeEntityPosition(vehicle, false)
										number = 1
										break
									end
									Citizen.Wait(sleep)
								end
								SetVehicleDoorsLocked(vehicle, 0)

								exports.pNotify:SendNotification({text = "<b>Boss</b></br>The trailer is full, go to the designated station.", timeout = 4500})
								RemoveBlip(RefuelingBlip)

								RandomPlace = math.random(1,#Config.Places)

								StationBlip = AddBlipForCoord(Config.Places[RandomPlace].Ped.x, Config.Places[RandomPlace].Ped.y, Config.Places[RandomPlace].Ped.z)
								SetBlipSprite (StationBlip, 47)
								SetBlipDisplay(StationBlip, 4)
								SetBlipScale  (StationBlip, 0.8)
								SetBlipColour (StationBlip, 0)
								SetBlipAsShortRange(StationBlip, true)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString('Filling station')
								EndTextCommandSetBlipName(StationBlip)	

								SetNewWaypoint(Config.Places[RandomPlace].Ped.x, Config.Places[RandomPlace].Ped.y)
								
								local ped_hash = GetHashKey(Config.Places[RandomPlace].Ped.model)
								RequestModel(ped_hash)
								while not HasModelLoaded(ped_hash) do
									Citizen.Wait(1)
								end	
								StationNPC = CreatePed(1, ped_hash, Config.Places[RandomPlace].Ped.x, Config.Places[RandomPlace].Ped.y, Config.Places[RandomPlace].Ped.z-1, Config.Places[RandomPlace].Ped.h, false, true)
								SetBlockingOfNonTemporaryEvents(StationNPC, true)
								SetPedDiesWhenInjured(StationNPC, false)
								SetPedCanPlayAmbientAnims(StationNPC, true)
								SetPedCanRagdollFromPlayerImpact(StationNPC, false)
								SetEntityInvincible(StationNPC, true)
								FreezeEntityPosition(StationNPC, true)	
								
								local tank = CreateObject(GetHashKey('prop_ind_mech_03a'), Config.Places[RandomPlace].RefulingPlace.x, Config.Places[RandomPlace].RefulingPlace.y, Config.Places[RandomPlace].RefulingPlace.z-1, false,  true, true)
								FreezeEntityPosition(tank, true)


								while true do
									local sleep = 500
									local ped = PlayerPedId()
									local coords = GetEntityCoords(ped)
										if(GetDistanceBetweenCoords(coords,Config.Places[RandomPlace].Ped.x, Config.Places[RandomPlace].Ped.y, Config.Places[RandomPlace].Ped.z, true) < 15.0) then
											sleep = 4
											-- DrawMarker(27, Config.Places[RandomPlace].Pos.x, Config.Places[RandomPlace].Pos.y, Config.Places[RandomPlace].Pos.z-1.20, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 3.0, 123, 204, 88, 200, false, true, 2, true, false, false, false)
											if(GetDistanceBetweenCoords(coords,Config.Places[RandomPlace].Ped.x, Config.Places[RandomPlace].Ped.y, Config.Places[RandomPlace].Ped.z, true) < 1.5) then			
												sleep = 0	
												DrawText3Ds(Config.Places[RandomPlace].Ped.x, Config.Places[RandomPlace].Ped.y, Config.Places[RandomPlace].Ped.z+1.0, 'Press [~g~E~w~] to talk.')
												if(IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false)) and not done then
													exports.pNotify:SendNotification({text = "<b>Client</b></br>You probably brought fuel, go to the indicated place and empty your trailer.", timeout = 4500})

													RefulingPlaceBlip = AddBlipForCoord(Config.Places[RandomPlace].RefulingPlace.x, Config.Places[RandomPlace].RefulingPlace.y, Config.Places[RandomPlace].RefulingPlace.z)
													SetBlipSprite (RefulingPlaceBlip, 162)
													SetBlipDisplay(RefulingPlaceBlip, 4)
													SetBlipScale  (RefulingPlaceBlip, 0.8)
													SetBlipColour (RefulingPlaceBlip, 0)
													SetBlipAsShortRange(RefulingPlaceBlip, true)
													BeginTextCommandSetBlipName("STRING")
													AddTextComponentString('Refuling Place')
													EndTextCommandSetBlipName(RefulingPlaceBlip)			
													
													while true do
														local sleep = 500
														local ped = PlayerPedId()
														local coords = GetEntityCoords(ped)
														if(GetDistanceBetweenCoords(coords,Config.Places[RandomPlace].RefulingPlace.x, Config.Places[RandomPlace].RefulingPlace.y, Config.Places[RandomPlace].RefulingPlace.z, true) < 35.0) then
															if not CanRopeOut then
																CanRopeOut = true
															end
															sleep = 4
															DrawMarker(20, Config.Places[RandomPlace].RefulingPlace.x, Config.Places[RandomPlace].RefulingPlace.y, Config.Places[RandomPlace].RefulingPlace.z+1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.4, 0.4, 0.4, 255, 255, 255, 200, false, true, 2, true, false, false, false)
															if(GetDistanceBetweenCoords(coords,Config.Places[RandomPlace].RefulingPlace.x, Config.Places[RandomPlace].RefulingPlace.y, Config.Places[RandomPlace].RefulingPlace.z, true) < 1.5) then
																sleep = 0	
																if not tube then
																	DrawText3Ds(Config.Places[RandomPlace].RefulingPlace.x, Config.Places[RandomPlace].RefulingPlace.y, Config.Places[RandomPlace].RefulingPlace.z+1.0, 'Filling place, connect the hose from the trailer here.')
																else 
																	DrawText3Ds(Config.Places[RandomPlace].RefulingPlace.x, Config.Places[RandomPlace].RefulingPlace.y, Config.Places[RandomPlace].RefulingPlace.z+1.0, 'Press [~g~E~w~] to connect the hose.')
																end

																if(IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false)) and tube then
																	local trunkpos = GetOffsetFromEntityInWorldCoords(Trailer, 0, -6.0, 0)
																	CanRopeOut = false
																	RopeUnloadTextures()
																	DeleteRope(rope)

																	FreezeEntityPosition(ped, true)
																	startAnim(ped, 'mini@repair', 'fixing_a_ped')
																	Citizen.Wait(1000)
																	ClearPedTasks(ped)
																	FreezeEntityPosition(ped, false)
																	
																	for i=1, 3 do
																		Citizen.Wait(5)
																		RopeLoadTextures()
																	end

																	rope = AddRope(trunkpos.x, trunkpos.y, trunkpos.z, 0.0, 0.0, 0.0, 10.0, 3, 4.0, 1.0, 0, 0, 0, 0, 0, 0, 0)
																	
																	local coordspack = GetEntityCoords(tank)
																	local length = GetRopeLength(rope)
																	AttachEntitiesToRope(rope, Trailer, tank, trunkpos.x, trunkpos.y, trunkpos.z-1.0, coordspack.x, coordspack.y, coordspack.z, length)
																		
																	meter()
																	while true do 	
																		local ped = PlayerPedId()
																		local coords = GetEntityCoords(ped)
																		if(GetDistanceBetweenCoords(coords,trunkpos.x, trunkpos.y, trunkpos.z, true) < 10.0) then
																			sleep = 0
																			DrawText3Ds(Config.Places[RandomPlace].RefulingPlace.x, Config.Places[RandomPlace].RefulingPlace.y, Config.Places[RandomPlace].RefulingPlace.z, number.."~g~%")
																		end
																		if number >= 100 then
																			number = 1
																			break
																		end
																		Citizen.Wait(sleep)
																	end

																	exports.pNotify:SendNotification({text = "<b>Boss</b></br>Fueled station go inform the station employee.", timeout = 4500})

																	RemoveBlip(RefulingPlaceBlip)

																	RopeUnloadTextures()
																	DeleteRope(rope)

																	done = true

																	tube = false

																	CanRopeOut = false

																	break
																end			
															end
														else
															if CanRopeOut then
																CanRopeOut = false
															end
														end
														if not JobStarted or not VehicleOut then
															break
														end
														-- if GetVehicleBodyHealth(Trailer) < 1 then
														-- 	exports.pNotify:SendNotification({text = "<b>Boss</b></br>Your trailer has been damaged, go get a new one to the manager.", timeout = 4500})
														-- 	job = false
											
														-- 	ManagerBlip = AddBlipForCoord(Config.tanker['Manager'].Pos.x, Config.tanker['Manager'].Pos.y, Config.tanker['Manager'].Pos.z)
														-- 	SetBlipSprite (ManagerBlip, 133)
														-- 	SetBlipDisplay(ManagerBlip, 4)
														-- 	SetBlipScale  (ManagerBlip, 0.8)
														-- 	SetBlipColour (ManagerBlip, 0)
														-- 	SetBlipAsShortRange(ManagerBlip, true)
														-- 	BeginTextCommandSetBlipName("STRING")
														-- 	AddTextComponentString('Manager')
														-- 	EndTextCommandSetBlipName(ManagerBlip)
				
														-- 	RemoveBlip(RefuelingBlip)
														-- 	RemoveBlip(StationBlip)
				
														-- 	DeletePed(StationNPC)
														-- 	DeleteObject(tank)

														-- 	CanRopeOut = false

														-- 	tube = false

														-- 	RopeUnloadTextures()
														-- 	DeleteRope(rope)
				
														-- 	CreateWork()
											
														-- 	break 
														-- end 
														Citizen.Wait(sleep)
													end

												elseif(IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false)) and done then 

													QBCore.Functions.TriggerCallback('dream-tanker:payout', function(money)
														exports.pNotify:SendNotification({text = "<b>Client</b></br>Thank you, your boss is calling you to go to the next station. Refuel the trailer on the base!.", timeout = 4000})
														Citizen.Wait(4500)
														exports.pNotify:SendNotification({text = "<b>Boss</b></br>It's a job for you "..money.."$, come to the base for another delivery.", timeout = 4000})

														RemoveBlip(StationBlip)

														DeletePed(StationNPC)

														DeleteObject(tank)

														done = false
													end)
													break
												end
											end
										end
										if not JobStarted or not VehicleOut then
											break
										end
										-- if GetVehicleBodyHealth(Trailer) < 1 then
										-- 	exports.pNotify:SendNotification({text = "<b>Boss</b></br>Your trailer has been damaged, go get a new one to the manager.", timeout = 4500})
										-- 	job = false
							
										-- 	ManagerBlip = AddBlipForCoord(Config.tanker['Manager'].Pos.x, Config.tanker['Manager'].Pos.y, Config.tanker['Manager'].Pos.z)
										-- 	SetBlipSprite (ManagerBlip, 133)
										-- 	SetBlipDisplay(ManagerBlip, 4)
										-- 	SetBlipScale  (ManagerBlip, 0.8)
										-- 	SetBlipColour (ManagerBlip, 0)
										-- 	SetBlipAsShortRange(ManagerBlip, true)
										-- 	BeginTextCommandSetBlipName("STRING")
										-- 	AddTextComponentString('Manager')
										-- 	EndTextCommandSetBlipName(ManagerBlip)

										-- 	RemoveBlip(RefuelingBlip)
										-- 	RemoveBlip(StationBlip)

										-- 	DeletePed(StationNPC)
										-- 	DeleteObject(tank)

										-- 	CreateWork()
							
										-- 	break 
										-- end
									Citizen.Wait(sleep)
								end
								break								
							else
								exports.pNotify:SendNotification({text = "<b>Boss</b></br>You don't have a trailer with you.", timeout = 4500})
							end
						else
							exports.pNotify:SendNotification({text = "<b>Boss</b></br>It's not your truck.", timeout = 4500})
						end
					end
				end
			end
			if not JobStarted or not VehicleOut then
				break
			end
			-- if GetVehicleBodyHealth(Trailer) < 1 then
			-- 	exports.pNotify:SendNotification({text = "<b>Boss</b></br>Your trailer has been damaged, go get a new one to the manager.", timeout = 4500})
			-- 	job = false

			-- 	ManagerBlip = AddBlipForCoord(Config.tanker['Manager'].Pos.x, Config.tanker['Manager'].Pos.y, Config.tanker['Manager'].Pos.z)
			-- 	SetBlipSprite (ManagerBlip, 133)
			-- 	SetBlipDisplay(ManagerBlip, 4)
			-- 	SetBlipScale  (ManagerBlip, 0.8)
			-- 	SetBlipColour (ManagerBlip, 0)
			-- 	SetBlipAsShortRange(ManagerBlip, true)
			-- 	BeginTextCommandSetBlipName("STRING")
			-- 	AddTextComponentString('Manager')
			-- 	EndTextCommandSetBlipName(ManagerBlip)

			-- 	CreateWork()
			-- 	break 
			-- end
		Citizen.Wait(sleep)
	end
	if JobStarted then
		Work()
	end
end

Citizen.CreateThread(function ()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)	
		local sleep = 500
			if CanRopeOut and not IsPedInAnyVehicle(ped, false) then
				sleep = 4
				local trunkpos = GetOffsetFromEntityInWorldCoords(Trailer, 0, -6.0, 0)
				
				if(GetDistanceBetweenCoords(coords.x, coords.y, coords.z, trunkpos.x, trunkpos.y, trunkpos.z, true) < 2.5) and not tube then
					sleep = 0
					DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z - 0.5, "To pull out the hose, press [E]")
					if(IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false)) then
						FreezeEntityPosition(ped, true)
						startAnim(ped, 'mini@repair', 'fixing_a_ped')
						Citizen.Wait(1000)
						ClearPedTasks(ped)
						FreezeEntityPosition(ped, false)
						tube = true

						for i=1, 3 do
							Citizen.Wait(5)
							RopeLoadTextures()
						end	
						
						rope = AddRope(trunkpos.x, trunkpos.y, trunkpos.z, 0.0, 0.0, 0.0, 10.0, 3, 1.0, 1.0, 0, 0, 0, 0, 0, 0, 0)

						AttachEntitiesToRope(rope, Trailer, ped, trunkpos.x, trunkpos.y, trunkpos.z-1.0, coords.x, coords.y, coords.z, 1.0)																										
						StartRopeWinding(rope)
						ActivatePhysics(rope)
						RopeForceLength(rope, 4.0)	
					end	
				elseif(GetDistanceBetweenCoords(coords.x, coords.y, coords.z, trunkpos.x, trunkpos.y, trunkpos.z, true) < 2.5) and tube then 	
					sleep = 0
					DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z - 0.5, "To hide the hose, press [E]")	
					if(IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false)) then
						FreezeEntityPosition(ped, true)
						startAnim(ped, 'mini@repair', 'fixing_a_ped')
						Citizen.Wait(1000)
						ClearPedTasks(ped)
						FreezeEntityPosition(ped, false)
						tube = false
						RopeUnloadTextures()
						DeleteRope(rope)
					end
				end

			end
		Citizen.Wait(sleep)
	end
end)

function meter()
	Citizen.CreateThread(function()
		for i=1, 100 do
			Citizen.Wait(100)
			number = i
		end	
	end)
end

loadDict = function(dict, anim)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

function Randomize(tb)
	local keys = {}
	for k in pairs(tb) do table.insert(keys, k) end
	return tb[keys[math.random(#keys)]]
end

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

RegisterNetEvent('dream-tanker:sound')
AddEventHandler('dream-tanker:sound', function(name, vol)
    SendNUIMessage({
        transactionType     = 'playSound',
        transactionFile     = name,
        transactionVolume   = vol
    })
end)

function startAnim(ped, dictionary, anim)
	Citizen.CreateThread(function()
	  RequestAnimDict(dictionary)
	  while not HasAnimDictLoaded(dictionary) do
		Citizen.Wait(0)
	  end
		TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, -1, 50, 0, false, false, false)
	end)
end


--##############################

function IsSpawnPointClear(coords, radius)
	local vehicles = GetVehiclesInArea(coords, radius)

	return #vehicles == 0
end

function GetVehicles()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

function GetClosestVehicle(coords)
	local vehicles        = GetVehicles()
	local closestDistance = -1
	local closestVehicle  = -1
	local coords          = coords

	if coords == nil then
		local playerPed = PlayerPedId()
		coords          = GetEntityCoords(playerPed)
	end

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end

	return closestVehicle, closestDistance
end

function GetVehiclesInArea(coords, area)
	local vehicles       = GetVehicles()
	local vehiclesInArea = {}

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if distance <= area then
			table.insert(vehiclesInArea, vehicles[i])
		end
	end

	return vehiclesInArea
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

--##############################