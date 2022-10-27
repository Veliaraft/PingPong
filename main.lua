require ("Game")
require ("Menu")

maxFPS = 60
currentScene = "menu"
image = love.graphics.newImage("sprites/background.png")
resFont = love.graphics.newFont("fonts/atariclassic.ttf", 48)


function love.load()
    love.window.setTitle("PingPong")
    menu = Menu:create()
end

-- Отслеживание кнопки по типу "пресс ту действие"
function love.keypressed(key)
    if currentScene == "menu" then
        game = Game:create()
        SceneChange("SFX/Start.wav", "game")
    end
end

function love.update(dt)
    -- ограничение кадров до количества, указанного максимальным в начале файла.
    if dt < 1/maxFPS then
        love.timer.sleep(1/maxFPS - dt)
    end
    if currentScene == "menu" then
        menu:update()
    elseif currentScene == "game" then
        victory = game:update()
        if victory == 1 then SceneChange("SFX/victory.wav", "Victory!")
        elseif victory == -1 then SceneChange("SFX/gameover.wav", "You lose!")
        end
    end
--if love.keyboard.isDown("down") then
end

function love.draw()
    love.graphics.clear()
    love.graphics.draw(image)
    if currentScene == "menu" then
        menu:draw()
    elseif currentScene == "game" then
        game:draw()
    else
        love.graphics.setFont(resFont)
        love.graphics.print(currentScene, 200, 100)
    end
end

-- Переключение сцены с воспроизведением звука.
function SceneChange(sound, sceneName)
    love.audio.newSource(sound, "static"):play()
    currentScene = sceneName
end