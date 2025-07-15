local ValidateButton = KeySystemTab:CreateButton({
    Name = "Validate Key",
    Callback = function()
        if not keyInputValue or keyInputValue == "" then
            Rayfield:Notify({
                Title = "Error",
                Content = "Please enter a key first!",
                Duration = 3,
                Image = "alert-circle",
            })
            return
        end

        -- Custom key check: only allow "me"
        if keyInputValue ~= "me" then
            Rayfield:Notify({
                Title = "Error",
                Content = "Invalid key entered. Please use the correct key.",
                Duration = 5,
                Image = "x-circle",
            })
            return
        end

        Rayfield:Notify({
            Title = "Validating",
            Content = "Checking your key...",
            Duration = 2,
            Image = "clock",
        })

        KeyModule.MainWindow = Window
        KeyModule.Notify = function(notifyData)
            if notifyData.Title == "Success" then
                isKeyValid = true
                Rayfield:Notify({
                    Title = "Success",
                    Content = notifyData.Content,
                    Duration = 5,
                    Image = "check-circle",
                })

                saveKeyToFile(keyInputValue)

                task.wait(2)

                print("Loading script directly...")
                getgenv().script_key = keyInputValue
                local scriptId = KeyModule.ScriptID
                pcall(function()
                    local api = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
                    api.script_id = scriptId
                    print("Using script ID:", scriptId)
                    print("Using key:", string.sub(keyInputValue, 1, 5) .. "...")
                    api.load_script()
                    print("Script loaded successfully!")
                end)

                task.wait(2)
                Rayfield:Destroy()
            else
                Rayfield:Notify({
                    Title = "Error",
                    Content = notifyData.Content,
                    Duration = 5,
                    Image = "x-circle",
                })
            end
        end

        KeyModule.CheckKey(keyInputValue)
    end,
})
