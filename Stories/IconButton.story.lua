-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Imports
local PluginEssentials = ReplicatedStorage.PluginEssentials
local StudioComponents = PluginEssentials.StudioComponents
local IconButton = require(StudioComponents.IconButton)

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Scope = Fusion.scoped(Fusion)

return function(Target)
    local self = Scope:innerScope()

    local TestButton = IconButton {
        Icon = "rbxassetid://5262570279",
        Enabled = true,

        Activated = function()

        end,

        Size = UDim2.fromOffset(100, 50),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Parent = Target,
    }

    table.insert(self, TestButton)

    return function()
        self:doCleanup()
    end
end