-- Editor module that stores editor's state

local Array2D = require "array2d"
local observe = require "observe"
local color = require "color"

local Editor = {}

function Editor.make(width, height)
    local self = {
	image = Array2D.make{
	    width = width,
	    height = height,
	    init = { color.white() },
	},
	-- mode = normal | visual | ink
	mode = "normal",
	primaryColor = { color.green() },
	cursor = {
	    x = 0,
	    y = 0
	}
    }

    setmetatable(self, { __index = Editor })

    observe.it(self);

    return self
end

function Editor:getCursorPosition()
    return self.cursor.x, self.cursor.y
end

function Editor:yankPixel()
    self.primaryColor = self.image:get(self.cursor.x, self.cursor.y)
end

function Editor:putPixel()
    self.image:set(self.cursor.x, self.cursor.y, self.primaryColor)
end

function Editor:locate(x, y)
    self.cursor.x = x
    self.cursor.y = y
    self:changed("cursor", x, y)

    if self.mode == "ink" then
	self:putPixel()
    end
end

return Editor
