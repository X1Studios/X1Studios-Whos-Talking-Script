local talkingPlayers = {}

function UpdateTalkingPlayers()
    local localPlayer = PlayerId()
    local localPlayerTalking = NetworkIsPlayerTalking(localPlayer)

    talkingPlayers = {}

    for _, player in ipairs(GetActivePlayers()) do
        local isTalking = NetworkIsPlayerTalking(player)
        if isTalking then
            if player ~= localPlayer then
                local name = GetPlayerName(player)
                local id = GetPlayerServerId(player)
                table.insert(talkingPlayers, "[" .. id .. "] " .. name)
            end
        end
    end

    if localPlayerTalking then
        local name = GetPlayerName(localPlayer)
        local id = GetPlayerServerId(localPlayer)
        table.insert(talkingPlayers, "[" .. id .. "] " .. name)
    end
end

function DisplayTalkingPlayers()
    if #talkingPlayers > 0 then
        local currentlyTalkingText = "Talking:"
        SetTextScale(0.3, 0.3)
        SetTextColour(255, 0, 0, 255)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextCentre(true)
        SetTextDropshadow(6, 0, 0, 0, 255)
        SetTextEdge(6, 0, 0, 0, 255)

        SetTextEntry("STRING")
        AddTextComponentString(currentlyTalkingText)
        DrawText(0.02, 0.480)

        local text = table.concat(talkingPlayers, "\n")
        SetTextScale(0.4, 0.4)
        SetTextColour(255, 255, 255, 255)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextCentre(false)
        SetTextDropshadow(6, 0, 0, 0, 255)
        SetTextEdge(6, 0, 0, 0, 255)

        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(0.01, 0.500)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        UpdateTalkingPlayers()
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DisplayTalkingPlayers()
    end
end)
