-- Load Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "OP 99 Days in the Forest Script",
    LoadingTitle = "Loading 99 Days Script",
    LoadingSubtitle = "by ChatGPT",
    ConfigurationSaving = {
       Enabled = false,
    },
    Discord = {
       Enabled = false,
    },
    KeySystem = false
})

-- Walkspeed changer
local Player = game.Players.LocalPlayer
local WalkSpeedSlider = Window:CreateSlider({
    Name = "Walkspeed",
    Range = {16, 200},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Callback = function(Value)
        Player.Character.Humanoid.WalkSpeed = Value
    end,
})

-- Hitbox extender
Window:CreateToggle({
    Name = "Enable Hitbox Extender",
    CurrentValue = false,
    Callback = function(state)
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                v.Character.HumanoidRootPart.Size = state and Vector3.new(10,10,10) or Vector3.new(2,2,1)
                v.Character.HumanoidRootPart.Transparency = state and 0.7 or 1
                v.Character.HumanoidRootPart.CanCollide = false
            end
        end
    end,
})

-- ESP Function
local function createESP(part, color, name)
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Size = UDim2.new(0, 100, 0, 40)
    BillboardGui.Adornee = part
    BillboardGui.AlwaysOnTop = true

    local TextLabel = Instance.new("TextLabel", BillboardGui)
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Text = name
    TextLabel.TextColor3 = color
    TextLabel.BackgroundTransparency = 1
    BillboardGui.Parent = part
end

-- ESP Toggles
local espToggles = {
    {label="ESP: Ammo", color=Color3.new(1, 1, 0), name="Ammo"},
    {label="ESP: Coal", color=Color3.new(0, 0, 0), name="Coal"},
    {label="ESP: Fuel", color=Color3.new(1, 0.5, 0), name="Fuel"},
    {label="ESP: Wolf", color=Color3.new(1, 0, 0), name="Wolf"},
    {label="ESP: Lost Child", color=Color3.new(0.2, 0.5, 1), name="Lost Child"},
    {label="ESP: Chest", color=Color3.new(1, 1, 1), name="Chest"},
    {label="ESP: Players", color=Color3.new(0, 1, 0), name="Player"},
}

for _, esp in pairs(espToggles) do
    Window:CreateToggle({
        Name = esp.label,
        CurrentValue = false,
        Callback = function(state)
            if state then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Part") and obj.Name:lower():find(esp.name:lower()) then
                        createESP(obj, esp.color, esp.name)
                    end
                end
            end
        end,
    })
end

-- Bring Items
Window:CreateButton({
    Name = "Bring All Items",
    Callback = function()
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Tool") or item:IsA("Part") then
                pcall(function()
                    item.CFrame = Player.Character.HumanoidRootPart.CFrame
                end)
            end
        end
    end,
})

-- Auto collect custom items
local collectList = {"Coal", "Ammo", "Log", "Fuel"}
Window:CreateButton({
    Name = "Auto Collect Custom Items",
    Callback = function()
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Part") then
                for _, keyword in pairs(collectList) do
                    if item.Name:lower():find(keyword:lower()) then
                        pcall(function()
                            item.CFrame = Player.Character.HumanoidRootPart.CFrame
                        end)
                    end
                end
            end
        end
    end,
})
