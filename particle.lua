Particle = {}
Particle.__index = Particle

function Particle: create(x, y)
    local particle  = {}
    setmetatable(particle, Particle)
    particle.location = Vector:create(x,y)
    particle.velocity = Vector:create(math.random(-50,50)/100,
                                        math.random(-50,50)/100)
    particle.acceleration = Vector:create(0, 0.05)
    particle.decay = math.random(3, 10) * 0.1
    particle.gravity = Vector:create(0, 0.1)
    particle.livetime = 100
    particle.texture = love.graphics.newImage("star.png")
    particle.choice = math.random(1,2)
    return particle
end

function Particle:update()
    self.velocity:add(self.acceleration)
    self.location:add(self.velocity)
    self.acceleration:mul(0)
    self.livetime = self.livetime - self.decay
end


function Particle:draw()
    r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255, self.livetime / 100)

    love.graphics.push()
    love.graphics.translate(self.location.x, self.location.y)
    love.graphics.rotate(mover.angle)

    
    if self.choice == 1 then
        love.graphics.draw(self.texture, -40, -25, 0.2,0.2)      
    else
        love.graphics.draw(self.texture, -40, 5, 0.2,0.2)  
    end
                                                 
    love.graphics.pop()
    love.graphics.setColor(r,g,b,a)
end

function Particle: isDead()
    return self.livetime < 0
end
