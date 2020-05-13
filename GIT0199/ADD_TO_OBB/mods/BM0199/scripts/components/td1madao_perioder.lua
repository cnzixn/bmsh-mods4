--[[
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- Do not modify and republish my mods .Respect copyright. 3Q for cooperation
 -- @Description: create period task
 -- If any question ,Please email me using Chinese to let me distinguish whether it is spam
 -- @version 1.0.0
 -- @author td1madao
 -- @email td1madao@163.com
 -- @qq 360810498
 -- @date 16/8/6
 ]]
local Td1madao_perioder = Class(function(self, inst)
    self.inst = inst
    self.taskList = {}
    self.time = 0
    self.task = self.inst:DoPeriodicTask(1, function()
        for i, v in pairs(self.taskList) do
            local myTask = self.taskList[i]
            if myTask and myTask.run and myTask.period and self.time % myTask.period == 0 then
                myTask.run()
            end
        end
        self.time = self.time + 1
        -- I don not believe anyone can play my mod continuously more than one day......
        if self.time > 86400 then
            self.time = 0
        end
    end)
end)

-- inst.components.td1madao_perioder:addTask()
function Td1madao_perioder:addTask(name, run, period)
    self:removeTask(name)
    if self.taskList then
        self.taskList[name] = {}
        self.taskList[name].run = run
        self.taskList[name].period = period
    end
end

-- inst.components.td1madao_perioder:removeTask()
function Td1madao_perioder:removeTask(name)
    if self.taskList and self.taskList[name] then
        self.taskList[name].run = nil
        self.taskList[name].period = nil
        self.taskList[name] = nil
    end
end

function Td1madao_perioder:hasTask(name)
    return self.taskList and self.taskList[name] and self.taskList[name].run
end

return Td1madao_perioder