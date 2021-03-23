codetorio = {
    player = nil,
    frame = nil,
    textfield = nil
}

codetorio.conveyor = function(position, length)
    local surface = codetorio.player.surface
    local x0 = position.x
    local y0 = position.y

    if x0 == nil then
        x0 = position[1]
        y0 = position[2]
    end

    for x = x0, x0 + length, 1 do
        surface.create_entity {
            name = "entity-ghost",
            inner_name = "transport-belt",
            position = {x, y0},
            force = codetorio.player.force
        }
    end
end

script.on_event(defines.events.on_lua_shortcut, function(event)
    local prototype_name = event.prototype_name
    local player = game.get_player(event.player_index)
    codetorio.player = player

    if prototype_name == "open-codetorio" then
        local screen = player.gui.screen
        codetorio.frame = screen.add {
            type = "frame",
            name = "codetorio",
            caption = "Codetorio"
        }

        local frame = codetorio.frame
        codetorio.textfield = frame.add {
            type = "text-box",
            name = "codetorio-text",
            text = [[codetorio.conveyor({
    codetorio.player.position.x,
    codetorio.player.position.y
}, 10)]],
            style = "reader_textbox"
        }

        local run = frame.add {
            type = "button",
            name = "codetorio-run",
            caption = "Run"
        }
        local close = frame.add {
            type = "button",
            name = "codetorio-close",
            caption = "Close"
        }
    end
end)

script.on_event(defines.events.on_gui_click, function(event)
    local element = event.element

    if element.name == "codetorio-close" then
        codetorio.frame.destroy()
    elseif element.name == "codetorio-run" then
        local f = load(codetorio.textfield.text)
        f()
    end
end)
