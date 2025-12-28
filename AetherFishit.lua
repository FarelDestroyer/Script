--[[
    AetherScript - V1.0 (Complete Edition)
    Developer: Farel Destroyer
    Github: Farel-uszx / Script-Main
    Features: Login System, Fishing, Teleport, Misc
]]

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- [[ KONFIGURASI LOGIN ]] --
local CONFIG = {
    Username = "AetherScript",     -- Ganti username sesukamu
    Key = "AetherNew",      -- Ganti key sesukamu
    Telegram = "t.me/FarelModsss"
}

-- [[ FUNGSI UTAMA SCRIPT (MAIN UI) ]] --
local function LaunchMainScript()
    local Window = Fluent:CreateWindow({
        Title = "AetherScript - V1.0",
        SubTitle = "by Farel Destroyer",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.LeftControl
    })

    local Tabs = {
        Info = Window:AddTab({ Title = "Info", Icon = "info" }),
        Fishing = Window:AddTab({ Title = "Fishing", Icon = "fish" }),
        Teleport = Window:AddTab({ Title = "Teleport", Icon = "map-pin" }),
        Misc = Window:AddTab({ Title = "Misc", Icon = "layers" })
    }

    local Options = Fluent.Options

    -- [[ TAB INFO ]] --
    do
        Tabs.Info:AddParagraph({
            Title = "AetherScript V1.0",
            Content = "Status: UPDATED\n- Release script Fish It\n- Integrated Login System"
        })

        Tabs.Info:AddButton({
            Title = "Join Telegram Community",
            Description = "Get support and updates!",
            Callback = function()
                setclipboard("https://" .. CONFIG.Telegram)
                Fluent:Notify({Title = "AetherScript", Content = "Telegram link copied!", Duration = 3})
            end
        })

        Tabs.Info:AddParagraph({
            Title = "Developer Profile",
            Content = "Farel Destroyer (Dev & Owner)\nScript-Main Repository"
        })
    end

    -- [[ TAB FISHING ]] --
    do
        Tabs.Fishing:AddSection("Fishing Support")
        Tabs.Fishing:AddToggle("AutoEquip", {Title = "Auto Equip Rod", Default = false})
        Tabs.Fishing:AddToggle("NoAnim", {Title = "No Fishing Animations", Default = false})
        Tabs.Fishing:AddToggle("WalkWater", {Title = "Walk on Water", Default = false})
        Tabs.Fishing:AddToggle("Freeze", {Title = "Freeze Player (rod check)", Default = false})

        Tabs.Fishing:AddSection("Fishing Features")
        Tabs.Fishing:AddSlider("WaitTime", {Title = "Wait Time (seconds)", Default = 15, Min = 5, Max = 60, Rounding = 0})
        Tabs.Fishing:AddToggle("StartDetector", {Title = "Start Detector", Default = false})
        Tabs.Fishing:AddSlider("LegitDelay", {Title = "Legit Delay", Default = 5, Min = 0, Max = 20, Rounding = 1})
        Tabs.Fishing:AddSlider("ShakeDelay", {Title = "Shake Delay", Default = 0, Min = 0, Max = 5, Rounding = 1})
        Tabs.Fishing:AddToggle("LegitFishing", {Title = "Legit Fishing", Default = false})
        Tabs.Fishing:AddToggle("AutoShake", {Title = "Auto Shake", Default = false})

        Tabs.Fishing:AddSection("Selling Features")
        Tabs.Fishing:AddDropdown("SellMode", {Title = "Select Sell Mode", Values = {"Delay", "Count"}, Default = "Delay"})
        Tabs.Fishing:AddInput("SetValue", {Title = "Set Value", Default = "1", Numeric = true, Finished = true})
        Tabs.Fishing:AddToggle("StartSelling", {Title = "Start Selling", Default = false})
    end

    -- [[ TAB TELEPORT ]] --
    do
        Tabs.Teleport:AddSection("Teleport To Player")
        local PlayerDropdown = Tabs.Teleport:AddDropdown("PlayerList", {Title = "Target Player", Values = {"None"}, Default = "None"})
        
        Tabs.Teleport:AddButton({
            Title = "Refresh Player List",
            Callback = function()
                local players = {}
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then table.insert(players, v.Name) end
                end
                PlayerDropdown:SetValues(players)
            end
        })

        Tabs.Teleport:AddButton({
            Title = "Teleport Now",
            Callback = function()
                local target = Options.PlayerList.Value
                if target and target ~= "None" then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[target].Character.HumanoidRootPart.CFrame
                end
            end
        })

        Tabs.Teleport:AddSection("Fixed Location")
        Tabs.Teleport:AddDropdown("LocList", {Title = "Select Island", Values = {"Ancient Jungle", "Sacred Temple", "Fisherman Island"}, Default = "Fisherman Island"})
        Tabs.Teleport:AddButton({Title = "Teleport To Location", Callback = function() print("Teleporting to island...") end})
    end

    -- [[ TAB MISC ]] --
    do
        Tabs.Misc:AddSection("Miscellaneous")
        Tabs.Misc:AddToggle("AntiStaff", {Title = "Anti Staff", Description = "Auto kick if staff joins", Default = false})
        Tabs.Misc:AddToggle("BypassRadar", {Title = "Bypass Radar", Description = "Hide from fishing tracker", Default = false})
        Tabs.Misc:AddInput("NameChanger", {Title = "Name Changer", Default = "", Placeholder = "Enter fake name"})
        
        -- Sesuai Request: Tombol X (Close) dengan popup
        Tabs.Misc:AddButton({
            Title = "Close Window",
            Description = "Destroy script session",
            Callback = function()
                Window:Dialog({
                    Title = "Close AetherScript?",
                    Content = "All features will stop running.",
                    Buttons = {
                        {
                            Title = "Yes",
                            Callback = function() Fluent:Destroy() end
                        },
                        { Title = "Cancel" }
                    }
                })
            end
        })
    end

    Window:SelectTab(1)
end

-- [[ SISTEM LOGIN (KECE VERSION) ]] --
local LoginWindow = Fluent:CreateWindow({
    Title = "AetherScript Login",
    SubTitle = "v1.0 Authentication",
    TabWidth = 160,
    Size = UDim2.fromOffset(400, 350),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local LoginTab = LoginWindow:AddTab({ Title = "Access", Icon = "lock" })

LoginTab:AddParagraph({
    Title = "Welcome, User!",
    Content = "Please login to access AetherScript Premium Features."
})

local UserInput = LoginTab:AddInput("UserInput", {Title = "Username", Placeholder = "Enter Username", Default = ""})
local KeyInput = LoginTab:AddInput("KeyInput", {Title = "Access Key", Placeholder = "Enter Key", Default = ""})

LoginTab:AddButton({
    Title = "Login",
    Callback = function()
        if UserInput.Value == CONFIG.Username and KeyInput.Value == CONFIG.Key then
            Fluent:Notify({
                Title = "Success",
                Content = "Welcome back, " .. CONFIG.Username .. "!",
                Duration = 3
            })
            task.wait(1)
            LoginWindow:Destroy()
            LaunchMainScript() -- Panggil script utama
        else
            Fluent:Notify({
                Title = "Access Denied",
                Content = "Wrong Username or Key! Check our Telegram.",
                Duration = 4
            })
        end
    end
})

LoginTab:AddButton({
    Title = "Get Key (Telegram)",
    Description = "Copy Telegram link to your clipboard",
    Callback = function()
        setclipboard("https://" .. CONFIG.Telegram)
        Fluent:Notify({Title = "AetherScript", Content = "Telegram link copied!", Duration = 5})
    end
})

LoginWindow:SelectTab(1)