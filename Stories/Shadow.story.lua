local Story = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Imports
local PluginEssentials = ReplicatedStorage.PluginEssentials
local StudioComponents = PluginEssentials.StudioComponents
local Shadow = require(StudioComponents.Shadow)
local Background = require(StudioComponents.Background)

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Scope = Fusion.scoped(Fusion)
local Children = Fusion.Children

Story.fusion = Fusion

Story.controls = {
    Side = "bottom"
}

Story.story = function(Properties)
    local self = Scope:innerScope()

    table.insert(self, Background {
        Parent = Properties.target,
        Size = UDim2.fromScale(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),

        [Children] = {
            Shadow {
                Side = Properties.controls.Side,
            }
        }
    })

    return function()
        self:doCleanup()
    end
end

return Story