local vector = require("source.math.vector")

local followPlayer = {}

followPlayer.update = function (entity, game)
  local playerPosition = game.player:toPosition()
  local entityPosition = entity:toPosition()
  local dX = 0
  local dZ = 0
  local room = game.map:currentRoom()

  local distance = vector.distance(entityPosition, playerPosition)
  entity.actualSpeed = entity.speed

  if 256 > distance and distance > 4 then
    local unitVector = vector.normalize(entityPosition, playerPosition)
    dX = unitVector.dX * entity.actualSpeed * game.dt
    dZ = unitVector.dZ * entity.actualSpeed * game.dt

    local newX = entity.x + dX
    local newZ = entity.z + dZ
  
    if room:walkable(newX, newZ) then
      entity.x = newX
      entity.z = newZ
    end
  end
end

return followPlayer