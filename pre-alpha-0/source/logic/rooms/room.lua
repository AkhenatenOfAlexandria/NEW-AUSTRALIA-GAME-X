local vector = require("source.math.vector")
local tilesheet = require("source.graphics.tilesheet")
local tilemap = require("source.logic.rooms.tilemap")

local room = {}

local walkable = function (self, x, z)
    local screenPosition = vector.worldToScreen({x=x, y=0, z=z})
    if screenPosition.x < 0 or screenPosition.y < 0 then return false end
    local tileChar = self.tilemap:getTile(screenPosition.x, screenPosition.y, self.tilesheet.tileSize)
    if (tileChar == "," or tileChar == ".")
        then return true
    end
end

local draw = function (self, view)
    self.tilemap:draw(view, self.tilesheet)

    for _, entity in ipairs(self.entities) do
        entity:draw(view)
    end
end

local update = function (self, game, map)
    for i, entity in ipairs(self.entities) do
        if entity.finished then
            table.remove(self.entities, i)
            break
        end

        entity:update(game)

        game.player:collisionCheck(entity, game)
        entity:collisionCheck(game.player, game)
        for _, anotherEntity in ipairs(self.entities) do
            entity:collisionCheck(anotherEntity, game)
        end
    end

    if game.player.drawX > self.roomWidth - self.tilesheet.tileSize then
        map:nextRoom(game)
    end

    if game.player.drawX < self.tilesheet.tileSize then
        map:previousRoom(game)
    end
end

local addEntity = function (self, ent)
    table.insert(self.entities, ent)
end

room.create = function (entities)
    local instance = {}

    instance.tilesheet = tilesheet.create("assets/sprites/tiles/dungeon.png", 8)
    instance.tilemap = tilemap.create()

    instance.color = {
        math.random(), math.random(), math.random()
    }
    
    instance.entities = entities

    instance.roomWidth = 240 * instance.tilesheet.tileSize
    instance.roomHeight = 135 * instance.tilesheet.tileSize
    instance.entranceX = 64
    instance.entranceZ = 64
    instance.exitX = 1896
    instance.exitZ = 64
    
    instance.draw = draw
    instance.update = update
    instance.walkable = walkable
    instance.addEntity = addEntity

    return instance
end

return room