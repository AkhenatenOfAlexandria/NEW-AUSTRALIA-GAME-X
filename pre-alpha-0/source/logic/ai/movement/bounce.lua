local vector = require("source.math.vector")

local bounce = {}

local bounceHeight = function (entity, game)
    local entityPosition = entity:toPosition()
    local playerPosition = game.player:toPosition()
    local distance = vector.distance(entityPosition, playerPosition)
    if distance < 100 then
    return 500
        else
    return 50
    end
  end

bounce.update = function (entity, game)
    if not entity.bounceDirection then
        entity.bounceDirection = 1
    end

    if entity.z > bounceHeight(entity, game) then entity.bounceDirection = -1 end
    if entity.z < 0 then entity.bounceDirection = 1 end
   -- if bounceHeight(entity, game) > 50 then entity.actualSpeed = entity.fastSpeed else entity.actualSpeed = entity.speed end

    entity.z = entity.z + entity.speed * 2 * entity.bounceDirection
end

return bounce