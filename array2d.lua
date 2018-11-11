local Array2D = {}

function Array2D.make(options)
    local width = options.width or error("Array2D: width option is required")
    local height = options.height or error("Array2D: height option is required")
    local init = options.init

    local self = {
	width = width,
	height = height,
	rows = {}
    }

    -- Fill table
    for i = 1, height do
	local row = {}
	for j = 1, width do
	    row[j] = init
	end

	self.rows[i] = row
    end

    setmetatable(self, { __index = Array2D })
    return self
end

function Array2D:get(x, y)
    return self.rows[y][x]
end

function Array2D:set(x, y, value)
    self.rows[y][x] = value
end

function Array2D:xypairs()
    local x = 1
    local y = 1

    return function()
	if y > self.height then
	    return nil
	end

	-- Copy current coords
	local x0 = x
	local y0 = y

	x = x + 1
	if x > self.width then
	    x = 1
	    y = y + 1
	end

	return x0, y0, self.rows[y0][x0]
    end
end

return Array2D
