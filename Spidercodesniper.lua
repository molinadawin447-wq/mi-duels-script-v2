--// 🕷 SPIDER CODE SNIPER
--// UI VISUAL

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CONFIG
--==================================================

local IMAGE_FILE = "Telarañacodesniper.jpg"

local COLORS = {
    Background = Color3.fromRGB(12, 12, 16),
    Panel = Color3.fromRGB(20, 20, 26),
    Header = Color3.fromRGB(25, 25, 32),
    Button = Color3.fromRGB(32, 32, 40),
    ButtonHover = Color3.fromRGB(45, 45, 55),
    Accent = Color3.fromRGB(220, 220, 220),
    White = Color3.fromRGB(245, 245, 245),
    Gray = Color3.fromRGB(160, 160, 170),
    Green = Color3.fromRGB(80, 210, 120),
    Red = Color3.fromRGB(230, 80, 80)
}

--==================================================
-- GUI
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpiderCodeSniperUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(520, 390)
Main.Position = UDim2.new(0.5, -260, 0.5, -195)
Main.BackgroundColor3 = COLORS.Background
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(55, 55, 65)
MainStroke.Thickness = 1
MainStroke.Parent = Main

--==================================================
-- HEADER
--==================================================

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 52)
Header.BackgroundColor3 = COLORS.Header
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0, 15)
HeaderFix.Position = UDim2.new(0, 0, 1, -15)
HeaderFix.BackgroundColor3 = COLORS.Header
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

-- Imagen
local CodeSniperImage = Instance.new("ImageLabel")
CodeSniperImage.Name = "CodeSniperImage"
CodeSniperImage.Size = UDim2.fromOffset(36, 36)
CodeSniperImage.Position = UDim2.fromOffset(10, 8)
CodeSniperImage.BackgroundTransparency = 1
CodeSniperImage.ScaleType = Enum.ScaleType.Fit
CodeSniperImage.Parent = Header

pcall(function()
    CodeSniperImage.Image = getcustomasset(IMAGE_FILE)
end)

-- Título
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Size = UDim2.new(1, -110, 0, 40)
TitleLabel.Position = UDim2.fromOffset(55, 6)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🕷 SPIDER CODE SNIPER"
TitleLabel.TextColor3 = COLORS.White
TitleLabel.TextSize = 17
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Header

-- Minimizar
local Minimize = Instance.new("TextButton")
Minimize.Name = "Minimize"
Minimize.Size = UDim2.fromOffset(38, 32)
Minimize.Position = UDim2.new(1, -47, 0, 10)
Minimize.BackgroundColor3 = COLORS.Button
Minimize.Text = "—"
Minimize.TextColor3 = COLORS.White
Minimize.TextSize = 20
Minimize.Font = Enum.Font.GothamBold
Minimize.AutoButtonColor = false
Minimize.Parent = Header

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = Minimize

--==================================================
-- TABS
--==================================================

local Tabs = Instance.new("Frame")
Tabs.Name = "Tabs"
Tabs.Size = UDim2.new(1, -20, 0, 42)
Tabs.Position = UDim2.fromOffset(10, 60)
Tabs.BackgroundTransparency = 1
Tabs.Parent = Main

local function CreateTab(name, position)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Size = UDim2.fromOffset(110, 36)
    Button.Position = position
    Button.BackgroundColor3 = COLORS.Button
    Button.Text = name
    Button.TextColor3 = COLORS.White
    Button.TextSize = 13
    Button.Font = Enum.Font.GothamBold
    Button.AutoButtonColor = false
    Button.Parent = Tabs

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button

    return Button
end

local MainTab = CreateTab("Main", UDim2.fromOffset(0, 0))
local HelperTab = CreateTab("Helper", UDim2.fromOffset(120, 0))

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -20, 1, -115)
Content.Position = UDim2.fromOffset(10, 105)
Content.BackgroundColor3 = COLORS.Panel
Content.BorderSizePixel = 0
Content.Parent = Main

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = Content

--==================================================
-- MAIN PAGE
--==================================================

local MainPage = Instance.new("Frame")
MainPage.Name = "MainPage"
MainPage.Size = UDim2.new(1, 0, 1, 0)
MainPage.BackgroundTransparency = 1
MainPage.Parent = Content

local CodeBox = Instance.new("TextBox")
CodeBox.Name = "CodeBox"
CodeBox.Size = UDim2.new(1, -24, 0, 105)
CodeBox.Position = UDim2.fromOffset(12, 12)
CodeBox.BackgroundColor3 = Color3.fromRGB(14, 14, 19)
CodeBox.TextColor3 = COLORS.White
CodeBox.PlaceholderColor3 = COLORS.Gray
CodeBox.PlaceholderText = "Code / text..."
CodeBox.Text = ""
CodeBox.TextSize = 14
CodeBox.Font = Enum.Font.Code
CodeBox.TextXAlignment = Enum.TextXAlignment.Left
CodeBox.TextYAlignment = Enum.TextYAlignment.Top
CodeBox.ClearTextOnFocus = false
CodeBox.MultiLine = true
CodeBox.Parent = MainPage

local CodeCorner = Instance.new("UICorner")
CodeCorner.CornerRadius = UDim.new(0, 8)
CodeCorner.Parent = CodeBox

local Submit = Instance.new("TextButton")
Submit.Name = "Submit"
Submit.Size = UDim2.new(1, -24, 0, 42)
Submit.Position = UDim2.fromOffset(12, 128)
Submit.BackgroundColor3 = COLORS.Button
Submit.Text = "SUBMIT"
Submit.TextColor3 = COLORS.White
Submit.TextSize = 14
Submit.Font = Enum.Font.GothamBold
Submit.AutoButtonColor = false
Submit.Parent = MainPage

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 8)
SubmitCorner.Parent = Submit

local Status = Instance.new("TextLabel")
Status.Name = "Status"
Status.Size = UDim2.new(1, -24, 0, 30)
Status.Position = UDim2.fromOffset(12, 178)
Status.BackgroundTransparency = 1
Status.Text = "Status: Ready"
Status.TextColor3 = COLORS.Green
Status.TextSize = 13
Status.Font = Enum.Font.Gotham
Status.TextXAlignment = Enum.TextXAlignment.Left
Status.Parent = MainPage

local Counter = Instance.new("TextLabel")
Counter.Name = "Counter"
Counter.Size = UDim2.new(1, -24, 0, 30)
Counter.Position = UDim2.fromOffset(12, 205)
Counter.BackgroundTransparency = 1
Counter.Text = "Counter: 0"
Counter.TextColor3 = COLORS.Gray
Counter.TextSize = 13
Counter.Font = Enum.Font.Gotham
Counter.TextXAlignment = Enum.TextXAlignment.Left
Counter.Parent = MainPage

--==================================================
-- HELPER PAGE
--==================================================

local HelperPage = Instance.new("Frame")
HelperPage.Name = "HelperPage"
HelperPage.Size = UDim2.new(1, 0, 1, 0)
HelperPage.BackgroundTransparency = 1
HelperPage.Visible = false
HelperPage.Parent = Content

local function CreateToggle(text, y)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -24, 0, 45)
    Button.Position = UDim2.fromOffset(12, y)
    Button.BackgroundColor3 = COLORS.Button
    Button.Text = text .. "   [ OFF ]"
    Button.TextColor3 = COLORS.White
    Button.TextSize = 14
    Button.Font = Enum.Font.GothamBold
    Button.AutoButtonColor = false
    Button.Parent = HelperPage

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button

    local Enabled = false

    Button.MouseButton1Click:Connect(function()
        Enabled = not Enabled

        if Enabled then
            Button.Text = text .. "   [ ON ]"
            Button.TextColor3 = COLORS.Green
        else
            Button.Text = text .. "   [ OFF ]"
            Button.TextColor3 = COLORS.White
        end
    end)

    return Button
end

CreateToggle("Anti Lag", 15)
CreateToggle("Anti Ragdoll", 70)

--==================================================
-- TAB SYSTEM
--==================================================

local function ShowPage(page)
    MainPage.Visible = false
    HelperPage.Visible = false
    page.Visible = true
end

MainTab.MouseButton1Click:Connect(function()
    ShowPage(MainPage)
end)

HelperTab.MouseButton1Click:Connect(function()
    ShowPage(HelperPage)
end)

--==================================================
-- BUTTON EFFECTS
--==================================================

local function HoverEffect(button)
    button.MouseEnter:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.15),
            {BackgroundColor3 = COLORS.ButtonHover}
        ):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.15),
            {BackgroundColor3 = COLORS.Button}
        ):Play()
    end)
end

HoverEffect(MainTab)
HoverEffect(HelperTab)
HoverEffect(Submit)
HoverEffect(Minimize)

--==================================================
-- VISUAL SUBMIT
--==================================================

local count = 0

Submit.MouseButton1Click:Connect(function()
    count = count + 1
    Counter.Text = "Counter: " .. count
    Status.Text = "Status: Submitted"
    Status.TextColor3 = COLORS.Green

    task.delay(1.5, function()
        if Status then
            Status.Text = "Status: Ready"
        end
    end)
end)

--==================================================
-- MINIMIZE
--==================================================

local minimized = false
local oldSize = Main.Size

Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized

    if minimized then
        Content.Visible = false
        Tabs.Visible = false

        TweenService:Create(
            Main,
            TweenInfo.new(0.25),
            {Size = UDim2.fromOffset(520, 52)}
        ):Play()

        Minimize.Text = "+"
    else
        TweenService:Create(
            Main,
            TweenInfo.new(0.25),
            {Size = oldSize}
        ):Play()

        task.wait(0.25)
        Content.Visible = true
        Tabs.Visible = true
        Minimize.Text = "—"
    end
end)

--==================================================
-- MOVER CON EL DEDO / MOUSE
--==================================================

local dragging = false
local dragStart
local startPos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPos = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then

        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

--==================================================
-- INICIO
--==================================================

ShowPage(MainPage)

print("🕷 SPIDER CODE SNIPER UI cargada")