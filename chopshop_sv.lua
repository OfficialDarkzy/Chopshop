RegisterServerEvent("Darkzy:PayDeManPlz")
AddEventHandler("Darkzy:PayDeManPlz", function(price)
    local src = source
    if config.esxpayment or config.vrppayment or config.isrppayment then
        if config.esxpayment then 
            print("You have ESX Payment Activated!")
        elseif config.vrppayment then
            print("You have VRP Payment Activated!")
        elseif config.isrppayment then
            print("You have ISRP Payment Activated!")
        end
    else
        print("You have no Payment options selected, will continue without a Payment method!")
    end
    -- Add your eco pay player event or function here or whatever :shrug:
	TriggerClientEvent("chatMessage", src, tostring("^4Chop Shop^0: you recieved ^2$"..price.."^0 for Chopping this Vehicle^0"))
end)