local map = require("source.logic.rooms.map")
--local controls = require("controls")

local gamestate = {}

local modulate = function (self)
    return (self.updates % 2) == 0
end

local addEntity = function (self, entity)
    table.insert(self.entities, entity)
end

local update = function (self, dt)
    self.updates = self.updates + 1
    self.dt = dt
    self.map:update(self)
    for _, entity in ipairs(self.entities) do
        entity:update(self)
    end
    self.player:update(self)
    self.view:update(self)
    -- controls:update(self)
end

local draw = function (self)
    self.map:draw(self.view)
    self.player:draw(self.view)
    for _, entity in ipairs(self.entities) do
        entity:draw(self.view)
    end
    if DEBUG then
        love.graphics.print(self.debugString)
    end
end

local keypressed = function (self, key)
    if key == "z" then self.player:action1(self) else return end
    if key == "return" then DEBUG = true end
    if key == "back" then DEBUG = false end
    self.player:action1(self)
end

gamestate.create = function (player, view)
    local instance = {}

    instance.updates = 0
    instance.entities = {}
    instance.player = player
    instance.map = map.create()
    instance.view = view
    instance.dt = 0
    instance.debugString = ""

    instance.addEntity = addEntity
    instance.update = update
    instance.draw = draw
    instance.keypressed = keypressed
    instance.modulate = modulate

    return instance
end

return gamestate