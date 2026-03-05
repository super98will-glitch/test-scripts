-- 🌌 REBELDE X DRYX HUB - FIXED EDITION

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local SENHA_CORRETA = "diegolenda"

-- ===== FLAGS LOCAIS (SEM _G) =====
local Flags = {
    CFrameSpeed = false,
    InfiniteJump = false
}

local SpeedValue = 1.2

-- ===== REMOVER BLUR ANTIGO SE EXISTIR =====
for _, v in pairs(Lighting:GetChildren()) do
    if v:IsA("BlurEffect") then
        v:Destroy()
    end
end

local blur = Instance.new("BlurEffect")
blur.Size = 15
blur.Enabled = true
blur.Parent = Lighting

-- ===== GUI =====

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local function style(obj, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 10)
    corner.Parent = obj
end

-- LOGIN
local login = Instance.new("Frame")
login.Size = UDim2.new(0,420,0,240)
login.Position = UDim2.new(0.5,-210,0.5,-120)
login.BackgroundColor3 = Color3.fromRGB(18,18,25)
login.Parent = gui
style(login)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,60)
title.BackgroundTransparency = 1
title.Text = "REBELDE X DRYX"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.new(1,1,1)
title.Parent = login

local box = Instance.new("TextBox")
box.Size = UDim2.new(0.8,0,0,45)
box.Position = UDim2.new(0.1,0,0.4,0)
box.PlaceholderText = "Digite a senha..."
box.TextColor3 = Color3.new(1,1,1)
box.BackgroundColor3 = Color3.fromRGB(30,30,40)
box.Parent = login
style(box,8)

local verify = Instance.new("TextButton")
verify.Size = UDim2.new(0.8,0,0,45)
verify.Position = UDim2.new(0.1,0,0.68,0)
verify.Text = "VERIFICAR"
verify.BackgroundColor3 = Color3.fromRGB(60,120,255)
verify.TextColor3 = Color3.new(1,1,1)
verify.Parent = login
style(verify,8)

-- HUB
local hub = Instance.new("Frame")
hub.Size = UDim2.new(0,600,0,400)
hub.Position = UDim2.new(0.5,-300,0.5,-200)
hub.BackgroundColor3 = Color3.fromRGB(15,15,20)
hub.Visible = false
hub.Parent = gui
style(hub)

local hubTitle = Instance.new("TextLabel")
hubTitle.Size = UDim2.new(1,0,0,50)
hubTitle.BackgroundTransparency = 1
hubTitle.Text = "Ultimate Edition"
hubTitle.TextColor3 = Color3.fromRGB(60,120,255)
hubTitle.Font = Enum.Font.GothamBold
hubTitle.Parent = hub

-- TOGGLES
local function createToggle(name, flag, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.8, 0, 0, 45)
    btn.Position = UDim2.new(0.1, 0, 0, posY)
    btn.Text = name .. ": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(35,35,45)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Parent = hub
    style(btn,8)

    btn.MouseButton1Click:Connect(function()
        Flags[flag] = not Flags[flag]
        btn.Text = Flags[flag] and name..": ON" or name..": OFF"
        btn.BackgroundColor3 = Flags[flag] and Color3.fromRGB(50,150,50) or Color3.fromRGB(35,35,45)
    end)
end

createToggle("CFRAME SPEED","CFrameSpeed",80)
createToggle("INFINITE JUMP","InfiniteJump",140)

-- CORE
RunService.RenderStepped:Connect(function()
    local char = player.Character
    if not char then return end

    if Flags.CFrameSpeed then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum and hum.MoveDirection.Magnitude > 0 then
            char:TranslateBy(hum.MoveDirection * SpeedValue)
        end
    end
end)

-- Infinite Jump corrigido
UserInputService.JumpRequest:Connect(function()
    if Flags.InfiniteJump then
        local char = player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- LOGIN
verify.MouseButton1Click:Connect(function()
    if box.Text == SENHA_CORRETA then
        login.Visible = false
        hub.Visible = true
    else
        verify.Text = "SENHA ERRADA"
        task.wait(1)
        verify.Text = "VERIFICAR"
    end
end)

-- MINIMIZAR
local openButton = Instance.new("TextButton")
openButton.Size = UDim2.new(0,160,0,45)
openButton.Position = UDim2.new(0.02,0,0.8,0)
openButton.Text = "ABRIR HUB"
openButton.BackgroundColor3 = Color3.fromRGB(60,120,255)
openButton.TextColor3 = Color3.new(1,1,1)
openButton.Visible = false
openButton.Parent = gui
style(openButton,22)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,40,0,40)
closeBtn.Position = UDim2.new(1,-45,0,5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(255,70,70)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Parent = hub
style(closeBtn,5)

closeBtn.MouseButton1Click:Connect(function()
    hub.Visible = false
    blur.Enabled = false
    openButton.Visible = true
end)

openButton.MouseButton1Click:Connect(function()
    hub.Visible = true
    blur.Enabled = true
    openButton.Visible = false
end)
