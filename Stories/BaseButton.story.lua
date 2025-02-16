local Story = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Imports
local PluginEssentials = ReplicatedStorage.PluginEssentials
local StudioComponents = PluginEssentials.StudioComponents
local BaseButton = require(StudioComponents.BaseButton)

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Scope = Fusion.scoped(Fusion)

Story.fusion = Fusion

Story.controls = {
    Enabled = true,
}

Story.story = function(Properties)
    local self = Scope:innerScope()

    local TestButton = BaseButton {
        Size = UDim2.fromOffset(100, 50),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Parent = Properties.target,

        Enabled = Properties.controls.Enabled,
    }

    table.insert(self, TestButton)

    return function()
        self:doCleanup()
    end
end

return Story