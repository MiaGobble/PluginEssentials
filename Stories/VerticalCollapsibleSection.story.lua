local Story = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Imports
local PluginEssentials = ReplicatedStorage.PluginEssentials
local StudioComponents = PluginEssentials.StudioComponents
local VerticalCollapsibleSection = require(StudioComponents.VerticalCollapsibleSection)
local BaseScrollFrame = require(StudioComponents.BaseScrollFrame)
local Label = require(StudioComponents.Label)

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Scope = Fusion.scoped(Fusion)
local Children = Fusion.Children

-- type VerticalExpandingListProperties = {
-- 	Enabled: (boolean | types.StateObject<boolean>)?,
-- 	Collapsed: (boolean | types.Value<boolean>)?,
-- 	Padding: (UDim | types.StateObject<UDim>)?,
-- 	[any]: any,
-- }

Story.fusion = Fusion

Story.controls = {
    Enabled = true,
    Collapsed = true,
}

Story.story = function(Properties)
    local self = Scope:innerScope()

    table.insert(self, VerticalCollapsibleSection {
        Padding = UDim.new(0, 5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Parent = Properties.target,

        Enabled = Properties.controls.Enabled,
        Collapsed = Properties.controls.Collapsed,

        [Children] = {
            BaseScrollFrame {
                Size = UDim2.new(1, 0, 0, 450),

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
            }
        }
    })

    return function()
        self:doCleanup()
    end
end

return Story