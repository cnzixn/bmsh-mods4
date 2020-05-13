--[[
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- @Description: my character can cast skill
 -- If any question ,Please email me using Chinese to let me distinguish whether it is spam
 -- @version 1.0.0
 -- @author td1madao
 -- @email td1madao@163.com
 -- @qq 360810498
 -- @date 16/8/6
 ]]
local Text = require "widgets/text"
local ImageButton = require "widgets/imagebutton"

local KEYCODE = {
    _TAB = 9,
    _KP_PERIOD = 266,
    _KP_DIVIDE = 267,
    _KP_MULTIPLY = 268,
    _KP_MINUS = 269,
    _KP_PLUS = 270,
    _KP_ENTER = 271,
    _KP_EQUALS = 272,
    _MINUS = 45,
    _EQUALS = 61,
    _SPACE = 32,
    _ENTER = 13,
    _ESCAPE = 27,
    _HOME = 278,
    _INSERT = 277,
    _DELETE = 127,
    _END = 279,
    _PAUSE = 19,
    _PRINT = 316,
    _CAPSLOCK = 301,
    _SCROLLOCK = 302,
    _RSHIFT = 303,
    _LSHIFT = 304,
    _RCTRL = 305,
    _LCTRL = 306,
    _RALT = 307,
    _LALT = 308,
    _ALT = 400,
    _CTRL = 401,
    _SHIFT = 402,
    _BACKSPACE = 8,
    _PERIOD = 46,
    _SLASH = 47,
    _LEFTBRACKET = 91,
    _BACKSLASH = 92,
    _RIGHTBRACKET = 93,
    _TILDE = 96,
    _A = 97,
    _B = 98,
    _C = 99,
    _D = 100,
    _E = 101,
    _F = 102,
    _G = 103,
    _H = 104,
    _I = 105,
    _J = 106,
    _K = 107,
    _L = 108,
    _M = 109,
    _N = 110,
    _O = 111,
    _P = 112,
    _Q = 113,
    _R = 114,
    _S = 115,
    _T = 116,
    _U = 117,
    _V = 118,
    _W = 119,
    _X = 120,
    _Y = 121,
    _Z = 122,
    _F1 = 282,
    _F2 = 283,
    _F3 = 284,
    _F4 = 285,
    _F5 = 286,
    _F6 = 287,
    _F7 = 288,
    _F8 = 289,
    _F9 = 290,
    _F10 = 291,
    _F11 = 292,
    _F12 = 293,
    _UP = 273,
    _DOWN = 274,
    _RIGHT = 275,
    _LEFT = 276,
    _PAGEUP = 280,
    _PAGEDOWN = 281,
    _0 = 48,
    _1 = 49,
    _2 = 50,
    _3 = 51,
    _4 = 52,
    _5 = 53,
    _6 = 54,
    _7 = 55,
    _8 = 56,
    _9 = 57,
}

local function getKey(num)
    for i, v in pairs(KEYCODE) do
        if v == num then
            return string.gsub(i, "_", "")
        end
    end
    return "nil"
end

-- inst.components.td1madao_leveler:getCurrentExp()
local Td1madao_skiller = Class(function(self, inst)
    self.inst = inst
    self.skillCD = {}
end)

-- get player real skill cd time
function Td1madao_skiller:getCD(tag)
    local inst = self.inst
    return inst.components.td1madao_attributer.attributes[string.upper(string.format("%sCD", tag))] * inst.cdtime * inst.changecdtimes
end

-- inst.components.Td1madao_skiller:addTask()
function Td1madao_skiller:addSkill(tag, hotkey, effect, _x, _y, condition, word, later, useToPoint, useToFriend)
    if not condition then
        condition = function() return true end
    end
    local effectPacker = function(...)
        if not later and not useToPoint and effect then
            effect(...)
        elseif self:castable(tag) and effect then
            effect(...)
        end
    end
    local function skillCast()
        local player = self.inst
        local inst = player
        -- any skill need a real weapon
        local weapon = player.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if not weapon then
            player.components.talker:Say(TUNING.LOLMEMBER.TALK15, nil, true)
            return
        end
        if self:castable(tag) then
            -- ������������ʩ��
            if inst[string.format("can%s", tag)] and condition() then
                inst[string.format("can%s", tag)] = false --�ص�ʩ��
                inst:AddTag(tag)
                inst:AddTag(string.format("skill%s", tag))
                self.skillCD[tag] = self:getCD(tag)
                effectPacker(inst)
            elseif not condition() then
                player.components.talker:Say(word, nil, true)
            end
        end
    end

    if not self.skillCD[tag] then
        self.skillCD[tag] = 0
    end
    -- refresh skill cd
    self.inst.components.td1madao_perioder:addTask("td1madaoPlayerSkillRecoverCD" .. tag, function()
        if not self.skillCD[tag] then
            self.skillCD[tag] = self:getCD(tag)
        end
        local ready = false
        if self.skillCD[tag] > 0 then
            ready = true
        end
        self.skillCD[tag] = self.skillCD[tag] - (self.inst["td1madaoCasting" .. tag] or 1)
        if self.skillCD[tag] < 0 then
            self.skillCD[tag] = 0
        end
        if self.skillCD[tag] <= 0 then
            local inst = self.inst
            inst[string.format("can%s", tag)] = true
            inst:RemoveTag(tag)
            inst:RemoveTag(string.format("skill%s", tag))
            if ready then
                inst:RemoveTag(string.format("%sbuffon", tag))
            end
        end
    end, 1)
    local skillBar = td1madao_getstr('jinenglan_%s', self.inst.prefab)
    self.inst[string.format("can%s", tag)] = true
    -- skill can cast to point
    if useToPoint then
        self.inst[string.format("useToPoint%s", tag)] = true
    else
        self.inst[string.format("useToPoint%s", tag)] = false
    end
    -- skill can cast to legal
    if useToFriend then
        self.inst[string.format("useToFriend%s", tag)] = true
    else
        self.inst[string.format("useToFriend%s", tag)] = false
    end
    -- this skill is not cast soon
    if later then
        self.inst[string.format("laterSkill%s", tag)] = true
    else
        self.inst[string.format("laterSkill%s", tag)] = false
    end

    local player = self.inst
    if not player or not self.inst.HUD[skillBar] then
        return
    end

    self.inst.HUD[tag] = self.inst.HUD[skillBar]:AddChild(ImageButton(string.format("images/%s_%s.xml", tag, self.inst.prefab), string.format("%s_%s.tex", tag, self.inst.prefab)))
    self.inst.HUD[tag]:SetPosition(_x, _y, 0)
    self.inst.HUD[tag]:SetScale(0.7,0.8,1)
    --self.inst.HUD[tag]:SetTooltip(tostring(getKey(hotkey)))
    self.inst.HUD[tag]:SetTooltip(tag)
    self.inst.HUD[tag]:MoveToFront()
    if later then
        self.inst.HUD[tag]:SetOnClick(effectPacker)
    else
        self.inst.HUD[tag]:SetOnClick(skillCast)
    end
    self.inst["text" .. tag] = self.inst.HUD[skillBar]:AddChild(Text(BODYTEXTFONT, 25))
    self.inst["text" .. tag]:SetPosition(_x, _y, 0)
    self.inst["text" .. tag]:SetColour(0, 1, 0, 1)
    self.inst["text" .. tag]:SetString("")
    self.inst.components.td1madao_perioder:addTask("td1madaoPlayerSkill" .. tag, function()
        if self.inst.HUD then
            if self.inst.components.td1madao_skiller.skillCD[tag] <= 0 then
                self.inst["text" .. tag]:SetColour(0, 1, 0, 1)
                --self.inst["text" .. tag]:SetString(tostring(getKey(hotkey)))
                self.inst["text" .. tag]:SetString(tag)
                if self.inst.HUD[tag] then
                    self.inst.HUD[tag].image:SetTint(1, 1, 1, 1)
                end
            else
                self.inst["text" .. tag]:SetColour(1, 0, 0, 1)
                self.inst["text" .. tag]:SetString(math.ceil(self.inst.components.td1madao_skiller.skillCD[tag]))
                if self.inst.HUD[tag] then
                    self.inst.HUD[tag].image:SetTint(0.2, 0.2, 0.2, 1)
                end
            end
        end
    end, 1)
    if later then
        TheInput:AddKeyDownHandler(hotkey, effectPacker)
    else
        TheInput:AddKeyDownHandler(hotkey, skillCast)
    end
end

-- save skill cd
function Td1madao_skiller:OnSave()
    return
    {
        skillCD = self.skillCD
    }
end

-- skill can be cast
-- GetPlayer().components.td1madao_skiller:castable()
function Td1madao_skiller:castable(tag)
    local player = GetPlayer()
    local weapon = player.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if tag and (not player[string.format("can%s", tag)] or self.skillCD[tag] > 0) then
        return false
    end
    return not IsPaused() and not TheInput:IsKeyDown(KEY_SHIFT)
            and not (player:HasTag("skillq") or player:HasTag("skillw") or player:HasTag("skille") or player:HasTag("skillr"))
            and weapon and not weapon:HasTag(td1madao_getstr('%sbowtype')) and not weapon:HasTag("notweapon")
end

-- reload skill cd
function Td1madao_skiller:OnLoad(data)
    if data ~= nil then
        if data.skillCD ~= nil then
            self.skillCD = data.skillCD
        else
            self.skillCD = {}
        end
    end
    for k, v in pairs(self.skillCD) do
        if v > 0 then
            self.inst[string.format("can%s", k)] = false
            self.inst:AddTag(k)
        end
    end
end

return Td1madao_skiller