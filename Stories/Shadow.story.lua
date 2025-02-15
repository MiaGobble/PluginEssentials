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

return function(Target)
    local self = Scope:innerScope()

    table.insert(self, Background {
        Parent = Target,
        Size = UDim2.fromScale(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),

        [Children] = {
            self:New "UIStroke" {
                Thickness = 1,
            },

            Shadow {
                Side = "bottom",
            }
        }
    })

    return function()
        self:doCleanup()
    end
end