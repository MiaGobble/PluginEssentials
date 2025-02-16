local Story = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Imports
local PluginEssentials = ReplicatedStorage.PluginEssentials
local StudioComponents = PluginEssentials.StudioComponents
local Checkbox = require(StudioComponents.Checkbox)

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Scope = Fusion.scoped(Fusion)

Story.fusion = Fusion

Story.controls = {
    Value = true,
    Enabled = true,
    Text = "Checkbox",
}

Story.story = function(Properties)
    local self = Scope:innerScope()

    local TestCheckbox = Checkbox {
        Size = UDim2.fromOffset(100, 50),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Parent = Properties.target,

        Value = Properties.controls.Value,
        Enabled = Properties.controls.Enabled,
        Text = Properties.controls.Text,
    }

    table.insert(self, TestCheckbox)

    return function()
        self:doCleanup()
    end
end

return Story