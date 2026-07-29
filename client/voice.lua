local voiceMode = 2
local radioChannel = 0
local radioTalking = false
local talking = false

-- Voice Mode
AddEventHandler('pma-voice:setTalkingMode', function(mode)
    voiceMode = mode

    SendNUIMessage({
        action = "voiceMode",
        mode = mode
    })
end)

-- Radio Channel
AddEventHandler('pma-voice:setRadioChannel', function(channel)
    radioChannel = channel or 0

    SendNUIMessage({
        action = "radio",
        channel = radioChannel
    })
end)

-- Radio Talking
AddEventHandler('pma-voice:radioActive', function(state)
    radioTalking = state

    SendNUIMessage({
        action = "radioTalking",
        state = state
    })
end)

-- Update Voice HUD
CreateThread(function()
    while true do
        Wait(150)

        talking = NetworkIsPlayerTalking(PlayerId())

        SendNUIMessage({
            action = "voice",
            talking = talking,
            mode = voiceMode,
            radio = radioChannel,
            radioTalking = radioTalking
        })
    end
end)
