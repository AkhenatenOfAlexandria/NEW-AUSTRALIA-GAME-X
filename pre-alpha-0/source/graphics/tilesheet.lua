local tilesheet = {}

local drawTile = function (self, view, x, y, tileX, tileY)
    view:inContext(function ()
    love.graphics.draw(self.image, self.quads[tileX][tileY], x, y)
  end)
end

tilesheet.create = function (imagePath, tileSize)
    local instance = {}

    instance.image = love.graphics.newImage(imagePath)
    instance.image:setFilter('nearest', 'nearest')
    instance.tileSize = tileSize
    instance.quads = {}

    for tileX=1, instance.image:getWidth()/tileSize do
        instance.quads[tileX] = {}
    for tileY=1, instance.image:getHeight()/tileSize do
        instance.quads[tileX][tileY] = love.graphics.newQuad(
            (tileX-1) * tileSize,
            (tileY-1) * tileSize,
            tileSize,
            tileSize,
        instance.image:getDimensions())
    end
  end

  instance.drawTile = drawTile

  return instance
end

return tilesheet