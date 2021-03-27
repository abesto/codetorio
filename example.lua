local C = codetorio

function twin_smelters(cursor, facing)
    -- Start: top-left. End: bottom-left
    cursor:fork():east():build("inserter", facing):east():build("inserter", facing)
    cursor:south():fork():build("stone-furnace"):east(2):build("stone-furnace"):west(2)
    cursor:south(2):fork():east():build("inserter", facing):east():build("inserter", facing)
end

function quad_smelters(cursor)
    -- Start: top-left. End: top-right
    local top = cursor.position.y
    cursor:fork():start_conveyor():east(3)
    twin_smelters(cursor:south(), C.north)
    cursor:south():fork():east(3):start_conveyor():west(3)
    twin_smelters(cursor:south(), C.south)
    cursor:south():start_conveyor():east(3):stop_conveyor()
    cursor:north(cursor.position.y - top)
end

local cursor = C.cursor()
for i = 0, 48, 4 do
    quad_smelters(cursor:east())
end
