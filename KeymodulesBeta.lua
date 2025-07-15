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

-- Removed StatusMessages related to keys

-- Removed SaveKey, LoadSavedKey, DeleteSavedKey functions

-- Removed FormatTime function (only used for key expiration)

-- Removed CheckKey function

function module.LoadScript()
    -- Without API from key checking, this just does nothing or could be adjusted as needed
    if module.MainWindow then
        task.delay(1, function()
            module.MainWindow:Destroy()
        end)
    end
    return true
end

-- Removed GetKeyLink function (which referenced key purchase)

return module
