Config = {}

-- Framework
Config.Framework = "esx"

-- HUD
Config.EnableHud = true
Config.ShowMinimap = true
Config.CircleMap = true
Config.ShowCompass = true
Config.ShowStreet = true
Config.ShowClock = true
Config.ShowPlayerID = true

-- Status
Config.ShowHealth = true
Config.ShowArmor = true
Config.ShowHunger = true
Config.ShowThirst = true
Config.ShowStress = true
Config.ShowStamina = true
Config.ShowVoice = true
Config.ShowFuel = true

-- Vehicle HUD
Config.EnableVehicleHud = true
Config.ShowSpeed = true
Config.SpeedUnit = "MPH" -- MPH or KMH
Config.ShowRPM = true
Config.ShowGear = true
Config.ShowSeatbelt = true
Config.ShowEngine = true
Config.ShowFuelLevel = true

-- Seatbelt
Config.SeatbeltKey = "B"
Config.SeatbeltEject = true
Config.MinimumEjectSpeed = 55

-- Voice
Config.VoiceScript = "pma-voice"

Config.VoiceRanges = {
    [1] = 2.5,
    [2] = 8.0,
    [3] = 20.0
}

-- Fuel
Config.FuelScript = "ox_fuel"

-- Inventory
Config.Inventory = "ox_inventory"

-- Banking
Config.Banking = "renewed"

-- Notifications
Config.Notify = "ox_lib"

-- Stress
Config.EnableStress = true
Config.MaxStress = 100

-- Compass
Config.CompassFollowCamera = true
Config.ShowHeadingDegrees = false

-- Minimap
Config.MinimapZoom = 1100

-- Vehicle Cruise Control
Config.EnableCruiseControl = true
Config.CruiseKey = "Y"

-- Cinematic Mode
Config.EnableCinematic = true
Config.CinematicKey = "F10"

-- HUD Toggle
Config.ToggleHudCommand = "hud"
Config.ToggleHudKey = "F9"

-- Debug
Config.Debug = false
