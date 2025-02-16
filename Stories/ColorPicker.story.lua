local Story = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Imports
local PluginEssentials = ReplicatedStorage.PluginEssentials
local StudioComponents = PluginEssentials.StudioComponents
local ColorPicker = require(StudioComponents.ColorPicker)

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Scope = Fusion.scoped(Fusion)

Story.fusion = Fusion

Story.controls = {
    Enabled = true,
    Value = Color3.fromRGB(255, 0, 0),
}

Story.story = function(Properties)
    local self = Scope:innerScope()

    table.insert(self, ColorPicker {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(200, 200),
        Parent = Properties.target,

        Enabled = Properties.controls.Enabled,
        Value = Properties.controls.Value,
    })

    return function()
        self:doCleanup()
    end
end

return Story