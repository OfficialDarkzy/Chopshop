local randomVehicles = {
    {model = "ADDER", price = 2300},
    {model = "SANDKING", price = 800},
    {model = "LANDSTAL", price = 1000},
    {model = "SUPERDIAMOND", price = 1600},
    {model = "SABREGT", price = 900},
    {model = "PANTO", price = 750}
    -- Add more vehicles you want.
}

local chopShopLocations = {
    {x = 480.47, y = -1317.82, z = 29.2}
    -- Add More if you want :D
}

local selectRandomVehicle = randomVehicles[math.random(1, #randomVehicles)]
local timer = false
Citizen.CreateThread(function()
    for _, item in pairs(chopShopLocations) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, 72)
		SetBlipColour(item.blip, 1)
		SetBlipScale(item.blip, 0.8)
		SetBlipAsShortRange(item.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Chop Shop")
		EndTextCommandSetBlipName(item.blip)
	end
    while true do
        Citizen.Wait(1)
        for a = 1, #chopShopLocations do
            local ped = GetPlayerPed(PlayerId())
            local pedPos = GetEntityCoords(ped, false)
            local distance = Vdist(pedPos.x, pedPos.y, pedPos.z, chopShopLocations[a].x, chopShopLocations[a].y, chopShopLocations[a].z)
            local vehicle = IsPedInAnyVehicle(ped, false)
            if distance <= 30.0 then
                    DrawMarker(1, chopShopLocations[a].x, chopShopLocations[a].y, chopShopLocations[a].z - 1, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 0.5001, 1555, 0, 0,165, 0, 0, 0,0)
                if distance <= 2.0 then
                    if not timer then
                        drawText('Press ~r~E~s~ to get a Vehicle to find!',0,1,0.5,0.8,0.6,255,255,255,255)
                        if IsControlJustPressed(1, 86) then
                            Countdown = GetGameTimer() + 600 * 1000
                            timer = true
                            if selectRandomVehicle.model == "LANDSTAL" then
                                TriggerEvent('chatMessage', 'Chop Shop', {255, 123, 0}, "^4Find the Chop Shop a LANDSTALKER")
                            else
                                TriggerEvent('chatMessage', 'Chop Shop', {255, 123, 0}, "^4Find the Chop Shop a "..selectRandomVehicle.model.."")
                            end
                        end
                    elseif timer and vehicle ~= false then
                        drawText('Press ~r~E~s~ to Chop Vehicle',0,1,0.5,0.8,0.6,255,255,255,255)
                        local currentVeh = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(PlayerId()))))
                        if IsControlJustPressed(1, 86) then
                            if currentVeh == selectRandomVehicle.model then
                                timer = false
                                TriggerServerEvent("Darkzy:PayDeManPlz", selectRandomVehicle.price)
                                local vehicleIn = GetVehiclePedIsUsing(ped)
                                deleteCar(vehicleIn)
                            else
                                TriggerEvent("ISRP_Notification:Error", "Chop Shop", "This is not the right Vehicle", 5000, false, "leftCenter")
                            end
                        end
                    elseif timer then
                        local secsRemaining = math.ceil((Countdown - GetGameTimer()) / 1000)
                        secsRemaining = secsRemaining - 1
                        if secsRemaining > 0 then
                            drawText('Please wait ~r~'..secsRemaining..'~w~ until you can get a new Vehicle',0,1,0.5,0.8,0.6,255,255,255,255)
                        else
                            timer = false
                            print(timer)
                        end
                    end
                end
            end
        end
    end
end)

function deleteCar( vehicle )
	Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( vehicle ) )
end

function drawText(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
    DrawText(x , y)
end