Ball = {}
Ball.__index = Ball

function Ball:create(size, scrHeight, scrWidth)
    local ball = {}
    setmetatable(ball, Ball)
    ball.SH = scrHeight-size
    ball.SW = scrWidth-size
    ball.size = size
    ball.startposx = scrWidth / 2 - size / 2
    ball.startposy = scrHeight / 2 - size / 2
    ball.x = scrWidth / 2 - size / 2
    ball.y = scrHeight / 2 - size / 2
    ball.speed = 10
    local xspeed = randV(ball.speed)
    ball.vecx = xspeed
    ball.vecy = yspeed(ball.speed, xspeed)
    return ball
end



function Ball:update()
    if self.y + self.vecy < 0 or self.y + self.vecy > self.SH then
        self.vecy = self.vecy * -1
    end
    self.x = self.x + self.vecx;
    self.y = self.y + self.vecy;
    if self.x < 0 then
        ballstart(self)
        return -1
    elseif self.x > self.SW then
        ballstart(self)
        return 1
    else
        return 0
    end
end

function Ball:draw()
    love.graphics.circle("fill", self.x, self.y, 15)
end

function ballstart(self)
    self.x = self.startposx
    self.y = self.startposy
    self.speed = self.speed + 1
    local xspeed = randV(self.speed)
    self.vecx = xspeed
    self.vecy = yspeed(self.speed, xspeed)
end

function randV(speed)
    math.randomseed(os.time())
    local a = math.random(30)
    if a > 15 then
        a = -1
    else
        a = 1
    end
    return math.random(speed/2-speed/4, speed/2 + speed/4) * a
end

function yspeed(speed, xspeed)
    math.randomseed(os.time())
    local a = math.random(30)
    if a > 15 then
        a = -1
    else
        a = 1
    end
    if xspeed < 0 then
        xspeed = -xspeed
    end
    return (speed - xspeed) * a
end
