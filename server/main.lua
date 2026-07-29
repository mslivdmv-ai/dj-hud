-------------------------------------
-- DG-HUD Server
-------------------------------------

local ESX = exports["es_extended"]:getSharedObject()

DGHUD = {}

DGHUD.Version = "1.0.0"

-------------------------------------
-- Callbacks
-------------------------------------

lib.callback.register("dg-hud:getPlayerData", function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        return false
    end

    local accounts = xPlayer.getAccounts()

    local bank = 0
    local cash = 0
    local dirty = 0

    for _, account in pairs(accounts) do

        if account.name == "bank" then
            bank = account.money
        elseif account.name == "money" then
            cash = account.money
        elseif account.name == "black_money" then
            dirty = account.money
        end

    end

    return {

        identifier = xPlayer.identifier,

        name = xPlayer.getName(),

        job = xPlayer.job.label,

        grade = xPlayer.job.grade_label,

        duty = true,

        cash = cash,

        bank = bank,

        dirty = dirty

    }

end)

-------------------------------------
-- Save HUD Preferences
-------------------------------------

local PlayerSettings = {}

RegisterNetEvent("dg-hud:saveSettings", function(settings)

    local src = source

    PlayerSettings[src] = settings

end)

lib.callback.register("dg-hud:getSettings", function(source)

    return PlayerSettings[source] or {

        theme = "purple",

        minimap = true,

        cinematic = false,

        speedUnit = Config.SpeedUnit,

        compass = true,

        vehicleHud = true

    }

end)

-------------------------------------
-- Cleanup
-------------------------------------

AddEventHandler("playerDropped", function()

    PlayerSettings[source] = nil

end)

-------------------------------------
-- Version
-------------------------------------

RegisterCommand("dghudversion", function(source)

    if source == 0 then

        print("^5DG-HUD Version:^7 "..DGHUD.Version)

    end

end)

-------------------------------------
-- Exports
-------------------------------------

exports("GetPlayerSettings", function(id)

    return PlayerSettings[id]

end)

exports("SetPlayerSettings", function(id,data)

    PlayerSettings[id] = data

end)
