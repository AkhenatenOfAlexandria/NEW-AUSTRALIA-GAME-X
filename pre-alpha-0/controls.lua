local controls = {}

    local update = function ()
      --  DEBUG = false
        if love.keyboard.isDown("d")
        and not DEBUG then
            DEBUG = true
        end
        
        if love.keyboard.isDown("d")
        and DEBUG then
            DEBUG = false
        end
    end

    controls.create = function (self)
        local instance = {}
            instance.update = update
        return instance
    end

return controls