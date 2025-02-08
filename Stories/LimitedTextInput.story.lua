-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Imports
local PluginEssentials = ReplicatedStorage.PluginEssentials
local StudioComponents = PluginEssentials.StudioComponents
local LimitedTextInput = require(StudioComponents.LimitedTextInput)

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Scope = Fusion.scoped(Fusion)

return function(Target)
    local self = Scope:innerScope()

    table.insert(self, LimitedTextInput {
        Text = "",
        TextLimit = 5,
        PlaceholderText = "Max 5 chars",
        Size = UDim2.fromOffset(100, 50),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Parent = Target,
    })

    return function()
        self:doCleanup()
    end
end