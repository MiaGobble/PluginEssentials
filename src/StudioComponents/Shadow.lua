-- Types
type ShadowProperties = {
    Side: string,
	Transparency: number?,
	[any]: any,
}

-- Imports
local Plugin = script:FindFirstAncestorWhichIsA("Plugin") or game
local Fusion = require(Plugin:FindFirstChild("Fusion", true))
local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")
local themeProvider = require(StudioComponentsUtil.themeProvider)
local constants = require(StudioComponentsUtil.constants)
local unwrap = require(StudioComponentsUtil.unwrap)
local Scope = Fusion.scoped(Fusion)

local SideData = {
	top = {
		image = "rbxassetid://6528009956",
		size = Scope:Computed(function(use)
			return UDim2.new(1,0,0,use(constants.TextSize))
		end),
		position = Scope:Computed(function(use)
			return UDim2.new(0,0,0,use(constants.TextSize))
		end)
	},

	bottom = {
		image = "rbxassetid://6185927567",
		size = Scope:Computed(function(use)
			return UDim2.new(1,0,0,use(constants.TextSize))
		end),
		position = Scope:Computed(function(use)
			return UDim2.new(0,0,1,0)
		end)
	},

	left = {
		image = "rbxassetid://6978297327",
		size = Scope:Computed(function(use)
			return UDim2.new(0,use(constants.TextSize),1,0)
		end),
		position = Scope:Computed(function(use)
			return UDim2.new(0,use(constants.TextSize),0,0)
		end)
	},

	right = {
		image = "rbxassetid://6441569774",
		size = Scope:Computed(function(use)
			return UDim2.new(0,use(constants.TextSize),1,0)
		end),
		position = Scope:Computed(function(use)
			return UDim2.new(1,0,0,0)
		end)
	},
}


return function(props: ShadowProperties): Frame
	local Side = SideData[string.lower(props.Side or "right")]

	return Scope:New "ImageLabel" { -- Shadow
		Name = "Shadow",
		BackgroundTransparency = 1,
		LayoutOrder = props.LayoutOrder or 10000,
		Image = Side.image,
		ImageTransparency = Scope:Computed(function(use)
			if not unwrap(themeProvider.IsDark, use)then
				-- Softer shadows on light themes
				return ((props.Transparency or 0) * 0.55) + 0.45
			else
				return props.Transparency or 0
			end
		end),

		Size = Side.size,
		Position = Side.position,
	}
end
