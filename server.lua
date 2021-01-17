ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('SimpleDispatch:sendDispatch')
AddEventHandler('SimpleDispatch:sendDispatch', function(targetData, message, playerCoords)
    TriggerClientEvent('SimpleDispatch:jobDispatch', -1, targetData, message, playerCoords)
end)