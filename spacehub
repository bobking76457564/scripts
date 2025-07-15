-- [OP 99 Days in the Forest Rayfield Script]--

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "OP 99 Days in the Forest Script",
    LoadingTitle = "OP 99 Forest OP Hub",
    LoadingSubtitle = "by ChatGPT",
    ConfigurationSaving = { Enabled = false },
    Discord = { Enabled = false },
    KeySystem = false
})

local Player = game.Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")

-- Misc Services
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Utility functions
local function teleportObject(item)
    if item and item:IsA("BasePart") then
        item.CFrame = Char:FindFirstChild("HumanoidRootPart").CFrame
    end
end

-- WALK & JUMP SLIDERS
Window:CreateSlider({
    Name = "WalkSpeed",
    Range = {16,200},
    Increment = 1,
    CurrentValue = 16,
    Suffix = "stud/s",
    Callback = function(v) Hum.WalkSpeed = v end
})
Window:CreateSlider({
    Name = "JumpPower",
    Range = {50,300},
    Increment = 1,
    CurrentValue = 50,
    Suffix = "stud",
    Callback = function(v) Hum.JumpPower = v end
})

-- HITBOX EXPANDER
local hitboxEnabled = false
Window:CreateToggle({
    Name = "Enable Hitbox Expander",
    CurrentValue = false,
    Callback = function(state)
        hitboxEnabled = state
        for _, v in pairs(Workspace.Players:GetChildren()) do
            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = v.Character.HumanoidRootPart
                hrp.Size = state and Vector3.new(10, 10, 10) or Vector3.new(2, 2, 1)
                hrp.Transparency = state and 0.7 or 1
                hrp.CanCollide = false
            end
        end
    end
})

RunService.Heartbeat:Connect(function()
    if hitboxEnabled then
        for _, v in pairs(Workspace.Players:GetChildren()) do
            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = v.Character.HumanoidRootPart
                hrp.Size = Vector3.new(10,10,10)
                hrp.Transparency = 0.7
                hrp.CanCollide = false
            end
        end
    end
end)

-- ESP Setup
local espCategories = {
    { name = "Ammo", color = Color3.new(1,1,0) },
    { name = "Coal", color = Color3.new(0.2,0.2,0.2) },
    { name = "Fuel", color = Color3.new(1,0.5,0) },
    { name = "Log",  color = Color3.new(0.4,0.2,0) },
    { name = "Wolf", color = Color3.new(1,0,0) },
    { name = "Lost Child", color = Color3.new(0.2,0.5,1) },
    { name = "Chest", color = Color3.new(1,1,1) },
    { name = "Player", color = Color3.new(0,1,0) },
}

for _, cat in ipairs(espCategories) do
    Window:CreateToggle({
        Name = "ESP: " .. cat.name,
        CurrentValue = false,
        Callback = function(enabled)
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name:lower():find(cat.name:lower()) then
                    if enabled then
                        local bg = Instance.new("BillboardGui", obj)
                        bg.Adornee = obj
                        bg.Size = UDim2.new(0,100,0,40)
                        bg.AlwaysOnTop = true
                        local txt = Instance.new("TextLabel", bg)
                        txt.Text = cat.name
                        txt.TextColor3 = cat.color
                        txt.BackgroundTransparency = 1
                        bg.Name = "ESP_"..cat.name
                    else
                        if obj:FindFirstChild("ESP_"..cat.name) then
                            obj:FindFirstChild("ESP_"..cat.name):Destroy()
                        end
                    end
                end
            end
        end
    })
end

-- BRING ITEMS / COLLECT CUSTOM ITEMS
local collectTypes = {"Ammo","Coal","Fuel","Log"}
Window:CreateToggle({
    Name = "Bring All Items",
    CurrentValue = false,
    Callback = function(state)
        RunService.Heartbeat:Connect(function()
            if state then
                for _, item in ipairs(Workspace:GetDescendants()) do
                    if item:IsA("BasePart") or item:IsA("Tool") then
                        teleportObject(item)
                    end
                end
            end
        end)
    end
})

Window:CreateButton({
    Name = "Collect (Ammo, Coal, Fuel, Logs)",
    Callback = function()
        for _, item in ipairs(Workspace:GetDescendants()) do
            if item:IsA("BasePart") then
                for _, key in ipairs(collectTypes) do
                    if item.Name:lower():find(key:lower()) then
                        teleportObject(item)
                    end
                end
            end
        end
    end
})

-- AUTO EAT / AUTO FARM / AUTO MOBS (example: trees)
Window:CreateToggle({
    Name = "Auto Eat (Food)",
    CurrentValue = false,
    Callback = function(state)
        if state then
            spawn(function()
                while state do
                    for _, food in ipairs(Workspace:GetDescendants()) do
                        if food.Name:lower():find("food") or food.Name:lower():find("berry") then
                            teleportObject(food)
                        end
                    end
                    wait(1)
                end
            end)
        end
    end
})

Window:CreateToggle({
    Name = "Auto Farm Trees",
    CurrentValue = false,
    Callback = function(state)
        if state then
            spawn(function()
                while state do
                    for _, tree in ipairs(Workspace:GetDescendants()) do
                        if tree.Name:lower():find("log") then
                            tree.CFrame = Char.HumanoidRootPart.CFrame
                        end
                    end
                    wait(0.5)
                end
            end)
        end
    end
})

-- TELEPORT FEATURES (e.g. Chest, Lost Child)
Window:CreateToggle({
    Name = "TP to Lost Child",
    CurrentValue = false,
    Callback = function(enabled)
        if enabled then
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj.Name:lower():find("lost child") and obj:IsA("Model") then
                    Char:SetPrimaryPartCFrame(obj:GetModelCFrame())
                end
            end
        end
    end
})

--____________________________________________________________________--

Rayfield:Init()

-- Loader from Space Hub (optional flag)
-- loadstring(game:HttpGet('https://raw.githubusercontent.com/ago106/SpaceHub/refs/heads/main/loader.lua'))()
-- This would dynamically load their repo-based hub. But the above code provides independent OP Rayfield UI hub.
