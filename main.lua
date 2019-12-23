require("vector")
require("mover")
require("particle")
require("particle_system")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    local location = Vector:create(width / 2, height/ 2)
    local velocity = Vector:create(0, 0)
    mover = Mover:create(location,velocity)
end

function love.update(dt)
    if love.keyboard.isDown("left") then
        mover.angle = mover.angle - 0.05
    end
    if love.keyboard.isDown("right") then
        mover.angle = mover.angle + 0.05
    end
    if love.keyboard.isDown("up") then
        x = 0.1 * math.cos(mover.angle);
        y = 0.1 * math.sin(mover.angle);
        local vector = Vector:create(x,y)
        mover.system.velocity = vector * -1
        mover:applyForce(vector)
        mover.active = true
    else
        mover.active = false
    end
    mover:update()
    mover:check_boundaries()
    mover.velocity = mover.velocity:limit(5)
    
end

function love.draw()
    mover:draw()
end

function love.keypressed(key)
    if (key == "g") then
        
    end
end