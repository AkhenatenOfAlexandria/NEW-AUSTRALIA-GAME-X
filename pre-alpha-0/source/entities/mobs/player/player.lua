local keyboardMovement = require("source.logic.ai.movement.keyboard_movement")
local sprite = require("source.graphics.sprite")
local entity = require("source.logic.entity")
local punch = require("source.entities.mobs.player.punch")
local timer = require("source.logic.timer")

local player = {}

local adventurerSprite = sprite.create("assets/sprites/entities/mobs/player/player.png")

local action1 = function (self, game)
    local currentRoom = game.map:currentRoom()
    currentRoom:addEntity(punch.create(self.x + 8, self.y, self.z))
    self.interruptMovement = true
    local punchTimer = timer.create (timer.ticks(6), function (_, owner, game)
        owner.interruptMovement = false
    end)

    self:addTimer(punchTimer)
end

player.create = function ()
    local player = entity.create(
        adventurerSprite,
        50,
        0,
        50,
        64,
        keyboardMovement,
        0.5,
        2)

    player.action1 = action1

    return player
end

return player