-- Roact version by @sircfenner
-- Ported to Fusion by @YasuYoshida
-- Modified by iGottic

-- Constants
local HEADER_HEIGHT = 25

-- Imports
local Plugin = script:FindFirstAncestorWhichIsA("Plugin") or game
local Fusion = require(Plugin:FindFirstChild("Fusion", true))
local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")
local VerticalExpandingList = require(StudioComponents.VerticalExpandingList)
local BoxBorder = require(StudioComponents.BoxBorder)
local Label = require(StudioComponents.Label)
local getMotionState = require(StudioComponentsUtil.getMotionState)
local themeProvider = require(StudioComponentsUtil.themeProvider)
local getModifier = require(StudioComponentsUtil.getModifier)
local stripProps = require(StudioComponentsUtil.stripProps)
local constants = require(StudioComponentsUtil.constants)
local getState = require(StudioComponentsUtil.getState)
local unwrap = require(StudioComponentsUtil.unwrap)
local types = require(StudioComponentsUtil.types)
local Scope = Fusion.scoped(Fusion)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local Peek = Fusion.peek

-- Types Extended
type VerticalExpandingListProperties = {
	Enabled: (boolean | types.StateObject<boolean>)?,
	Collapsed: (boolean | types.Value<boolean>)?,
	Padding: (UDim | types.StateObject<UDim>)?,
	[any]: any,
}

-- Constants Extended
local COMPONENT_ONLY_PROPERTIES = {
	"Padding",
	"Collapsed",
	"Text",
	"TextColor3",
	"Enabled",
	Children,
}

return function(props: VerticalExpandingListProperties): Frame
	local shouldBeCollapsed = getState(props.Collapsed, false, "Value")
	local isEnabled = getState(props.Enabled, true)
	local isHovering = Scope:Value(false)

	local modifier = getModifier({
		Enabled = isEnabled,
		Hovering = isHovering,
		Otherwise = Scope:Computed(function(use)
			return if unwrap(themeProvider.IsDark, use) then Enum.StudioStyleGuideModifier.Default else Enum.StudioStyleGuideModifier.Pressed
		end),
	})

	local isCollapsed = Scope:Computed(function(use)
		local shouldBeCollapsed = unwrap(shouldBeCollapsed, use)
		local isEnabled = unwrap(isEnabled, use)
		return if isEnabled then shouldBeCollapsed else true
	end)

	local labelColor = themeProvider:GetColor(Enum.StudioStyleGuideColor.BrightText, modifier)
	local backgroundColor = themeProvider:GetColor(Enum.StudioStyleGuideColor.MainBackground)
	local themeColorModifier = Scope:Computed(function(use)
		local _, _, v = unwrap(backgroundColor, use):ToHSV()
		return if v<.5 then -1 else 1
	end)

	return Scope:Hydrate(VerticalExpandingList {
		Name = "VerticalCollapsibleSection",
		BackgroundTransparency = 1,
		--TODO: remove this +2 once BorderMode becomes a thing for UIStroke
		Size = UDim2.new(1, 0, 0, HEADER_HEIGHT+2),
		AutomaticSize = Scope:Computed(function(use)
			return unwrap(isCollapsed, use) and Enum.AutomaticSize.None or Enum.AutomaticSize.Y
		end),
		Padding = props.Padding,

		[Children] = {
			--TODO: remove this UIPadding and Frame once BorderMode becomes a thing for UIStroke
			-- until then, this will need to stay here
			Scope:New "UIPadding" {
				Name = "BorderUIPadding",
				PaddingRight = UDim.new(0, 1),
				PaddingLeft = UDim.new(0, 1),
				PaddingTop = UDim.new(0, 1),
				PaddingBottom = UDim.new(0, 1),
			},

			Scope:New "Frame" {
				Name = "BorderBottomPadding",
				LayoutOrder = 10^5,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 0),
			},
			
			BoxBorder {
				Color = getMotionState(themeProvider:GetColor(Enum.StudioStyleGuideColor.Border), "Spring", 40),

				[Children] = Scope:New "Frame" {
					Name = "CollapsibleSectionHeader",
					LayoutOrder = 0,
					Active = true,
					Size = UDim2.new(1, 0, 0, HEADER_HEIGHT),
					BackgroundColor3 = getMotionState(themeProvider:GetColor(Enum.StudioStyleGuideColor.HeaderSection, modifier), "Spring", 40),

					[OnEvent "InputBegan"] = function(inputObject)
						if not unwrap(isEnabled) then
							return
						elseif inputObject.UserInputType == Enum.UserInputType.MouseMovement then
							isHovering:set(true)
						elseif inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
							shouldBeCollapsed:set(not Peek(shouldBeCollapsed))
						end
					end,

					[OnEvent "InputEnded"] = function(inputObject)
						if not unwrap(isEnabled) then
							return
						elseif inputObject.UserInputType == Enum.UserInputType.MouseMovement then
							isHovering:set(false)
						end
					end,

					[Children] = {
						Scope:New "ImageLabel" {
							Name = "Icon",
							AnchorPoint = Vector2.new(0, 0.5),
							Position = UDim2.new(0, 7, 0.5, 0),
							Size = UDim2.fromOffset(10, 10),
							Image = "rbxassetid://5607705156",

							ImageColor3 = getMotionState(Scope:Computed(function()
								local baseColor = Color3.fromRGB(170, 170, 170)
								if unwrap(isEnabled) then
									return baseColor
								end
								local h, s, v = baseColor:ToHSV()
								return Color3.fromHSV(h, s, math.clamp(v - .2, 0, 1))
							end), "Spring", 40),

							ImageRectOffset = Scope:Computed(function(use)
								return Vector2.new(unwrap(isCollapsed, use) and 0 or 10, 0)
							end),

							ImageRectSize = Vector2.new(10, 10),
							BackgroundTransparency = 1,
						},

						Label {
							TextColor3 = getMotionState(Scope:Computed(function(use)
								local currentLabelColor = unwrap(props.TextColor3 or labelColor, use)
								local themeModifier = unwrap(themeColorModifier, use)

								if unwrap(isEnabled, use) then
									return currentLabelColor
								end

								local h, s, v = currentLabelColor:ToHSV()
								return Color3.fromHSV(h, s, math.clamp(v + .3 * themeModifier, 0, 1))
							end), "Spring", 40),

							TextXAlignment = Enum.TextXAlignment.Left,
							Font = themeProvider:GetFont("Bold"),
							TextSize = constants.TextSize,
							Text = props.Text or "HeaderText",
							Size = UDim2.fromScale(1, 1),

							[Children] = Scope:New "UIPadding" {
								PaddingLeft = UDim.new(0, 24),
							}
						}
					}
				}
			},

			props[Children],
		}
	})(stripProps(props, COMPONENT_ONLY_PROPERTIES))
end
