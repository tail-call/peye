-- View for rendering editor

local observe = require "observe"
local color = require "color"

local EditorView = {}

function EditorView.make(editor)
    local self = {
	model = editor,
	translate = { 0, 0 },
	scale = 20,
	status = "Welcome to pi",
    }

    observe.watch(editor, function(editor, key, ...)
        print("Something changed")
	if key == "cursor" then
	    local x, y = ...
	    self.status = editor.mode .. " [" .. x .. ", " .. y .. "]"
	end
    end)

    setmetatable(self, { __index = EditorView })

    return self
end

function EditorView:drawImage()
    love.graphics.push()
    love.graphics.translate(unpack(self.translate))
    love.graphics.scale(self.scale)
    for x, y, rgb in self.model.image:xypairs() do
	love.graphics.setColor(unpack(rgb))
	love.graphics.rectangle("fill", x, y, 1, 1)
    end

    -- Draw cursor
    local x, y = self.model:getCursorPosition()
    -- love.graphics.setBlendMode("subtract")
    love.graphics.setColor(color.magenta())
    love.graphics.rectangle("line", x, y, 1, 1)
    love.graphics.pop()
end

function EditorView:draw()
    self:drawImage()
    local windowHeight = love.graphics.getHeight()
    local windowWidth = love.graphics.getWidth()

    love.graphics.setBlendMode("alpha")

    -- Draw status line
    love.graphics.setColor(color.white())
    love.graphics.print(self.status, 0, windowHeight - 20)

    -- Draw primary color
    love.graphics.setColor(unpack(self.model.primaryColor))
    love.graphics.rectangle("fill", windowWidth - 20, 0, 20, 20)
end

return EditorView
