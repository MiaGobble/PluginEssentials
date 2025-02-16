-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Imports
local PluginEssentials = ReplicatedStorage.PluginEssentials
local StudioComponents = PluginEssentials.StudioComponents
local Slider = require(StudioComponents.Slider)

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Scope = Fusion.scoped(Fusion)

return function(Target)
    local self = Scope:innerScope()

    table.insert(self, Slider {
        Size = UDim2.fromOffset(200, 30),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Parent = Target,

        OnChange = function(newValue)
            
        end,

        Min = 1,
        Max = 10,
        Step = 1,
    })

    return function()
        self:doCleanup()
    end
end