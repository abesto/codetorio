if global.script == nil then
    global.script = ""
end

codetorio = {
    east = defines.direction.east,
    west = defines.direction.west,
    north = defines.direction.north,
    south = defines.direction.south
}
require "lib.buildings"
require "lib.cursor"

local C = codetorio

function store_player(event)
    C.player = game.get_player(event.player_index)
end

script.on_event(defines.events.on_lua_shortcut, function(event)
    local prototype_name = event.prototype_name
    store_player(event)

    if prototype_name == "open-codetorio" then
        local screen = C.player.gui.screen
        if screen.codetorio then
            return
        end

        local frame = screen.add {
            type = "frame",
            name = "codetorio",
            caption = "Codetorio"
        }

        local textfield = frame.add {
            type = "text-box",
            name = "codetorio-text",
            text = global.script,
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

        frame.location = {50, 50}
    end
end)

script.on_event(defines.events.on_gui_click, function(event)
    local element = event.element
    store_player(event)

    if element.name == "codetorio-close" then
        C.player.gui.screen.codetorio.destroy()
    elseif element.name == "codetorio-run" then
        local f = load(global.script)
        local status, err = pcall(f)
        if not status then
            game.print(err)
        end
    end
end)

script.on_event(defines.events.on_gui_text_changed, function(event)
    local element = event.element
    store_player(event)

    if element.name == "codetorio-text" then
        global.script = element.text
    end
end)
