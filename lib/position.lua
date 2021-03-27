local position = {}
local Position = {}

function Position:offset(vector)
    self.x = self.x + vector.x
    self.y = self.y + vector.y
end

function Position:times(n)
    return position.new(self.x * n, self.y * n)
end

function position.new(x_or_raw, y)
    local self = {}
    if type(x_or_raw) == "number" then
        self.x = x_or_raw
        self.y = y
    elseif x_or_raw.x then
        self.x = x_or_raw.x
        self.y = x_or_raw.y
    else
        self.x = x_or_raw[1]
        self.y = x_or_raw[2]
    end

    assert(self.x ~= nil)
    assert(self.y ~= nil)

    self.x = math.floor(self.x)
    self.y = math.floor(self.y)

    setmetatable(self, {
        __index = Position
    })
    return self
end

return position
