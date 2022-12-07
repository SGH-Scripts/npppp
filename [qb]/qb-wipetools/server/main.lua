local QBCore = exports['qb-core']:GetCoreObject()

------------
-- Events --
------------
RegisterServerEvent('qb-wipetools')
AddEventHandler('qb-wipetools', function(Payment)

end)

---------------
-- Callbacks --
---------------
QBCore.Functions.CreateCallback('qb-wipetools:server:getoldvehicles', function(source, cb)
    src = source

    local identifiers = GetPlayerIdentifiers(src)
    local license

    for _, v in pairs(identifiers) do
        if string.find(v, 'license') then
            license = v
            break
        end
    end

    result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles_old WHERE `license` = ? ', {license})

	cb(result)
end)

--------------
-- Commands --
--------------
QBCore.Commands.Add("importcarlist", "List all of the car imports you can import", {}, false, function(source, args)
    
    -- Variables
    src = source

    local identifiers = GetPlayerIdentifiers(src)
	local license

	for _, v in pairs(identifiers) do
        if string.find(v, 'license') then
            license = v
            break
        end
    end

    if Config.AllowVehicleImports == true then
        
        -- Let's see if the person exists in the metadata
        --
        result = MySQL.Sync.fetchAll('SELECT * FROM wipe_tools_vehicles WHERE `identifier` = ? ', {license})

        if result == nil or result[1] == nil then

            -- Insert them into the DB
            result = MySQL.Sync.fetchAll('INSERT INTO wipe_tools_vehicles (`identifier`) VALUES (?)', {license})

        end

        -----------------

        -- Now let's check to see how many redeems we have
        redeems = MySQL.Sync.fetchAll('SELECT redeems_allowed FROM wipe_tools_vehicles WHERE `identifier` = ? ', {license})

        if redeems ~= nil and redeems[1] ~= nil then
            redeems = redeems[1].redeems_allowed
        end

        if redeems > 0 then
            TriggerClientEvent("qb-wipetools:client:sendcarsemail", src)
        end

    end

end)

QBCore.Commands.Add("importcar", "Import a car from previous eco", {{name='plate', help='plate you want to import'}}, false, function(source, args)
    
    -- Variables
    src = source
    plate = args[1]

    local identifiers = GetPlayerIdentifiers(src)
	local license

	for _, v in pairs(identifiers) do
        if string.find(v, 'license') then
            license = v
            break
        end
    end

    if Config.AllowVehicleImports == true then
        
        -- Let's see if the person exists in the metadata
        --
        result = MySQL.Sync.fetchAll('SELECT * FROM wipe_tools_vehicles WHERE `identifier` = ? ', {license})

        if result == nil or result[1] == nil then

            -- Insert them into the DB
            result = MySQL.Sync.fetchAll('INSERT INTO wipe_tools_vehicles (`identifier`) VALUES (?)', {license})

        end

        -- Now let's check to see how many redeems we have
        redeems = MySQL.Sync.fetchAll('SELECT redeems_allowed FROM wipe_tools_vehicles WHERE `identifier` = ? ', {license})

        if redeems ~= nil and redeems[1] ~= nil then
            redeems = redeems[1].redeems_allowed
        end

        if redeems > 0 then

            result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles_old WHERE `plate` = ? ', {plate})

            -- Current Player Ped
            local Player = QBCore.Functions.GetPlayer(src)

            -- Citizen ID
            local CitizenID = Player.PlayerData.citizenid
            local Vehicle = result[1].vehicle
            local Hash = result[1].hash
            local Mods = result[1].mods
            local Garage = "motelgarage"

            insert = MySQL.Sync.fetchAll('INSERT INTO player_vehicles (`license`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `garage`) VALUES (?,?,?,?,?,?,?)', {license, CitizenID, Vehicle, Hash, Mods, plate, Garage})

            if insert.affectedRows == 1 then

                -- Notify the player
                TriggerClientEvent('QBCore:Notify', src, "Successfully imported car back to garage: "..Garage)

                -- Take away a redeem
                local updateSql = [[
                    UPDATE `wipe_tools_vehicles`
                    SET redeems_allowed = redeems_allowed-1
                    WHERE identifier = @license
                ]]

                local updatedRedeem = exports.oxmysql:executeSync(updateSql, {
                    ["@license"] = license
                })

                TriggerEvent('qb-log:server:CreateLog', 'v4import', 'Redeemed', 'red', ('**%s** (%s) redeemed %s (%s).'):format(GetPlayerName(source), license, Vehicle, plate))

            end

        else
            TriggerClientEvent('QBCore:Notify', src, "You have no more redeems left!", 'error', 10000)
        end

    end

end)


---------------
-- Functions --
---------------
function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end