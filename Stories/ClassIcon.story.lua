local Story = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Imports
local PluginEssentials = ReplicatedStorage.PluginEssentials
local StudioComponents = PluginEssentials.StudioComponents
local ClassIcon = require(StudioComponents.ClassIcon)

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Scope = Fusion.scoped(Fusion)

Story.fusion = Fusion

Story.controls = {
    ClassName = "Part",
}

Story.story = function(Properties)
    local self = Scope:innerScope()

    table.insert(self, ClassIcon {
        ClassName = Properties.controls.ClassName,
        Size = UDim2.fromOffset(20, 20),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Parent = Properties.target,
    })
    
    return function()
        self:doCleanup()
    end
end

return Story