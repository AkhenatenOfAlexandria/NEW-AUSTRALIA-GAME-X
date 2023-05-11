local gamestate = require("source.logic.gamestate")
local view = require("source.graphics.view")
local player = require("source.entities.mobs.player.player")

local game
local theView
DEBUG = true

love.load = function ()
    theView = view.create(240, 180, 0, 0)
    game = gamestate.create(player.create(), theView)
end

love.update = function (dt)
    game:update(dt)
end

love.draw = function ()
    game:draw()
end

function love.keypressed(key)
    game:keypressed(key)
end