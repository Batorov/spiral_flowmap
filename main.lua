require("vector")
require("flowmap")
require("vehicle")

function love.load()
   width = love.graphics.getWidth()
   height = love.graphics.getHeight()

   map = FlowMap:create(40)
   map:init()

   vehicle = Vehicle:create(0, 0)
   vehicle.velocity.x = 1;
   vehicle.velocity.y = 1.5;
end

function love.update(dt)
	vehicle:update()
	vehicle:borders()
	vehicle:follow(map)
end

function love.draw()
	map:draw()
	vehicle:draw()
end
