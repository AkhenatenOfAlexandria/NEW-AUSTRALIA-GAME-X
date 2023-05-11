local entity = require ("source.logic.entity")
local sprite = require ("source.graphics.sprite")
local timer = require ("source.logic.timer")

local punch = {}

local punchSprite = sprite.create("assets/sprites/entities/mobs/player/punch.png")
local punchSound = love.audio.newSource("assets/sounds/punch.wav", "static")

local collision = function (self, entity, game)
    if game.player ~= entity then
        entity:takeDamage(1)
    end
end

punch.create = function (xPosition, yPosition, zPosition)
    local punch = entity.create(punchSprite, xPosition, yPosition, zPosition, 1, nil, 0.5, 2, collision)
    punchSound:play()

    local punchTimer = timer.create (timer.ticks(6), function (punchTimer, ent, game)
        ent:done()
    end)

    punch:addTimer(punchTimer)

    return punch
end

return punch