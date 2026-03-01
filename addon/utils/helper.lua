local addon_name, store = ...

store.utils = {}
store.utils.helper = {}


function store.utils.helper.create_frame(name, width, height, x, y, anchor_point)
    name = name .. "_" .. addon_name .. "_frame"
    width = width or 10
    height = height or 10
    x = x or 0
    y = y or 0
    anchor_point = anchor_point or "TOPLEFT"

    local frame = CreateFrame("Frame", name, UIParent)
    frame:SetWidth(width)
    frame:SetHeight(height)

    frame:SetPoint(anchor_point, UIParent, anchor_point, x, y)

    frame:SetFrameStrata("TOOLTIP")

    local texture = frame:CreateTexture(nil, "OVERLAY")
    texture:SetAllPoints(frame)

    frame.texture = texture

    return frame
end


function store.utils.helper.set_color_to_frame(r, g, b, frame)
    frame.texture:SetTexture(r, g, b, 1)
end
