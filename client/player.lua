-------------------------------------
-- DG-HUD Player Information
-------------------------------------

local ESX = exports['es_extended']:getSharedObject()

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob', function(job)
    PlayerData.job = job
end)

CreateThread(function()

    while true do

        Wait(1000)

        if not LocalPlayer.state.isLoggedIn then
            goto continue
        end

        local jobName = "Unemployed"
        local jobGrade = ""
        local duty = "Off Duty"

        if PlayerData.job then
            jobName = PlayerData.job.label or PlayerData.job.name
            jobGrade = PlayerData.job.grade_label or ""

            if PlayerData.job.onDuty ~= nil then
                duty = PlayerData.job.onDuty and "On Duty" or "Off Duty"
            else
                duty = "On Duty"
            end
        end

        local cash = exports.ox_inventory:Search('count', 'money') or 0
        local bank = 0
        local dirty = exports.ox_inventory:Search('count', 'black_money') or 0

        -- Replace this export if you're using a different banking resource
        if exports['Renewed-Banking'] then
            local account = exports['Renewed-Banking']:getAccountMoney('bank')

            if account then
                bank = account
            end
        end

        SendNUIMessage({

            action = "player",

            id = GetPlayerServerId(PlayerId()),

            cash = cash,

            bank = bank,

            dirty = dirty,

            job = jobName,

            grade = jobGrade,

            duty = duty,

            online = #GetActivePlayers(),

            maxPlayers = GetConvarInt("sv_maxclients", 64)

        })

        -- Send server clock to NUI
        SendNUIMessage({
            action = "clock",
            time = os.date("%I:%M %p")
        })

        ::continue::

    end

end)
