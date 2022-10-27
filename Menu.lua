Menu = {}
Menu.__index = Menu

function Menu:create()
    local menu = {}
    setmetatable(menu, Menu)
    menu.TitleFont = love.graphics.newFont("fonts/atariclassic.ttf", 48)
    menu.StartMessageFont = love.graphics.newFont("fonts/atariclassic.ttf", 18)
    menu.iter = 60
    return menu
end

function Menu:update()
    self.iter = self.iter - 1
    if self.iter < -60 then
        self.iter = 60
    end
end

function Menu:draw()
    love.graphics.setFont(self.TitleFont)
    love.graphics.print("PingPong", 200, 250)
    love.graphics.setFont(self.StartMessageFont)
    self.iter = self.iter - 1
    if self.iter > 0 then
        love.graphics.print("Press any key to start", 195, 320)
    end
end