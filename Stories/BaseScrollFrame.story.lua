local Story = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Imports
local PluginEssentials = ReplicatedStorage.PluginEssentials
local StudioComponents = PluginEssentials.StudioComponents
local BaseScrollFrame = require(StudioComponents.BaseScrollFrame)
local Label = require(StudioComponents.Label)

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Scope = Fusion.scoped(Fusion)
local Children = Fusion.Children

Story.fusion = Fusion

Story.controls = {
    ScrollingEnabled = true,
    ScrollBarThickness = 10,
}

Story.story = function(Properties)
    local self = Scope:innerScope()

    table.insert(self, BaseScrollFrame {
        Size = UDim2.fromOffset(150, 450),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Parent = Properties.target,

        ScrollingEnabled = Properties.controls.ScrollingEnabled,
        ScrollBarThickness = Properties.controls.ScrollBarThickness,

        [Children] = {
            Scope:New "UIListLayout" {
                Padding = UDim.new(0, 5),
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Top,
            },

            Label {
                Text = "Hello, World!",
                Size = UDim2.new(1, 0, 0, 50),
            },

            Label {
                Text = "Hello, World!",
                Size = UDim2.new(1, 0, 0, 50),
            },

            Label {
                Text = "Hello, World!",
                Size = UDim2.new(1, 0, 0, 50),
            },

            Label {
                Text = "Hello, World!",
                Size = UDim2.new(1, 0, 0, 50),
            },

            Label {
                Text = "Hello, World!",
                Size = UDim2.new(1, 0, 0, 50),
            },
        }
    })

    return function()
        self:doCleanup()
    end
end

return Story