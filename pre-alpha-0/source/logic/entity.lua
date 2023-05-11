local vector = require("source.math.vector")
local rectangle = require ("source.math.rectangle")
local timer = require("source.logic.timer")

local entity = {}

local _positionString = function (self)
    return math.floor(self.x) .. ", " .. math.floor(self.y) .. ", " .. math.floor(self.z)
end

local draw = function (self, view)
    if self.visible then
        self.sprite:draw(view, self.drawX, self.drawY)
    end
    if DEBUG then
        view:inContext(function () 
            love.graphics.print (_positionString(self), self.drawX, self.drawY)
            if self.debugColor then love.graphics.setColor(self.debugColor) end
            love.graphics.polygon("line", self.boundingBox:getPoints())
        end)
    end
end

local toPosition = function (self)
    return {
        x = self.x,
        y = self.y,
        z = self.z
    }
end

local update = function (self, game)
    if self.iframes and game:modulate() then
        self.visible = false
    else
        self.visible = true
    end
    if self.timer then self.timer:tick(self, game) end
    if self.movement then self.movement.update(self, game) end
    self.boundingBox:update(self.x, self.z)
    local screenPosition = vector.worldToScreen(toPosition(self))
    self.drawX = screenPosition.x
    self.drawY = screenPosition.y
end

local collisionCheck = function (self, ent, game)
    if self == ent then return end
    if self.boundingBox:overlaps(ent.boundingBox) then
        self.debugColor = {1, 0, 0}
        if self.collison then self:collison(ent, game) end
    end
end

local done = function (self)
    self.finished = true
end

local addTimer = function (self, timer)
    self.timer = timer
end

local removeTimer = function (self)
    self.timer = nil
end

local takeDamage = function (self, damage)
    if self.vulnerable then
        self.hp = self.hp - damage
        if self.hp <= 0 then
            self:done()
        else
            self.vulnerable = false
            self.iframes = true
            self:addTimer(timer.create(timer.ticks(20), function (_, ent, game)
                ent.vulnerable = true
                ent.iframes = false
            end))
        end
    end
end

entity.create = function (sprite, x, y, z, speed, movement, slow, fast, collision)
    local instance = {}

    instance.finished = false
    instance.sprite = sprite
    instance.x = x
    instance.y = y
    instance.z = z
    instance.drawX = x
    instance.drawY = z
    instance.speed = speed
    instance.fast = fast
    instance.slow = slow
    instance.fastSpeed = instance.speed * fast
    instance.slowSpeed = instance.speed * slow
    instance.movement = movement
    instance.collison = collison
    instance.boundingBox = rectangle.create(
        x,
        z,
        sprite.image:getWidth(),
        sprite.image:getHeight()
    )

    instance.draw = draw
    instance.update = update
    instance.toPosition = toPosition
    instance.collisionCheck = collisionCheck
    instance.done = done
    instance.addTimer = addTimer
    instance.removeTimer = removeTimer
    instance.takeDamage = takeDamage
    instance.iframes = false
    instance.visible = true

    instance.interruptMovement = false    
    instance.vulnerable = true
    instance.hp = 5

    return instance
end

return entity