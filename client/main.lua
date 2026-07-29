local ESX = exports['es_extended']:getSharedObject()

local PlayerLoaded = false
local HudVisible = true

-- Wait for player to load
RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    PlayerLoaded = true

    SendNUIMessage({
        action = "playerLoaded"
    })
end)

AddEventHandler('onClientResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end

    Wait(1000)

    if LocalPlayer.state.isLoggedIn then
        PlayerLoaded = true
    end

    DisplayRadar(Config.ShowMinimap)
end)

-- Toggle HUD
RegisterCommand(Config.ToggleHudCommand, function()
    HudVisible = not HudVisible

    SendNUIMessage({
        action = "toggleHud",
        state = HudVisible
    })

    lib.notify({
        title = "DG-HUD",
        description = HudVisible and "HUD Enabled" or "HUD Disabled",
        type = "success"
    })
end)

RegisterKeyMapping(
    Config.ToggleHudCommand,
    "Toggle HUD",
    "keyboard",
    Config.ToggleHudKey
)

CreateThread(function()
    while true do
        Wait(250)

        if PlayerLoaded then
            local ped = PlayerPedId()

            SendNUIMessage({
                action = "updatePlayer",
                health = GetEntityHealth(ped) - 100,
                armor = GetPedArmour(ped),
                stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
                talking = NetworkIsPlayerTalking(PlayerId())
            })
        end
    end
end)

CreateThread(function()
    while true do
        Wait(100)

        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)

            local speed = GetEntitySpeed(vehicle)

            if Config.SpeedUnit == "MPH" then
                speed = math.floor(speed * 2.236936)
            else
                speed = math.floor(speed * 3.6)
            end

            SendNUIMessage({
                action = "vehicle",
                show = true,
                speed = speed,
                gear = GetVehicleCurrentGear(vehicle),
                rpm = GetVehicleCurrentRpm(vehicle),
                engine = GetIsVehicleEngineRunning(vehicle)
            })
        else
            SendNUIMessage({
                action = "vehicle",
                show = false
            })
        end
    end
end)
