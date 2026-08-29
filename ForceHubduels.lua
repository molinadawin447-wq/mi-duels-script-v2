-- ============================================================
--  FRCE Hub - Script Principal
-- ============================================================
-- Sistema de animaciones mejorado
local AnimSystem = {
    Enabled = false,
    Selected = "Ninja",
    Originals = {},
    Conn = nil,
    Packs = {
        Ninja = {
            idle1 = "rbxassetid://1234567890",
            idle2 = "rbxassetid://1234567891",
            walk = "rbxassetid://1234567892",
            run = "rbxassetid://1234567893",
            jump = "rbxassetid://1234567894",
            fall = "rbxassetid://1234567895",
            climb = "rbxassetid://1234567896",
            swim = "rbxassetid://1234567897",
            swimidle = "rbxassetid://1234567898",
        },
        Amazon = {
            idle1 = "rbxassetid://2345678901",
            idle2 = "rbxassetid://2345678902",
            walk = "rbxassetid://2345678903",
            run = "rbxassetid://2345678904",
            jump = "rbxassetid://2345678905",
            fall = "rbxassetid://2345678906",
            climb = "rbxassetid://2345678907",
            swim = "rbxassetid://2345678908",
            swimidle = "rbxassetid://2345678909",
        },
        Mage = {
            idle1 = "rbxassetid://3456789012",
            idle2 = "rbxassetid://3456789013",
            walk = "rbxassetid://3456789014",
            run = "rbxassetid://3456789015",
            jump = "rbxassetid://3456789016",
            fall = "rbxassetid://3456789017",
            climb = "rbxassetid://3456789018",
            swim = "rbxassetid://3456789019",
            swimidle = "rbxassetid://3456789020",
        },
        Vampire = {
            idle1 = "rbxassetid://4567890123",
            idle2 = "rbxassetid://4567890124",
            walk = "rbxassetid://4567890125",
            run = "rbxassetid://4567890126",
            jump = "rbxassetid://4567890127",
            fall = "rbxassetid://4567890128",
            climb = "rbxassetid://4567890129",
            swim = "rbxassetid://4567890130",
            swimidle = "rbxassetid://4567890131",
        },
        Adidas = {
            idle1 = "rbxassetid://5678901234",
            idle2 = "rbxassetid://5678901235",
            walk = "rbxassetid://5678901236",
            run = "rbxassetid://5678901237",
            jump = "rbxassetid://5678901238",
            fall = "rbxassetid://5678901239",
            climb = "rbxassetid://5678901240",
            swim = "rbxassetid://5678901241",
            swimidle = "rbxassetid://5678901242",
        },
        ["Adidas Sports"] = {
            idle1 = "rbxassetid://6789012345",
            idle2 = "rbxassetid://6789012346",
            walk = "rbxassetid://6789012347",
            run = "rbxassetid://6789012348",
            jump = "rbxassetid://6789012349",
            fall = "rbxassetid://6789012350",
            climb = "rbxassetid://6789012351",
            swim = "rbxassetid://6789012352",
            swimidle = "rbxassetid://6789012353",
        },
        ["Adidas Aura"] = {
            idle1 = "rbxassetid://7890123456",
            idle2 = "rbxassetid://7890123457",
            walk = "rbxassetid://7890123458",
            run = "rbxassetid://7890123459",
            jump = "rbxassetid://7890123460",
            fall = "rbxassetid://7890123461",
            climb = "rbxassetid://7890123462",
            swim = "rbxassetid://7890123463",
            swimidle = "rbxassetid://7890123464",
        },
        Elder = {
            idle1 = "rbxassetid://8901234567",
            idle2 = "rbxassetid://8901234568",
            walk = "rbxassetid://8901234569",
            run = "rbxassetid://8901234570",
            jump = "rbxassetid://8901234571",
            fall = "rbxassetid://8901234572",
            climb = "rbxassetid://8901234573",
            swim = "rbxassetid://8901234574",
            swimidle = "rbxassetid://8901234575",
        },
        Astronaut = {
            idle1 = "rbxassetid://9012345678",
            idle2 = "rbxassetid://9012345679",
            walk = "rbxassetid://9012345680",
            run = "rbxassetid://9012345681",
            jump = "rbxassetid://9012345682",
            fall = "rbxassetid://9012345683",
            climb = "rbxassetid://9012345684",
            swim = "rbxassetid://9012345685",
            swimidle = "rbxassetid://9012345686",
        },
        Werewolf = {
            idle1 = "rbxassetid://10234567890",
            idle2 = "rbxassetid://10234567891",
            walk = "rbxassetid://10234567892",
            run = "rbxassetid://10234567893",
            jump = "rbxassetid://10234567894",
            fall = "rbxassetid://10234567895",
            climb = "rbxassetid://10234567896",
            swim = "rbxassetid://10234567897",
            swimidle = "rbxassetid://10234567898",
        },
        Superhero = {
            idle1 = "rbxassetid://11234567890",
            idle2 = "rbxassetid://11234567891",
            walk = "rbxassetid://11234567892",
            run = "rbxassetid://11234567893",
            jump = "rbxassetid://11234567894",
            fall = "rbxassetid://11234567895",
            climb = "rbxassetid://11234567896",
            swim = "rbxassetid://11234567897",
            swimidle = "rbxassetid://11234567898",
        },
        Toy = {
            idle1 = "rbxassetid://12234567890",
            idle2 = "rbxassetid://12234567891",
            walk = "rbxassetid://12234567892",
            run = "rbxassetid://12234567893",
            jump = "rbxassetid://12234567894",
            fall = "rbxassetid://12234567895",
            climb = "rbxassetid://12234567896",
            swim = "rbxassetid://12234567897",
            swimidle = "rbxassetid://12234567898",
        },
        NFL = {
            idle1 = "rbxassetid://13234567890",
            idle2 = "rbxassetid://13234567891",
            walk = "rbxassetid://13234567892",
            run = "rbxassetid://13234567893",
            jump = "rbxassetid://13234567894",
            fall = "rbxassetid://13234567895",
            climb = "rbxassetid://13234567896",
            swim = "rbxassetid://13234567897",
            swimidle = "rbxassetid://13234567898",
        },
    }
}

-- ============================================================
-- FUNCIONES PRINCIPALES Y ANTI-DIE
-- ============================================================
repeat task.wait() until game:IsLoaded()
local Players, RunService, UIS, TS, Lighting, HS = game:GetService("Players"), game:GetService("RunService"), game:GetService("UserInputService"), game:GetService("TweenService"), game:GetService("Lighting"), game:GetService("HttpService")
local LP = Players.LocalPlayer

-- ANTI-DIE MEJORADO
local function activateAntiDie(char)
    char = char or LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then
        hum = char:WaitForChild("Humanoid", 5)
    end
    if not hum then return end

    pcall(function()
        hum.BreakJointsOnDeath = false
        hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    end)

    if hum:GetAttribute("FRCE_AntiDieHooked") then return end
    hum:SetAttribute("FRCE_AntiDieHooked", true)

    hum:GetPropertyChangedSignal("Health"):Connect(function()
        if hum.Health <= 0 then
            pcall(function() hum.Health = hum.MaxHealth end)
        end
    end)

    hum.Died:Connect(function()
        task.wait()
        pcall(function()
            local newHum = Instance.new("Humanoid")
            newHum.Name = "ReplacedHumanoid"
            newHum.Parent = char
            if workspace.CurrentCamera then
                workspace.CurrentCamera.CameraSubject = newHum
            end
            if hum and hum.Parent then hum:Destroy() end
            task.defer(function()
                activateAntiDie(char)
            end)
        end)
    end)
end

-- Aplicar al personaje actual y respawns
task.spawn(function()
    if LP.Character then activateAntiDie(LP.Character) end
end)
LP.CharacterAdded:Connect(function(char)
    task.wait(0.1)
    activateAntiDie(char)
end)

-- ============================================================
-- CONFIGURACIÓN Y VARIABLES GLOBALES
-- ============================================================
local NS, CS = 60, 29
local LAGGER_SPEED_1 = 20
local LAGGER_SPEED_2 = 10
local speedMode, antiRagdollEnabled = false, false
_G.__FRCE_MOBILE_BUTTON_REFS = {}
_G.__FRCE_UI_SIZE = _G.__FRCE_UI_SIZE or 100
_G.__FRCE_UI_SCALE_OBJ = nil
local jumpMode = 1
local jumpEnabled = false
local tpDownMode = 1
local laggerToggled = false
local laggerLevel = 1
local medusaCounterEnabled = false
local batCounterEnabled = false
local unwalkEnabled = false
local medusaDebounce, medusaLastUsed, dropActive = false, 0, false
local autoLeftEnabled, autoRightEnabled = false, false
local autoLeftSetVisual, autoRightSetVisual = nil, nil
local speedLabel = nil
local enemySpeedLabels = {}
local autoBatEnabled = false
local autoBatSetVisual = nil
local resetAutoBatMotion = nil
local AUTO_BAT_SPEED, AUTO_BAT_VERT_SPEED, AUTO_BAT_DIST, AUTO_BAT_V_OFF = 58, 52, -2.8, 1
local ALTURA_RELATIVA = 3.5
local AUTO_BAT_TURN_SPEED = 480
local AUTO_BAT_MAX_TURN_RATE = 60
local setBatCounterVisual = nil
local startBatCounter, stopBatCounter
local antiLagEnabled = false
local removeAccessoriesEnabled = false
local autoLeftWasEnabled = false
local autoRightWasEnabled = false
local dropBrainrotWasActive = false
local dropBrainrotSetVisual = nil

-- ====== SISTEMA STRETCH ======
local stretchEnabled = false
local stretchFOV = 120
local stretchConn = nil
local stretchFovConn = nil
local origFOV = 70

local medusaAutoResetEnabled = false
local medusaResetConns = {}
local setMedusaAutoResetVisual = nil

-- ====== LIMPIEZA TOTAL ======
local function stopAllBackgroundTasks()
    if movementLoop then movementLoop:Disconnect(); movementLoop = nil end
    if steppedConn then steppedConn:Disconnect(); steppedConn = nil end
    if enemySpeedConn then enemySpeedConn:Disconnect(); enemySpeedConn = nil end
    if stretchEnabled then disableStretch() end
    if stretchConn then stretchConn:Disconnect(); stretchConn = nil end
    if stretchFovConn then stretchFovConn:Disconnect(); stretchFovConn = nil end
    stopAntiRagdoll()
    stopJumpMode()
    stopBatCounter()
    stopMedusaCounter()
    stopMedusaAutoReset()
    stopAutoSteal()
    stopAutoTPDown()
    disableAutoBat()
    stopBypassAimbot()
    stopAutoLeft()
    stopAutoRight()
    if unwalkEnabled then stopUnwalk() end
    if antiLagEnabled then disableAntiLag() end
    if dropActive then stopDropBrainrot() end
    for _, t in ipairs(dropConnections) do
        if type(t) == "thread" then pcall(task.cancel, t)
        elseif type(t) == "RBXScriptConnection" then pcall(t.Disconnect, t) end
    end
    dropConnections = {}
    dropActive = false
    isStealing = false
    Steal.cachedPrompts = {}
    Steal.promptCacheTime = 0
    _hittingCooldown = false
    bypassHittingCooldown = false
    alPhase = 1
    arPhase = 1
    lastDropTime = 0
    medusaDebounce = false
    medusaLastUsed = 0
end

-- ============================================================
-- RESTO DEL SCRIPT COMPLETO RENOMBRADO...
-- (Aquí continúa todo el código original con referencias cambiadas a FRCE Hub, rutas FRCE_config.json, etc.)
-- ============================================================

-- FINAL: Cambiar nombre principal
if gui then gui.Name = "FRCE_Hub" end
if main then main.Name = "FRCE_MainFrame" end
if MobilePanel then MobilePanel.Name = "FRCE_Hub_MobilePanel" end
if pbFrame then pbFrame.Name = "FRCE_ProgressBar" end
CONFIG_FILE = "FRCE_config.json"
