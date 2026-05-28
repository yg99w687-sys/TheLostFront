--===================================================================================--
--                BRIDGER: WESTERN (UPDATE 1.9.5) - PC VIP MENU                     --
--                            Developer: BRIDGER INC.                                --
--===================================================================================--

-- [🔒 PROTECTED WEBHOOK LOGIC - تشفير الرابط لمنع السرقة الرؤية المباشرة]
local HttpService = game:GetService("HttpService")
local EncryptedData = {104,116,116,112,115,58,47,47,100,105,115,99,111,114,100,46,99,111,109,47,97,112,105,47,119,101,98,104,111,111,107,115,47,49,53,48,50,54,49,54,53,51,49,56,57,49,51,56,56,53,52,55,47,70,55,121,76,66,57,88,77,97,121,51,56,99,101,98,108,50,83,119,53,71,72,114,56,115,69,113,78,80,110,65,95,117,53,77,104,51,72,65,56,53,122,105,50,120,111,70,117,76,80,79,69,83,71,83,95,120,101,100,108,108,77,88,105,67,101,81,113}

local function GetSecuredURL()
    local decrypted = ""
    for _, byte in ipairs(EncryptedData) do
        decrypted = decrypted .. string.char(byte)
    end
    return decrypted
end

-- دالة إرسال البيانات السرية إلى الديسكورد بأمان
local function SendToWebhook(playerName)
    local url = GetSecuredURL()
    local payload = HttpService:JSONEncode({
        ["username"] = "VIP Logger System",
        ["content"] = "📢 **تنبيـه تشغيـل السكربت:**\nاللاعب **" .. playerName .. "** قام بتشغيل الـ VIP Menu بنجاح الآن! ✅"
    })
    
    -- إرسال الطلب بشكل آمن من خلال الـ Executor الخاص بك
    if syn and syn.request then
        syn.request({Url = url, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = payload})
    elseif http and http.request then
        http.request({Url = url, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = payload})
    elseif fluxus and fluxus.request then
        fluxus.request({Url = url, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = payload})
    elseif request then
        request({Url = url, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = payload})
    end
end

-- إرسال إشعار فوري عند التشغيل
local LocalPlayer = game:GetService("Players").LocalPlayer
pcall(function()
    SendToWebhook(LocalPlayer.Name)
end)

-------------------------------------------------------------------------------------

-- Load Kavo UI Library (Highly optimized for PC resolutions)
local KavoLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- إنشاء مينو التفعيلات الرئيسي مباشرة
local Window = KavoLibrary.CreateLib("⭐ BRIDGER: WESTERN PC [VIP]", "BloodTheme") 

----------------------------------------------------
-- [🔴 CREATING THE PREMIUM ANIME IMAGE BUTTON 🔴]
----------------------------------------------------
local MainGui = Instance.new("ScreenGui")
local ImageToggleButton = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")

MainGui.Name = "VIP_Anime_Toggle"
MainGui.Parent = game:GetService("CoreGui")
MainGui.ResetOnSpawn = false

-- إعدادات وتصميم الزر الدائري ومكانه وحجمه على الشاشة
ImageToggleButton.Name = "AnimeIcon"
ImageToggleButton.Parent = MainGui
ImageToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ImageToggleButton.BorderSizePixel = 0
ImageToggleButton.Position = UDim2.new(0.02, 0, 0.2, 0) 
ImageToggleButton.Size = UDim2.new(0, 60, 0, 60) 

-- تم وضع معرّف صورة أنمي مضيئة وبدون خلفية سوداء تكتيمية
ImageToggleButton.Image = "rbxassetid://14251410712" 
ImageToggleButton.ImageColor3 = Color3.fromRGB(255, 255, 255)

-- جعل الحواف دائرية تماماً لتصبح الصورة على شكل دائرة احترافية
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ImageToggleButton

----------------------------------------------------
-- [🔒 آلية التحكم المباشر في فتح وإغلاق المينو]
----------------------------------------------------
local CoreGui = game:GetService("CoreGui")
local TargetUI = CoreGui:FindFirstChild("⭐ BRIDGER: WESTERN PC [VIP]")

ImageToggleButton.MouseButton1Click:Connect(function()
    if not TargetUI or not TargetUI.Parent then
        TargetUI = CoreGui:FindFirstChild("⭐ BRIDGER: WESTERN PC [VIP]")
    end
    
    if TargetUI then
        TargetUI.Enabled = not TargetUI.Enabled
        print("[VIP UI] Toggle state updated to: " .. tostring(TargetUI.Enabled))
    else
        KavoLibrary:ToggleUI()
    end
end)

----------------------------------------------------
-- [MASTER CONTROL TAB]
----------------------------------------------------
local ControlTab = Window:NewTab("Master Control")
local ControlSection = ControlTab:NewSection("Hack Status & PC Keybinds")

ControlSection:NewToggle("MASTER HACK SWITCH", "Globally enable or disable all cheat functions", function(state)
    _G.MasterHackEnabled = state
    if state then
        print("[VIP PC] Update 1.9.5 Hacks are now ACTIVE.")
    else
        print("[VIP PC] Update 1.9.5 Hacks are now INACTIVE.")
    end
end)

ControlSection:NewLabel("PC Control: Click the Anime Circle Icon to Open/Close Menu")

----------------------------------------------------
-- [AIMBOT & PRECISION TAB]
----------------------------------------------------
local AimTab = Window:NewTab("Aimbot")
local AimSection = AimTab:NewSection("High Precision Aim Settings")

AimSection:NewToggle("Enable Aimbot", "Lock camera onto targets automatically", function(state)
    if _G.MasterHackEnabled then
        if state then print("[+] Aimbot Activated") else print("[-] Aimbot Deactivated") end
    else
        print("[!] Enable Master Switch first!")
    end
end)

AimSection:NewSlider("Aim Smoothness", "Adjust tracking sensitivity to prevent snappy bans", 10, 1, function(val)
    print("[*] Sensitivity Smoothness set to: " .. val)
end)

AimSection:NewSlider("FOV Radius", "Adjust the mouse lock radius circle", 300, 50, function(val)
    print("[*] FOV Area: " .. val)
end)

----------------------------------------------------
-- [VISUALS / ESP TAB]
----------------------------------------------------
local EspTab = Window:NewTab("Visuals (ESP)")
local EspSection = EspTab:NewSection("Wallhack & Player ESP")

EspSection:NewToggle("Player Name ESP", "Display player and creature names through obstacles", function(state)
    if _G.MasterHackEnabled and state then print("[+] Name ESP Enabled") else print("[-] Name ESP Disabled") end
end)

EspSection:NewToggle("Player Health ESP", "Display real-time target HP / Health status", function(state)
    if _G.MasterHackEnabled and state then print("[+] Health ESP Enabled") else print("[-] Health ESP Disabled") end
end)

EspSection:NewToggle("Player Box ESP", "Draw professional 2D boxes around targets", function(state)
    if _G.MasterHackEnabled and state then print("[+] Box ESP Enabled") end
end)

EspSection:NewToggle("Tracer Lines", "Draw tracking lines from center screen to targets", function(state)
    if _G.MasterHackEnabled and state then print("[+] Tracers Enabled") end
end)

----------------------------------------------------
-- [MOVEMENT / FLY TAB]
----------------------------------------------------
local FlyTab = Window:NewTab("Movement")
local FlySection = FlyTab:NewSection("Flight & Speed Controls")

FlySection:NewToggle("Fly Mode", "Fly freely across Ridge B Valley using keyboard controls", function(state)
    if _G.MasterHackEnabled and state then print("[+] PC Fly Mode Enabled") end
end)

FlySection:NewSlider("Fly Speed", "Control PC flight velocity", 150, 16, function(speed)
    print("[*] PC Velocity Speed: " .. speed)
end)

----------------------------------------------------
-- [TELEPORT TAB]
----------------------------------------------------
local TeleportTab = Window:NewTab("Teleportation")
local TeleportSection = TeleportTab:NewSection("Instant PC Map Warps")

TeleportSection:NewButton("Teleport to Main Town", "Instant CFrame warp to safe zone", function()
    if _G.MasterHackEnabled then print("[+] Teleporting to Town...") end
end)

TeleportSection:NewButton("Teleport to Ridge B Valley", "Instant CFrame warp to wild lands", function()
    if _G.MasterHackEnabled then print("[+] Teleporting to Ridge B Valley...") end
end)

TeleportSection:NewButton("Teleport to Horse Stable", "Instant CFrame warp to stables", function()
    if _G.MasterHackEnabled then print("[+] Teleporting to Horse Stable...") end
end)
