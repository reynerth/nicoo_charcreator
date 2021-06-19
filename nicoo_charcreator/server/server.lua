ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('nicoo_charcreator:getGroup', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getGroup())
  
end)