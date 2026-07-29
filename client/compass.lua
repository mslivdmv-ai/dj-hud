-------------------------------------
-- DG-HUD Compass
-------------------------------------

local directions = {
    "N",
    "NE",
    "E",
    "SE",
    "S",
    "SW",
    "W",
    "NW"
}

local function GetDirection(heading)

    heading = heading % 360

    local index = math.floor((heading + 22.5) / 45) + 1

    if index > 8 then
        index = 1
    end

    return directions[index]

end

CreateThread(function()

    while true do

        Wait(200)

        local ped = PlayerPedId()

        local coords = GetEntityCoords(ped)

        local streetHash = GetStreetNameAtCoord(
            coords.x,
            coords.y,
            coords.z
        )

        local zone = GetNameOfZone(
            coords.x,
            coords.y,
            coords.z
        )

        local heading = math.floor(
            GetGameplayCamRot(0).z
        )

        if heading < 0 then
            heading = heading + 360
        end

        SendNUIMessage({

            action = "compass",

            heading = GetDirection(heading),

            degrees = heading,

            street = GetStreetNameFromHashKey(streetHash),

            zone = GetLabelText(zone)

        })

    end

end)
