-- Put your webhook URL below if you want Send All to work
local WEBHOOK_URL = "" -- e.g. "https://discord.com/api/webhooks/..." (leave empty to disable)

local cloneref = cloneref or function(object) return object end
local Players = cloneref(game:GetService("Players"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local HttpService = cloneref(game:GetService("HttpService"))
local TweenService = cloneref(game:GetService("TweenService"))
local Lighting = cloneref(game:GetService("Lighting"))
local Workspace = cloneref(game:GetService("Workspace"))
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- minimal http request support detection (executors)
local httpRequest = (syn and syn.request) or (http and http.request) or http_request or request

if getgenv and getgenv().StopAura then
    pcall(getgenv().StopAura)
end

-- CONFIGURATION --
local CONFIG_FILE = "ace_code_sniper_config.json"
local savedConfig = {
    codeSniper = true,
    autoSubmit = true,
    submitCount = 2,
    spamCount = 1,
    antiRagdoll = false,
}

pcall(function()
    if type(isfile) == "function" and type(readfile) == "function" and isfile(CONFIG_FILE) then
        local decoded = HttpService:JSONDecode(readfile(CONFIG_FILE))
        if type(decoded) == "table" then
            for k, v in pairs(decoded) do
                if savedConfig[k] ~= nil then
                    savedConfig[k] = v
                end
            end
        end
    end
end)

local function saveConfig()
    if type(writefile) ~= "function" then return end
    pcall(function()
        writefile(CONFIG_FILE, HttpService:JSONEncode({
            codeSniper = savedConfig.codeSniper,
            autoSubmit = savedConfig.autoSubmit,
            submitCount = savedConfig.submitCount,
            spamCount = savedConfig.spamCount,
            antiRagdoll = savedConfig.antiRagdoll,
        }))
    end)
end

-- STATE VARIABLES --
local _enabled = true
local _seen = {}
local _focused = nil
local _lastBox = nil
local _autoAccept = savedConfig.autoSubmit
local _submitAfter = savedConfig.submitCount or 2
local _spamCount = savedConfig.spamCount or 1
local _capturedParts = {}
local _lastWatchedBox = nil
local _boxTextConn = nil
local _boxAncestryConn = nil
local _boxVisibilityConns = {}
local _lastNonBlankBoxText = ""
local ACE_CASE_MODE = "EXACT"
local ACE_WORD_COUNT = 1

-- Counter for submit (1-6)
local _submitCounter = 1

-- Anti-lag state
local _antiLagEnabled = false
local _antiLagConnection = nil

-- Anti-ragdoll state
local _antiRagdollEnabled = savedConfig.antiRagdoll or false
local _antiRagdollConnection = nil
local _antiRagdollLastReset = 0
local _antiRagdollStateTimers = {}

-- Status
local _statusText = "Idle"

-- Track when the user is manually editing the display TextBox
local _userEditingDisplay = false

local getupvalues = (debug and debug.getupvalues) or getupvalues
local getconns = getconnections or (debug and debug.getconnections)
local setupv = (debug and debug.setupvalue) or setupvalue

local clearAceCapture

-- UTILITY & REDEEM LOGIC --
local function isOurGui(instance)
    local p = instance
    for _ = 1, 10 do
        if not p then break end
        if p.Name == "ACECodeSniperUI" or p.Name == "SourcesHubRedeemerGui" then
            return true
        end
        p = p.Parent
    end
    return false
end

local function isVisibleChain(inst)
    local current = inst
    while current do
        if current:IsA("GuiObject") and not current.Visible then
            return false
        end
        if current:IsA("ScreenGui") then
            return current.Enabled
        end
        current = current.Parent
    end
    return true
end

local function findAllTextBoxes(pg)
    local boxes = {}
    for _, gui in ipairs(pg:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Enabled and not isOurGui(gui) then
            for _, d in ipairs(gui:GetDescendants()) do
                if d:IsA("TextBox") and not isOurGui(d) then
                    boxes[#boxes+1] = d
                end
            end
        end
    end
    return boxes
end

local function findCodeButtons(pg)
    local btns = {}
    for _, gui in ipairs(pg:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Enabled and not isOurGui(gui) then
            for _, d in ipairs(gui:GetDescendants()) do
                if (d:IsA("TextButton") or d:IsA("ImageButton")) and not isOurGui(d) then
                    local n = d.Name:lower()
                    local pn = (d.Parent and d.Parent.Name or ""):lower()
                    if (n:find("code") or n:find("redeem") or pn:find("code") or pn:find("redeem")) and isVisibleChain(d) then
                        btns[#btns+1] = d
                    end
                end
            end
        end
    end
    return btns
end

local function clickButton(btn)
    if not btn then return false end
    local methods = {}
    methods[#methods+1] = function() btn.MouseButton1Click:Fire() end
    methods[#methods+1] = function() btn.Activated:Fire() end
    if typeof(firesignal) == "function" then
        methods[#methods+1] = function() firesignal(btn.MouseButton1Click) end
        methods[#methods+1] = function() firesignal(btn.Activated) end
    end
    if typeof(getconns) == "function" then
        methods[#methods+1] = function()
            local ok, cs = pcall(getconns, btn.MouseButton1Click)
            if ok and type(cs) == "table" then
                for _, c in ipairs(cs) do
                    pcall(function() c:Fire() end)
                end
            end
            local ok2, cs2 = pcall(getconns, btn.Activated)
            if ok2 and type(cs2) == "table" then
                for _, c in ipairs(cs2) do
                    pcall(function() c:Fire() end)
                end
            end
        end
    end
    if typeof(fireclick) == "function" then
        methods[#methods+1] = function() fireclick(btn) end
    end
    local anyOk = false
    for _, fn in ipairs(methods) do
        local ok = pcall(fn)
        anyOk = anyOk or ok
    end
    return anyOk
end

local function fireBoxFocusLost(box)
    if not box then return false end
    local anyFired = false
    if typeof(firesignal) == "function" then
        local ok = pcall(firesignal, box.FocusLost, true)
        anyFired = anyFired or ok
    end
    if typeof(getconns) == "function" then
        local ok, cs = pcall(getconns, box.FocusLost)
        if ok and type(cs) == "table" then
            for _, c in ipairs(cs) do
                local fn
                pcall(function() fn = c.Function end)
                if fn and typeof(getupvalues) == "function" and typeof(setupv) == "function" then
                    local uOk, ups = pcall(getupvalues, fn)
                    if uOk and type(ups) == "table" then
                        for i, v in pairs(ups) do
                            if type(v) == "boolean" and v == true then
                                pcall(setupv, fn, i, false)
                            end
                        end
                    end
                end
                local fOk = pcall(function()
                    if c.Enabled ~= false then
                        c:Fire(true)
                    end
                end)
                anyFired = anyFired or fOk
            end
        end
    end
    return anyFired
end

local function typeAndSubmitCode(code)
    local pg = playerGui or player:FindFirstChildOfClass("PlayerGui")
    if not pg then return false, "no PlayerGui" end

    -- Strategy 1: Known UI path
    local codesGui = pg:FindFirstChild("Codes")
    if codesGui then
        if codesGui:IsA("ScreenGui") then
            codesGui.Enabled = true
        end
        local codesFrame = codesGui:FindFirstChild("Codes") or codesGui
        if codesFrame then
            if codesFrame:IsA("GuiObject") then
                codesFrame.Visible = true
            end
            local cur = codesFrame
            while cur and cur ~= codesGui do
                if cur:IsA("GuiObject") then
                    cur.Visible = true
                end
                cur = cur.Parent
            end
            local box = nil
            for _, d in ipairs(codesFrame:GetDescendants()) do
                if d:IsA("TextBox") and not isOurGui(d) then
                    box = d
                    break
                end
            end
            local submitBtn = nil
            for _, d in ipairs(codesFrame:GetDescendants()) do
                if (d:IsA("TextButton") or d:IsA("ImageButton")) and not isOurGui(d) then
                    local n = d.Name:lower()
                    local txt = ""
                    pcall(function() txt = d.Text:lower() end)
                    if n:find("submit") or txt:find("submit") or n:find("redeem") or txt:find("redeem") or n:find("claim") or txt:find("confirm") or n:find("enter") then
                        submitBtn = d
                        break
                    end
                end
            end
            if not submitBtn then
                for _, d in ipairs(codesFrame:GetDescendants()) do
                    if (d:IsA("TextButton") or d:IsA("ImageButton")) and not isOurGui(d) then
                        local n = d.Name:lower()
                        if not n:find("close") and not n:find("x") and not n:find("toggle") then
                            submitBtn = d
                            break
                        end
                    end
                end
            end
            if box then
                pcall(function() box.Text = code end)
                task.wait(0.05)
                if submitBtn then clickButton(submitBtn) end
                fireBoxFocusLost(box)
                return true, "submitted via PlayerGui.Codes"
            end
        end
    end

    -- Strategy 2: Dynamic Search
    local btns = findCodeButtons(pg)
    for _, btn in ipairs(btns) do
        clickButton(btn)
        task.wait(0.05)
    end
    task.wait(0.2)
    local box = nil
    local deadline = tick() + 2
    while tick() < deadline do
        local allBoxes = findAllTextBoxes(pg)
        for _, d in ipairs(allBoxes) do
            if isVisibleChain(d) then
                local n = d.Name:lower()
                local pn = (d.Parent and d.Parent.Name or ""):lower()
                if n:find("code") or pn:find("code") or n:find("redeem") or pn:find("redeem") or n:find("input") or pn:find("textbox") or n:find("enter") then
                    box = d
                    break
                end
            end
        end
        if not box then
            for _, d in ipairs(allBoxes) do
                if isVisibleChain(d) then
                    box = d
                    break
                end
            end
        end
        if box then break end
        task.wait(0.1)
    end
    if not box then return false, "no codebox visible" end
    pcall(function() box.Text = code end)
    task.wait(0.05)
    local redeemBtn = nil
    local searchNames = {"submit","redeem","claim","confirm","enter","send","apply","ok","use","go","check"}
    local p = box.Parent
    for _ = 1, 8 do
        if not p then break end
        for _, d in ipairs(p:GetDescendants()) do
            if (d:IsA("TextButton") or d:IsA("ImageButton")) and not isOurGui(d) and d ~= box then
                local n = d.Name:lower()
                local txt = ""
                pcall(function() txt = d.Text:lower() end)
                for _, sn in ipairs(searchNames) do
                    if n:find(sn) or txt:find(sn) then
                        if isVisibleChain(d) then
                            redeemBtn = d
                            break
                        end
                    end
                end
                if redeemBtn then break end
            end
        end
        if redeemBtn then break end
        p = p.Parent
    end
    if redeemBtn then clickButton(redeemBtn) end
    fireBoxFocusLost(box)
    return true, "submitted via dynamic search"
end

local function aceCodeBox()
    local pg = playerGui
    local allBoxes = findAllTextBoxes(pg)
    for _, box in ipairs(allBoxes) do
        if isVisibleChain(box) then
            return box
        end
    end
    return nil
end

-- STYLING & HELPERS --
local COLORS = {
    Window = Color3.fromRGB(0, 0, 0),
    Row = Color3.fromRGB(15, 15, 17),
    Control = Color3.fromRGB(35, 35, 39),
    Log = Color3.fromRGB(10, 10, 12),
    Border = Color3.fromRGB(82, 82, 89),
    White = Color3.fromRGB(245, 245, 245),
    Text = Color3.fromRGB(190, 190, 196),
    Dim = Color3.fromRGB(120, 120, 130),
    Accent = Color3.fromRGB(245, 245, 245),
    Green = Color3.fromRGB(70, 210, 100),
    Red = Color3.fromRGB(255, 70, 70),
}

local function addCorner(parent, radius)
    local value = Instance.new("UICorner")
    value.CornerRadius = UDim.new(0, radius)
    value.Parent = parent
    return value
end

local function addStroke(parent, color, thickness, transparency)
    local value = Instance.new("UIStroke")
    value.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    value.Color = color
    value.Thickness = thickness or 1
    value.Transparency = transparency or 0
    value.Parent = parent
    return value
end

local function makeLabel(parent, name, text, size, position, textSize, color, font)
    local label = Instance.new("TextLabel")
    label.Name = name
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextSize = textSize
    label.TextColor3 = color
    label.Font = font or Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Parent = parent
    return label
end

-- CLEANUP OLD GUIS --
pcall(function()
    for _, name in ipairs({"ACECodeSniperUI", "AutoTypeCodesUI", "ACEPaste"}) do
        local previous = game.CoreGui:FindFirstChild(name)
        if previous then previous:Destroy() end
    end
end)
for _, name in ipairs({"ACECodeSniperUI", "AutoTypeCodesUI", "ACEPaste"}) do
    local previous = playerGui:FindFirstChild(name)
    if previous then previous:Destroy() end
end

-- ========== MAIN GUI ==========
local GUI = Instance.new("ScreenGui")
GUI.Name = "ACECodeSniperUI"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.DisplayOrder = 999
if not pcall(function() GUI.Parent = game.CoreGui end) then
    GUI.Parent = playerGui
end

local Window = Instance.new("Frame")
Window.Name = "Window"
Window.Size = UDim2.fromOffset(310, 440)
Window.AnchorPoint = Vector2.new(1, 0)
Window.Position = UDim2.new(1, -8, 0, 8)
Window.BackgroundColor3 = COLORS.Window
Window.BackgroundTransparency = 1
Window.BorderSizePixel = 0
Window.ClipsDescendants = true
Window.Parent = GUI
addCorner(Window, 14)
addStroke(Window, COLORS.White, 1, 0.58)

-- ===== FONDO PERSONALIZADO (SPIDER) =====
do
    local bgImage = nil
    if type(getcustomasset) == "function" then
        local path = "Telarañacodesniper.jpg"
        local ok, result = pcall(getcustomasset, path)
        if ok and type(result) == "string" and result ~= "" then
            bgImage = result
        end
    end
    local bg = Instance.new("ImageLabel")
    bg.Name = "BackgroundImage"
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.Position = UDim2.new(0, 0, 0, 0)
    bg.BackgroundTransparency = 1
    bg.Image = bgImage or ""
    bg.ScaleType = Enum.ScaleType.Scale
    bg.ZIndex = 0
    bg.Parent = Window
    -- Copiar el mismo corner radius para que la imagen respete los bordes redondeados
    addCorner(bg, 14)
    -- Si no hay imagen, usamos el color de fondo original (negro)
    if not bgImage then
        bg.BackgroundTransparency = 0
        bg.BackgroundColor3 = COLORS.Window
        bg.Image = ""
    end
end

local Scale = Instance.new("UIScale")
Scale.Name = "InterfaceScale"
Scale.Scale = 0.92
Scale.Parent = Window

local viewportConnection
local function updateScale()
    local camera = workspace.CurrentCamera
    if not camera then Scale.Scale = 0.92; return end
    local viewport = camera.ViewportSize
    local fitScale = math.min((viewport.X - 16) / 310, (viewport.Y - 16) / 440)
    if UserInputService.TouchEnabled then
        local mobileTarget = 0.72
        Scale.Scale = math.max(0.45, math.min(mobileTarget, fitScale))
    else
        Scale.Scale = 0.92
    end
end

local function watchViewport()
    if viewportConnection then viewportConnection:Disconnect(); viewportConnection = nil end
    local camera = workspace.CurrentCamera
    if camera then
        viewportConnection = camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
    end
    updateScale()
end
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(watchViewport)
watchViewport()

-- Animation
Window.BackgroundTransparency = 1
local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local fadeTween = TweenService:Create(Window, tweenInfo, {BackgroundTransparency = 0})
local scaleTween = TweenService:Create(Scale, tweenInfo, {Scale = 0.92})
fadeTween:Play()
scaleTween:Play()

-- HEADER
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 48)
Header.BackgroundTransparency = 1
Header.Active = true
Header.ZIndex = 3
Header.Parent = Window

-- Cambio de nombre a 🕷SPIDER CODE SNIPER
local TitleLabel = makeLabel(Header, "Title", "🕷SPIDER CODE SNIPER", UDim2.fromOffset(220, 25), UDim2.fromOffset(10, 12), 15, COLORS.White, Enum.Font.GothamBold)

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Size = UDim2.fromOffset(24, 24)
MinimizeBtn.Position = UDim2.new(1, -32, 0.5, -12)
MinimizeBtn.BackgroundColor3 = COLORS.Control
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.AutoButtonColor = false
MinimizeBtn.Active = true
MinimizeBtn.Text = "â”€"
MinimizeBtn.TextSize = 18
MinimizeBtn.TextColor3 = COLORS.Text
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.ZIndex = 5
MinimizeBtn.Parent = Header
addCorner(MinimizeBtn, 6)
addStroke(MinimizeBtn, COLORS.White, 1, 0.6)

local HeaderAccent = Instance.new("Frame")
HeaderAccent.Name = "TitleDivider"
HeaderAccent.Size = UDim2.new(1, -20, 0, 1)
HeaderAccent.Position = UDim2.fromOffset(10, 40)
HeaderAccent.BackgroundColor3 = COLORS.White
HeaderAccent.BackgroundTransparency = 0.72
HeaderAccent.BorderSizePixel = 0
HeaderAccent.Parent = Header

-- ========== TABS (centered) ==========
local TabFrame = Instance.new("Frame")
TabFrame.Name = "Tabs"
TabFrame.Size = UDim2.new(1, 0, 0, 28)
TabFrame.Position = UDim2.fromOffset(0, 48)
TabFrame.BackgroundTransparency = 1
TabFrame.ZIndex = 3
TabFrame.Parent = Window

local function makeTabButton(text, position)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromOffset(70, 24)
    btn.Position = position
    btn.BackgroundColor3 = COLORS.Control
    btn.BackgroundTransparency = 0.5
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Active = true
    btn.Text = text
    btn.TextSize = 12
    btn.TextColor3 = COLORS.Text
    btn.Font = Enum.Font.GothamBold
    btn.ZIndex = 4
    btn.Parent = TabFrame
    addCorner(btn, 5)
    addStroke(btn, COLORS.White, 1, 0.6)
    return btn
end

-- Center two tabs: (310 - 70*2 - gap) / 2 = about 85 offset, gap 8 between them
local TabMain = makeTabButton("Main", UDim2.fromOffset(85, 2))
local TabHelper = makeTabButton("Helper", UDim2.fromOffset(163, 2))

-- Content container
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "Content"
ContentContainer.Size = UDim2.new(1, 0, 1, -76)
ContentContainer.Position = UDim2.fromOffset(0, 76)
ContentContainer.BackgroundTransparency = 1
ContentContainer.ZIndex = 2
ContentContainer.Parent = Window

-- ========== MAIN TAB ==========
local MainTab = Instance.new("ScrollingFrame")
MainTab.Name = "MainTab"
MainTab.Size = UDim2.new(1, 0, 1, 0)
MainTab.BackgroundTransparency = 1
MainTab.BorderSizePixel = 0
MainTab.ZIndex = 2
MainTab.CanvasSize = UDim2.fromOffset(0, 0)
MainTab.ScrollBarThickness = 4
MainTab.ScrollBarImageColor3 = COLORS.Dim
MainTab.ScrollBarImageTransparency = 0.8
MainTab.Parent = ContentContainer

local MainContent = Instance.new("Frame")
MainContent.Name = "Content"
MainContent.Size = UDim2.new(1, 0, 0, 0)
MainContent.BackgroundTransparency = 1
MainContent.Parent = MainTab

-- Code Display (top)
local CodeDisplayFrame = Instance.new("Frame")
CodeDisplayFrame.Name = "CodeDisplay"
CodeDisplayFrame.Size = UDim2.new(1, -16, 0, 120)
CodeDisplayFrame.Position = UDim2.fromOffset(8, 0)
CodeDisplayFrame.BackgroundColor3 = COLORS.Row
CodeDisplayFrame.BackgroundTransparency = 0.5
CodeDisplayFrame.BorderSizePixel = 0
CodeDisplayFrame.ClipsDescendants = true
CodeDisplayFrame.ZIndex = 3
CodeDisplayFrame.Parent = MainContent
addCorner(CodeDisplayFrame, 9)
addStroke(CodeDisplayFrame, COLORS.White, 1, 0.8)

-- Submit row with counter
local SubmitRow = Instance.new("Frame")
SubmitRow.Name = "SubmitRow"
SubmitRow.Size = UDim2.new(1, 0, 0, 32)
SubmitRow.Position = UDim2.fromOffset(0, 0)
SubmitRow.BackgroundTransparency = 1
SubmitRow.ZIndex = 4
SubmitRow.Parent = CodeDisplayFrame

local ManualSubmitBtn = Instance.new("TextButton")
ManualSubmitBtn.Name = "ManualSubmit"
ManualSubmitBtn.Size = UDim2.fromOffset(100, 28)
ManualSubmitBtn.Position = UDim2.fromOffset(8, 2)
ManualSubmitBtn.BackgroundColor3 = COLORS.Accent
ManualSubmitBtn.BackgroundTransparency = 0.1
ManualSubmitBtn.BorderSizePixel = 0
ManualSubmitBtn.Text = "SUBMIT"
ManualSubmitBtn.TextSize = 12
ManualSubmitBtn.TextColor3 = COLORS.Window
ManualSubmitBtn.Font = Enum.Font.GothamBold
ManualSubmitBtn.ZIndex = 4
ManualSubmitBtn.Parent = SubmitRow
addCorner(ManualSubmitBtn, 6)
addStroke(ManualSubmitBtn, COLORS.White, 1, 0.6)

local CounterLabel = makeLabel(SubmitRow, "Counter", "Counter: 1", UDim2.fromOffset(100, 28), UDim2.new(1, -110, 0, 2), 12, COLORS.White, Enum.Font.GothamMedium)
CounterLabel.TextXAlignment = Enum.TextXAlignment.Right
CounterLabel.TextYAlignment = Enum.TextYAlignment.Center

local function updateCounterDisplay()
    CounterLabel.Text = "Counter: " .. _submitCounter
end
updateCounterDisplay()

local function incrementCounter()
    _submitCounter = _submitCounter + 1
    if _submitCounter > 6 then _submitCounter = 1 end
    updateCounterDisplay()
end

-- Status display (replaces LastActionDisplay)
local StatusDisplay = makeLabel(CodeDisplayFrame, "StatusDisplay", "Status: Idle", UDim2.new(1, -16, 0, 16), UDim2.fromOffset(8, 98), 10, COLORS.White, Enum.Font.GothamMedium)
StatusDisplay.TextXAlignment = Enum.TextXAlignment.Left
StatusDisplay.TextYAlignment = Enum.TextYAlignment.Center

local function setStatus(text)
    _statusText = text
    StatusDisplay.Text = "Status: " .. text
end

setStatus("Idle")

-- Code display textbox
local CodeDisplayLabel = makeLabel(CodeDisplayFrame, "Label", "Captured Code:", UDim2.new(1, -10, 0, 18), UDim2.fromOffset(10, 36), 10, COLORS.Dim, Enum.Font.GothamMedium)
local CodeDisplayBox = Instance.new("TextBox")
CodeDisplayBox.Name = "DisplayBox"
CodeDisplayBox.Size = UDim2.new(1, -16, 1, -54)
CodeDisplayBox.Position = UDim2.fromOffset(8, 54)
CodeDisplayBox.BackgroundColor3 = COLORS.Window
CodeDisplayBox.BackgroundTransparency = 0
CodeDisplayBox.BorderSizePixel = 0
CodeDisplayBox.Text = ""
CodeDisplayBox.TextSize = 12
CodeDisplayBox.TextColor3 = COLORS.White
CodeDisplayBox.Font = Enum.Font.Code
CodeDisplayBox.TextXAlignment = Enum.TextXAlignment.Left
CodeDisplayBox.TextYAlignment = Enum.TextYAlignment.Top
CodeDisplayBox.TextWrapped = true
CodeDisplayBox.ClearTextOnFocus = false
CodeDisplayBox.ZIndex = 4
CodeDisplayBox.Parent = CodeDisplayFrame
addCorner(CodeDisplayBox, 6)
addStroke(CodeDisplayBox, COLORS.White, 1, 0.7)

-- Respect user edits â€” don't overwrite while editing
CodeDisplayBox.Focused:Connect(function()
    _userEditingDisplay = true
end)
CodeDisplayBox.FocusLost:Connect(function(enterPressed)
    _userEditingDisplay = false
    local text = tostring(CodeDisplayBox.Text or "")
    if text == "" then
        _capturedParts = {}
    else
        -- keep the user's full text as a single captured part
        _capturedParts = { text }
    end
    updateStatus()
end)

-- Manual submit with spam
ManualSubmitBtn.MouseButton1Click:Connect(function()
    local code = CodeDisplayBox.Text
    if code == "" then return end
    setStatus("Redeeming...")
    local ok, msg = typeAndSubmitCode(code)
    if ok then
        setStatus("Redeemed: " .. code)
        _capturedParts = {}
        updateStatus()
        incrementCounter()
        -- spam submit if >1
        if _spamCount > 1 then
            task.spawn(function()
                for i = 2, _spamCount do
                    task.wait(0.1)
                    setStatus("Spamming " .. i .. "/" .. _spamCount)
                    local ok2, msg2 = typeAndSubmitCode(code)
                    if ok2 then
                        incrementCounter()
                    end
                end
                setStatus("Spam complete")
            end)
        end
    else
        local box = aceCodeBox()
        if box then
            pcall(function() box.Text = code end)
            fireBoxFocusLost(box)
        end
        setStatus("Failed: " .. code)
    end
end)

-- Settings (cards)
local Settings = Instance.new("Frame")
Settings.Name = "Settings"
Settings.Size = UDim2.new(1, -16, 0, 160)  -- increased height for spam count
Settings.Position = UDim2.fromOffset(8, 130)
Settings.BackgroundTransparency = 1
Settings.ZIndex = 3
Settings.Parent = MainContent

local function makeCard(name, position, size)
    local card = Instance.new("Frame")
    card.Name = name
    card.Position = position
    card.Size = size
    card.BackgroundColor3 = COLORS.Row
    card.BackgroundTransparency = 0.68
    card.BorderSizePixel = 0
    card.Parent = Settings
    addCorner(card, 9)
    addStroke(card, COLORS.White, 1, 0.76)
    return card
end

local function makeToggleButton(parent, text, initialState, onToggle)
    local button = Instance.new("TextButton")
    button.Size = UDim2.fromOffset(50, 22)
    button.Position = UDim2.new(1, -58, 0.5, -11)
    button.BackgroundColor3 = initialState and COLORS.Accent or COLORS.Control
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Active = true
    button.Text = initialState and "ON" or "OFF"
    button.TextSize = 10
    button.TextColor3 = initialState and COLORS.Window or COLORS.Dim
    button.Font = Enum.Font.GothamBold
    button.ZIndex = 5
    button.Parent = parent
    addCorner(button, 6)
    addStroke(button, COLORS.White, 1, initialState and 0.62 or 0.88)
    local state = initialState
    button.MouseButton1Click:Connect(function()
        state = not state
        button.Text = state and "ON" or "OFF"
        button.BackgroundColor3 = state and COLORS.Accent or COLORS.Control
        button.TextColor3 = state and COLORS.Window or COLORS.Dim
        if onToggle then onToggle(state) end
    end)
    return button
end

-- Submit Count Card
local SubmitCountCard = makeCard("SubmitCount", UDim2.fromOffset(0, 0), UDim2.fromOffset(276, 40))
makeLabel(SubmitCountCard, "Title", "Submit Count:", UDim2.new(0, 90, 1, 0), UDim2.fromOffset(12, 0), 11, COLORS.White, Enum.Font.GothamMedium)

local SubmitCountBox = Instance.new("TextBox")
SubmitCountBox.Name = "SubmitCountBox"
SubmitCountBox.Size = UDim2.fromOffset(50, 24)
SubmitCountBox.Position = UDim2.fromOffset(100, 8)
SubmitCountBox.BackgroundColor3 = COLORS.Window
SubmitCountBox.BackgroundTransparency = 0.5
SubmitCountBox.BorderSizePixel = 0
SubmitCountBox.Text = tostring(_submitAfter)
SubmitCountBox.TextSize = 12
SubmitCountBox.TextColor3 = COLORS.White
SubmitCountBox.Font = Enum.Font.GothamMedium
SubmitCountBox.TextXAlignment = Enum.TextXAlignment.Center
SubmitCountBox.TextYAlignment = Enum.TextYAlignment.Center
SubmitCountBox.ClearTextOnFocus = false
SubmitCountBox.ZIndex = 5
SubmitCountBox.Parent = SubmitCountCard
addCorner(SubmitCountBox, 5)
addStroke(SubmitCountBox, COLORS.White, 1, 0.7)

local function applySubmitVal(val)
    val = math.floor(val)
    if val < 1 then val = 1 end
    if val > 10 then val = 10 end
    _submitAfter = val
    savedConfig.submitCount = val
    saveConfig()
    SubmitCountBox.Text = tostring(val)
end

SubmitCountBox:GetPropertyChangedSignal("Text"):Connect(function()
    local val = tonumber(SubmitCountBox.Text)
    if val then
        val = math.floor(val)
        if val >= 1 and val <= 10 then
            _submitAfter = val
            savedConfig.submitCount = val
            saveConfig()
        end
    end
end)

SubmitCountBox.FocusLost:Connect(function(enterPressed)
    local val = tonumber(SubmitCountBox.Text)
    if val then
        applySubmitVal(val)
    else
        SubmitCountBox.Text = tostring(_submitAfter)
    end
end)

-- Spam Count Card
local SpamCountCard = makeCard("SpamCount", UDim2.fromOffset(0, 48), UDim2.fromOffset(276, 40))
makeLabel(SpamCountCard, "Title", "Spam Count:", UDim2.new(0, 90, 1, 0), UDim2.fromOffset(12, 0), 11, COLORS.White, Enum.Font.GothamMedium)

local SpamCountBox = Instance.new("TextBox")
SpamCountBox.Name = "SpamCountBox"
SpamCountBox.Size = UDim2.fromOffset(50, 24)
SpamCountBox.Position = UDim2.fromOffset(100, 8)
SpamCountBox.BackgroundColor3 = COLORS.Window
SpamCountBox.BackgroundTransparency = 0.5
SpamCountBox.BorderSizePixel = 0
SpamCountBox.Text = tostring(_spamCount)
SpamCountBox.TextSize = 12
SpamCountBox.TextColor3 = COLORS.White
SpamCountBox.Font = Enum.Font.GothamMedium
SpamCountBox.TextXAlignment = Enum.TextXAlignment.Center
SpamCountBox.TextYAlignment = Enum.TextYAlignment.Center
SpamCountBox.ClearTextOnFocus = false
SpamCountBox.ZIndex = 5
SpamCountBox.Parent = SpamCountCard
addCorner(SpamCountBox, 5)
addStroke(SpamCountBox, COLORS.White, 1, 0.7)

local function applySpamVal(val)
    val = math.floor(val)
    if val < 1 then val = 1 end
    if val > 20 then val = 20 end
    _spamCount = val
    savedConfig.spamCount = val
    saveConfig()
    SpamCountBox.Text = tostring(val)
end

SpamCountBox:GetPropertyChangedSignal("Text"):Connect(function()
    local val = tonumber(SpamCountBox.Text)
    if val then
        val = math.floor(val)
        if val >= 1 and val <= 20 then
            _spamCount = val
            savedConfig.spamCount = val
            saveConfig()
        end
    end
end)

SpamCountBox.FocusLost:Connect(function(enterPressed)
    local val = tonumber(SpamCountBox.Text)
    if val then
        applySpamVal(val)
    else
        SpamCountBox.Text = tostring(_spamCount)
    end
end)

-- AutoSubmit toggle
local AutoCard = makeCard("AutoSubmit", UDim2.fromOffset(0, 96), UDim2.fromOffset(276, 43))
makeLabel(AutoCard, "Title", "Auto submit", UDim2.new(1, -70, 1, 0), UDim2.fromOffset(12, 0), 11, COLORS.White, Enum.Font.GothamMedium)
local AutoToggle = makeToggleButton(AutoCard, "Auto", _autoAccept, function(state)
    _autoAccept = state
    savedConfig.autoSubmit = state
    saveConfig()
end)

-- Update canvas
local function updateMainCanvas()
    local contentHeight = CodeDisplayFrame.Size.Y.Offset + Settings.Size.Y.Offset + 20
    MainContent.Size = UDim2.new(1, 0, 0, contentHeight)
    MainTab.CanvasSize = UDim2.new(0, 0, 0, contentHeight + 10)
end
task.defer(updateMainCanvas)

-- ========== HELPER TAB ==========
local HelperTab = Instance.new("ScrollingFrame")
HelperTab.Name = "HelperTab"
HelperTab.Size = UDim2.new(1, 0, 1, 0)
HelperTab.BackgroundTransparency = 1
HelperTab.BorderSizePixel = 0
HelperTab.ZIndex = 2
HelperTab.CanvasSize = UDim2.fromOffset(0, 0)
HelperTab.ScrollBarThickness = 4
HelperTab.ScrollBarImageColor3 = COLORS.Dim
HelperTab.ScrollBarImageTransparency = 0.8
HelperTab.Visible = false
HelperTab.Parent = ContentContainer

local HelperContent = Instance.new("Frame")
HelperContent.Name = "Content"
HelperContent.Size = UDim2.new(1, 0, 0, 0)
HelperContent.BackgroundTransparency = 1
HelperContent.Parent = HelperTab

-- Anti-Lag Toggle Card (lightened, no parentheses)
local AntiLagCard = Instance.new("Frame")
AntiLagCard.Name = "AntiLagCard"
AntiLagCard.Size = UDim2.new(1, -16, 0, 60)
AntiLagCard.Position = UDim2.fromOffset(8, 10)
AntiLagCard.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
AntiLagCard.BackgroundTransparency = 0.3
AntiLagCard.BorderSizePixel = 0
AntiLagCard.ZIndex = 3
AntiLagCard.Parent = HelperContent
addCorner(AntiLagCard, 9)
addStroke(AntiLagCard, COLORS.White, 1, 0.76)

makeLabel(AntiLagCard, "Title", "Anti Lag - No effects/animations", UDim2.new(1, -70, 1, 0), UDim2.fromOffset(12, 0), 12, COLORS.White, Enum.Font.GothamBold)

local AntiLagToggle = Instance.new("TextButton")
AntiLagToggle.Name = "AntiLagToggle"
AntiLagToggle.Size = UDim2.fromOffset(60, 28)
AntiLagToggle.Position = UDim2.new(1, -70, 0.5, -14)
AntiLagToggle.BackgroundColor3 = COLORS.Control
AntiLagToggle.BorderSizePixel = 0
AntiLagToggle.AutoButtonColor = false
AntiLagToggle.Active = true
AntiLagToggle.Text = "OFF"
AntiLagToggle.TextSize = 12
AntiLagToggle.TextColor3 = COLORS.Dim
AntiLagToggle.Font = Enum.Font.GothamBold
AntiLagToggle.ZIndex = 5
AntiLagToggle.Parent = AntiLagCard
addCorner(AntiLagToggle, 6)
addStroke(AntiLagToggle, COLORS.White, 1, 0.88)

-- Anti-Ragdoll Card (lightened)
local AntiRagdollCard = Instance.new("Frame")
AntiRagdollCard.Name = "AntiRagdollCard"
AntiRagdollCard.Size = UDim2.new(1, -16, 0, 60)
AntiRagdollCard.Position = UDim2.fromOffset(8, 80)
AntiRagdollCard.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
AntiRagdollCard.BackgroundTransparency = 0.3
AntiRagdollCard.BorderSizePixel = 0
AntiRagdollCard.ZIndex = 3
AntiRagdollCard.Parent = HelperContent
addCorner(AntiRagdollCard, 9)
addStroke(AntiRagdollCard, COLORS.White, 1, 0.76)

makeLabel(AntiRagdollCard, "Title", "Anti Ragdoll", UDim2.new(1, -70, 1, 0), UDim2.fromOffset(12, 0), 12, COLORS.White, Enum.Font.GothamBold)

local AntiRagdollToggle = Instance.new("TextButton")
AntiRagdollToggle.Name = "AntiRagdollToggle"
AntiRagdollToggle.Size = UDim2.fromOffset(60, 28)
AntiRagdollToggle.Position = UDim2.new(1, -70, 0.5, -14)
AntiRagdollToggle.BackgroundColor3 = _antiRagdollEnabled and COLORS.Accent or COLORS.Control
AntiRagdollToggle.BorderSizePixel = 0
AntiRagdollToggle.AutoButtonColor = false
AntiRagdollToggle.Active = true
AntiRagdollToggle.Text = _antiRagdollEnabled and "ON" or "OFF"
AntiRagdollToggle.TextSize = 12
AntiRagdollToggle.TextColor3 = _antiRagdollEnabled and COLORS.Window or COLORS.Dim
AntiRagdollToggle.Font = Enum.Font.GothamBold
AntiRagdollToggle.ZIndex = 5
AntiRagdollToggle.Parent = AntiRagdollCard
addCorner(AntiRagdollToggle, 6)
addStroke(AntiRagdollToggle, COLORS.White, 1, 0.88)

local function updateHelperCanvas()
    local contentHeight = AntiLagCard.Size.Y.Offset + 80 + 20
    HelperContent.Size = UDim2.new(1, 0, 0, contentHeight)
    HelperTab.CanvasSize = UDim2.new(0, 0, 0, contentHeight + 10)
end
task.defer(updateHelperCanvas)

-- ========== ANTI-LAG FUNCTIONS ==========
local function applyAntiLag()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 1
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0
    Lighting.Ambient = Color3.new(0,0,0)
    Lighting.OutdoorAmbient = Color3.new(0,0,0)
    Lighting.ClockTime = 12

    for _, child in pairs(Lighting:GetChildren()) do
        if child:IsA('BloomEffect') or child:IsA('BlurEffect') or child:IsA('SunRaysEffect') or
           child:IsA('ColorCorrectionEffect') or child:IsA('DepthOfFieldEffect') then
            child.Enabled = false
        end
    end

    for _, descendant in pairs(Workspace:GetDescendants()) do
        if descendant:IsA('ParticleEmitter') or descendant:IsA('Beam') or descendant:IsA('Trail') or
           descendant:IsA('Smoke') or descendant:IsA('Fire') or descendant:IsA('Sparkles') or
           descendant:IsA('Explosion') then
            descendant.Enabled = false
        elseif descendant:IsA('Decal') then
            descendant.Transparency = 1
        elseif descendant:IsA('BasePart') then
            descendant.Material = Enum.Material.Plastic
            descendant.Reflectance = 0
            descendant.CastShadow = false
        end
        if descendant:IsA('Accessory') then
            descendant:Destroy()
        end
        if (descendant:IsA('SurfaceGui') or descendant:IsA('BillboardGui')) and not isOurGui(descendant) then
            descendant.Enabled = false
        end
    end
end

local function toggleAntiLag(state)
    if state then
        _antiLagEnabled = true
        AntiLagToggle.Text = "ON"
        AntiLagToggle.BackgroundColor3 = COLORS.Accent
        AntiLagToggle.TextColor3 = COLORS.Window
        applyAntiLag()
        if _antiLagConnection then _antiLagConnection:Disconnect() end
        _antiLagConnection = Workspace.DescendantAdded:Connect(function(descendant)
            if descendant:IsA('ParticleEmitter') or descendant:IsA('Beam') or descendant:IsA('Trail') or
               descendant:IsA('Smoke') or descendant:IsA('Fire') or descendant:IsA('Sparkles') or
               descendant:IsA('Explosion') then
                descendant.Enabled = false
            elseif descendant:IsA('Decal') then
                descendant.Transparency = 1
            elseif descendant:IsA('BasePart') then
                descendant.Material = Enum.Material.Plastic
                descendant.Reflectance = 0
                descendant.CastShadow = false
            end
            if descendant:IsA('Accessory') then
                descendant:Destroy()
            end
            if (descendant:IsA('SurfaceGui') or descendant:IsA('BillboardGui')) and not isOurGui(descendant) then
                descendant.Enabled = false
            end
        end)
    else
        _antiLagEnabled = false
        AntiLagToggle.Text = "OFF"
        AntiLagToggle.BackgroundColor3 = COLORS.Control
        AntiLagToggle.TextColor3 = COLORS.Dim
        if _antiLagConnection then
            _antiLagConnection:Disconnect()
            _antiLagConnection = nil
        end
    end
end

AntiLagToggle.MouseButton1Click:Connect(function()
    toggleAntiLag(not _antiLagEnabled)
end)

-- ========== ANTI-RAGDOLL FUNCTIONS ==========
local function resetCharacter(char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or not root or hum.Health <= 0 then return end
    pcall(function()
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        task.wait(0.05)
        hum:ChangeState(Enum.HumanoidStateType.Running)
        root.Velocity = Vector3.zero
        root.RotVelocity = Vector3.zero
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        local pos = root.Position
        root.CFrame = CFrame.new(pos)
        hum.PlatformStand = false
        hum.Sit = false
        hum.AutoRotate = true
        hum.JumpPower = hum.JumpPower > 0 and hum.JumpPower or 50
        hum.WalkSpeed = hum.WalkSpeed > 0 and hum.WalkSpeed or 16
        for _, obj in ipairs(char:GetDescendants()) do
            if obj:IsA("Motor6D") then
                obj.Enabled = true
            elseif obj:IsA("Constraint") or obj:IsA("BallSocketConstraint") or obj:IsA("HingeConstraint") then
                obj.Enabled = true
            elseif obj:IsA("BasePart") then
                obj.CanCollide = true
                obj.AssemblyLinearVelocity = Vector3.zero
                obj.AssemblyAngularVelocity = Vector3.zero
                obj.CanCollide = false
                task.wait(0.02)
                obj.CanCollide = true
            end
        end
        workspace.CurrentCamera.CameraSubject = hum
        local PM = player.PlayerScripts:FindFirstChild("PlayerModule")
        if PM then
            local CM = PM:FindFirstChild("ControlModule")
            if CM then
                local success, module = pcall(require, CM)
                if success and module and module.Enable then
                    module:Enable()
                end
            end
        end
    end)
end

local function startAntiRagdoll()
    if _antiRagdollConnection then return end
    _antiRagdollConnection = RunService.Heartbeat:Connect(function()
        if not _antiRagdollEnabled then return end
        local char = player.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local state = hum:GetState()
        local root = char:FindFirstChild("HumanoidRootPart")
        local isBadState = (state == Enum.HumanoidStateType.Physics or state == Enum.HumanoidStateType.Ragdoll or
                            state == Enum.HumanoidStateType.FallingDown or state == Enum.HumanoidStateType.Dead or
                            hum.PlatformStand == true or hum.Sit == true)
        local velocityExceeded = false
        if root then
            local linVel = root.AssemblyLinearVelocity.Magnitude
            local angVel = root.AssemblyAngularVelocity.Magnitude
            if linVel > 150 or angVel > 20 then velocityExceeded = true end
        end
        local stateKey = tostring(state)
        if isBadState then
            _antiRagdollStateTimers[stateKey] = _antiRagdollStateTimers[stateKey] or tick()
            local duration = tick() - _antiRagdollStateTimers[stateKey]
            if duration > 1 then
                resetCharacter(char)
                _antiRagdollStateTimers[stateKey] = tick()
                return
            end
        else
            _antiRagdollStateTimers[stateKey] = nil
        end
        if isBadState or velocityExceeded then
            local now = tick()
            if now - _antiRagdollLastReset >= 0.5 then
                _antiRagdollLastReset = now
                resetCharacter(char)
            end
        end
    end)
end

local function stopAntiRagdoll()
    if _antiRagdollConnection then
        _antiRagdollConnection:Disconnect()
        _antiRagdollConnection = nil
    end
    _antiRagdollStateTimers = {}
end

local function toggleAntiRagdoll(state)
    _antiRagdollEnabled = state
    savedConfig.antiRagdoll = state
    saveConfig()
    AntiRagdollToggle.Text = state and "ON" or "OFF"
    AntiRagdollToggle.BackgroundColor3 = state and COLORS.Accent or COLORS.Control
    AntiRagdollToggle.TextColor3 = state and COLORS.Window or COLORS.Dim
    if state then
        startAntiRagdoll()
    else
        stopAntiRagdoll()
    end
end

AntiRagdollToggle.MouseButton1Click:Connect(function()
    toggleAntiRagdoll(not _antiRagdollEnabled)
end)

-- Restart anti-ragdoll on respawn
player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    _antiRagdollStateTimers = {}
    if _antiRagdollEnabled then
        startAntiRagdoll()
    end
end)

-- Initialize anti-ragdoll if enabled
if _antiRagdollEnabled then
    task.spawn(function()
        task.wait(0.5)
        startAntiRagdoll()
    end)
end

-- ========== TAB SWITCHING ==========
local function switchTab(tabName)
    if tabName == "Main" then
        MainTab.Visible = true
        HelperTab.Visible = false
        TabMain.BackgroundColor3 = COLORS.Accent
        TabMain.BackgroundTransparency = 0.3
        TabMain.TextColor3 = COLORS.Window
        TabHelper.BackgroundColor3 = COLORS.Control
        TabHelper.BackgroundTransparency = 0.5
        TabHelper.TextColor3 = COLORS.Text
    else
        MainTab.Visible = false
        HelperTab.Visible = true
        TabHelper.BackgroundColor3 = COLORS.Accent
        TabHelper.BackgroundTransparency = 0.3
        TabHelper.TextColor3 = COLORS.Window
        TabMain.BackgroundColor3 = COLORS.Control
        TabMain.BackgroundTransparency = 0.5
        TabMain.TextColor3 = COLORS.Text
    end
end

TabMain.MouseButton1Click:Connect(function() switchTab("Main") end)
TabHelper.MouseButton1Click:Connect(function() switchTab("Helper") end)
switchTab("Main")

-- ========== MINIMIZE ==========
local isMinimized = false
local expandedSize = UDim2.fromOffset(310, 440)
local minimizedSize = UDim2.fromOffset(310, 48)

MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        Window.Size = minimizedSize
        MinimizeBtn.Text = "â–¡"
        ContentContainer.Visible = false
        TabFrame.Visible = false
    else
        Window.Size = expandedSize
        MinimizeBtn.Text = "â”€"
        ContentContainer.Visible = true
        TabFrame.Visible = true
    end
end)

-- ========== DRAGGING ==========
do
    local dragging = false
    local activeDragInput
    local dragStart
    local startPosition
    local dragMoved = false
    local DRAG_THRESHOLD = UserInputService.TouchEnabled and 10 or 3
    local function stopDragging(input)
        if input ~= activeDragInput then return end
        dragging = false
        activeDragInput = nil
        dragStart = nil
        startPosition = nil
    end
    Header.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
        if dragging then return end
        dragging = true
        activeDragInput = input
        dragStart = Vector2.new(input.Position.X, input.Position.Y)
        startPosition = Window.Position
        dragMoved = false
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End or input.UserInputState == Enum.UserInputState.Cancel then
                stopDragging(input)
            end
        end)
    end)
    UserInputService.InputChanged:Connect(function(input)
        if not dragging or not activeDragInput then return end
        local isTrackedTouch = activeDragInput.UserInputType == Enum.UserInputType.Touch and input == activeDragInput
        local isTrackedMouse = activeDragInput.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseMovement
        if not isTrackedTouch and not isTrackedMouse then return end
        local current = Vector2.new(input.Position.X, input.Position.Y)
        local delta = current - dragStart
        if not dragMoved then
            if delta.Magnitude < DRAG_THRESHOLD then return end
            dragMoved = true
        end
        Window.Position = UDim2.new(
            startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
        )
    end)
end

-- ========== CORE SNIPER LOGIC ==========
local function resetPasteCounter()
    _capturedParts = {}
end

clearAceCapture = function()
    _capturedParts = {}
end

-- Modified updateStatus: do not overwrite display while user is editing it
local function updateStatus()
    local combined = table.concat(_capturedParts)
    if CodeDisplayBox and (UserInputService:GetFocusedTextBox() == CodeDisplayBox or _userEditingDisplay) then
        return
    end
    if CodeDisplayBox then
        CodeDisplayBox.Text = combined
    end
    -- also update billboard code text when not being edited
    if _billboard and _billboard.CodeLabel and _billboard.CodeLabel:IsA("TextLabel") then
        pcall(function()
            _billboard.CodeLabel.Text = combined
        end)
    end
end

local function clearBoxWatchers()
    if _boxTextConn then pcall(function() _boxTextConn:Disconnect() end) end
    if _boxAncestryConn then pcall(function() _boxAncestryConn:Disconnect() end) end
    for _, connection in ipairs(_boxVisibilityConns) do
        pcall(function() connection:Disconnect() end)
    end
    _boxTextConn = nil
    _boxAncestryConn = nil
    _boxVisibilityConns = {}
    _lastWatchedBox = nil
end

local function watchBoxForBlankReset(box)
    if not box or _lastWatchedBox == box then return end
    clearBoxWatchers()
    _lastWatchedBox = box
    if box.Text ~= "" then _lastNonBlankBoxText = box.Text end
    _boxTextConn = box:GetPropertyChangedSignal("Text"):Connect(function()
        if box.Text == "" then
            resetPasteCounter()
            updateStatus()
        else
            _lastNonBlankBoxText = box.Text
        end
    end)
    _boxAncestryConn = box.AncestryChanged:Connect(function(_, parent)
        if not parent then
            resetPasteCounter()
            clearBoxWatchers()
            updateStatus()
        end
    end)
end

UserInputService.TextBoxFocused:Connect(function(box)
    if box:IsDescendantOf(GUI) then return end
    if box ~= aceCodeBox() then return end
    _focused = box
    _lastBox = box
    watchBoxForBlankReset(box)
end)

UserInputService.TextBoxFocusReleased:Connect(function(box)
    if box:IsDescendantOf(GUI) then return end
    -- retype invalid removed
end)

function appendToBox(text)
    if not text or text == "" then return end
    local filtered = text:gsub("[^%w]", "")
    local common = {"code","redeem","claim","enter","submit","confirm","apply","use","go","ok","check","get","free","win","bonus","spin","daily","reward","gift","event","party","lucky","happy","new","old","big","small","one","two","three","four","five","six","seven","eight","nine","ten"}
    for _, word in ipairs(common) do
        if filtered:lower() == word then return end
    end
    if _seen[filtered] then return end
    _seen[filtered] = true
    task.delay(2, function() _seen[filtered] = nil end)

    if _lastWatchedBox and not isVisibleChain(_lastWatchedBox) then
        resetPasteCounter()
        clearBoxWatchers()
        updateStatus()
    end
    local box = aceCodeBox()
    _capturedParts[#_capturedParts + 1] = filtered
    local combinedCode = table.concat(_capturedParts)
    local capturedCount = #_capturedParts
    if box then
        _lastBox = box
        watchBoxForBlankReset(box)
        local boxWasFocused = UserInputService:GetFocusedTextBox() == box
        -- Only overwrite the textbox if the user is not currently editing the display box
        if not (CodeDisplayBox and _userEditingDisplay and box == CodeDisplayBox) then
            pcall(function() box.Text = combinedCode end)
        end
        if boxWasFocused then
            pcall(function()
                local caretEnd = #combinedCode + 1
                box.CursorPosition = caretEnd
                box.SelectionStart = caretEnd
            end)
        end
    end
    updateStatus()
    if capturedCount >= _submitAfter then
        if _autoAccept then
            setStatus("Redeeming...")
            local ok, msg = typeAndSubmitCode(combinedCode)
            if ok then
                setStatus("Redeemed: " .. combinedCode)
                _capturedParts = {}
                updateStatus()
                incrementCounter()
                -- spam
                if _spamCount > 1 then
                    task.spawn(function()
                        for i = 2, _spamCount do
                            task.wait(0.1)
                            setStatus("Spamming " .. i .. "/" .. _spamCount)
                            local ok2, msg2 = typeAndSubmitCode(combinedCode)
                            if ok2 then
                                incrementCounter()
                            end
                        end
                        setStatus("Spam complete")
                    end)
                end
            else
                setStatus("Failed: " .. combinedCode)
            end
        else
            setStatus("Captured " .. capturedCount .. "/" .. _submitAfter .. " - waiting")
        end
    else
        setStatus("Typing... (" .. capturedCount .. "/" .. _submitAfter .. ")")
    end
end

-- Announcement listener (for code capture)
local function resolveNotifyRemote()
    if _G.PhiNotifyRemote then return _G.PhiNotifyRemote end
    local ok, Net = pcall(function() return ReplicatedStorage:WaitForChild("Packages",5):WaitForChild("Net",5) end)
    if not ok or not Net then return nil end
    local getinfo = debug and (debug.getinfo or debug.info)
    if getgc and getinfo and getconnections then
        for _, d in ipairs(Net:GetDescendants()) do
            if d:IsA("RemoteEvent") then
                local ok2, cs = pcall(getconnections, d.OnClientEvent)
                if ok2 then
                    for _, c in ipairs(cs) do
                        local f, fn = pcall(function() return c.Function end)
                        if f and type(fn) == "function" then
                            local i, info = pcall(getinfo, fn)
                            if i and tostring(info.short_src or info.source or ""):find("NotificationController", 1, true) then
                                return d
                            end
                        end
                    end
                end
            end
        end
    end
    return nil
end

local function aceStripRich(text)
    if type(text) ~= "string" then return tostring(text) end
    return (text:gsub("<[^>]->", ""))
end

local function aceTokenize(text)
    local words = {}
    for word in text:gmatch("[%w_]+") do
        words[#words + 1] = word
    end
    return words
end

local aceCollectBuffer = {}
local function onAceAnnouncement(...)
    local text = aceStripRich(tostring((...) or ""))
    text = text:match("^%s*(.-)%s*$") or ""
    if text == "" or text:find("%s") then return end
    for _, word in ipairs(aceTokenize(text)) do
        aceCollectBuffer[#aceCollectBuffer + 1] = word
    end
    local parts = {}
    for index = 1, math.min(#aceCollectBuffer, ACE_WORD_COUNT) do
        parts[index] = aceCollectBuffer[index]
    end
    if #aceCollectBuffer < ACE_WORD_COUNT then return end
    aceCollectBuffer = {}
    local captured = table.concat(parts)
    if captured == "" then return end
    appendToBox(captured)
end

local aceNotifyRemote = resolveNotifyRemote()
local aceListenConnection
if aceNotifyRemote then
    if getgenv then
        local previous = getgenv().ACECodeSniperNotifyConnection
        if previous then pcall(function() previous:Disconnect() end) end
    end
    aceListenConnection = aceNotifyRemote.OnClientEvent:Connect(function(...)
        if not _enabled then return end
        pcall(onAceAnnouncement, ...)
    end)
    if getgenv then
        getgenv().ACECodeSniperNotifyConnection = aceListenConnection
    end
end

-- ========== HITS TAB & SPAWN HOOK ==========
-- Hits UI (simple list of spawn events)
local HitsTab = Instance.new("ScrollingFrame")
HitsTab.Name = "HitsTab"
HitsTab.Size = UDim2.new(1, 0, 1, 0)
HitsTab.BackgroundTransparency = 1
HitsTab.BorderSizePixel = 0
HitsTab.ZIndex = 2
HitsTab.CanvasSize = UDim2.fromOffset(0, 0)
HitsTab.ScrollBarThickness = 6
HitsTab.ScrollBarImageColor3 = COLORS.Dim
HitsTab.ScrollBarImageTransparency = 0.8
HitsTab.Visible = false
HitsTab.Parent = ContentContainer

local HitsContent = Instance.new("Frame")
HitsContent.Name = "Content"
HitsContent.Size = UDim2.new(1, 0, 0, 0)
HitsContent.BackgroundTransparency = 1
HitsContent.Parent = HitsTab

local HitsTop = Instance.new("Frame")
HitsTop.Name = "Top"
HitsTop.Size = UDim2.new(1, -16, 0, 32)
HitsTop.Position = UDim2.fromOffset(8, 8)
HitsTop.BackgroundTransparency = 1
HitsTop.Parent = HitsContent

local ClearHitsBtn = Instance.new("TextButton")
ClearHitsBtn.Name = "ClearHits"
ClearHitsBtn.Size = UDim2.fromOffset(80, 24)
ClearHitsBtn.Position = UDim2.fromOffset(0, 4)
ClearHitsBtn.BackgroundColor3 = COLORS.Control
ClearHitsBtn.BorderSizePixel = 0
ClearHitsBtn.Text = "Clear"
ClearHitsBtn.Font = Enum.Font.GothamBold
ClearHitsBtn.TextSize = 12
ClearHitsBtn.TextColor3 = COLORS.Text
ClearHitsBtn.Parent = HitsTop
addCorner(ClearHitsBtn, 6)
addStroke(ClearHitsBtn, COLORS.White, 1, 0.8)

local SendHitsBtn = Instance.new("TextButton")
SendHitsBtn.Name = "SendHits"
SendHitsBtn.Size = UDim2.fromOffset(120, 24)
SendHitsBtn.Position = UDim2.fromOffset(92, 4)
SendHitsBtn.BackgroundColor3 = COLORS.Control
SendHitsBtn.BorderSizePixel = 0
SendHitsBtn.Text = "Send All (Webhook)"
SendHitsBtn.Font = Enum.Font.GothamBold
SendHitsBtn.TextSize = 12
SendHitsBtn.TextColor3 = COLORS.Text
SendHitsBtn.Parent = HitsTop
addCorner(SendHitsBtn, 6)
addStroke(SendHitsBtn, COLORS.White, 1, 0.8)

local hitsStartY = 48
local hitsList = {}

local function refreshHitsCanvas()
    local contentHeight = hitsStartY + (#hitsList) * 44 + 12
    HitsContent.Size = UDim2.new(1, 0, 0, contentHeight)
    HitsTab.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
end

local function tryCopyToClipboard(text)
    pcall(function()
        if typeof(setclipboard) == "function" then
            setclipboard(text)
        elseif syn and syn.set_clipboard then
            syn.set_clipboard(text)
        elseif set_clipboard then
            set_clipboard(text)
        end
    end)
end

local function addHitEntry(spawnName, sourceOwner)
    local idx = #hitsList + 1
    local frame = Instance.new("Frame")
    frame.Name = "Hit_" .. tostring(idx)
    frame.Size = UDim2.new(1, -16, 0, 40)
    frame.Position = UDim2.fromOffset(8, hitsStartY + (idx-1) * 44)
    frame.BackgroundColor3 = COLORS.Row
    frame.BackgroundTransparency = 0.6
    frame.BorderSizePixel = 0
    frame.Parent = HitsContent
    addCorner(frame, 8)
    addStroke(frame, COLORS.White, 1, 0.7)

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -100, 0, 20)
    title.Position = UDim2.fromOffset(8, 4)
    title.BackgroundTransparency = 1
    title.Text = tostring(spawnName or "Unknown")
    title.TextColor3 = COLORS.White
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local sub = Instance.new("TextLabel")
    sub.Name = "Sub"
    sub.Size = UDim2.new(1, -100, 0, 16)
    sub.Position = UDim2.fromOffset(8, 22)
    sub.BackgroundTransparency = 1
    sub.Text = "By: " .. tostring(sourceOwner or "?")
    sub.TextColor3 = COLORS.Dim
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 12
    sub.TextXAlignment = Enum.TextXAlignment.Left
    sub.Parent = frame

    local copyBtn = Instance.new("TextButton")
    copyBtn.Name = "Copy"
    copyBtn.Size = UDim2.fromOffset(72, 28)
    copyBtn.Position = UDim2.fromOffset(frame.Size.X.Offset - 80, 6)
    copyBtn.AnchorPoint = Vector2.new(0,0)
    copyBtn.BackgroundColor3 = COLORS.Control
    copyBtn.BorderSizePixel = 0
    copyBtn.Text = "Copy"
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.TextSize = 12
    copyBtn.TextColor3 = COLORS.Text
    copyBtn.Parent = frame
    addCorner(copyBtn, 6)
    addStroke(copyBtn, COLORS.White, 1, 0.8)

    copyBtn.MouseButton1Click:Connect(function()
        tryCopyToClipboard(tostring(sourceOwner or spawnName or ""))
        setStatus("Copied: "..tostring(sourceOwner or spawnName or ""))
    end)

    hitsList[#hitsList + 1] = { name = spawnName, owner = sourceOwner, frame = frame }
    refreshHitsCanvas()
end

ClearHitsBtn.MouseButton1Click:Connect(function()
    for _, entry in ipairs(hitsList) do
        pcall(function() entry.frame:Destroy() end)
    end
    hitsList = {}
    refreshHitsCanvas()
    setStatus("Hits cleared")
end)

SendHitsBtn.MouseButton1Click:Connect(function()
    if not WEBHOOK_URL or WEBHOOK_URL == "" then
        setStatus("No webhook URL set")
        return
    end
    if not httpRequest then
        setStatus("No HTTP request available")
        return
    end
    if #hitsList == 0 then
        setStatus("No hits to send")
        return
    end
    setStatus("Sending hits...")
    local lines = {}
    for _, h in ipairs(hitsList) do
        lines[#lines+1] = ("**%s** â€” %s"):format(tostring(h.name or "?"), tostring(h.owner or "?"))
    end
    local payload = {
        content = "",
        embeds = {{
            title = "Hits Report",
            description = table.concat(lines, "\n"),
            color = 0x92FF67
        }}
    }
    pcall(function()
        httpRequest({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode(payload),
        })
    end)
    setStatus("Hits sent")
end)

-- Spawn hook (Notification GUI watcher)
local function checkSpawnLabel(obj)
    if not obj or not obj:IsA("TextLabel") then return end
    local plain = tostring(obj.Text or ""):gsub("<[^>]+>", "")
    local name = plain:match("^(.-)%s+spawned!%s*$")
    if not name or name == "" then return end
    pcall(function() addHitEntry(name, name) end)
end

local function hookSpawnFolder()
    local timeout = 10
    local ok, folder = pcall(function()
        return playerGui:WaitForChild("Notification", timeout):WaitForChild("Notification", timeout)
    end)
    if not ok or not folder then return end
    for _, obj in ipairs(folder:GetChildren()) do
        checkSpawnLabel(obj)
    end
    folder.ChildAdded:Connect(function(obj)
        task.wait(0.02)
        checkSpawnLabel(obj)
    end)
end

task.spawn(hookSpawnFolder)

-- ========== FINALIZE ==========
if getgenv then
    getgenv().StopAura = function()
        if aceListenConnection then
            pcall(function() aceListenConnection:Disconnect() end)
            aceListenConnection = nil
        end
        if getgenv().ACECodeSniperNotifyConnection then
            pcall(function() getgenv().ACECodeSniperNotifyConnection:Disconnect() end)
            getgenv().ACECodeSniperNotifyConnection = nil
        end
        if GUI then GUI:Destroy() end
        stopAntiRagdoll()
        toggleAntiLag(false)
    end
end

updateStatus()
setStatus("Idle")