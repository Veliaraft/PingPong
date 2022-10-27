Wall = {}
Wall.__index = Wall

function Wall:create(width, height, x, y)
    local wall = {}
    setmetatable(wall, Wall)
    wall.width = width
    wall.height = height
    wall.speed = 10
    wall.x = x
    wall.y = y
    wall.hit = false
    return wall
end

function Wall:update(ball)
    if love.keyboard.isDown("down") then
        if self.y + self.height < love.graphics.getHeight() then
            self.y = self.y + self.speed
        end
    elseif love.keyboard.isDown("up") then
        if self.y > 0 then
            self.y = self.y - self.speed
        end
    end
    if ball.x <= self.x + self.width and ball.x > self.x then
        if ball.y < self.y + self.height and ball.y + ball.size > self.y then
            if not self.hit then
                self.hit = true
                ball.vecx = ball.vecx * -1
                if love.keyboard.isDown("down") then
                    if ball.vecy > 0 then
                        ball.vecy = ball.vecy + 1
                        ball.vecx = ball.vecx - 1
                    elseif ball.vecy < 0 then
                        ball.vecy = ball.vecy - 1
                        ball.vecx = ball.vecx + 1
                    end
                elseif love.keyboard.isDown("up") then
                    if ball.vecy > 0 then
                        ball.vecy = ball.vecy - 1
                        ball.vecx = ball.vecx + 1
                    elseif ball.vecy < 0 then
                        ball.vecy = ball.vecy + 1
                        ball.vecx = ball.vecx - 1
                    end
                end
                love.audio.newSource("SFX/pong.wav", "static"):play()
            end
        end
    else
        self.hit = false
    end
end

function Wall:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end