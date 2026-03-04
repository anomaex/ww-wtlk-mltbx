--
-- core\frame_manager.lua
--
local addon_name, store = ...
store.core = store.core or {}

local defaults = {
    width = 10,
    height = 10,
    x = 0,
    y = 0,
    point = "TOPLEFT"
}


function store.core.create_frame(name, x, y, width, height)
    local frame_name = name .. "_" .. addon_name .. "_frame"

    local frame = CreateFrame("Frame", frame_name)
    frame:SetSize(width or defaults.width, height or defaults.height)
    frame:SetPoint(defaults.point, UIParent, defaults.point, x or defaults.x, y or defaults.y)

    frame:SetFrameStrata("TOOLTIP")
    frame:SetScale(1)

    local texture = frame:CreateTexture(nil, "OVERLAY")
    texture:SetAllPoints(frame)
    texture:SetTexture(1, 1, 1, 1) -- some times this not work, frame is still transparent
    texture:SetTexture("Interface\\Buttons\\WHITE8X8")
    texture:SetVertexColor(1, 1, 1, 1)
    frame.texture = texture

    function frame:set_color(color_table)
        -- RGB: [1] - red, [2] - green, [3] - blue
        self.texture:SetVertexColor(color_table[1], color_table[2], color_table[3], 1) -- default color format (r: 1.0 g: 1.0 b: 1.0)
    end

    frame:Show()
    return frame
end


function store.core.create_event_frame(name)
    local frame_name = name .. "_" .. addon_name .. "_frame"
    local frame = CreateFrame("Frame", frame_name)
    return frame
end
