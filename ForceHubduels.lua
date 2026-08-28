-- Botón FORCE HUB
local forceButton = Instance.new("TextButton")
forceButton.Name = "ForceHub"
forceButton.Size = UDim2.new(0, 150, 0, 55)
forceButton.Position = UDim2.new(0, 15, 0.5, -27)
forceButton.AnchorPoint = Vector2.new(0, 0)

forceButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
forceButton.BorderSizePixel = 0

forceButton.Text = "FORCE HUB"
forceButton.TextColor3 = Color3.fromRGB(200, 200, 200)
forceButton.TextSize = 18
forceButton.Font = Enum.Font.GothamBold
forceButton.TextScaled = false

local forceCorner = Instance.new("UICorner")
forceCorner.CornerRadius = UDim.new(0, 12)
forceCorner.Parent = forceButton

forceButton.Parent = screenGui

-- Movimiento con el dedo
local UserInputService = game:GetService("UserInputService")

local moviendo = false
local inicioToque
local inicioPos

forceButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseButton1 then

		moviendo = true
		inicioToque = input.Position
		inicioPos = forceButton.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if not moviendo then
		return
	end

	if input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseMovement then

		local desplazamiento = input.Position - inicioToque

		forceButton.Position = UDim2.new(
			inicioPos.X.Scale,
			inicioPos.X.Offset + desplazamiento.X,
			inicioPos.Y.Scale,
			inicioPos.Y.Offset + desplazamiento.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseButton1 then

		moviendo = false
	end
end)