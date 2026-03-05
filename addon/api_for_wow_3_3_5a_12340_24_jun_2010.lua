--
-- API for World of Warcraft: Wrath of the Lich King, version 3.3.5a (12340), Jun 24 2010
--

---@diagnostic disable: missing-return


--- Determines if the unit exists and is in the current zone or not, in view zone and if loaded to game RAM.
--- @param unit string example: "name", "player", "target", "party1", ...
--- @return boolean is_exists 1 (true), if exists, else nil if not.
function UnitExists(unit) end


--- Returns the name and realm of the specified unit.
--- @param unit string example: "player", "target", "party1", ...
--- @return string name, string realm name - name of the specified unit or nil, realm - realm the specified unit is from, nil or empty string "".
function UnitName(unit) end


--- Start following an allied unit.
--- @param unit string example: "name", "player", "target", "party1", ...
function FollowUnit(unit) end

--- Determines if unit is dead or ghost.
--- @param unit string example: "name", "player", "target", "party1", ...
--- @return boolean is_dead_ghost 1 (true), if unit is dead or a ghost, nil otherwise.
function UnitIsDeadOrGhost(unit) end
