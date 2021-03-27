local position = require "lib.position"

local C = codetorio

local cursor = {}
local Cursor = {}

function cursor.new(at, laying_conveyor)
    self = {
        position = position.new(at or C.player.position),
        laying_conveyor = laying_conveyor or false
    }
    setmetatable(self, {
        __index = Cursor
    })
    return self
end

C.cursor = cursor.new

function Cursor:fork()
    return cursor.new(position.new(self.position), self.laying_conveyor)
end

function Cursor:start_conveyor()
    self.laying_conveyor = true
    return self
end

function Cursor:stop_conveyor()
    self.laying_conveyor = false
    return self
end

local direction_to_unit = {}
direction_to_unit[C.east] = position.new({1, 0})
direction_to_unit[C.west] = position.new({-1, 0})
direction_to_unit[C.north] = position.new({0, -1})
direction_to_unit[C.south] = position.new({0, 1})

function Cursor:move(direction, amount)
    local unit = direction_to_unit[direction]

    if amount == nil then
        amount = 1
    end

    if self.laying_conveyor then
        C:conveyor(self.position, direction)
        for i = 1, amount do
            self.position:offset(unit)
            C:conveyor(self.position, direction)
        end
    else
        self.position:offset(unit:times(amount))
    end
    return self
end

function Cursor:east(amount)
    return self:move(C.east, amount)
end

function Cursor:south(amount)
    return self:move(C.south, amount)
end

function Cursor:west(amount)
    return self:move(C.west, amount)
end

function Cursor:north(amount)
    return self:move(C.north, amount)
end

function Cursor:build(building, direction)
    C:build(building, self.position, direction)
    return self
end

return cursor
