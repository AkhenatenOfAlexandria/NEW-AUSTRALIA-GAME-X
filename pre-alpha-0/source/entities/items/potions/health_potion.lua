local entity = require("source.logic.entity")
local sprite = require("source.graphics.sprite")

local healthPotion = {}

local healthPotionSprite = sprite.create("assets/sprites/entities/items/potions/health_potion.png")

local potionPlink = love.audio.newSource(
    "assets/sounds/potion_plink.wav",
    "static"
)

local collision = function (self, entity, game)
    if entity == game.player then
        potionPlink:play()
        self:done()
    end
end

healthPotion.create = function (xPos, yPos, zPos)
    local healthPotion = entity.create(
        healthPotionSprite,
        xPos, yPos, zPos,
        0, nil, 0, 0,
        collision
    )
    
    return healthPotion
end

return healthPotion