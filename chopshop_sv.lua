RegisterServerEvent("Darkzy:PayDeManPlz")
AddEventHandler("Darkzy:PayDeManPlz", function(price)
    local src = source
    -- Add your eco pay player event or function here or whatever :shrug:
	TriggerClientEvent("chatMessage", src, tostring("^4Chop Shop^0: you recieved ^2$"..price.."^0 for Chopping this Vehicle^0"))
end)