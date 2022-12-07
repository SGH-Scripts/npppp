local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	Citizen.CreateThread(function()
		FetchSkills()
		while true do
			local seconds = Config.UpdateFrequency * 1000
			Citizen.Wait(seconds)
			for skill, value in pairs(Config.Skills) do
				UpdateSkill(skill, value["RemoveAmount"])
			end
			TriggerServerEvent("skillsystem:update", json.encode(Config.Skills))
		end
	end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
	for skill, value in pairs(Config.Skills) do
		Config.Skills[skill]["Current"] = 0
	end
end)
end)

AddEventHandler('onResourceStart', function(resource)
   if resource == GetCurrentResourceName() then
	  Wait(100)
	  FetchSkills()
   end
end)

-------------------
--HOSTILES NATIVE--
-------------------

RegisterNetEvent('mz-skills:client:SpawnShooters', function(position)
    QBCore.Functions.TriggerCallback('mz-skills:server:SpawnShooters', function(netIds, position)
        Wait(1000)
        local ped = PlayerPedId()
        for i=1, #netIds, 1 do
            local npc = NetworkGetEntityFromNetworkId(netIds[i])
            SetPedDropsWeaponsWhenDead(npc, false)
            GiveWeaponToPed(npc, Config.PedGun2, 250, false, true)
            SetPedMaxHealth(npc, 300)
            SetPedArmour(npc, 200)
            SetCanAttackFriendly(npc, true, false)
            TaskCombatPed(npc, ped, 0, 16)
            SetPedCombatAttributes(npc, 46, true)
            SetPedCombatAttributes(npc, 0, false)
            SetPedCombatAbility(npc, 100)
            SetPedAsCop(npc, true)
            SetPedRelationshipGroupHash(npc, `HATES_PLAYER`)
            SetPedAccuracy(npc, 60)
            SetPedFleeAttributes(npc, 0, 0)
            SetPedKeepTask(npc, true)
            SetBlockingOfNonTemporaryEvents(npc, true)
        end
    end, position)
end)