Mover = {}
Mover.__index = Mover

function Mover:create(location, velocity, mass)
    local mover = {}
    setmetatable(mover, Mover)
    mover.location = location
    mover.velocity = velocity
    mover.acceleration = Vector:create(0, 0)
    mover.mass = mass or 1
    mover.size = 30 * mover.mass
    mover.aAcceleration = 0
    mover.aVelocity = 0
    mover.angle = 0
    mover.active = false

    mover.system = ParticleSystem:create(location.x, location.y, 200)
    return mover
end

-- function Mover:random()
--     local location = Vector:create()
--     location.x = love.math.random(0, love.graphics.getWidth())
--     location.y = love.math.random(0, love.graphics.getHeight())
--     local velocity = Vector:create()
--     velocity.x = love.math.random(-2, 2)
--     velocity.y = love.math.random(-2, 2)
--     return Mover:create(location, velocity)
-- end

function Mover:draw()
    self.system:draw(self.location.x, self.location.y)

    love.graphics.push()
    love.graphics.translate(self.location.x, self.location.y)
    love.graphics.rotate(self.angle)
    r,g,b,a = love.graphics.getColor()
    love.graphics.line(self.size, 0, -self.size, self.size, -self.size, -self.size, self.size, 0)
    local type = "line"
    if self.active then
        love.graphics.setColor(1, 0, 0, 1)
        type = "fill"
    end
    love.graphics.rectangle(type, -40, -25, 10, 20)
    love.graphics.rectangle(type, -40, 5, 10, 20)
    love.graphics.circle("fill", 0, 0, 4)
    love.graphics.setColor(r,g,b,a)
    love.graphics.pop()

    
end

function Mover:update()
    self.velocity:add(self.acceleration)
    self.location:add(self.velocity)
    self.aVelocity = self.aVelocity + self.aAcceleration
    self.acceleration:mul(0)

    self.system:update(self.active)
end

function Mover:check_boundaries()
    if self.location.x > width - self.size then
        self.location.x = self.location.x % width
    elseif self.location.x < self.size then
        self.location.x = self.location.x % width
    end  
    if self.location.y > height - self.size then
        self.location.y = self.location.y % height
    elseif self.location.y < self.size then
        self.location.y = self.location.y % height
    end  
end

function Mover:applyForce(force)
    --print(self.acceleration)
    
    self.acceleration:add(force * self.mass)
end