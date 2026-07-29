local seatbelt = false
local cruiseControl = false

-- Toggle Seatbelt
RegisterCommand("+seatbelt", function()
    if not IsPedInAnyVehicle(PlayerPedId(), false) then return end

    seatbelt = not seatbelt

    SendNUIMessage({
        action = "seatbelt",
        state = seatbelt
    })

    lib.notify({
        title = "Seatbelt",
        description = seatbelt and "Seatbelt Fastened" or "Seatbelt Unfastened",
        type = seatbelt and "success" or "inform"
    })
end, false)

RegisterCommand("-seatbelt", function() end, false)
RegisterKeyMapping("+seatbelt", "Toggle Seatbelt", "keyboard", Config.SeatbeltKey)

-- Toggle Cruise Control
RegisterCommand("+cruise", function()
    if not IsPedInAnyVehicle(PlayerPedId(), false) then return end

    cruiseControl = not cruiseControl

    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

    if cruiseControl then
        SetVehicleMaxSpeed(vehicle, GetEntitySpeed(vehicle))
    else
        SetVehicleMaxSpeed(vehicle, 0.0)
    end

    SendNUIMessage({
        action = "cruise",
        state = cruiseControl
    })
end, false)

RegisterCommand("-cruise", function() end, false)
RegisterKeyMapping("+cruise", "Toggle Cruise Control", "keyboard", Config.CruiseKey)

-- Vehicle HUD Update
CreateThread(function()
    while true do
        Wait(100)

        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)

            local speed = GetEntitySpeed(vehicle)
            local fuel = exports.ox_fuel and exports.ox_fuel:GetFuel(vehicle) or 0

            if Config.SpeedUnit == "MPH" then
                speed = math.floor(speed * 2.236936)
            else
                speed = math.floor(speed * 3.6)
            end

            SendNUIMessage({
                action = "vehicleUpdate",
                show = true,
                speed = speed,
                rpm = math.floor(GetVehicleCurrentRpm(vehicle) * 100),
                gear = GetVehicleCurrentGear(vehicle),
                fuel = math.floor(fuel),
                engine = math.floor(GetVehicleEngineHealth(vehicle)),
                body = math.floor(GetVehicleBodyHealth(vehicle)),
                headlights = GetVehicleLightsState(vehicle),
                seatbelt = seatbelt,
                cruise = cruiseControl
            })
        else
            cruiseControl = false

            SendNUIMessage({
                action = "vehicleUpdate",
                show = false
            })
        end
    end
end)
