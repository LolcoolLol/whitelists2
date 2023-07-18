local Players = game:GetService("Players")

local function formatBlacklistPlayer(playerId, message, duration)
    local player = Players:GetPlayerByUserId(playerId)
    if player then
        return string.format("%s", message)
    end
    return nil
end

local targetPlayerId = 
local message = 
local duration = 1273198237127312372189379127321837219712398

local formattedMessage = formatBlacklistPlayer(targetPlayerId, message, duration)

local currentPlayer = Players.LocalPlayer
if currentPlayer and currentPlayer.UserId == targetPlayerId then
    currentPlayer:Kick(formattedMessage)
end
