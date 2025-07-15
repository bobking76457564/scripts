local module = {}

local GameIDs = {
    [6137321701] = "fa4e49b11535d5a034b51e9bfd716abf",
    [6348640020] = "fa4e49b11535d5a034b51e9bfd716abf",
    [18199615050] = "f94ef2b233e95b8ff359b6b089d46f48",
    [18794863104] = "f94ef2b233e95b8ff359b6b089d46f48",
    [142823291] = "8cd48d4ae8ca2c6da70cd1a3092efdc6",
    [2768379856] = "877b22f6944965a8f352ff8980d055ee",
    [83704201064817] = "cf15315e9b55371d845882b79058fbc7",
    [109652885385286] = "cf15315e9b55371d845882b79058fbc7",
    [13772394625] = "9fc1f4535785382f9cac4ef8c8739f08",
    [8260276694] = "963cec62def32b2419a935d99b45f1cc",
    [126884695634066] = "2a27087a4236ede80a0fbc75648ca547",
    [14518422161] = "a3212006bcc8e4564322d37c24adb8ed",
    [17487136170] = "a3212006bcc8e4564322d37c24adb8ed",
    [15000687579] = "a3212006bcc8e4564322d37c24adb8ed",
    [15443524647] = "a3212006bcc8e4564322d37c24adb8ed",
    [16390384148] = "a3212006bcc8e4564322d37c24adb8ed",
    [15514734207] = "a3212006bcc8e4564322d37c24adb8ed",
    [15514727567] = "a3212006bcc8e4564322d37c24adb8ed",
    [8267733039] = "2aefe36cb593d0ea8ddf85c9a163df2f",
    [8417221956] = "2aefe36cb593d0ea8ddf85c9a163df2f",
    [79546208627805] = "0bc73c28f738300dbd3d4b99e5daf4f3",
    [126509999114328] = "0bc73c28f738300dbd3d4b99e5daf4f3",
}

module.ScriptID = GameIDs[game.PlaceId] or "e875a9abc2005dd220616ad2d265e2b9"
module.MainWindow = nil
module.Notify = nil

local StatusMessages = {
    KEY_VALID = "Key is valid. Access granted!",
    KEY_EXPIRED = "Your key has expired. Please get a new one.",
    KEY_BANNED = "This key has been blacklisted. Please get a new one.",
    KEY_HWID_LOCKED = "Key is locked to a different device. Please reset your key.",
    KEY_INCORRECT = "Invalid key! The key doesn't exist or has been deleted.",
    KEY_INVALID = "Key format is invalid. Please check and try again.",
    SCRIPT_ID_INCORRECT = "Script ID error. Please contact the developers.",
    SCRIPT_ID_INVALID = "Script ID format error. Please contact the developers.",
    INVALID_EXECUTOR = "Your executor is not supported. Please use a different one.",
    SECURITY_ERROR = "Security validation failed. Please try again.",
    TIME_ERROR = "Time validation error. Please check your system clock.",
    UNKNOWN_ERROR = "An unknown error occurred. Please try again later."
}

function module.SaveKey(key)
    if key and key ~= "" then
        pcall(function()
            if writefile then
                writefile("PulseHubKey.txt", key)
            end
        end)
    end
end

function module.LoadSavedKey()
    local success, result = pcall(function()
        if isfile and isfile("PulseHubKey.txt") then
            return readfile("PulseHubKey.txt")
        end
        return nil
    end)
    
    if success and result then
        return result
    end
    return nil
end

function module.DeleteSavedKey()
    pcall(function()
        if isfile and isfile("PulseHubKey.txt") then
            delfile("PulseHubKey.txt")
        end
    end)
end

function module.FormatTime(timestamp)
    if not timestamp or timestamp <= 0 then
        return "Lifetime"
    end
    
    local timeLeft = timestamp - os.time()
    if timeLeft <= 0 then
        return "Expired"
    end
    
    local days = math.floor(timeLeft / 86400)
    local hours = math.floor((timeLeft % 86400) / 3600)
    local minutes = math.floor((timeLeft % 3600) / 60)
    
    if days > 0 then
        return string.format("%d days, %d hours", days, hours)
    elseif hours > 0 then
        return string.format("%d hours, %d minutes", hours, minutes)
    else
        return string.format("%d minutes", minutes)
    end
end

-- Custom key check: only "me" is valid
function module.CheckKey(key)
    if not key or key == "" then
        if module.Notify then
            module.Notify({
                Title = "Error",
                Content = "Please enter a key",
                Duration = 5
            })
        end
        return false
    end

    if key == "me" then
        -- Save the key locally
        module.SaveKey(key)

        if module.Notify then
            module.Notify({
                Title = "Success",
                Content = StatusMessages.KEY_VALID,
                Duration = 5
            })
        end

        -- Simulate that the script is ready to load
        return true
    else
        -- Invalid key
        module.DeleteSavedKey()

        if module.Notify then
            module.Notify({
                Title = "Error",
                Content = StatusMessages.KEY_INCORRECT,
                Duration = 5
            })
        end
        return false
    end
end

function module.LoadScript()
    -- You can place your script loading logic here.
    -- For now, just print a confirmation or load your script
    if module.MainWindow then
        task.delay(1, function()
            module.MainWindow:Destroy()
        end)
    end
    print("Script loaded successfully!")
    return true
end

function module.GetKeyLink()
    return "https://ads.luarmor.net/get_key?for=Pulse_Hub_Checkpoint-TxLYDUUMfNao"
end

return module
