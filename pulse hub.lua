-- OP 99 Nights Pulse Hub - Rayfield UI --

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "OP 99 Nights Pulse Hub",
    LoadingTitle = "Loading Pulse Hub",
    LoadingSubtitle = "By ChatGPT",
    ConfigurationSaving = { Enabled = false },
    Discord = { Enabled = false },
    KeySystem = false
})

local Player = game.Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- UTILS
local function createESP(part, color, name)
    if part:FindFirstChild("ESP") then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP"
    billboard.Adornee = part
    billboard.Size = UDim2.new(0,100,0,40)
    billboard.AlwaysOnTop = true
    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = color
    label.TextStrokeTransparency = 0
    label.Font = Enum.Font.ArialBold
    label.TextScaled = true
    billboard.Parent = part
end

local function removeESP(part)
    local esp = part:FindFirstChild("ESP")
    if esp then esp:Destroy() end
end

local function teleportItem(item)
    if item and item:IsA("BasePart") and Char and Char:FindFirstChild("HumanoidRootPart") then
        item.CFrame = Char.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
    end
end

-- WALK & JUMP
Window:CreateSlider({
    Name = "Walkspeed",
    Range = {16, 250},
    Increment = 1,
    CurrentValue = 16,
    Suffix = "Speed",
    Callback = function(val)
        if Hum then Hum.WalkSpeed = val end
    end
})
Window:CreateSlider({
    Name = "JumpPower",
    Range = {50, 300},
    Increment = 1,
    CurrentValue = 50,
    Suffix = "Jump",
    Callback = function(val)
        if Hum then Hum.JumpPower = val end
    end
})

-- HITBOX
local hitboxEnabled = false
Window:CreateToggle({
    Name = "Hitbox Expander",
    CurrentValue = false,
    Callback = function(state)
        hitboxEnabled = state
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character.HumanoidRootPart
                hrp.Size = state and Vector3.new(10,10,10) or Vector3.new(2,2,1)
                hrp.Transparency = state and 0.7 or 1
                hrp.CanCollide = false
            end
        end
    end
})

RunService.Heartbeat:Connect(function()
    if hitboxEnabled then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character.HumanoidRootPart
                hrp.Size = Vector3.new(10,10,10)
                hrp.Transparency = 0.7
                hrp.CanCollide = false
            end
        end
    end
end)

-- FULLBRIGHT + NO FOG
local lighting = game:GetService("Lighting")
local fullbrightEnabled = false
Window:CreateToggle({
    Name = "Fullbright + No Fog",
    CurrentValue = false,
    Callback = function(state)
        fullbrightEnabled = state
        if state then
            lighting.FogEnd = 100000
            lighting.Brightness = 3
            lighting.GlobalShadows = false
            lighting.ClockTime = 14
        else
            lighting.FogEnd = 1000
            lighting.Brightness = 1
            lighting.GlobalShadows = true
            lighting.ClockTime = 14
        end
    end
})

-- ESP TOGGLES
local ESPSettings = {}

local function toggleESP(name, color, enabled)
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find(name:lower()) then
            if enabled then
                createESP(obj, color, name)
            else
                removeESP(obj)
            end
        end
    end
end

local espItems = {
    {label="Player ESP", name="Player", color=Color3.new(0,1,0)},
    {label="Fuel ESP", name="Fuel", color=Color3.fromRGB(255,165,0)},
    {label="Food ESP", name="Food", color=Color3.fromRGB(255,69,0)},
    {label="Lost Child ESP", name="Lost Child", color=Color3.fromRGB(0, 191, 255)},
    {label="Stronghold ESP", name="Stronghold", color=Color3.fromRGB(255,215,0)},
}

for _, v in pairs(espItems) do
    ESPSettings[v.name] = false
    Window:CreateToggle({
        Name = v.label,
        CurrentValue = false,
        Callback = function(state)
            ESPSettings[v.name] = state
            toggleESP(v.name, v.color, state)
        end
    })
end

-- BRING ALL ITEMS
local bringAllEnabled = false
Window:CreateToggle({
    Name = "Bring All Items",
    CurrentValue = false,
    Callback = function(state)
        bringAllEnabled = state
    end
})

RunService.Heartbeat:Connect(function()
    if bringAllEnabled and Char and Char:FindFirstChild("HumanoidRootPart") then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name:lower():find("fuel") or obj.Name:lower():find("coal") or obj.Name:lower():find("ammo") or obj.Name:lower():find("log") or obj.Name:lower():find("food")) then
                teleportItem(obj)
            end
        end
    end
end)

-- TELEPORT BUTTONS
local function teleportTo(name)
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name:lower():find(name:lower()) and obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") then
            Char:SetPrimaryPartCFrame(obj.HumanoidRootPart.CFrame + Vector3.new(0,5,0))
            return
        elseif obj.Name:lower():find(name:lower()) and obj:IsA("BasePart") then
            Char.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0,5,0)
            return
        end
    end
end

Window:CreateButton({
    Name = "Teleport to Fire",
    Callback = function() teleportTo("fire") end
})

Window:CreateButton({
    Name = "Teleport to Stronghold",
    Callback = function() teleportTo("stronghold") end
})

Window:CreateButton({
    Name = "Teleport to Lost Child",
    Callback = function() teleportTo("lost child") end
})

-- KILL AURA
local killAuraEnabled = false
local killRange = 10

Window:CreateToggle({
    Name = "Kill Aura",
    CurrentValue = false,
    Callback = function(state)
        killAuraEnabled = state
    end
})

Window:CreateSlider({
    Name = "Kill Aura Range",
    Range = {5, 30},
    Increment = 1,
    CurrentValue = 10,
    Suffix = "Studs",
    Callback = function(value)
        killRange = value
    end
})

RunService.Heartbeat:Connect(function()
    if killAuraEnabled then
        for _, npc in pairs(Workspace:GetChildren()) do
            if npc.Name:lower():find("wolf") or npc.Name:lower():find("enemy") or npc.Name:lower():find("mob") then
                if npc:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("Humanoid") then
                    local distance = (Char.HumanoidRootPart.Position - npc.HumanoidRootPart.Position).Magnitude
                    if distance <= killRange then
                        npc.Humanoid:TakeDamage(9999)
                    end
                end
            end
        end
    end
end)

-- NOCOLIP, FLY, INFINITY JUMP
local noclipEnabled = false
local flyEnabled = false
local flySpeed = 50
local flying = false

Window:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(state)
        noclipEnabled = state
    end
})

Window:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(state)
        flyEnabled = state
        if state then
            flying = true
            local bodyGyro = Instance.new("BodyGyro", Char.HumanoidRootPart)
            bodyGyro.P = 9e4
            bodyGyro.maxTorque = Vector3.new(9e4, 9e4, 9e4)
            bodyGyro.cframe = Char.HumanoidRootPart.CFrame
            local bodyVelocity = Instance.new("BodyVelocity", Char.HumanoidRootPart)
            bodyVelocity.velocity = Vector3.new(0,0,0)
            bodyVelocity.maxForce = Vector3.new(9e4, 9e4, 9e4)

            local userInput = game:GetService("UserInputService")
            local function flyControl()
                local moveVector = Vector3.new(0,0,0)
                if userInput:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + workspace.CurrentCamera.CFrame.LookVector end
                if userInput:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - workspace.CurrentCamera.CFrame.LookVector end
                if userInput:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - workspace.CurrentCamera.CFrame.RightVector end
                if userInput:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + workspace.CurrentCamera.CFrame.RightVector end
                bodyVelocity.velocity = moveVector.Unit * flySpeed
                bodyGyro.cframe = workspace.CurrentCamera.CFrame
            end

            local flyConn
            flyConn = RunService.Heartbeat:Connect(flyControl)

            -- Save conn to disconnect later
            flyConnCleanup = flyConn
        else
            flying = false
            for _, v in pairs(Char.HumanoidRootPart:GetChildren()) do
                if v:IsA("BodyGyro") or v:IsA("BodyVelocity") then
                    v:Destroy()
                end
            end
            if flyConnCleanup then flyConnCleanup:Disconnect() end
        end
    end
})

Window:CreateToggle({
    Name = "Infinity Jump",
    CurrentValue = false,
    Callback = function(state)
        if state then
            local UIS = game:GetService("UserInputService")
            UIS.JumpRequest:Connect(function()
                if not Hum:GetState() == Enum.HumanoidStateType.Freefall then
                    Hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end
})

-- NOCLIP LOOP
RunService.Stepped:Connect(function()
    if noclipEnabled and Char then
        for _, part in pairs(Char:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

Rayfield:Init()
