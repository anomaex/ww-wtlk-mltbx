--
-- core\frame_manager.lua
--
local addon_name, store = ...
store.core = store.core or {}


local defaults = {
    width = 10,
    height = 10,
    point = "TOPLEFT"
}


function store.core.create_frame(name, width, height, x, y)
    local frame_name = name .. "_" .. addon_name .. "_frame"

    local frame = CreateFrame("Frame", frame_name, UIParent)
    frame:SetSize(width or defaults.width, height or defaults.height)
    frame:SetPoint(defaults.point, UIParent, defaults.point, x or 0, y or 0)

    frame:SetFrameStrata("TOOLTIP")
    frame:SetScale(1)

    local texture = frame:CreateTexture(nil, "OVERLAY")
    texture:SetAllPoints(frame)
    texture:SetTexture(1, 1, 1, 1) -- Some times this not work, frame is still transparent
    texture:SetTexture("Interface\\Buttons\\WHITE8X8")
    frame.texture = texture

    function frame:set_color(r, g, b)
        self.texture:SetVertexColor(r/255, g/255, b/255, 1) -- on default color format (r: 1.0 g: 1.0 b: 1.0), now is (r: 255 g: 255 b: 255)
    end

    frame:Show()
    return frame
end
