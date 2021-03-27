local C = codetorio

function twin_smelters(cursor, facing)
    cursor:fork():east(1):build("inserter", facing):east(1):build("inserter", facing):west(2):south(1):build(
        "stone-furnace"):east(2):build("stone-furnace"):west(2):south(2):east(1):build("inserter", facing):east(1)
        :build("inserter", facing)
end

function quad_smelters(cursor)
    cursor:fork():start_conveyor():east(4)
    twin_smelters(cursor:south(1), C.north)
    cursor:south(2):fork():east(4):start_conveyor():west(4)
    twin_smelters(cursor:south(6), C.south)
end

quad_smelters(C.cursor())
