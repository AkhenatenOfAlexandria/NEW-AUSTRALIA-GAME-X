local vector = require("source.math.vector")

local keyboardMovement = {}

keyboardMovement.update = function (entity, game)
        if entity.interruptMovement then return end

        local dX = 0
        local dZ = 0
        local currentRoom = game.map:currentRoom()

        entity.actualSpeed = entity.speed
        if love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl") then entity.actualSpeed = entity.fastSpeed end
        if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then entity.actualSpeed = entity.slowSpeed end
        if love.keyboard.isDown("up") or love.keyboard.isDown("w") then dZ = - entity.actualSpeed end
        if love.keyboard.isDown("left") or love.keyboard.isDown("a") then dX = - entity.actualSpeed end
        if love.keyboard.isDown("down") or love.keyboard.isDown("s") then dZ = entity.actualSpeed end
        if love.keyboard.isDown("right") or love.keyboard.isDown("d") then dX = entity.actualSpeed end

        local newX = entity.x + dX * game.dt
        local newZ = entity.z + dZ * game.dt
        
        if currentRoom:walkable(newX, newZ) then
                entity.x = newX
                entity.z = newZ
        end

        game.debugString = entity.x .. ", " .. entity.y .. ", " .. entity.z
end

return keyboardMovement