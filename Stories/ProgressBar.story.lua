local Story = {}

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

Story.fusion = Fusion

Story.controls = {
    Progress = 0.5,
}

Story.story = function(Properties)
    local self = Scope:innerScope()

    table.insert(self, ProgressBar {
        Progress = Properties.controls.Progress,
        Size = UDim2.fromOffset(400, 20),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Parent = Properties.target,
    })

    return function()
        self:doCleanup()
    end
end

return Story