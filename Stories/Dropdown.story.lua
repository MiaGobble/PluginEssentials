-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Imports
local PluginEssentials = ReplicatedStorage.PluginEssentials
local StudioComponents = PluginEssentials.StudioComponents
local Dropdown = require(StudioComponents.Dropdown)

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Scope = Fusion.scoped(Fusion)

return function(Target)
    local self = Scope:innerScope()

    table.insert(self, Dropdown {
        Size = UDim2.fromOffset(150, 50),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Parent = Target,
        
        Options = {
            "Option 1",
            "Option 2",
            "Option 3",
            "Option 4",
            "Option 5",
            "Option 6",
        },

        OnSelected = function(option)

        end
    })

    return function()
        self:doCleanup()
    end
end