local sprite = require ("source.graphics.sprite")
local entity = require ("source.logic.entity")
local followPlayer = require ("source.logic.ai.movement.follow_player")
local bounceAfterPlayer = require ("source.logic.ai.movement.bounce_after_player")

local karen = {}

local karenSprite = sprite.create("assets/sprites/entities/mobs/karen.png")

local speed = 32
local fast = 2
local slow = 0.5

karen.create = function (xPos, yPos, zPos)
    return entity.create(karenSprite, xPos, yPos, zPos, speed, followPlayer, slow, fast)
end

return karen