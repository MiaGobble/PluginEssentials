local Story = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Imports
local PluginEssentials = ReplicatedStorage.PluginEssentials
local StudioComponents = PluginEssentials.StudioComponents
local Dropdown = require(StudioComponents.Dropdown)

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Scope = Fusion.scoped(Fusion)

Story.fusion = Fusion

Story.controls = {
    Enabled = true,
    MaxVisibleItems = 5,
    OptionCount = 6,
}

Story.story = function(Properties)
    local self = Scope:innerScope()

    table.insert(self, Dropdown {
        Size = UDim2.fromOffset(150, 50),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Parent = Properties.target,
        
        Options = self:Computed(function(use)
            local Options = {}

            for i = 1, use(Properties.controls.OptionCount) do
                table.insert(Options, `Test Option {i}`)
            end

            return Options
        end),

        Enabled = Properties.controls.Enabled,
        MaxVisibleItems = Properties.controls.MaxVisibleItems,
    })

    return function()
        self:doCleanup()
    end
end

return Story