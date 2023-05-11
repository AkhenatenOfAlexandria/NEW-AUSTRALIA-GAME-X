local timer = {}

timer.ticks = function (frames)
    return frames / 60
end

local tick = function (self, owner, game)
    self.time = self.time + (1 * game.dt)

    if self.time >= self.duration then
        self:onDone(owner, game)
        owner:removeTimer()
    end
end

timer.create = function (duration, onDone)
    local instance = {}

    instance.time = 0
    instance.duration = duration
    instance.onDone = onDone
    instance.tick = tick

    return instance
end

return timer