RegisterServerEvent("Opticom:TriggeredOnCoords")
AddEventHandler("Opticom:TriggeredOnCoords", function(id, coords)
	TriggerClientEvent('Opticom:TriggeredOnCoords', -1, id, coords)
end)

print("OPTICOMSYSTEM ^1Has Authenticated ^2Successfully! ^0By ^1ToxicScripts! ^7")