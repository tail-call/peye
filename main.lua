-- pi - a vi inspired pixel art editor

local Editor = require "editor"
local EditorView = require "editor-view"

local editor
local editorView

function love.load()
    editor = Editor.make(256, 256)
    editorView = EditorView.make(editor)
end

function love.update(dt)
    local speed = 100
    local x, y = unpack(editorView.translate)
    local scale = editorView.scale

    if love.keyboard.isDown("down") then
	y = y + speed * dt
    elseif love.keyboard.isDown("up") then
	y = y - speed * dt
    elseif love.keyboard.isDown("left") then
	x = x - speed * dt
    elseif love.keyboard.isDown("right") then
	x = x + speed * dt
    elseif love.keyboard.isDown("z") then
	scale = scale - scale * dt
    elseif love.keyboard.isDown("q") then
	scale = scale + scale * dt
    end

    editorView.translate = { x, y }
    editorView.scale = scale
end

function love.draw()
    love.graphics.reset()
    editorView:draw()
end

function love.mousepressed(x, y)
end

function love.keypressed(key)
    local x, y = editor:getCursorPosition()
    if key == "j" then
	y = y + 1
    elseif key == "k" then
	y = y - 1
    elseif key == "h" then
	x = x - 1
    elseif key == "l" then
	x = x + 1
    elseif key == "space" then
	editor:putPixel()
    elseif key == "y" then
	editor:yankPixel()
    elseif key == "i" then
	editor.mode = "ink"
    elseif key == "escape" then
	editor.mode = "normal"
    elseif key == "1" then
	editor.primaryColor = { 255, 0, 0 }
    elseif key == "2" then
	editor.primaryColor = { 0, 255, 0 }
    elseif key == "3" then
	editor.primaryColor = { 0, 0, 255 }
    elseif key == "4" then
	editor.primaryColor = { 0, 0, 0 }
    elseif key == "5" then
	editor.primaryColor = { 255, 255, 255 }
    elseif key == "up" then
    elseif key == "down" then
    elseif key == "left" then
    elseif key == "right" then
    end

    editor:locate(x, y)
end
