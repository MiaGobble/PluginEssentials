local Story = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Imports
local PluginEssentials = ReplicatedStorage.PluginEssentials
local StudioComponents = PluginEssentials.StudioComponents
local Slider = require(StudioComponents.Slider)

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Scope = Fusion.scoped(Fusion)

local COMPONENT_ONLY_PROPERTIES = {
	"ZIndex",
	"HandleSize",
	"OnChange",
	"Value",
	"Min",
	"Max",
	"Step",
	"Enabled",
}

Story.fusion = Fusion

Story.controls = {
    Value = 5,
    Min = 1,
    Max = 10,
    Step = 1,
    Enabled = true,
}

Story.story = function(Properties)
    local self = Scope:innerScope()

    table.insert(self, Slider {
        Size = UDim2.fromOffset(200, 30),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Parent = Properties.target,

        Value = Properties.controls.Value,
        Min = Properties.controls.Min,
        Max = Properties.controls.Max,
        Step = Properties.controls.Step,
        Enabled = Properties.controls.Enabled,
    })

    return function()
        self:doCleanup()
    end
end

return Story