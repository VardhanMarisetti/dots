local M = {}

-- Change this to your MPD music_directory defined in mpd.conf
local MUSIC_ROOT = "/home/vm/Music/" 

local get_selected = ya.sync(function()
    local tab = cx.active
    local urls = {}
    for _, file in pairs(tab.selected) do
        table.insert(urls, tostring(file.url))
    end
    if #urls == 0 and tab.current.hovered then
        table.insert(urls, tostring(tab.current.hovered.url))
    end
    return urls
end)

function M:entry()
    local files = get_selected()
    if #files == 0 then return end

    os.execute("mpc clear")
    for _, f in ipairs(files) do
        -- Strip the MUSIC_ROOT to make the path relative for MPD
        local relative_path = f:gsub("^" .. MUSIC_ROOT, "")
        os.execute(string.format('mpc add %q', relative_path))
    end
    os.execute("mpc play")
end

function M:peek(job)
    -- Metadata & Progress fetch
    local handle = io.popen("mpc current -f 'Title: %title%\nArtist: %artist%\nAlbum: %album%' && mpc status | grep -E '(\\[playing\\]|\\[paused\\])'")
    local status = handle:read("*a")
    handle:close()

    ya.preview_widgets(job, {
        ui.Paragraph(job.area, {
            ui.Line(" 🎵 MPD PLAYER "):style(ui.Style():fg("magenta"):bold(true)),
            ui.Line(status ~= "" and status or "Stopped / Idle"),
        }):wrap(ui.Paragraph.WRAP)
    })
end

return M
