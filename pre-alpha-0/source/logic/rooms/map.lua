local room = require("source.logic.rooms.room")
local karen = require("source.entities.mobs.karen")
local healthPotion = require("source.entities.items.potions.health_potion")

local map = {}

local draw = function (self, view)
    self.rooms[self.roomIndex]:draw(view)
    
    if DEBUG then love.graphics.printf("Room " .. self.roomIndex,
    350,
    20,
    100,
    "center"
    ) end
end

local currentRoom = function (self)
    return self.rooms[self.roomIndex]
end

local update = function (self, game)
    currentRoom(self):update(game, self)
end

local _createRoom = function ()
    local entities = {}

    for i=1, 32 do
        local xPosition = math.random(1920) + 64
        local yPosition = 0
        local zPosition = math.random(1080) + 64
        entities[i] = karen.create(xPosition, yPosition, zPosition)
    end

    for i=1, 5 do
        table.insert(entities, healthPotion.create(150 + i*10, 0, 100))
    end

    return room.create(entities)
end

local nextRoom = function (self, game)
    if self.roomIndex == #self.rooms then
        table.insert(self.rooms, _createRoom())
    end

    local newRoom = self.rooms[self.roomIndex + 1]

    game.player.x = newRoom.entranceX
    game.player.z = newRoom.entranceZ

    self.roomIndex = self.roomIndex + 1
end

local previousRoom = function (self, game)
    if self.roomIndex > 1 then
        self.roomIndex = self.roomIndex - 1
        local newRoom = currentRoom(self)

        game.player.x = newRoom.exitX
        game.player.y = newRoom.exitZ
    end
end

map.create = function ()
    local instance = {}

    instance.roomIndex = 1
    instance.rooms = {}
    instance.rooms[1] = _createRoom()

    instance.draw = draw
    instance.update = update
    instance.nextRoom = nextRoom
    instance.previousRoom = previousRoom
    instance.currentRoom = currentRoom

    return instance
end

return map