-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Imports
local PluginEssentials = ReplicatedStorage.PluginEssentials
local StudioComponents = PluginEssentials.StudioComponents
local ProgressBar = require(StudioComponents.ProgressBar)

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Scope = Fusion.scoped(Fusion)
local Peek = Fusion.peek

return function(Target)
    local self = Scope:innerScope()

    local Progress = self:Value(0)
    local LastUpdate = os.clock()

    table.insert(self, ProgressBar {
        Progress = Progress,
        Size = UDim2.fromOffset(300, 20),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Parent = Target,
    })

    table.insert(self, RunService.RenderStepped:Connect(function()
        if os.clock() - LastUpdate < 0.5 then
            return
        end

        LastUpdate = os.clock()

        if Peek(Progress) < 1 then
            Progress:set(Peek(Progress) + 0.1)
            return
        end

        Progress:set(0)
    end))

    return function()
        self:doCleanup()
    end
end