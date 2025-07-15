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
        module.SaveKey(key)

        if module.Notify then
            module.Notify({
                Title = "Success",
                Content = "Key is valid. Access granted! (Custom key)",
                Duration = 5
            })
        end

        return true
    else
        module.DeleteSavedKey()
        
        if module.Notify then
            module.Notify({
                Title = "Error",
                Content = "Invalid key! The key doesn't exist or has been deleted.",
                Duration = 5
            })
        end

        return false
    end
end
