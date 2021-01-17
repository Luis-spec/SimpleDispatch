ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = ESX.GetPlayerData()
	PlayerData = xPlayer
	PlayerData.job = xPlayer.job
	PlayerLoaded = true
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


for k, v in pairs(Config.Dispatches) do

    RegisterCommand(v.number, function(source, args, raw)

        if args[1] ~= nil then
            local finalString = ""
            for k2, v2 in pairs(args) do
                finalString = finalString .. ' ' .. v2
            end

            local playerPed = PlayerPedId()
		    local playerCoords = GetEntityCoords(playerPed)
            TriggerServerEvent('SimpleDispatch:sendDispatch', v, finalString, playerCoords)
            showPictureNotification(v.picture, Strings['dispatch_infotext'], v.label, Strings['dispatch_sent'])
        else
            ShowNotification('Wrong Usage!')
        end
    
    end, false)

end

RegisterNetEvent('SimpleDispatch:jobDispatch')
AddEventHandler('SimpleDispatch:jobDispatch', function(targetData, message, playerCoords)

    if PlayerData.job ~= nil and PlayerData.job.name == targetData.job then

        local blip = AddBlipForCoord(playerCoords.x, playerCoords.y)
        SetBlipSprite(blip, Config.DispatchBlip.Sprite)
        SetBlipDisplay(blip, 6)
        SetBlipScale(blip, Config.DispatchBlip.Size)
        SetBlipColour(blip, Config.DispatchBlip.Colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING");
        AddTextComponentString(targetData.label .. Strings['blip_dispatch'])
        EndTextCommandSetBlipName(blip)

        local s1 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, playerCoords.x, playerCoords.y, playerCoords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
	    local street1 = GetStreetNameFromHashKey(s1)

        showPictureNotification(targetData.picture, Strings['location'] .. street1 .. '\n~o~' .. message , targetData.label, Strings['dispatch_subtitle'])


        Citizen.Wait(Config.BlipTimer * 1000)
        RemoveBlip(blip)
    end

end)

function showPictureNotification(icon, msg, title, subtitle)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg);
    SetNotificationMessage(icon, icon, true, 1, title, subtitle);
    DrawNotification(false, true);
end

function ShowNotification(text)
	SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
	DrawNotification(false, true)
end