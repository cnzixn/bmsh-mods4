--name = "garen"

name = "BM0199"
description = "(人物)盖伦\n移植者:  灰太狼"
author = "TD1MADAO"
version = "f1.0.1"
forumthread = "http://steamcommunity.com/sharedfiles/filedetails/?id=652675604"
api_version = 6
dont_starve_compatible = true
reign_of_giants_compatible = true
dst_compatible = true
shipwrecked_compatible = true
icon_atlas = "modicon.xml"
icon = "modicon.tex"

local op = {
    { description = "TAB", data = 9 },
    { description = "KP_PERIOD", data = 266 },
    { description = "KP_DIVIDE", data = 267 },
    { description = "KP_MULTIPLY", data = 268 },
    { description = "KP_MINUS", data = 269 },
    { description = "KP_PLUS", data = 270 },
    { description = "KP_ENTER", data = 271 },
    { description = "KP_EQUALS", data = 272 },
    { description = "MINUS", data = 45 },
    { description = "EQUALS", data = 61 },
    { description = "SPACE", data = 32 },
    { description = "ENTER", data = 13 },
    { description = "ESCAPE", data = 27 },
    { description = "HOME", data = 278 },
    { description = "INSERT", data = 277 },
    { description = "DELETE", data = 127 },
    { description = "END", data = 279 },
    { description = "PAUSE", data = 19 },
    { description = "PRINT", data = 316 },
    { description = "CAPSLOCK", data = 301 },
    { description = "SCROLLOCK", data = 302 },
    { description = "RSHIFT", data = 303 },
    { description = "LSHIFT", data = 304 },
    { description = "RCTRL", data = 305 },
    { description = "LCTRL", data = 306 },
    { description = "RALT", data = 307 },
    { description = "LALT", data = 308 },
    { description = "ALT", data = 400 },
    { description = "CTRL", data = 401 },
    { description = "SHIFT", data = 402 },
    { description = "BACKSPACE", data = 8 },
    { description = "PERIOD", data = 46 },
    { description = "SLASH", data = 47 },
    { description = "LEFTBRACKET", data = 91 },
    { description = "BACKSLASH", data = 92 },
    { description = "RIGHTBRACKET", data = 93 },
    { description = "TILDE", data = 96 },
    { description = "A", data = 97 },
    { description = "B", data = 98 },
    { description = "C", data = 99 },
    { description = "D", data = 100 },
    { description = "E", data = 101 },
    { description = "F", data = 102 },
    { description = "G", data = 103 },
    { description = "H", data = 104 },
    { description = "I", data = 105 },
    { description = "J", data = 106 },
    { description = "K", data = 107 },
    { description = "L", data = 108 },
    { description = "M", data = 109 },
    { description = "N", data = 110 },
    { description = "O", data = 111 },
    { description = "P", data = 112 },
    { description = "Q", data = 113 },
    { description = "R", data = 114 },
    { description = "S", data = 115 },
    { description = "T", data = 116 },
    { description = "U", data = 117 },
    { description = "V", data = 118 },
    { description = "W", data = 119 },
    { description = "X", data = 120 },
    { description = "Y", data = 121 },
    { description = "Z", data = 122 },
    { description = "F1", data = 282 },
    { description = "F2", data = 283 },
    { description = "F3", data = 284 },
    { description = "F4", data = 285 },
    { description = "F5", data = 286 },
    { description = "F6", data = 287 },
    { description = "F7", data = 288 },
    { description = "F8", data = 289 },
    { description = "F9", data = 290 },
    { description = "F10", data = 291 },
    { description = "F11", data = 292 },
    { description = "F12", data = 293 },

    { description = "UP", data = 273 },
    { description = "DOWN", data = 274 },
    { description = "RIGHT", data = 275 },
    { description = "LEFT", data = 276 },
    { description = "PAGEUP", data = 280 },
    { description = "PAGEDOWN", data = 281 },

    { description = "0", data = 48 },
    { description = "1", data = 49 },
    { description = "2", data = 50 },
    { description = "3", data = 51 },
    { description = "4", data = 52 },
    { description = "5", data = 53 },
    { description = "6", data = 54 },
    { description = "7", data = 55 },
    { description = "8", data = 56 },
    { description = "9", data = 57 },
}

configuration_options =
{
    {
        name = "reborn",
        label = "死亡重生",
        hover = "reborn",
        options = {
            { description = "开", data = 0 },
            { description = "关", data = 1 },
        },
        default = 0,
    },
    {
        name = "SmartCast",
        label = "智能钓鱼",
        hover = "SmartCast",
        options = {
            { description = "开", data = 0 },
            { description = "关", data = 1 },
        },
        default = 0,
    },
    {
        name = "difficulty",
        label = "选择难度",
        hover = "difficulty",
        options = {
            { description = "容易", data = 0 },
            { description = "普通", data = 1 },
            { description = "困难", data = 2 },
        },
        default = 1,
    },
    
 --[[   
    {
        name = "key1",
        label = "Q skill",
        hover = "Q skill",
        options = op,
        default = 116,
    },

    {
        name = "key2",
        label = "W skill",
        hover = "W skill",
        options = op,
        default = 121,
    },

    {
        name = "key3",
        label = "E skill",
        hover = "E skill",
        options = op,
        default = 117,
    },

    {
        name = "key4",
        label = "R skill",
        hover = "R skill",
        options = op,
        default = 105,
    },
    
   -- ]]
}