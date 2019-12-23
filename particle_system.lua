ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem:create(x,y, n)
    local system = {}
    setmetatable(system, ParticleSystem)
    system.origin = Vector:create(x, y)
    system.n = n or 10
    system.particles = {}
    system.index = 0
    system.velocity = Vector:create(0, 0)

    return system
end

function ParticleSystem:draw(x,y)
    self.origin.x = x
    self.origin.y = y
    
    for k, v in pairs(self.particles) do
        v:draw()
    end
end

function ParticleSystem:update(active)
    if #self.particles < self.n then
        if active then
            local part = Particle:create(self.origin.x, self.origin.y)
            part.acceleration:add(self.velocity*50)
            self.particles[self.index] = part
            self.index = self.index + 1
        end
    end
    for k, v in pairs(self.particles) do
        if v:isDead() then
            if active then
                v = Particle:create(self.origin.x, self.origin.y)
                v.acceleration:add(self.velocity*50)
                self.particles[k] = v 
            end
        end
        v:update()
    end
end

