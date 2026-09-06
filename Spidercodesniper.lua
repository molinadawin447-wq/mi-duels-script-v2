-- =========================================================
-- 🕷 SPIDER.VS + CRYON BUTTONS (Fusión)
-- Interfaz gráfica + Keybinds + Funciones avanzadas
-- =========================================================

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Stats = game:GetService("Stats")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- =========================================================
-- CONFIGURACIÓN DE KEYBINDS (predeterminados)
-- =========================================================
local KB = {
    AutoLeft  = Enum.KeyCode.Z,
    AutoRight = Enum.KeyCode.C,
    Drop      = Enum.KeyCode.X,
    TPDown    = Enum.KeyCode.F,
    AutoBat   = Enum.KeyCode.E,
    Lagger    = Enum.KeyCode.R,
    InstaReset= Enum.KeyCode.G,
    GuiHide   = Enum.KeyCode.LeftControl,
}

local CONFIG_FILE = "CRYON_SPIDER_CONFIG.json"

local function saveKeybinds()
    local data = {}
    for name, key in pairs(KB) do
        data[name] = key and key.Name or nil
    end
    local encoded = HttpService:JSONEncode(data)
    if writefile then
        pcall(function() writefile(CONFIG_FILE, encoded) end)
    end
end

local function loadKeybinds()
    if not isfile then return end
    if not isfile(CONFIG_FILE) then return end
    local content = readfile(CONFIG_FILE)
    if content and content ~= "" then
        local data = HttpService:JSONDecode(content)
        for name, keyName in pairs(data) do
            if keyName and KB[name] ~= nil then
                KB[name] = Enum.KeyCode[keyName]
            end
        end
    end
end
loadKeybinds()

-- =========================================================
-- ESTADOS GLOBALES
-- =========================================================
local State = {
    autoLeftEnabled = false,
    autoRightEnabled = false,
    dropActive = false,
    autoBatToggled = false,
    tpBatEnabled = false,
    laggerToggled = false,
    infJumpEnabled = false,
    antiRagdollEnabled = false,
    fpsBoostEnabled = false,
    guiVisible = true,
}

-- =========================================================
-- FUNCIONES DEL SCRIPT ORIGINAL (CRYON BUTTONS)
-- =========================================================

-- Drop (teletransporta hacia arriba y luego al suelo)
function runDrop()
    if State.dropActive then return end
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end
    State.dropActive = true
    local t0 = tick()
    local dc
    dc = RunService.Heartbeat:Connect(function()
        local c = player.Character
        local r = c and c:FindFirstChild("HumanoidRootPart")
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if not r or not h or h.Health <= 0 then
            if dc then dc:Disconnect() end
            State.dropActive = false
            return
        end
        if tick() - t0 >= 0.25 then
            if dc then dc:Disconnect() end
            r.AssemblyLinearVelocity = Vector3.zero
            r.AssemblyAngularVelocity = Vector3.zero
            local params = RaycastParams.new()
            params.FilterDescendantsInstances = {c}
            params.FilterType = Enum.RaycastFilterType.Exclude
            local result = workspace:Raycast(r.Position + Vector3.new(0,5,0), Vector3.new(0,-4000,0), params)
            if result then
                r.CFrame = CFrame.new(Vector3.new(r.Position.X, result.Position.Y + 2.5, r.Position.Z))
            end
            State.dropActive = false
            return
        end
        r.AssemblyLinearVelocity = Vector3.new(r.AssemblyLinearVelocity.X, 240, r.AssemblyLinearVelocity.Z)
    end)
end

-- AutoBat (aimbot con bate) - del primer script
local autoBatRunning = false
local autoBatConnection = nil

local function findBat()
    local char = player.Character
    if not char then return nil end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") and (tool.Name:lower():find("bat") or tool.Name:lower():find("slap")) then
            return tool
        end
    end
    local bp = player:FindFirstChild("Backpack")
    if bp then
        for _, tool in ipairs(bp:GetChildren()) do
            if tool:IsA("Tool") and (tool.Name:lower():find("bat") or tool.Name:lower():find("slap")) then
                return tool
            end
        end
    end
    return nil
end

local function getClosestTarget()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local closest, minDist = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local tr = plr.Character:FindFirstChild("HumanoidRootPart")
            local h = plr.Character:FindFirstChildOfClass("Humanoid")
            if tr and h and h.Health > 0 then
                local d = (tr.Position - root.Position).Magnitude
                if d < minDist then minDist = d; closest = tr end
            end
        end
    end
    return closest
end

function toggleAutoBat()
    State.autoBatToggled = not State.autoBatToggled
    if State.autoBatToggled then
        autoBatRunning = true
        if autoBatConnection then autoBatConnection:Disconnect() end
        autoBatConnection = RunService.RenderStepped:Connect(function()
            if not State.autoBatToggled then return end
            local char = player.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not root or not hum then return end
            if not char:FindFirstChildOfClass("Tool") then
                local bat = findBat()
                if bat then pcall(function() hum:EquipTool(bat) end) end
            end
            local target = getClosestTarget()
            if target then
                local dir = (target.Position - root.Position)
                local flatDir = Vector3.new(dir.X, 0, dir.Z).Unit
                root.CFrame = CFrame.lookAt(root.Position, root.Position + flatDir)
                local vel = flatDir * 60 + Vector3.new(0, (target.Position.Y - root.Position.Y) * 19.5, 0)
                root.AssemblyLinearVelocity = root.AssemblyLinearVelocity:Lerp(vel, 0.8)
                local bat = char:FindFirstChildOfClass("Tool")
                if bat and (bat.Name:lower():find("bat") or bat.Name:lower():find("slap")) then
                    pcall(function() bat:Activate() end)
                end
            end
        end)
    else
        autoBatRunning = false
        if autoBatConnection then autoBatConnection:Disconnect(); autoBatConnection = nil end
        local c = player.Character
        local root = c and c:FindFirstChild("HumanoidRootPart")
        if root then root.AssemblyLinearVelocity = Vector3.zero end
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if h then h.AutoRotate = true end
    end
end

-- Lagger Toggle (efecto estético)
function toggleLagger()
    State.laggerToggled = not State.laggerToggled
    -- Aquí se puede añadir efecto visual si se desea
end

-- InfJump
local infJumpConn = nil
function toggleInfJump()
    State.infJumpEnabled = not State.infJumpEnabled
    if State.infJumpEnabled then
        if infJumpConn then infJumpConn:Disconnect() end
        infJumpConn = UIS.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.Space then
                local char = player.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end
        end)
    else
        if infJumpConn then infJumpConn:Disconnect(); infJumpConn = nil end
    end
end

-- AntiRagdoll
local antiRagdollConn = nil
function toggleAntiRagdoll()
    State.antiRagdollEnabled = not State.antiRagdollEnabled
    if State.antiRagdollEnabled then
        if antiRagdollConn then antiRagdollConn:Disconnect() end
        antiRagdollConn = RunService.Heartbeat:Connect(function()
            local char = player.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum:GetState() == Enum.HumanoidStateType.Physics then
                    hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                end
            end
        end)
    else
        if antiRagdollConn then antiRagdollConn:Disconnect(); antiRagdollConn = nil end
    end
end

-- FPS Boost (reduce gráficos)
function toggleFpsBoost()
    State.fpsBoostEnabled = not State.fpsBoostEnabled
    if State.fpsBoostEnabled then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Part") then
                v.Material = Enum.Material.Plastic
            end
        end
        settings().Rendering.QualityLevel = 1
    else
        settings().Rendering.QualityLevel = 21
    end
end

-- =========================================================
-- FUNCIONES DEL SEGUNDO SCRIPT (SPIDER.VS UI)
-- =========================================================

-- TP Bat (del segundo script)
local tpBatEnabled = false
local tpBatHittingCooldown = false
local tpBatHRP = nil
local tpBatH = nil
local tpHeartbeatConn = nil
local tpRenderConn = nil
local tpCharAddedConn = nil

local function getBatTool()
    local char = player.Character
    if not char then return nil end
    local bat = char:FindFirstChild("Bat")
    if bat then return bat end
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        bat = backpack:FindFirstChild("Bat")
        if bat then
            bat.Parent = char
            return bat
        end
    end
    return nil
end

local function tryHit()
    if tpBatHittingCooldown then return end
    tpBatHittingCooldown = true
    pcall(function()
        local bat = getBatTool()
        if bat then
            bat:Activate()
            local remoteEvent = bat:FindFirstChildWhichIsA("RemoteEvent")
            if remoteEvent then remoteEvent:FireServer() end
            local remoteFunction = bat:FindFirstChildWhichIsA("RemoteFunction")
            if remoteFunction then pcall(function() remoteFunction:InvokeServer() end) end
        end
    end)
    task.delay(0.08, function() tpBatHittingCooldown = false end)
end

local function getClosestPlayerTP()
    if not tpBatHRP then return nil, math.huge end
    local closest, closestDist = nil, math.huge
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local targetRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                local dist = (tpBatHRP.Position - targetRoot.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closest = otherPlayer
                end
            end
        end
    end
    return closest, closestDist
end

local function updateCharacterReferences()
    local char = player.Character
    if char then
        tpBatH = char:FindFirstChildOfClass("Humanoid")
        tpBatHRP = char:FindFirstChild("HumanoidRootPart")
    end
end

local function heartbeatLoop()
    if not tpBatEnabled then return end
    if not tpBatH or not tpBatHRP or not tpBatH.Parent or not tpBatHRP.Parent then
        updateCharacterReferences()
        if not tpBatH or not tpBatHRP then return end
    end
    local target, dist = getClosestPlayerTP()
    if target and target.Character then
        local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
        if targetRoot then
            if sethiddenproperty then
                pcall(function()
                    sethiddenproperty(tpBatHRP, "PhysicsRepRootPart", targetRoot)
                end)
            end
            local targetPosition = targetRoot.Position + Vector3.new(0, 0.9, 0)
            if (tpBatHRP.Position - targetPosition).Magnitude > 5 then
                tpBatHRP.CFrame = CFrame.new(targetPosition)
            end
            local camera = workspace.CurrentCamera
            if camera then
                camera.CFrame = CFrame.new(camera.CFrame.Position, targetRoot.Position)
            end
            tryHit()
        end
    end
end

local function renderLoop()
    if not tpBatEnabled then return end
    if not tpBatH or not tpBatHRP or not tpBatH.Parent or not tpBatHRP.Parent then
        updateCharacterReferences()
        if not tpBatH or not tpBatHRP then return end
    end
    local target, dist = getClosestPlayerTP()
    if target and target.Character then
        local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
        if targetRoot then
            local camera = workspace.CurrentCamera
            if camera then
                camera.CFrame = CFrame.new(camera.CFrame.Position, targetRoot.Position)
            end
            tryHit()
        end
    end
end

function enableTPBat()
    if tpBatEnabled then return end
    tpBatEnabled = true
    State.tpBatEnabled = true
    updateCharacterReferences()
    if tpHeartbeatConn then tpHeartbeatConn:Disconnect() end
    if tpRenderConn then tpRenderConn:Disconnect() end
    tpHeartbeatConn = RunService.Heartbeat:Connect(heartbeatLoop)
    tpRenderConn = RunService.RenderStepped:Connect(renderLoop)
    if tpCharAddedConn then tpCharAddedConn:Disconnect() end
    tpCharAddedConn = player.CharacterAdded:Connect(function()
        task.wait(0.2)
        updateCharacterReferences()
    end)
    print("🕷 TP Bat activado")
end

function disableTPBat()
    if not tpBatEnabled then return end
    tpBatEnabled = false
    State.tpBatEnabled = false
    if tpHeartbeatConn then tpHeartbeatConn:Disconnect(); tpHeartbeatConn = nil end
    if tpRenderConn then tpRenderConn:Disconnect(); tpRenderConn = nil end
    if tpCharAddedConn then tpCharAddedConn:Disconnect(); tpCharAddedConn = nil end
    pcall(function()
        local camera = workspace.CurrentCamera
        if camera then
            camera.CFrame = CFrame.new(camera.CFrame.Position, Vector3.zero)
        end
    end)
    print("🕷 TP Bat desactivado")
end

function toggleTPBat()
    if tpBatEnabled then disableTPBat() else enableTPBat() end
end

-- Auto Left / Auto Right (del segundo script)
local AP = {
    L1 = Vector3.new(-476.48, -6.28, 92.73),
    L2 = Vector3.new(-483.12, -4.95, 94.80),
    L_FACE = Vector3.new(-482.25, -4.96, 92.09),
    R1 = Vector3.new(-476.16, -6.52, 25.62),
    R2 = Vector3.new(-483.06, -5.03, 25.48),
    R_FACE = Vector3.new(-482.06, -6.93, 35.47),
}

local alPhase = 1
local arPhase = 1
local alConn = nil
local arConn = nil
local normalSpeed = 60

function setNormalSpeed(speed)
    if type(speed) == "number" and speed > 0 then normalSpeed = speed end
end

function startAutoLeft(speed)
    if alConn then stopAutoLeft() end
    State.autoLeftEnabled = true
    alPhase = 1
    local spd = speed or normalSpeed
    alConn = RunService.Heartbeat:Connect(function()
        if not State.autoLeftEnabled then return end
        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end
        if alPhase == 1 then
            local target = Vector3.new(AP.L1.X, hrp.Position.Y, AP.L1.Z)
            local dist = (target - hrp.Position).Magnitude
            if dist < 1 then
                alPhase = 2
                local dir = (AP.L2 - hrp.Position)
                local move = Vector3.new(dir.X, 0, dir.Z).Unit
                hum:Move(move, false)
                hrp.AssemblyLinearVelocity = Vector3.new(move.X * spd, hrp.AssemblyLinearVelocity.Y, move.Z * spd)
                return
            end
            local dir = (AP.L1 - hrp.Position)
            local move = Vector3.new(dir.X, 0, dir.Z).Unit
            hum:Move(move, false)
            hrp.AssemblyLinearVelocity = Vector3.new(move.X * spd, hrp.AssemblyLinearVelocity.Y, move.Z * spd)
        elseif alPhase == 2 then
            local target = Vector3.new(AP.L2.X, hrp.Position.Y, AP.L2.Z)
            local dist = (target - hrp.Position).Magnitude
            if dist < 1 then
                hum:Move(Vector3.zero, false)
                hrp.AssemblyLinearVelocity = Vector3.zero
                State.autoLeftEnabled = false
                if alConn then alConn:Disconnect(); alConn = nil end
                alPhase = 1
                if (AP.L_FACE - hrp.Position).Magnitude > 0.01 then
                    hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(AP.L_FACE.X, hrp.Position.Y, AP.L_FACE.Z))
                end
                return
            end
            local dir = (AP.L2 - hrp.Position)
            local move = Vector3.new(dir.X, 0, dir.Z).Unit
            hum:Move(move, false)
            hrp.AssemblyLinearVelocity = Vector3.new(move.X * spd, hrp.AssemblyLinearVelocity.Y, move.Z * spd)
        end
    end)
    print("🕷 Auto Left activado")
end

function stopAutoLeft()
    if alConn then alConn:Disconnect(); alConn = nil end
    State.autoLeftEnabled = false
    alPhase = 1
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum:Move(Vector3.zero, false) end
    end
    print("🕷 Auto Left desactivado")
end

function toggleAutoLeft()
    if State.autoLeftEnabled then stopAutoLeft() else startAutoLeft() end
end

function startAutoRight(speed)
    if arConn then stopAutoRight() end
    State.autoRightEnabled = true
    arPhase = 1
    local spd = speed or normalSpeed
    arConn = RunService.Heartbeat:Connect(function()
        if not State.autoRightEnabled then return end
        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end
        if arPhase == 1 then
            local target = Vector3.new(AP.R1.X, hrp.Position.Y, AP.R1.Z)
            local dist = (target - hrp.Position).Magnitude
            if dist < 1 then
                arPhase = 2
                local dir = (AP.R2 - hrp.Position)
                local move = Vector3.new(dir.X, 0, dir.Z).Unit
                hum:Move(move, false)
                hrp.AssemblyLinearVelocity = Vector3.new(move.X * spd, hrp.AssemblyLinearVelocity.Y, move.Z * spd)
                return
            end
            local dir = (AP.R1 - hrp.Position)
            local move = Vector3.new(dir.X, 0, dir.Z).Unit
            hum:Move(move, false)
            hrp.AssemblyLinearVelocity = Vector3.new(move.X * spd, hrp.AssemblyLinearVelocity.Y, move.Z * spd)
        elseif arPhase == 2 then
            local target = Vector3.new(AP.R2.X, hrp.Position.Y, AP.R2.Z)
            local dist = (target - hrp.Position).Magnitude
            if dist < 1 then
                hum:Move(Vector3.zero, false)
                hrp.AssemblyLinearVelocity = Vector3.zero
                State.autoRightEnabled = false
                if arConn then arConn:Disconnect(); arConn = nil end
                arPhase = 1
                if (AP.R_FACE - hrp.Position).Magnitude > 0.01 then
                    hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(AP.R_FACE.X, hrp.Position.Y, AP.R_FACE.Z))
                end
                return
            end
            local dir = (AP.R2 - hrp.Position)
            local move = Vector3.new(dir.X, 0, dir.Z).Unit
            hum:Move(move, false)
            hrp.AssemblyLinearVelocity = Vector3.new(move.X * spd, hrp.AssemblyLinearVelocity.Y, move.Z * spd)
        end
    end)
    print("🕷 Auto Right activado")
end

function stopAutoRight()
    if arConn then arConn:Disconnect(); arConn = nil end
    State.autoRightEnabled = false
    arPhase = 1
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum:Move(Vector3.zero, false) end
    end
    print("🕷 Auto Right desactivado")
end

function toggleAutoRight()
    if State.autoRightEnabled then stopAutoRight() else startAutoRight() end
end

-- TP Down (del segundo script)
function runTPDown()
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local pos = root.Position
    root.CFrame = CFrame.new(pos.X, -6.84, pos.Z)
end

-- Insta Reset (del segundo script)
local cursedResetRemote = nil
local resetCooldown = false
local CURSED_RESET_GUID = "f888ee6e-c86d-46e1-93d7-0639d6635d42"

local function findResetRemote()
    for _, desc in ipairs(game:GetDescendants()) do
        if desc:IsA("RemoteEvent") and desc.Name:sub(1,3) == "RE/" then
            cursedResetRemote = desc
            return true
        end
    end
    return false
end

function performInstantReset()
    if resetCooldown then return end
    resetCooldown = true
    if not cursedResetRemote then findResetRemote() end
    if not cursedResetRemote then
        for _, desc in ipairs(game:GetDescendants()) do
            if desc:IsA("RemoteEvent") and desc.Name:sub(1,3) == "RE/" then
                cursedResetRemote = desc
                break
            end
        end
    end
    if cursedResetRemote then
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health <= 0 then
            pcall(function()
                cursedResetRemote:FireServer(CURSED_RESET_GUID, player, "balloon")
            end)
            task.delay(0.3, function() resetCooldown = false end)
            return
        end
        local resetDetected = false
        local conns = {}
        if humanoid then
            table.insert(conns, humanoid.Died:Connect(function() resetDetected = true end))
            table.insert(conns, humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                if humanoid.Health <= 0 then resetDetected = true end
            end))
        end
        if character then
            table.insert(conns, character.AncestryChanged:Connect(function(_, parent)
                if not parent then resetDetected = true end
            end))
        end
        task.spawn(function()
            for i = 1, 50 do
                if resetDetected then break end
                pcall(function()
                    cursedResetRemote:FireServer(CURSED_RESET_GUID, player, "balloon")
                end)
                task.wait()
            end
            for _, conn in ipairs(conns) do
                pcall(function() conn:Disconnect() end)
            end
            task.delay(0.3, function() resetCooldown = false end)
        end)
    else
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = 0 end
        task.delay(0.3, function() resetCooldown = false end)
    end
end

-- =========================================================
-- INTERFAZ GRÁFICA (SPIDER.VS UI)
-- =========================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpiderVS_UI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 200
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Contenedor de botones
local container = Instance.new("Frame")
container.Name = "ButtonContainer"
container.BackgroundTransparency = 1
container.AnchorPoint = Vector2.new(1, 0)
container.Position = UDim2.new(1, -5, 0, 10)
container.Size = UDim2.fromOffset(300, 300)
container.Parent = screenGui

-- Gradiente animado
local function addAnimatedGradient(label)
    local gradient = Instance.new("UIGradient")
    gradient.Name = "DiagonalShadow"
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.42, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(35, 35, 35)),
        ColorSequenceKeypoint.new(0.58, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
    })
    gradient.Rotation = 45
    gradient.Offset = Vector2.new(-1.5, -1.5)
    gradient.Parent = label
    task.spawn(function()
        while label.Parent do
            gradient.Offset = Vector2.new(-1.5, -1.5)
            local tween = TweenService:Create(gradient, TweenInfo.new(1.8, Enum.EasingStyle.Linear), { Offset = Vector2.new(1.5, 1.5) })
            tween:Play()
            tween.Completed:Wait()
            task.wait(0.25)
        end
    end)
end

-- Crear botón
local buttonSize = 63
local gap = 7

local function createButton(name, text, x, y)
    local button = Instance.new("ImageButton")
    button.Name = name
    button.Size = UDim2.fromOffset(buttonSize, buttonSize)
    button.Position = UDim2.fromOffset(x, y)
    button.BackgroundTransparency = 1
    button.BorderSizePixel = 0
    button.Image = getcustomasset("Telaraña.jpg")
    button.ScaleType = Enum.ScaleType.Crop
    button.AutoButtonColor = false
    button.Parent = container

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = button

    local label = Instance.new("TextLabel")
    label.Name = "Text"
    label.Size = UDim2.new(1, -12, 1, -12)
    label.Position = UDim2.fromOffset(6, 6)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 13
    label.TextScaled = false
    label.Font = Enum.Font.GothamBold
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Parent = button
    addAnimatedGradient(label)
    return button
end

-- Botones (4 columnas x 4 filas)
local btnTPBat = createButton("Button1", "TP\nBAT", 0, 0)
local btnInstaReset = createButton("Button2", "INSTA\nRESET", buttonSize + gap, 0)
createButton("Button3", "BYPASS\nANTIBAT", buttonSize + gap, buttonSize + gap)
local btnAutoRight = createButton("Button4", "AUTO\nRIGHT", (buttonSize + gap) * 2, 0)
local btnBatAimbot = createButton("Button5", "BAT\nAIMBOT", (buttonSize + gap) * 2, buttonSize + gap)
local tpDownButton = createButton("Button6", "TP\nDOWN", (buttonSize + gap) * 2, (buttonSize + gap) * 2)
local btnLagger1 = createButton("Button7", "LAGGER 1", (buttonSize + gap) * 2, (buttonSize + gap) * 3)
local btnAutoLeft = createButton("Button8", "AUTO\nLEFT", (buttonSize + gap) * 3, 0)
local btnDropBR = createButton("Button9", "DROP BR", (buttonSize + gap) * 3, buttonSize + gap)
-- CARRY SPD movido a columna 4 (índice 3) y fila 3 (índice 2)
local btnCarrySpd = createButton("Button10", "CARRY\nSPD", (buttonSize + gap) * 3, (buttonSize + gap) * 2)
local btnLagger2 = createButton("Button11", "LAGGER 2", (buttonSize + gap) * 3, (buttonSize + gap) * 3)

-- =========================================================
-- BOTÓN SPIDER.VS (IZQUIERDA) Y PANEL LATERAL NUEVO
-- =========================================================

-- Botón izquierdo (el que abre el panel)
local spiderButton = Instance.new("TextButton")
spiderButton.Name = "SpiderVS"
spiderButton.Size = UDim2.fromOffset(110, 43)
spiderButton.AnchorPoint = Vector2.new(0, 0.5)
spiderButton.Position = UDim2.new(0, 15, 0.36, 0)
spiderButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
spiderButton.BorderSizePixel = 0
spiderButton.Text = ""
spiderButton.AutoButtonColor = false
spiderButton.Parent = screenGui

local spiderCorner = Instance.new("UICorner")
spiderCorner.CornerRadius = UDim.new(0, 12)
spiderCorner.Parent = spiderButton

local spiderText = Instance.new("TextLabel")
spiderText.Name = "SpiderText"
spiderText.Size = UDim2.new(1, -8, 1, -4)
spiderText.Position = UDim2.fromOffset(4, 2)
spiderText.BackgroundTransparency = 1
spiderText.Text = "🕷 SPIDER.VS"
spiderText.TextColor3 = Color3.fromRGB(255, 255, 255)
spiderText.TextSize = 13
spiderText.Font = Enum.Font.GothamBold
spiderText.TextXAlignment = Enum.TextXAlignment.Center
spiderText.TextYAlignment = Enum.TextYAlignment.Center
spiderText.Parent = spiderButton
addAnimatedGradient(spiderText)

-- Panel lateral (se muestra al hacer clic en spiderButton)
local panel = Instance.new("Frame")
panel.Name = "SidePanel"
panel.BackgroundTransparency = 1  -- Fondo transparente, usaremos imagen
panel.BorderSizePixel = 0
panel.ClipsDescendants = true
panel.ZIndex = 400
panel.Parent = screenGui

-- Ancho restaurado a 250 px, y margen mayor para bajarlo (60 px)
local PANEL_WIDTH = 250
local MARGIN = 60  -- antes era 10, ahora más grande para que quede más abajo
panel.Size = UDim2.new(0, PANEL_WIDTH, 1, -2 * MARGIN)
panel.Position = UDim2.new(1, 0, 0, MARGIN)  -- fuera por la derecha, con el mismo margen

-- Imagen de fondo del panel
local panelBg = Instance.new("ImageLabel")
panelBg.Name = "BackgroundImage"
panelBg.Size = UDim2.new(1, 0, 1, 0)
panelBg.Position = UDim2.new(0, 0, 0, 0)
panelBg.BackgroundTransparency = 1
panelBg.Image = getcustomasset("Telarañacodesniper.jpg")
panelBg.ScaleType = Enum.ScaleType.Crop
panelBg.ZIndex = 400
panelBg.Parent = panel

-- Esquinas redondeadas
local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 16)
panelCorner.Parent = panel

-- Borde sutil
local panelStroke = Instance.new("UIStroke")
panelStroke.Color = Color3.fromRGB(255, 255, 255)
panelStroke.Thickness = 1.5
panelStroke.Transparency = 0.2
panelStroke.Parent = panel

-- Título
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -20, 0, 35)
title.Position = UDim2.new(0, 10, 0, 8)
title.BackgroundTransparency = 1
title.Text = "🕷 SPIDER.VS"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextYAlignment = Enum.TextYAlignment.Center
title.ZIndex = 410
title.Parent = panel

-- Botón cerrar (—) pequeño y pegado a la esquina
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 7)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "—"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextXAlignment = Enum.TextXAlignment.Center
closeBtn.TextYAlignment = Enum.TextYAlignment.Center
closeBtn.ZIndex = 410
closeBtn.Parent = panel

-- Estado del panel
local panelVisible = false
local panelTween = nil

-- Función para abrir/cerrar el panel con animación
local function toggleSidePanel(show)
    if panelTween and panelTween.PlaybackState == Enum.PlaybackState.Playing then
        panelTween:Cancel()
    end

    local targetPosition
    if show == nil then
        show = not panelVisible
    end

    if show then
        targetPosition = UDim2.new(0, MARGIN, 0, MARGIN)  -- visible a la izquierda, con el margen
    else
        targetPosition = UDim2.new(1, 0, 0, MARGIN)        -- oculto fuera a la derecha
    end

    panelTween = TweenService:Create(panel, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = targetPosition })
    panelTween:Play()
    panelTween.Completed:Connect(function()
        panelTween = nil
    end)
    panelVisible = show
end

-- Asignar al botón izquierdo
spiderButton.Activated:Connect(function()
    toggleSidePanel()
end)

-- Asignar al botón cerrar
closeBtn.Activated:Connect(function()
    toggleSidePanel(false)
end)

-- =========================================================
-- BARRA INFERIOR (FPS, PING, PROGRESO)
-- =========================================================
local WHITE = Color3.fromRGB(255, 255, 255)
local BLACK = Color3.fromRGB(0, 0, 0)
local DARK = Color3.fromRGB(35, 35, 35)

local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.Size = UDim2.fromOffset(390, 40)
shadow.Position = UDim2.new(0.5, 5, 1, -62)
shadow.AnchorPoint = Vector2.new(0.5, 1)
shadow.BackgroundColor3 = BLACK
shadow.BackgroundTransparency = 0.35
shadow.BorderSizePixel = 0
shadow.ZIndex = 299
shadow.Parent = screenGui
local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 16)
shadowCorner.Parent = shadow

local spFrame = Instance.new("Frame")
spFrame.Name = "SpiderVSProgress"
spFrame.Size = UDim2.fromOffset(380, 34)
spFrame.Position = UDim2.new(0.5, 0, 1, -65)
spFrame.AnchorPoint = Vector2.new(0.5, 1)
spFrame.BackgroundTransparency = 1
spFrame.BorderSizePixel = 0
spFrame.Active = true
spFrame.Visible = true
spFrame.ZIndex = 300
spFrame.ClipsDescendants = true
spFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 14)
frameCorner.Parent = spFrame

local autoStealBackground = Instance.new("ImageLabel")
autoStealBackground.Name = "AutoStealBackground"
autoStealBackground.Size = UDim2.new(1, 0, 1, 0)
autoStealBackground.Position = UDim2.fromOffset(0, 0)
autoStealBackground.BackgroundTransparency = 1
autoStealBackground.Image = getcustomasset("Telarañaautosteal.jpg")
autoStealBackground.ScaleType = Enum.ScaleType.Crop
autoStealBackground.ZIndex = 300
autoStealBackground.Parent = spFrame
local bgCorner = Instance.new("UICorner")
bgCorner.CornerRadius = UDim.new(0, 14)
bgCorner.Parent = autoStealBackground

local frameStroke = Instance.new("UIStroke")
frameStroke.Color = WHITE
frameStroke.Thickness = 1.5
frameStroke.Transparency = 0.2
frameStroke.Parent = spFrame

local barSpiderText = Instance.new("TextLabel")
barSpiderText.Name = "SpiderText"
barSpiderText.Size = UDim2.fromOffset(125, 34)
barSpiderText.Position = UDim2.fromOffset(5, 0)
barSpiderText.BackgroundTransparency = 1
barSpiderText.Text = "🕷SPIDER.VS"
barSpiderText.TextColor3 = WHITE
barSpiderText.Font = Enum.Font.GothamBold
barSpiderText.TextSize = 14
barSpiderText.TextXAlignment = Enum.TextXAlignment.Center
barSpiderText.TextYAlignment = Enum.TextYAlignment.Center
barSpiderText.ZIndex = 310
barSpiderText.Parent = spFrame

local spiderGradient = Instance.new("UIGradient")
spiderGradient.Name = "DiagonalShadow"
spiderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, WHITE),
    ColorSequenceKeypoint.new(0.42, WHITE),
    ColorSequenceKeypoint.new(0.50, DARK),
    ColorSequenceKeypoint.new(0.58, WHITE),
    ColorSequenceKeypoint.new(1, WHITE)
})
spiderGradient.Rotation = 45
spiderGradient.Offset = Vector2.new(-1.5, -1.5)
spiderGradient.Parent = barSpiderText
task.spawn(function()
    while barSpiderText.Parent do
        spiderGradient.Offset = Vector2.new(-1.5, -1.5)
        local tween = TweenService:Create(spiderGradient, TweenInfo.new(1.8, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), { Offset = Vector2.new(1.5, 1.5) })
        tween:Play()
        tween.Completed:Wait()
        task.wait(0.25)
    end
end)

local pctLabel = Instance.new("TextLabel")
pctLabel.Name = "Percentage"
pctLabel.Size = UDim2.fromOffset(45, 34)
pctLabel.Position = UDim2.fromOffset(135, 0)
pctLabel.BackgroundTransparency = 1
pctLabel.Text = "0%"
pctLabel.TextColor3 = WHITE
pctLabel.Font = Enum.Font.GothamBold
pctLabel.TextSize = 14
pctLabel.TextXAlignment = Enum.TextXAlignment.Center
pctLabel.TextYAlignment = Enum.TextYAlignment.Center
pctLabel.ZIndex = 310
pctLabel.Parent = spFrame

local barBg = Instance.new("Frame")
barBg.Name = "ProgressBackground"
barBg.Size = UDim2.fromOffset(100, 18)
barBg.Position = UDim2.fromOffset(185, 8)
barBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
barBg.BorderSizePixel = 0
barBg.ClipsDescendants = true
barBg.ZIndex = 310
barBg.Parent = spFrame
local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = barBg
local barStroke = Instance.new("UIStroke")
barStroke.Color = WHITE
barStroke.Thickness = 1
barStroke.Transparency = 0.25
barStroke.Parent = barBg

local progressFill = Instance.new("Frame")
progressFill.Name = "ProgressFill"
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = WHITE
progressFill.BorderSizePixel = 0
progressFill.ZIndex = 311
progressFill.Parent = barBg
local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(1, 0)
fillCorner.Parent = progressFill

local separator = Instance.new("Frame")
separator.Name = "Separator"
separator.Size = UDim2.fromOffset(1.5, 20)
separator.Position = UDim2.fromOffset(292, 7)
separator.BackgroundColor3 = WHITE
separator.BackgroundTransparency = 0.3
separator.BorderSizePixel = 0
separator.ZIndex = 310
separator.Parent = spFrame

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Name = "FPS"
fpsLabel.Size = UDim2.fromOffset(55, 34)
fpsLabel.Position = UDim2.fromOffset(300, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: 0"
fpsLabel.TextColor3 = WHITE
fpsLabel.Font = Enum.Font.Gotham
fpsLabel.TextSize = 12
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.TextYAlignment = Enum.TextYAlignment.Center
fpsLabel.ZIndex = 310
fpsLabel.Parent = spFrame

local pingLabel = Instance.new("TextLabel")
pingLabel.Name = "PING"
pingLabel.Size = UDim2.fromOffset(65, 34)
pingLabel.Position = UDim2.fromOffset(310, 0)
pingLabel.BackgroundTransparency = 1
pingLabel.Text = "PING: 0ms"
pingLabel.TextColor3 = WHITE
pingLabel.Font = Enum.Font.Gotham
pingLabel.TextSize = 12
pingLabel.TextXAlignment = Enum.TextXAlignment.Right
pingLabel.TextYAlignment = Enum.TextYAlignment.Center
pingLabel.ZIndex = 310
pingLabel.Parent = spFrame

local spToggleBtn = Instance.new("TextButton")
spToggleBtn.Name = "SpiderVSButton"
spToggleBtn.Size = UDim2.new(1, 0, 1, 0)
spToggleBtn.BackgroundTransparency = 1
spToggleBtn.BorderSizePixel = 0
spToggleBtn.Text = ""
spToggleBtn.AutoButtonColor = false
spToggleBtn.ZIndex = 320
spToggleBtn.Parent = spFrame

-- Animación de porcentaje
local progress = 0
local speedAnim = 0.5
RunService.RenderStepped:Connect(function(deltaTime)
    if not spFrame.Visible then return end
    progress = progress + (deltaTime / speedAnim)
    if progress >= 1 then progress = 0 end
    local value = math.clamp(progress, 0, 1)
    progressFill.Size = UDim2.new(value, 0, 1, 0)
    pctLabel.Text = math.floor(value * 100 + 0.5) .. "%"
end)

-- FPS y PING
local frameCount = 0
local lastFPSUpdate = tick()
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()
    if now - lastFPSUpdate >= 1 then
        local fps = math.floor(frameCount / (now - lastFPSUpdate))
        fpsLabel.Text = "FPS: " .. tostring(fps)
        frameCount = 0
        lastFPSUpdate = now
        local ping = 0
        pcall(function()
            ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue() or 0)
        end)
        pingLabel.Text = "PING: " .. tostring(ping) .. "ms"
    end
end)

-- Arrastrar barra
local dragging = false
local dragStart = nil
local startPos = nil
spToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = spFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
UIS.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        local dx = input.Position.X - dragStart.X
        local dy = input.Position.Y - dragStart.Y
        local camera = workspace.CurrentCamera
        local viewport = camera and camera.ViewportSize or Vector2.new(1000, 1000)
        local size = spFrame.AbsoluteSize
        local newXScalePx = startPos.X.Scale * viewport.X
        local newX = math.clamp(newXScalePx + startPos.X.Offset + dx, size.X / 2, viewport.X - size.X / 2)
        local newY = math.clamp(startPos.Y.Scale * viewport.Y + startPos.Y.Offset + dy, size.Y, viewport.Y)
        spFrame.Position = UDim2.new(startPos.X.Scale, newX - newXScalePx, startPos.Y.Scale, newY - startPos.Y.Scale * viewport.Y)
    end
end)

local function updateShadow()
    shadow.Position = UDim2.new(spFrame.Position.X.Scale, spFrame.Position.X.Offset + 5, spFrame.Position.Y.Scale, spFrame.Position.Y.Offset + 5)
end
spFrame:GetPropertyChangedSignal("Position"):Connect(updateShadow)
updateShadow()

-- Control de visibilidad de la barra
_G._CursedSetProgressBarVisible = function(value)
    spFrame.Visible = value
    shadow.Visible = value
end

-- =========================================================
-- ASIGNACIÓN DE BOTONES
-- =========================================================

-- TP BAT
btnTPBat.Activated:Connect(toggleTPBat)

-- INSTA RESET
btnInstaReset.Activated:Connect(performInstantReset)

-- AUTO RIGHT
btnAutoRight.Activated:Connect(toggleAutoRight)

-- BAT AIMBOT
btnBatAimbot.Activated:Connect(toggleAutoBat)

-- TP DOWN (ya tiene función)
tpDownButton.Activated:Connect(runTPDown)

-- LAGGER 1
btnLagger1.Activated:Connect(toggleLagger)

-- AUTO LEFT
btnAutoLeft.Activated:Connect(toggleAutoLeft)

-- DROP BR
btnDropBR.Activated:Connect(runDrop)

-- CARRY SPD (sin función, solo decorativo)
btnCarrySpd.Activated:Connect(function() end)

-- LAGGER 2 (asignamos a AntiRagdoll)
btnLagger2.Activated:Connect(toggleAntiRagdoll)

-- BYPASS ANTIBAT (asignamos a InfJump como alternativa)
local btnBypass = container:FindFirstChild("Button3")
if btnBypass then
    btnBypass.Activated:Connect(toggleInfJump)
end

-- =========================================================
-- OCULTAR/MOSTRAR GUI (todos los elementos)
-- =========================================================
function toggleGui()
    State.guiVisible = not State.guiVisible
    container.Visible = State.guiVisible
    spFrame.Visible = State.guiVisible
    shadow.Visible = State.guiVisible
    spiderButton.Visible = State.guiVisible
    -- Si el panel está abierto, lo cerramos al ocultar la GUI
    if panelVisible then
        toggleSidePanel(false)
    end
    panel.Visible = State.guiVisible  -- si la GUI se oculta, también el panel
    print("GUI visibility: " .. tostring(State.guiVisible))
end

-- =========================================================
-- KEYBINDS
-- =========================================================
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    local key = input.KeyCode
    if key == KB.AutoLeft then toggleAutoLeft() end
    if key == KB.AutoRight then toggleAutoRight() end
    if key == KB.Drop then runDrop() end
    if key == KB.TPDown then runTPDown() end
    if key == KB.AutoBat then toggleAutoBat() end
    if key == KB.Lagger then toggleLagger() end
    if key == KB.InstaReset then performInstantReset() end
    if key == KB.GuiHide then toggleGui() end
end)

-- =========================================================
-- GUARDAR KEYBINDS AL SALIR
-- =========================================================
game:BindToClose(function()
    saveKeybinds()
end)

-- =========================================================
-- MENSAJE INICIAL
-- =========================================================
print("🕷 SPIDER.VS + CRYON BUTTONS cargado (panel ancho 250px y más abajo)")
print("Keybinds activos:")
for name, key in pairs(KB) do
    print(name .. ": " .. (key and key.Name or "ninguna"))
end