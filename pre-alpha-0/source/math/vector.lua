local vector = {}

vector.distance = function (from, to)
    local dX = to.x - from.x
    local dZ = to.z - from.z
    return math.sqrt(dX*dX + dZ*dZ)
end

vector.normalize = function (from, to)
    local dX = to.x - from.x
    local dZ = to.z - from.z
    local distance = vector.distance(from, to)

    return {
        dX  = dX / distance,
        dZ = dZ / distance
    }
end

local theta = math.rad(0)

vector.worldToScreen = function (vec3)
    return {
        x = vec3.x,
        y = vec3.z
    }
end

return vector