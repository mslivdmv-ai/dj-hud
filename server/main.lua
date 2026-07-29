-------------------------------------
-- DG-HUD Server
-------------------------------------

local ESX = exports["es_extended"]:getSharedObject()

DGHUD = {}

DGHUD.Version = "1.0.0"

-------------------------------------
-- Helpers
-------------------------------------

local PlayerSettings = {}

local function GetIdentifierFromSource(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer and xPlayer.identifier then
        return xPlayer.identifier
    end
    return nil
end

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
-- Save HUD Preferences (by identifier)
-------------------------------------

RegisterNetEvent("dg-hud:saveSettings", function(settings)

    local src = source
    local identifier = GetIdentifierFromSource(src)
    if not identifier then return end

    PlayerSettings[identifier] = settings

    -- Persist to DB when enabled
    if Config and Config.SaveSettings then
        local ok, jsonSettings = pcall(function() return json.encode(settings) end)
        if ok and jsonSettings then
            -- Use oxmysql to insert or update
            exports.oxmysql:execute(
                "INSERT INTO `" .. Config.SettingsTable .. "` (`identifier`,`settings`) VALUES (?, ?) ON DUPLICATE KEY UPDATE `settings` = ?",
                { identifier, jsonSettings, jsonSettings }
            )
        end
    end

end)

lib.callback.register("dg-hud:getSettings", function(source)

    local identifier = GetIdentifierFromSource(source)
    if not identifier then
        return {
            theme = "purple",
            minimap = true,
            cinematic = false,
            speedUnit = (Config and Config.SpeedUnit) or "MPH",
            compass = true,
            vehicleHud = true
        }
    end

    -- in-memory
    if PlayerSettings[identifier] then
        return PlayerSettings[identifier]
    end

    -- try DB
    if Config and Config.SaveSettings then
        local result = exports.oxmysql:executeSync("SELECT settings FROM `" .. Config.SettingsTable .. "` WHERE identifier = ?", { identifier })
        if result and result[1] and result[1].settings then
            local ok, decoded = pcall(function() return json.decode(result[1].settings) end)
            if ok and decoded then
                PlayerSettings[identifier] = decoded
                return decoded
            end
        end
    end

    -- fallback default
    return {
        theme = "purple",
        minimap = true,
        cinematic = false,
        speedUnit = (Config and Config.SpeedUnit) or "MPH",
        compass = true,
        vehicleHud = true
    }

end)

-------------------------------------
-- Cleanup
-------------------------------------

AddEventHandler("playerDropped", function(reason)
    local src = source
    local identifier = GetIdentifierFromSource(src)
    if identifier then
        PlayerSettings[identifier] = nil
    end
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
    local identifier = GetIdentifierFromSource(id)
    if not identifier then return nil end
    return PlayerSettings[identifier]
end)

exports("SetPlayerSettings", function(id,data)
    local identifier = GetIdentifierFromSource(id)
    if not identifier then return end
    PlayerSettings[identifier] = data
end)
