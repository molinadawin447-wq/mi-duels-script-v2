--========================================================
-- 🕷 SPIDER.VS HUB
-- UI COMPLETA
--========================================================

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--========================================================
-- CONFIGURACIÓN
--========================================================

local BUTTON_IMAGE = "Telaraña.jpg"
local AUTOSTEAL_IMAGE = "Telarañaautosteal.jpg"

local WHITE = Color3.fromRGB(255,255,255)
local BLACK = Color3.fromRGB(0,0,0)
local DARK = Color3.fromRGB(35,35,35)

--========================================================
-- BORRAR GUI ANTERIOR
--========================================================

local oldGui = PlayerGui:FindFirstChild("SpiderVS_GUI")

if oldGui then
    oldGui:Destroy()
end

--========================================================
-- SCREEN GUI
--========================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpiderVS_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

--========================================================
-- CONTENEDOR DE BOTONES DERECHA
--========================================================

local Container = Instance.new("Frame")
Container.Name = "ButtonContainer"
Container.BackgroundTransparency = 1
Container.AnchorPoint = Vector2.new(1,0)
Container.Position = UDim2.new(1,-5,0,10)
Container.Size = UDim2.fromOffset(300,300)
Container.Parent = ScreenGui

--========================================================
-- BOTONES
--========================================================

local ButtonNames = {
    "TP\nBAT",
    "INSTA\nRESET",
    "BYPASS\nANTIBAT",
    "AUTO\nRIGHT",
    "BAT\nAIMBOT",
    "TP\nDOWN",
    "LAGGER 1",
    "AUTO\nLEFT",
    "DROP BR",
    "CARRY SPD",
    "LAGGER 2"
}

--========================================================
-- CREAR BOTÓN
--========================================================

local function createButton(name, index)

    local Button = Instance.new("ImageButton")

    Button.Name = "Button_" .. index
    Button.Size = UDim2.fromOffset(63,63)
    Button.BackgroundColor3 = BLACK
    Button.BackgroundTransparency = 0
    Button.BorderSizePixel = 0

    Button.Image = getcustomasset(BUTTON_IMAGE)
    Button.ScaleType = Enum.ScaleType.Crop

    Button.AutoButtonColor = false

    -- Posición en columna
    local column = math.floor((index - 1) / 4)
    local row = (index - 1) % 4

    Button.Position = UDim2.fromOffset(
        column * 70,
        row * 70
    )

    Button.ZIndex = 20
    Button.Parent = Container

    -- Bordes redondos
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0,20)
    Corner.Parent = Button

    -- Borde
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = WHITE
    Stroke.Thickness = 1
    Stroke.Transparency = 0.25
    Stroke.Parent = Button

    -- Texto
    local Text = Instance.new("TextLabel")
    Text.Name = "Text"
    Text.Size = UDim2.new(1,-4,1,-4)
    Text.Position = UDim2.fromOffset(2,2)

    Text.BackgroundTransparency = 1
    Text.Text = name

    Text.TextColor3 = WHITE
    Text.Font = Enum.Font.GothamBold
    Text.TextSize = 13

    Text.TextWrapped = true
    Text.TextScaled = false

    Text.TextXAlignment = Enum.TextXAlignment.Center
    Text.TextYAlignment = Enum.TextYAlignment.Center

    Text.ZIndex = 21
    Text.Parent = Button

    -- Brillo diagonal
    local Gradient = Instance.new("UIGradient")

    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(
            0.00,
            WHITE
        ),

        ColorSequenceKeypoint.new(
            0.42,
            WHITE
        ),

        ColorSequenceKeypoint.new(
            0.50,
            DARK
        ),

        ColorSequenceKeypoint.new(
            0.58,
            WHITE
        ),

        ColorSequenceKeypoint.new(
            1.00,
            WHITE
        )
    })

    Gradient.Rotation = 45
    Gradient.Offset = Vector2.new(-1.5,-1.5)
    Gradient.Parent = Text

    task.spawn(function()

        while Button.Parent do

            Gradient.Offset =
                Vector2.new(-1.5,-1.5)

            local Tween = TweenService:Create(
                Gradient,

                TweenInfo.new(
                    1.8,
                    Enum.EasingStyle.Linear
                ),

                {
                    Offset =
                        Vector2.new(1.5,1.5)
                }
            )

            Tween:Play()
            Tween.Completed:Wait()

            task.wait(0.25)
        end
    end)

    -- Efecto al tocar
    Button.MouseButton1Down:Connect(function()

        TweenService:Create(
            Button,

            TweenInfo.new(
                0.08,
                Enum.EasingStyle.Quad
            ),

            {
                Size = UDim2.fromOffset(58,58)
            }
        ):Play()
    end)

    Button.MouseButton1Up:Connect(function()

        TweenService:Create(
            Button,

            TweenInfo.new(
                0.08,
                Enum.EasingStyle.Quad
            ),

            {
                Size = UDim2.fromOffset(63,63)
            }
        ):Play()
    end)

    -- Aquí puedes conectar una función permitida
    Button.Activated:Connect(function()
        print("Botón presionado:", name)
    end)

    return Button
end

-- Crear los 11 botones
for i,name in ipairs(ButtonNames) do
    createButton(name,i)
end

--========================================================
-- SOMBRA DE LA BARRA
--========================================================

local Shadow = Instance.new("Frame")

Shadow.Name = "AutoStealShadow"
Shadow.Size = UDim2.fromOffset(390,40)

Shadow.AnchorPoint = Vector2.new(0.5,1)
Shadow.Position = UDim2.new(0.5,5,1,-60)

Shadow.BackgroundColor3 = BLACK
Shadow.BackgroundTransparency = 0.3
Shadow.BorderSizePixel = 0

Shadow.ZIndex = 99
Shadow.Parent = ScreenGui

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0,16)
ShadowCorner.Parent = Shadow

--========================================================
-- BARRA SPIDER.VS
--========================================================

local Frame = Instance.new("Frame")

Frame.Name = "AutoStealBar"

Frame.Size = UDim2.fromOffset(380,34)

Frame.AnchorPoint = Vector2.new(0.5,1)
Frame.Position = UDim2.new(0.5,0,1,-65)

Frame.BackgroundTransparency = 1
Frame.BorderSizePixel = 0

Frame.Active = true
Frame.ClipsDescendants = true
Frame.ZIndex = 100

Frame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0,14)
FrameCorner.Parent = Frame

--========================================================
-- FONDO Telarañaautosteal.jpg
--========================================================

local Background = Instance.new("ImageLabel")

Background.Name = "TelarañaAutoSteal"

Background.Size = UDim2.new(1,0,1,0)
Background.Position = UDim2.fromOffset(0,0)

Background.BackgroundTransparency = 1
Background.BorderSizePixel = 0

Background.Image =
    getcustomasset(AUTOSTEAL_IMAGE)

Background.ScaleType = Enum.ScaleType.Crop

Background.ZIndex = 100
Background.Parent = Frame

local BackgroundCorner = Instance.new("UICorner")
BackgroundCorner.CornerRadius = UDim.new(0,14)
BackgroundCorner.Parent = Background

--========================================================
-- BORDE
--========================================================

local FrameStroke = Instance.new("UIStroke")

FrameStroke.Color = WHITE
FrameStroke.Thickness = 1.5
FrameStroke.Transparency = 0.15

FrameStroke.Parent = Frame

--========================================================
-- 🕷SPIDER.VS
--========================================================

local SpiderText = Instance.new("TextLabel")

SpiderText.Name = "SpiderVS"

SpiderText.Size = UDim2.fromOffset(125,34)
SpiderText.Position = UDim2.fromOffset(4,0)

SpiderText.BackgroundTransparency = 1

SpiderText.Text = "🕷SPIDER.VS"

SpiderText.TextColor3 = WHITE
SpiderText.Font = Enum.Font.GothamBold
SpiderText.TextSize = 14

SpiderText.TextXAlignment = Enum.TextXAlignment.Center
SpiderText.TextYAlignment = Enum.TextYAlignment.Center

SpiderText.ZIndex = 110
SpiderText.Parent = Frame

--========================================================
-- BRILLO DEL TEXTO
--========================================================

local SpiderGradient = Instance.new("UIGradient")

SpiderGradient.Color = ColorSequence.new({

    ColorSequenceKeypoint.new(
        0,
        WHITE
    ),

    ColorSequenceKeypoint.new(
        0.42,
        WHITE
    ),

    ColorSequenceKeypoint.new(
        0.50,
        DARK
    ),

    ColorSequenceKeypoint.new(
        0.58,
        WHITE
    ),

    ColorSequenceKeypoint.new(
        1,
        WHITE
    )
})

SpiderGradient.Rotation = 45
SpiderGradient.Offset = Vector2.new(-1.5,-1.5)

SpiderGradient.Parent = SpiderText

task.spawn(function()

    while SpiderText.Parent do

        SpiderGradient.Offset =
            Vector2.new(-1.5,-1.5)

        local Tween = TweenService:Create(
            SpiderGradient,

            TweenInfo.new(
                1.8,
                Enum.EasingStyle.Linear
            ),

            {
                Offset =
                    Vector2.new(1.5,1.5)
            }
        )

        Tween:Play()
        Tween.Completed:Wait()

        task.wait(0.25)
    end
end)

--========================================================
-- PORCENTAJE
--========================================================

local Percentage = Instance.new("TextLabel")

Percentage.Name = "Percentage"

Percentage.Size = UDim2.fromOffset(45,34)
Percentage.Position = UDim2.fromOffset(132,0)

Percentage.BackgroundTransparency = 1

Percentage.Text = "0%"
Percentage.TextColor3 = WHITE
Percentage.Font = Enum.Font.GothamBold
Percentage.TextSize = 14

Percentage.TextXAlignment = Enum.TextXAlignment.Center
Percentage.TextYAlignment = Enum.TextYAlignment.Center

Percentage.ZIndex = 110
Percentage.Parent = Frame

--========================================================
-- FONDO DE CARGA
--========================================================

local BarBackground = Instance.new("Frame")

BarBackground.Name = "LoadingBackground"

BarBackground.Size = UDim2.fromOffset(100,18)
BarBackground.Position = UDim2.fromOffset(184,8)

BarBackground.BackgroundColor3 =
    Color3.fromRGB(35,35,35)

BarBackground.BackgroundTransparency = 0.25
BarBackground.BorderSizePixel = 0

BarBackground.ClipsDescendants = true

BarBackground.ZIndex = 110
BarBackground.Parent = Frame

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(1,0)
BarCorner.Parent = BarBackground

--========================================================
-- BARRA BLANCA
--========================================================

local LoadingBar = Instance.new("Frame")

LoadingBar.Name = "WhiteLoadingBar"

LoadingBar.Size = UDim2.new(0,0,1,0)

LoadingBar.BackgroundColor3 = WHITE
LoadingBar.BorderSizePixel = 0

LoadingBar.ZIndex = 111
LoadingBar.Parent = BarBackground

local LoadingCorner = Instance.new("UICorner")
LoadingCorner.CornerRadius = UDim.new(1,0)
LoadingCorner.Parent = LoadingBar

--========================================================
-- SEPARADOR
--========================================================

local Separator = Instance.new("Frame")

Separator.Name = "Separator"

Separator.Size = UDim2.fromOffset(1.5,20)
Separator.Position = UDim2.fromOffset(291,7)

Separator.BackgroundColor3 = WHITE
Separator.BackgroundTransparency = 0.25

Separator.BorderSizePixel = 0

Separator.ZIndex = 110
Separator.Parent = Frame

--========================================================
-- FPS
--========================================================

local FPSLabel = Instance.new("TextLabel")

FPSLabel.Name = "FPS"

FPSLabel.Size = UDim2.fromOffset(55,34)
FPSLabel.Position = UDim2.fromOffset(298,0)

FPSLabel.BackgroundTransparency = 1

FPSLabel.Text = "FPS: 0"

FPSLabel.TextColor3 = WHITE
FPSLabel.Font = Enum.Font.Gotham
FPSLabel.TextSize = 11

FPSLabel.TextXAlignment = Enum.TextXAlignment.Left
FPSLabel.TextYAlignment = Enum.TextYAlignment.Center

FPSLabel.ZIndex = 110
FPSLabel.Parent = Frame

--========================================================
-- PING
--========================================================

local PingLabel = Instance.new("TextLabel")

PingLabel.Name = "PING"

PingLabel.Size = UDim2.fromOffset(65,34)
PingLabel.Position = UDim2.fromOffset(310,0)

PingLabel.BackgroundTransparency = 1

PingLabel.Text = "PING: 0ms"

PingLabel.TextColor3 = WHITE
PingLabel.Font = Enum.Font.Gotham
PingLabel.TextSize = 11

PingLabel.TextXAlignment = Enum.TextXAlignment.Right
PingLabel.TextYAlignment = Enum.TextYAlignment.Center

PingLabel.ZIndex = 110
PingLabel.Parent = Frame

--========================================================
-- ÁREA PARA ARRASTRAR
--========================================================

local DragButton = Instance.new("TextButton")

DragButton.Name = "DragButton"

DragButton.Size = UDim2.new(1,0,1,0)

DragButton.BackgroundTransparency = 1
DragButton.BorderSizePixel = 0

DragButton.Text = ""
DragButton.AutoButtonColor = false

DragButton.ZIndex = 120
DragButton.Parent = Frame

--========================================================
-- DRAG
--========================================================

local Dragging = false
local DragStart
local StartPosition

DragButton.InputBegan:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or Input.UserInputType ==
        Enum.UserInputType.Touch then

        Dragging = true
        DragStart = Input.Position
        StartPosition = Frame.Position

        Input.Changed:Connect(function()

            if Input.UserInputState ==
                Enum.UserInputState.End then

                Dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(Input)

    if not Dragging then
        return
    end

    if Input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or Input.UserInputType ==
        Enum.UserInputType.Touch then

        local Delta =
            Input.Position - DragStart

        Frame.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,

            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )

        Shadow.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X + 5,

            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y + 5
        )
    end
end)

--========================================================
-- ANIMACIÓN DE LA BARRA
--========================================================

local Progress = 0
local Duration = 0.5

RunService.RenderStepped:Connect(function(DeltaTime)

    if not Frame.Visible then
        return
    end

    Progress += DeltaTime / Duration

    if Progress >= 1 then
        Progress = 0
    end

    local Value =
        math.clamp(Progress,0,1)

    LoadingBar.Size =
        UDim2.new(Value,0,1,0)

    Percentage.Text =
        math.floor(Value * 100 + 0.5) .. "%"
end)

--========================================================
-- FPS / PING
--========================================================

local Frames = 0
local LastUpdate = tick()

RunService.RenderStepped:Connect(function()

    Frames += 1

    local Now = tick()

    if Now - LastUpdate >= 1 then

        local FPS =
            math.floor(
                Frames /
                (Now - LastUpdate)
            )

        FPSLabel.Text =
            "FPS: " .. tostring(FPS)

        Frames = 0
        LastUpdate = Now

        local Ping = 0

        pcall(function()

            Ping = math.floor(
                Stats.Network.ServerStatsItem
                ["Data Ping"]:GetValue()
            )
        end)

        PingLabel.Text =
            "PING: " ..
            tostring(Ping) ..
            "ms"
    end
end)

--========================================================
-- FUNCIÓN DE VISIBILIDAD
--========================================================

_G._CursedSetProgressBarVisible =
    function(Value)

        Frame.Visible = Value
        Shadow.Visible = Value

    end

print("🕷 SPIDER.VS UI cargada correctamente")