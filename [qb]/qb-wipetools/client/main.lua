local QBCore = exports['qb-core']:GetCoreObject()

------------
-- Events --
------------
RegisterNetEvent('qb-wipetools:client:sendcarsemail')
AddEventHandler('qb-wipetools:client:sendcarsemail', function()

    QBCore.Functions.TriggerCallback('qb-wipetools:server:getoldvehicles', function(result)
        if result == nil or result[1] == nil then
            QBCore.Functions.Notify("Could not find any cars to import", "error", 10000)
        else
            str = "To import a car, type <b>/importcar PLATEHERE</b><br><br>Example: <b>/importcar</b> GAO23948<br><br>IMPORT LIST<br><ul>"

            for k,v in pairs(result) do
                local model = v.vehicle
                local plate = v.plate

                str = str.."<li>Model: "..model..", Plate: "..plate.."</li>"
            end
            str = str.."</ul>"

            TriggerServerEvent('qb-phone:server:sendNewMail', {
                sender = "Andy's Import Service",
                subject = "List of cars to import",
                message = str,
                button = {}
            })
        end
    end)
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