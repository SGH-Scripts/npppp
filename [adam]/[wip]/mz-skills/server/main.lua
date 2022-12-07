local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('skillsystem:fetchStatus', function(source, cb)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player then
		local status = MySQL.scalar.await('SELECT skills FROM players WHERE citizenid = ?', {Player.PlayerData.citizenid})
		if status ~= nil then
			cb(json.decode(status))
		else
			cb(nil)
		end
	else
		cb()
	end
end)

RegisterServerEvent('skillsystem:update')
AddEventHandler('skillsystem:update', function (data)
     local Player = QBCore.Functions.GetPlayer(source)
	 MySQL.query('UPDATE players SET skills = @skills WHERE citizenid = @citizenid', {
		['@skills'] = data,
		['@citizenid'] = Player.PlayerData.citizenid
	})
end)

------------
--HOSTILES--
------------

local peds = { 
    `g_m_y_famca_01`,
    `g_m_y_famdnf_01`,
}

local getRandomNPC = function()
    return peds[math.random(#peds)]
end

QBCore.Functions.CreateCallback('mz-skills:server:SpawnShooters', function(source, cb, loc)
    local netIds = {}
    local netId
    local npc
    for i=1, #Config.Shooters['soldiers'].locations[loc].peds, 1 do
        npc = CreatePed(30, getRandomNPC(), Config.Shooters['soldiers'].locations[loc].peds[i], true, false)
        while not DoesEntityExist(npc) do Wait(10) end
        netId = NetworkGetNetworkIdFromEntity(npc)
        netIds[#netIds+1] = netId
    end
    cb(netIds)
end)
