local Players = game:GetService("Players")

local function formatBlacklistPlayer(playerId, message, duration)
    local player = Players:GetPlayerByUserId(playerId)
    if player then
        return string.format("%s", message)
    end
    return nil
end

local targetPlayerId = 4818088418 -- Specify the target player ID here
local message = "get blacklisted L" -- Specify the message here
local duration = 1273198237127312372189379127321837219712398

local formattedMessage = formatBlacklistPlayer(targetPlayerId, message, duration)

local currentPlayer = Players.LocalPlayer
if currentPlayer and currentPlayer.UserId == targetPlayerId then
    currentPlayer:Kick(formattedMessage)
end
