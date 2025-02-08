-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Imports
local PluginEssentials = ReplicatedStorage.PluginEssentials
local StudioComponents = PluginEssentials.StudioComponents
local ClassIcon = require(StudioComponents.ClassIcon)

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Scope = Fusion.scoped(Fusion)

return function(Target)
    local self = Scope:innerScope()

    table.insert(self, ClassIcon {
        ClassName = "Part",
        Size = UDim2.fromOffset(50, 50),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.4, 0.5),
        Parent = Target,
    })

    table.insert(self, ClassIcon {
        ClassName = "Actor",
        Size = UDim2.fromOffset(50, 50),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Parent = Target,
    })

    table.insert(self, ClassIcon {
        ClassName = "Script",
        Size = UDim2.fromOffset(50, 50),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.6, 0.5),
        Parent = Target,
    })

    return function()
        self:doCleanup()
    end
end