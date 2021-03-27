local C = codetorio

function C:conveyor(position, direction)
    self:build("transport-belt", position, direction)
end

function C:build(building, position, direction)
    local surface = self.player.surface
    surface.create_entity {
        name = "entity-ghost",
        inner_name = building,
        position = position,
        direction = direction,
        force = self.player.force
    }
end
