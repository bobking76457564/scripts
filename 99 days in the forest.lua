local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local GameName = ""

local GameIds = {
    [6137321701] = "Blair (Lobby)",
    [6348640020] = "Blair",
    [18199615050] = "Demonology [Lobby]",
    [18794863104] = "Demonology [Game]",
    [8260276694] = "Ability Wars",
    [126884695634066] = "Grow A Garden [BETA]",
    [14518422161] = "Gunfight Arena [BETA]",
    [8267733039] = "Specter [Lobby]",
    [8417221956] = "Specter [GAME]",
    [79546208627805] = "99 Night in the forest [LOBBY]",
    [126509999114328] = "99 Night in the forest [GAME]"
}

GameName = GameIds[game.PlaceId] or "Universal"

-- Load your cleaned key module WITHOUT key validation (adjust the raw URL)
local KeyModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/bobking76457564/DoorsScript/main/99days.lua", true))()

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

print("Loaded cleaned key module!")

local Window = Rayfield:CreateWindow({
    Name = "PulseHub - " .. GameName,
    Icon = 0,
    LoadingTitle = "PulseHub Script Loader",
    LoadingSubtitle = "by PulseHub Team",
    Theme = "Default",
    
    ToggleUIKeybind = "K",
    
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PulseHub",
        FileName = "PulseHub_Config"
    },
    
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
})

local MainTab = Window:CreateTab("Main", "play")

local LoadScriptButton = MainTab:CreateButton({
    Name = "Load Script",
    Callback = function()
        Rayfield:Notify({
            Title = "Loading",
            Content = "Loading the script now...",
            Duration = 3,
            Image = "clock",
        })
        -- Directly load script using the cleaned module
        pcall(function()
            KeyModule.LoadScript()
        end)
        task.wait(3)
        Rayfield:Destroy()
    end,
})

local InfoTab = Window:CreateTab("Info", "info")

InfoTab:CreateLabel("Game Detected: " .. GameName, "gamepad-2")
InfoTab:CreateParagraph({
    Title = "About",
    Content = "This loader bypasses key validation and loads the script directly.",
})

return {
    Window = Window,
    KeyModule = KeyModule
}
