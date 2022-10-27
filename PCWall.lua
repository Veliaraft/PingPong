PCWall = {}
PCWall.__index = PCWall

function PCWall:create(width, height, x, y)
    local pcwall = {}
    setmetatable(pcwall, PCWall)
    pcwall.width = width
    pcwall.height = height
    pcwall.speed = 10
    pcwall.x = x
    pcwall.y = y
    pcwall.hit = false
    return pcwall
end

function PCWall:update(ball)
    if ball.x > self.x - 100 then
        if ball.y + ball.size < self.y then
            self.y = self.y - self.speed
        elseif ball.y > self.y + self.height then
            self.y = self.y + self.speed
        end
    end
    if ball.x + ball.size >= self.x and ball.x < self.x + self.width  then
        if ball.y < self.y + self.height and ball.y + ball.size > self.y then
            if not self.hit then
                self.hit = true
                ball.vecx = ball.vecx * -1
                love.audio.newSource("SFX/pong.wav", "static"):play()
            end
        end
    else
        self.hit = false
    end
end

function PCWall:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end