require ("Ball")
require ("Wall")
require ("PCWall")

Game = {}
Game.__index = Game

function Game:create()
    local game = {}
    setmetatable(game, Game)
    game.scoreFont = love.graphics.newFont("fonts/atariclassic.ttf", 15)
    game.screenWidth = love.graphics.getWidth()
    game.screenHeigth = love.graphics.getHeight()
    game.playerScore = 0
    game.computerScore = 0
    game.ball = Ball:create(10, game.screenHeigth, game.screenWidth)
    game.player = Wall:create(15, 100, 15, game.screenHeigth/2-50)
    game.computer = PCWall:create(15, 100, game.screenWidth-30, game.screenHeigth/2-50)
    game.res = 0
    return game
end

function Game:update()
    self.res = self.ball:update()
    self.player:update(self.ball)
    self.computer:update(self.ball)
    if self.res == 1 then
        self.playerScore = self.playerScore + 1
        if self.playerScore == 10 then return 1
        end
    elseif self.res == -1 then
        self.computerScore = self.computerScore + 1
        if self.computerScore == 10 then return -1
        end
    end
    return 0
end

function Game:draw()
    love.graphics.setFont(self.scoreFont)
    love.graphics.circle("fill", self.ball.x, self.ball.y, 10)
    self.player:draw()
    self.computer:draw()
    love.graphics.print(self.playerScore, self.screenWidth/4-20, 60)
    love.graphics.print(self.computerScore, self.screenWidth - self.screenWidth/4, 60)
end