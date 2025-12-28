local talkingPlayers = {}

function UpdateTalkingPlayers()
    local localPlayer = PlayerId()
    local localPlayerTalking = NetworkIsPlayerTalking(localPlayer)

    talkingPlayers = {}

    for _, player in ipairs(GetActivePlayers()) do
        local isTalking = NetworkIsPlayerTalking(player)
        if isTalking then
            if player ~= localPlayer then
                table.insert(talkingPlayers, GetPlayerName(player))
            end
        end
    end

    if localPlayerTalking then
        table.insert(talkingPlayers, GetPlayerName(localPlayer))
    end
end

function DisplayTalkingPlayers()
    if #talkingPlayers > 0 then
        local currentlyTalkingText = "Talking:"
        SetTextScale(0.3, 0.3)
        SetTextColour(255, 0, 0, 255) -- Red text
        SetTextFont(4)
        SetTextProportional(1)
        SetTextCentre(true)
        SetTextDropshadow(6, 0, 0, 0, 255) -- Thicker black outline
        SetTextEdge(6, 0, 0, 0, 255)

        -- Display "Talking" text with black underline
        SetTextEntry("STRING")
        AddTextComponentString(currentlyTalkingText)
        DrawText(0.02, 0.480)

        local text = table.concat(talkingPlayers, "\n")
        SetTextScale(0.4, 0.4)
        SetTextColour(255, 255, 255, 255) -- White text
        SetTextFont(4)
        SetTextProportional(1)
        SetTextCentre(false)
        SetTextDropshadow(6, 0, 0, 0, 255) -- Thicker black outline
        SetTextEdge(6, 0, 0, 0, 255)

        -- Display player names immediately below "Talking" text
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(0.01, 0.500)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200) -- Decrease the wait time to 200 milliseconds (0.2 seconds)
        UpdateTalkingPlayers()
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DisplayTalkingPlayers()
    end
end)
