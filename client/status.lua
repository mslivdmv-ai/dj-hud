local hunger = 100
local thirst = 100
local stress = 0

-- ESX Status
RegisterNetEvent('esx_status:onTick', function(data)
    for _, status in pairs(data) do
        if status.name == 'hunger' then
            hunger = math.floor(status.percent)
        elseif status.name == 'thirst' then
            thirst = math.floor(status.percent)
        end
    end
end)

-- Stress (compatible with most police/job scripts)
RegisterNetEvent('dg-hud:setStress', function(value)
    stress = math.max(0, math.min(100, value))
end)

exports('SetStress', function(value)
    stress = math.max(0, math.min(100, value))
end)

CreateThread(function()
    while true do
        Wait(500)

        if not PlayerLoaded then
            goto continue
        end

        local ped = PlayerPedId()

        SendNUIMessage({
            action = "status",
            hunger = hunger,
            thirst = thirst,
            stress = stress,
            stamina = math.floor(100 - GetPlayerSprintStaminaRemaining(PlayerId()))
        })

        ::continue::
    end
end)
