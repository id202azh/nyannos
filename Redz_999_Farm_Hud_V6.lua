
-- ========== FIX: KURRI COMPAT SHIM O DAU FILE (phai co truoc Farm, neu khong GetSetting = nil -> chet o Line 4611) ==========
if not _G.SaveData then _G.SaveData = {} end
if not GetSetting then
    GetSetting = function(k, d) if _G.SaveData[k] == nil then return d end return _G.SaveData[k] end
end
if not SaveSettings then
    SaveSettings = function()
        pcall(function()
            if writefile then
                if makefolder and not isfolder("Redz Hub - OK Hub") then makefolder("Redz Hub - OK Hub") end
                writefile("Redz Hub - OK Hub/Configs.json", game:GetService("HttpService"):JSONEncode(_G.SaveData))
            end
        end)
    end
end
if not FolderName then FolderName = "Redz Hub - OK Hub" end
if not Player then Player = game.Players.LocalPlayer end
if not LocalPlayer3 then LocalPlayer3 = game.Players.LocalPlayer end
if not ReplicatedStorage6 then ReplicatedStorage6 = game:GetService("ReplicatedStorage") end
if not RunService6 then RunService6 = game:GetService("RunService") end
if not KurriRS then KurriRS = game:GetService("ReplicatedStorage") end
if not Sec then Sec = 0.1 end
if not TweenSpeed then TweenSpeed = 191 end
if not _G.TweenSpeed then _G.TweenSpeed = 191 end
if not getgenv().TweenSpeed then getgenv().TweenSpeed = 191 end
-- ========== HET SHIM DAU FILE ==========


-- UI HELPERS
function GetQuestActive()
    local p = game.Players.LocalPlayer
    local tqf = p.PlayerGui:FindFirstChild("TrackedQuestFrame")
    if tqf and tqf.Enabled then return true end
    local _main = p.PlayerGui:FindFirstChild("Main")
    local mq = _main and _main:FindFirstChild("Quest")
    if mq and mq.Visible then return true end
    return false
end

function GetQuestText()
    local p = game.Players.LocalPlayer
    local tqf = p.PlayerGui:FindFirstChild("TrackedQuestFrame")
    if tqf and tqf.Enabled then
        local header = tqf:FindFirstChild("Frame") and tqf.Frame:FindFirstChild("header")
        local lbl = header and header:FindFirstChild("textLabel")
        if lbl then return lbl.Text end
    end
    local _main = p.PlayerGui:FindFirstChild("Main")
    local mq = _main and _main:FindFirstChild("Quest")
    if mq and mq.Visible then
        local qtObj = mq:FindFirstChild("Container") and mq.Container:FindFirstChild("QuestTitle") and mq.Container.QuestTitle:FindFirstChild("Title")
        if qtObj then return qtObj.Text end
    end
    return ""
end
--
local wait = task.wait

-- Executor Compatibility and Polyfill Layer
do
    local safe_pcall = pcall or function() return false end
    local env = _G
    safe_pcall(function()
        if type(getgenv) == "function" then
            env = getgenv()
        elseif type(getgenv) == "table" then
            env = getgenv
        end
    end)

    safe_pcall(function()
        if not env.cloneref then
            env.cloneref = function(ref) return ref end
        end
    end)

    safe_pcall(function()
        if not env.sethiddenproperty then
            env.sethiddenproperty = function(instance, property, value)
                safe_pcall(function()
                    instance[property] = value
                end)
            end
        end
    end)

    safe_pcall(function()
        if not env.gethiddenproperty then
            env.gethiddenproperty = function(instance, property)
                local val = nil
                local success = safe_pcall(function()
                    val = instance[property]
                end)
                return success and val or nil
            end
        end
    end)

    safe_pcall(function()
        if not env.fireclickdetector then
            env.fireclickdetector = function(detector, distance)
                safe_pcall(function()
                    if detector and detector:IsA("ClickDetector") then
                        detector:InputBegan(Enum.UserInputType.MouseButton1)
                    end
                end)
            end
        end
    end)

    safe_pcall(function()
        if not env.getconnections then env.getconnections = function() return {} end end
        if not env.getgc then env.getgc = function() return {} end end
        if not env.isnetworkowner then env.isnetworkowner = function() return true end end
        if not env.queue_on_teleport then env.queue_on_teleport = function() end end
    end)
    
    safe_pcall(function()
        if not env.fireproximityprompt then
            env.fireproximityprompt = function(prompt)
                safe_pcall(function()
                    if prompt and prompt:IsA("ProximityPrompt") then
                        prompt:InputBegan(Enum.UserInputType.MouseButton1)
                        if task and task.wait then
                            task.wait(prompt.HoldDuration + 0.05)
                        end
                        prompt:InputEnded(Enum.UserInputType.MouseButton1)
                    end
                end)
            end
        end
    end)
end



Settings = Settings or {}

_G.GlitchedMobs = _G.GlitchedMobs or setmetatable({}, {__mode = "k"})
_G.GrabbedFruits = _G.GrabbedFruits or setmetatable({}, {__mode = "k"})

Players = game:GetService("Players")
ReplicatedStorage = game:GetService("ReplicatedStorage")
HttpService = game:GetService("HttpService")

task.spawn(function()
    pcall(function()
        local remotes = ReplicatedStorage:WaitForChild("Remotes", 10)
        if remotes then
            local dmgDebug = remotes:WaitForChild("DMGDEBUG", 10)
            if dmgDebug and dmgDebug:IsA("RemoteEvent") then
                dmgDebug.OnClientEvent:Connect(function() end)
            end
        end
    end)
end)

Plr = Players.LocalPlayer

if Settings.Translator == true then
    pcall(function()
        _G.RedzTranslator = HttpService:JSONDecode(game:HttpGet("https://raw.githubusercontent.com/realredz999/NewRedz/main/Translator/Portuguese.json"))
    end)
end

local function JoinTeam()
    local targetTeam = "Marines"
    if Settings.JoinTeam == "Pirates" then
        targetTeam = "Pirates"
    end

    if not Plr.Team or (Plr.Team.Name ~= "Marines" and Plr.Team.Name ~= "Pirates") then
        pcall(function()
            ReplicatedStorage
                :WaitForChild("Remotes")
                :WaitForChild("CommF_")
                :InvokeServer("SetTeam", targetTeam)
        end)
    end
end

JoinTeam()

Mouse = Plr:GetMouse()


function Skill(v572)
    local l_VirtualInputManager_0 = game:GetService("VirtualInputManager")
    l_VirtualInputManager_0:SendKeyEvent(true, Enum.KeyCode[v572], false, game)
    task.wait(0.05)
    l_VirtualInputManager_0:SendKeyEvent(false, Enum.KeyCode[v572], false, game)
end

function Click()
    pcall(function()
        local vim = game:GetService("VirtualInputManager")
        vim:SendMouseButtonEvent(0, 0, 0, true, game, 1)
        task.wait(0.05)
        vim:SendMouseButtonEvent(0, 0, 0, false, game, 1)
    end)
    pcall(function()
        local vu = game:GetService("VirtualUser")
        vu:CaptureController()
        vu:Button1Down(Vector2.new(1280, 672))
    end)
end

function FindWeapon(v575)
    local l_Backpack_0 = game.Players.LocalPlayer.Backpack
    for _, v578 in ipairs(l_Backpack_0:GetChildren()) do
        if v578:IsA("Tool") then
            if v575 ~= "Melee" or v578.ToolTip ~= "Melee" and v578.Name ~= "Combat" then
                if v575 ~= "Sword" or v578.ToolTip ~= "Sword" then
                    if v575 == "Gun" and v578.ToolTip == "Gun" then
                        return v578.Name
                    elseif v575 == "Fruit" and v578.ToolTip == "Blox Fruit" then
                        return v578.Name
                    end
                else
                    return v578.Name
                end
            else
                return v578.Name
            end
        end
    end
    local char = game.Players.LocalPlayer.Character
    if char then
        for _, v578 in ipairs(char:GetChildren()) do
            if v578:IsA("Tool") then
                if v575 ~= "Melee" or v578.ToolTip ~= "Melee" and v578.Name ~= "Combat" then
                    if v575 ~= "Sword" or v578.ToolTip ~= "Sword" then
                        if v575 == "Gun" and v578.ToolTip == "Gun" then
                            return v578.Name
                        elseif v575 == "Fruit" and v578.ToolTip == "Blox Fruit" then
                            return v578.Name
                        end
                    else
                        return v578.Name
                    end
                else
                    return v578.Name
                end
            end
        end
    end
    return nil
end

function EquipWeapon(v579)
    if not v579 then
        return 
    else
        local l_LocalPlayer_7 = game.Players.LocalPlayer
        local l_FirstChild_1 = l_LocalPlayer_7:WaitForChild("Backpack"):FindFirstChild(v579)
        if l_FirstChild_1 then
            l_LocalPlayer_7.Character.Humanoid:EquipTool(l_FirstChild_1)
        end
        return 
    end
end

function isFruitOrGun(toolName)
    if not toolName then return false end
    local backpack = game.Players.LocalPlayer:FindFirstChild("Backpack")
    local char = game.Players.LocalPlayer.Character
    local tool = (backpack and backpack:FindFirstChild(toolName)) or (char and char:FindFirstChild(toolName))
    if tool and tool:IsA("Tool") and (tool.ToolTip == "Blox Fruit" or tool.ToolTip == "Gun") then
        return true
    end
    return false
end

function getToolToEquip(mob)
    if _G.AutoFarmMastery then
        local weaponType = _G.MasterySelectWeapon or "Melee"
        if weaponType == "Gun" or weaponType == "Blox Fruit" then
            if mob and mob:FindFirstChild("Humanoid") then
                local hpPercent = (mob.Humanoid.Health / mob.Humanoid.MaxHealth) * 100
                if hpPercent > (_G.UseSkillHP or 20) then
                    local toolName = FindWeapon("Melee") or "Combat"
                    return toolName
                else
                    local targetType = (weaponType == "Blox Fruit" and "Fruit" or "Gun")
                    local toolName = FindWeapon(targetType)
                    return toolName
                end
            end
        end
        local defaultTool = FindWeapon(weaponType == "Blox Fruit" and "Fruit" or weaponType)
        return defaultTool
    else
        return _G.SelectWeapon
    end
end

local function isSkillReady(key)
    local ready = true
    pcall(function()
        local skills = game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills
        local skillFrame = skills:FindFirstChild(key)
        if skillFrame then
            local cooldown = skillFrame:FindFirstChild("Cooldown")
            if cooldown then
                if cooldown.Visible and cooldown.AbsoluteSize.X > 0 and cooldown.AbsoluteSize.Y > 0 then
                    ready = false
                end
                local textLabel = cooldown:FindFirstChildOfClass("TextLabel")
                if textLabel and textLabel.Text ~= "" and textLabel.Text:match("%d") then
                    ready = false
                end
            end
        end
    end)
    return ready
end

local currentFarmedMob = nil
function spamCombatSkills(mob)
    if currentFarmedMob == mob then 
        return 
    end

    -- Bail out immediately if mob is nil, dead, or despawned
    if not mob or not mob.Parent or not mob:FindFirstChild("Humanoid") or mob.Humanoid.Health <= 0 then
        return
    end
    if not mob:FindFirstChild("HumanoidRootPart") then
        return
    end

    local weaponType = _G.SelectWeapon
    if _G.AutoFarmMastery then
        local mType = _G.MasterySelectWeapon or "Melee"
        if mType == "Gun" or mType == "Blox Fruit" then
            local hpPercent = (mob.Humanoid.Health / mob.Humanoid.MaxHealth) * 100
            if hpPercent <= (_G.UseSkillHP or 20) then
                weaponType = FindWeapon(mType == "Blox Fruit" and "Fruit" or "Gun")
            else
                return
            end
        else
            return
        end
    end

    if not weaponType then 
        return 
    end

    currentFarmedMob = mob
    _G.SpamThreadID = (_G.SpamThreadID or 0) + 1
    local myThreadID = _G.SpamThreadID

    task.spawn(function()
        local casting = true
        local skillFiring = false -- When true, position anchoring pauses so dash skills can travel

        -- Helper to check if mob is still valid and alive
        local function isMobAlive()
            if _G.SpamThreadID ~= myThreadID then return false end
            -- Also check player is alive to prevent acting at respawn
            local myChar = game.Players.LocalPlayer.Character
            if not myChar or not myChar:FindFirstChild("Humanoid") or myChar.Humanoid.Health <= 0 then
                return false
            end
            if _G.PlayerRespawning then
                return false
            end
            -- Check if farm toggles are active
            if not (_G.AutoFarm or _G.AutoFarmMastery or _G.AutoNear or _G.FarmBone or _G.AutoBoss or _G.AutoAllBoss) then
                return false
            end
            return mob and mob.Parent and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart")
        end

        -- Position anchoring loop: hovers player 30 studs above mob, pauses during skill dashes
        task.spawn(function()
            while casting do
                if not isMobAlive() then
                    casting = false
                    break
                end
                pcall(function()
                    PosMon = mob.HumanoidRootPart.CFrame
                    MonFarm = mob.Name
                    
                    -- Only anchor when NOT firing a dash skill
                    if not skillFiring then
                        local character = game.Players.LocalPlayer.Character
                        if character and character:FindFirstChild("HumanoidRootPart") then
                            local mobPos = mob.HumanoidRootPart.Position
                            local farmHeight = 10
                            local holdPos = Vector3.new(mobPos.X, mobPos.Y + farmHeight, mobPos.Z)
                            character.HumanoidRootPart.CFrame = CFrame.lookAt(
                                holdPos,
                                mobPos
                            )
                            character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                            character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
                        end
                    end
                end)
                task.wait()
            end
        end)

        -- Helper: drop near mob, fire skill, let dash connect, then re-engage hover
        local function fireSkill(key)
            if not isMobAlive() or not casting then return end
            -- Drop to mob level offset, facing the mob so dashes travel toward it
            pcall(function()
                local character = game.Players.LocalPlayer.Character
                if character and character:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("HumanoidRootPart") then
                    local mobPos = mob.HumanoidRootPart.Position
                    local charPos = character.HumanoidRootPart.Position
                    -- Calculate horizontal direction away from mob for offset
                    local dx = charPos.X - mobPos.X
                    local dz = charPos.Z - mobPos.Z
                    local hDist = math.sqrt(dx * dx + dz * dz)
                    local offX, offZ
                    if hDist > 1 then
                        offX = (dx / hDist) * 12
                        offZ = (dz / hDist) * 12
                    else
                        offX = 12
                        offZ = 0
                    end
                    local dropPos = Vector3.new(mobPos.X + offX, mobPos.Y + 12, mobPos.Z + offZ)
                    character.HumanoidRootPart.CFrame = CFrame.lookAt(
                        dropPos,
                        mobPos
                    )
                    character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                    character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
                end
            end)
            skillFiring = true   -- Release position lock for dash travel
            Skill(key)
            task.wait(0.35)      -- Let dash animation connect with mob
            skillFiring = false  -- Re-engage hover (anchoring loop snaps back to 30 above)
        end

        -- Skill loop: fire all skills → wait for cooldown → repeat until mob dies
        while isMobAlive() and casting do
            local currentWeapon = getToolToEquip(mob)
            _G.UseSkill = true
            pcall(function()
                if FindWeapon("Fruit") and currentWeapon == FindWeapon("Fruit") then
                    if isMobAlive() and _G.UseSkillZ and isSkillReady("Z") then fireSkill("Z") task.wait(0.05) end
                    if isMobAlive() and _G.UseSkillX and isSkillReady("X") then fireSkill("X") task.wait(0.05) end
                    if isMobAlive() and _G.UseSkillC and isSkillReady("C") then fireSkill("C") task.wait(0.05) end
                    if isMobAlive() and _G.UseSkillV and isSkillReady("V") then fireSkill("V") task.wait(0.05) end
                    if isMobAlive() and _G.UseSkillF and isSkillReady("F") then fireSkill("F") task.wait(0.05) end
                elseif FindWeapon("Gun") and currentWeapon == FindWeapon("Gun") then
                    if isMobAlive() and _G.UseSkillZ and isSkillReady("Z") then fireSkill("Z") task.wait(0.05) end
                    if isMobAlive() and _G.UseSkillX and isSkillReady("X") then fireSkill("X") task.wait(0.05) end
                end
            end)
            _G.UseSkill = false

            -- Check skills again in real-time as fast as possible without freezing
            task.wait(0.01)
        end

        _G.UseSkill = false
        casting = false
        if currentFarmedMob == mob then
            currentFarmedMob = nil
        end
    end)
end

function AttackAllSkills()
    local v582 = FindWeapon("Melee")
    local v583 = FindWeapon("Sword")
    local v584 = FindWeapon("Fruit")
    local v585 = FindWeapon("Gun")
    if v582 then
        EquipWeapon(v582)
        Skill("Z")
        Skill("X")
        Skill("C")
        Skill("V")
        Click()
    end
    if v583 then
        EquipWeapon(v583)
        Skill("Z")
        Skill("X")
        Click()
    end
    if v584 then
        EquipWeapon(v584)
        Skill("Z")
        Skill("X")
        Skill("C")
        Skill("F")
        Click()
    end
    if v585 then
        EquipWeapon(v585)
        Skill("Z")
        Skill("X")
        Click()
    end
end

pcall(function()
    hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Death), function()
        -- empty block
    end)
end)
pcall(function()
    hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Respawn), function()
        -- empty block
    end)
end)
if game.PlaceId == 2753915549 or game.PlaceId == 85211729168715 then
    World1 = true
elseif game.PlaceId == 4442272183 or game.PlaceId == 79091703265657 then
    World2 = true
elseif game.PlaceId == 7449423635 or game.PlaceId == 100117331123089 then
    World3 = true
end
function MaterialMon()
    if _G.SelectMaterial ~= "Radiactive Material" then
        if _G.SelectMaterial ~= "Leather + Scrap Metal" then
            if _G.SelectMaterial ~= "Magma Ore" then
                if _G.SelectMaterial ~= "Fish Tail" then
                    if _G.SelectMaterial == "Angel Wings" then
                        MMon = "Royal Soldier"
                        MPos = CFrame.new(-7138.5, 5541.1, 1050.8, -0.866007447, 0, -0.500031412, 0, 1, 0, 0.500031412, 0, -0.866007447)
                        SP = "SkyArea2"
                    elseif _G.SelectMaterial == "Mystic Droplet" then
                        MMon = "Water Fighter"
                        MPos = CFrame.new(-3331.70459, 239.138336, -10553.3564, -0.29242146, 0, 0.95628953, 0, 1, 0, -0.95628953, 0, -0.29242146)
                        SP = "ForgottenIsland"
                    elseif _G.SelectMaterial == "Vampire Fang" then
                        MMon = "Vampire"
                        MPos = CFrame.new(-6132.39453, 9.00769424, -1466.16919, -0.927179813, 0, -0.374617696, 0, 1, 0, 0.374617696, 0, -0.927179813)
                        SP = "Graveyard"
                    elseif _G.SelectMaterial == "Gunpowder" then
                        MMon = "Pistol Billionaire"
                        MPos = CFrame.new(-185.693283, 84.7088699, 6103.62744, 0.90629667, 0, -0.422642082, 0, 1, 0, 0.422642082, 0, 0.90629667)
                        SP = "Mansion"
                    elseif _G.SelectMaterial ~= "Mini Tusk" then
                        if _G.SelectMaterial == "Conjured Cocoa" then
                            MMon = "Chocolate Bar Battler"
                            MPos = CFrame.new(582.828674, 25.5824986, -12550.7041, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664)
                            SP = "Chocolate"
                        end
                    else
                        MMon = "Mythological Pirate"
                        MPos = CFrame.new(-13456.0498, 469.433228, -7039.96436, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                        SP = "BigMansion"
                    end
                elseif game.PlaceId == 2753915549 then
                    MMon = "Fishman Warrior"
                    MPos = CFrame.new(60736.8, 23.6, 1396.3, 0.826706648, 0, -0.562633216, 0, 1, 0, 0.562633216, 0, 0.826706648)
                    SP = "Underwater City"
                    MMon = "Fishman Commando"
                    MPos = CFrame.new(61352.9, 64.5, 1029.1, -0.632549644, 0, -0.774520278, 0, 1, 0, 0.774520278, 0, -0.632549644)
                    SP = "Underwater City"
                elseif game.PlaceId == 7449423635 then
                    MMon = "Fishman Captain"
                    MPos = CFrame.new(-10828.1064, 331.825989, -9049.14648, -0.0912091732, 0, 0.995831788, 0, 1, 0, -0.995831788, 0, -0.0912091732)
                    SP = "PineappleTown"
                end
            elseif game.PlaceId == 2753915549 then
                MMon = "Military Soldier"
                MPos = CFrame.new(-5418.5, 17.1, 8421.1, -0.838688731, 0, -0.544611216, 0, 1, 0, 0.544611216, 0, -0.838688731)
                SP = "Magma"
                MMon = "Military Spy"
                MPos = CFrame.new(-5714.9, 76.0, 8834.9, 0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, 0.707134247)
                SP = "Magma"
            elseif game.PlaceId == 4442272183 then
                MMon = "Lava Pirate"
                MPos = CFrame.new(-5158.77051, 14.4791956, -4654.2627, -0.848060489, 0, -0.529899538, 0, 1, 0, 0.529899538, 0, -0.848060489)
                SP = "CircleIslandFire"
            end
        elseif game.PlaceId == 2753915549 then
            MMon = "Pirate"
            MPos = CFrame.new(-1285.1, 16.0, 3887.0, -0.258864403, 0, -0.965913713, 0, 1, 0, 0.965913713, 0, -0.258864403)
            SP = "Pirate"
            MMon = "Brute"
            MPos = CFrame.new(-1094.9, 26.0, 4442.9, 0.629286051, 0, -0.777173758, 0, 1, 0, 0.777173758, 0, 0.629286051)
            SP = "Pirate"
        elseif game.PlaceId ~= 4442272183 then
            if game.PlaceId == 7449423635 then
                MMon = "Pirate Millionaire"
                MPos = CFrame.new(-118.809372, 55.4874573, 5649.17041, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
                SP = "Default"
            end
        else
            MMon = "Mercenary"
            MPos = CFrame.new(-986.774475, 72.8755951, 1088.44653, -0.656062722, 0, 0.754706323, 0, 1, 0, -0.754706323, 0, -0.656062722)
            SP = "DressTown"
        end
    else
        MMon = "Factory Staff"
        MPos = CFrame.new(-105.889565, 72.8076935, -670.247986, -0.965929747, 0, -0.258804798, 0, 1, 0, 0.258804798, 0, -0.965929747)
        SP = "Bar"
    end
end
function CheckQuest()
    MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
    if World1 then
        if MyLevel >= 1 and MyLevel <= 9 or SelectMonster == "Bandit" then
            Mon = "Bandit"
            LevelQuest = 1
            NameQuest = "BanditQuest1"
            NameMon = "Bandit"
            CFrameQuest = CFrame.new(1051.8, 14.5, 1557.7)
            CFrameMon = CFrame.new(928.0, 13.2, 1597.3)
        elseif (MyLevel < 10 or MyLevel > 14) and SelectMonster ~= "Monkey" then
            if (MyLevel < 15 or MyLevel > 29) and SelectMonster ~= "Gorilla" then
                if (MyLevel < 30 or MyLevel > 39) and SelectMonster ~= "Pirate" then
                    if (MyLevel < 40 or MyLevel > 59) and SelectMonster ~= "Brute" then
                        if MyLevel >= 60 and MyLevel <= 74 or SelectMonster == "Desert Bandit" then
                            Mon = "Desert Bandit"
                            LevelQuest = 1
                            NameQuest = "DesertQuest"
                            NameMon = "Desert Bandit"
                            CFrameQuest = CFrame.new(931.4, 4.7, 4198.2, 0.819155693, -0, -0.573571265, -0, 1, -0, 0.573571265, -0, 0.819155693)
                            CFrameMon = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375)
                        elseif (MyLevel < 75 or MyLevel > 89) and SelectMonster ~= "Desert Officer" then
                            if (MyLevel < 90 or MyLevel > 99) and SelectMonster ~= "Snow Bandit" then
                                if MyLevel >= 100 and MyLevel <= 119 or SelectMonster == "Snowman" then
                                    Mon = "Snowman"
                                    LevelQuest = 2
                                    NameQuest = "SnowQuest"
                                    NameMon = "Snowman"
                                    CFrameQuest = CFrame.new(1400.6, 77.4, -1311.3, -0.342042685, -0, 0.939684391, -0, 1, -0, -0.939684391, -0, -0.342042685)
                                    CFrameMon = CFrame.new(1246.8, 98.3, -1555.7)
                                elseif (MyLevel < 120 or MyLevel > 149) and SelectMonster ~= "Chief Petty Officer" then
                                    if (MyLevel < 150 or MyLevel > 174) and SelectMonster ~= "Sky Bandit" then
                                        if (MyLevel < 175 or MyLevel > 189) and SelectMonster ~= "Dark Master" then
                                            if MyLevel >= 190 and MyLevel <= 209 or SelectMonster == "Prisoner" then
                                                Mon = "Prisoner"
                                                LevelQuest = 1
                                                NameQuest = "PrisonerQuest"
                                                NameMon = "Prisoner"
                                                CFrameQuest = CFrame.new(5208.3, 18.9, 736.6, -0.0894274712, -5.00292918E-9, -0.995993316, 1.60817859E-9, 1, -5.16744869E-9, 0.995993316, -2.06384709E-9, -0.0894274712)
                                                CFrameMon = CFrame.new(5278.6, 8.0, 391.6)
                                            elseif (MyLevel < 210 or MyLevel > 249) and SelectMonster ~= "Dangerous Prisone" then
                                                if MyLevel >= 250 and MyLevel <= 274 or SelectMonster == "Toga Warrior" then
                                                    Mon = "Toga Warrior"
                                                    LevelQuest = 1
                                                    NameQuest = "ColosseumQuest"
                                                    NameMon = "Toga Warrior"
                                                    CFrameQuest = CFrame.new(-1342.3, 11.2, -2928.6, -0.515037298, -0, -0.857167721, -0, 1, -0, 0.857167721, -0, -0.515037298)
                                                    CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
                                                elseif (MyLevel < 275 or MyLevel > 299) and SelectMonster ~= "Gladiator" then
                                                    if (MyLevel < 300 or MyLevel > 324) and SelectMonster ~= "Military Soldier" then
                                                        if (MyLevel < 325 or MyLevel > 374) and SelectMonster ~= "Military Spy" then
                                                            if (MyLevel < 375 or MyLevel > 399) and SelectMonster ~= "Fishman Warrior" then
                                                                if (MyLevel < 400 or MyLevel > 449) and SelectMonster ~= "Fishman Commando" then
                                                                    if MyLevel >= 450 and MyLevel <= 474 or SelectMonster == "God's Guard" then
                                                                        Mon = "God's Guard"
                                                                        LevelQuest = 1
                                                                        NameQuest = "SkyExp1Quest"
                                                                        NameMon = "God's Guard"
                                                                        CFrameQuest = CFrame.new(-4820.9, 936.8, -1152.0, 0.996191859, -0, -0.0871884301, -0, 1, -0, 0.0871884301, -0, 0.996191859)
                                                                        CFrameMon = CFrame.new(-4227.3, 1088.0, -567.6)
                                                                        if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4607.82275, 872.54248, -1667.55688))
                                                                        end
                                                                    elseif MyLevel >= 475 and MyLevel <= 524 or SelectMonster == "Shanda" then
                                                                        Mon = "Shanda"
                                                                        LevelQuest = 2
                                                                        NameQuest = "SkyExp1Quest"
                                                                        NameMon = "Shanda"
                                                                        CFrameQuest = CFrame.new(-4820.9, 936.8, -1152.0, -0.422592998, -0, 0.906319618, -0, 1, -0, -0.906319618, -0, -0.422592998)
                                                                        CFrameMon = CFrame.new(-5956.5, 5467.8, 1750.6)
                                                                        if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
                                                                        end
                                                                    elseif MyLevel >= 525 and MyLevel <= 549 or SelectMonster == "Royal Squad" then
                                                                        Mon = "Royal Squad"
                                                                        LevelQuest = 1
                                                                        NameQuest = "SkyExp2Quest"
                                                                        NameMon = "Royal Squad"
                                                                        CFrameQuest = CFrame.new(-5949.1, 5467.9, 2086.5, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                                        CFrameMon = CFrame.new(-6690.0, 5551.4, 1318.3)
                                                                    elseif (MyLevel < 550 or MyLevel > 624) and SelectMonster ~= "Royal Soldier" then
                                                                        if MyLevel >= 625 and MyLevel <= 649 or SelectMonster == "Galley Pirate" then
                                                                            Mon = "Galley Pirate"
                                                                            LevelQuest = 1
                                                                            NameQuest = "FountainQuest"
                                                                            NameMon = "Galley Pirate"
                                                                            CFrameQuest = CFrame.new(5263.5, 74.9, 4087.6, 0.087131381, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, 0.087131381)
                                                                            CFrameMon = CFrame.new(5670.7, 79.5, 4074.5)
                                                                        elseif MyLevel >= 650 or SelectMonster == "Galley Captain" then
                                                                            Mon = "Galley Captain"
                                                                            LevelQuest = 2
                                                                            NameQuest = "FountainQuest"
                                                                            NameMon = "Galley Captain"
                                                                            CFrameQuest = CFrame.new(5263.5, 74.9, 4087.6, 0.087131381, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, 0.087131381)
                                                                            CFrameMon = CFrame.new(5385.5, 77.3, 4851.1)
                                                                        end
                                                                    else
                                                                        Mon = "Royal Soldier"
                                                                        LevelQuest = 2
                                                                        NameQuest = "SkyExp2Quest"
                                                                        NameMon = "Royal Soldier"
                                                                        CFrameQuest = CFrame.new(-5949.1, 5467.9, 2086.5, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                                        CFrameMon = CFrame.new(-7138.5, 5541.1, 1050.8)
                                                                    end
                                                                else
                                                                    Mon = "Fishman Commando"
                                                                    LevelQuest = 2
                                                                    NameQuest = "FishmanQuest"
                                                                    NameMon = "Fishman Commando"
                                                                    CFrameQuest = CFrame.new(61406.2, 24.5, 1626.8)
                                                                    CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
                                                                    if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                                                                    end
                                                                end
                                                            else
                                                                Mon = "Fishman Warrior"
                                                                LevelQuest = 1
                                                                NameQuest = "FishmanQuest"
                                                                NameMon = "Fishman Warrior"
                                                                CFrameQuest = CFrame.new(61406.2, 24.5, 1626.8)
                                                                CFrameMon = CFrame.new(60736.8, 23.6, 1396.3)
                                                                if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                                                                end
                                                            end
                                                        else
                                                            Mon = "Military Spy"
                                                            LevelQuest = 2
                                                            NameQuest = "MagmaQuest"
                                                            NameMon = "Military Spy"
                                                            CFrameQuest = CFrame.new(-5308.9, 17.0, 8482.7, -0.499959469, -0, 0.866048813, -0, 1, -0, -0.866048813, -0, -0.499959469)
                                                            CFrameMon = CFrame.new(-5714.9, 76.0, 8834.9)
                                                        end
                                                    else
                                                        Mon = "Military Soldier"
                                                        LevelQuest = 1
                                                        NameQuest = "MagmaQuest"
                                                        NameMon = "Military Soldier"
                                                        CFrameQuest = CFrame.new(-5308.9, 17.0, 8482.7, -0.499959469, -0, 0.866048813, -0, 1, -0, -0.866048813, -0, -0.499959469)
                                                        CFrameMon = CFrame.new(-5418.5, 17.1, 8421.1)
                                                    end
                                                else
                                                    Mon = "Gladiator"
                                                    LevelQuest = 2
                                                    NameQuest = "ColosseumQuest"
                                                    NameMon = "Gladiator"
                                                    CFrameQuest = CFrame.new(-1342.3, 11.2, -2928.6, -0.515037298, -0, -0.857167721, -0, 1, -0, 0.857167721, -0, -0.515037298)
                                                    CFrameMon = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625)
                                                end
                                            else
                                                Mon = "Dangerous Prisoner"
                                                LevelQuest = 2
                                                NameQuest = "PrisonerQuest"
                                                NameMon = "Dangerous Prisoner"
                                                CFrameQuest = CFrame.new(5208.3, 18.9, 736.6, -0.0894274712, -5.00292918E-9, -0.995993316, 1.60817859E-9, 1, -5.16744869E-9, 0.995993316, -2.06384709E-9, -0.0894274712)
                                                CFrameMon = CFrame.new(5188.9, 9.1, 1058.1)
                                            end
                                        else
                                            Mon = "Dark Master"
                                            LevelQuest = 2
                                            NameQuest = "SkyQuest"
                                            NameMon = "Dark Master"
                                            CFrameQuest = CFrame.new(-4750.2, 966.1, -748.2, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                                            CFrameMon = CFrame.new(-5206.8, 502.9, -348.5)
                                        end
                                    else
                                        Mon = "Sky Bandit"
                                        LevelQuest = 1
                                        NameQuest = "SkyQuest"
                                        NameMon = "Sky Bandit"
                                        CFrameQuest = CFrame.new(-4750.2, 966.1, -748.2, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                                        CFrameMon = CFrame.new(-5221.6, 280.7, -1068.6)
                                    end
                                else
                                    Mon = "Chief Petty Officer"
                                    LevelQuest = 1
                                    NameQuest = "MarineQuest2"
                                    NameMon = "Chief Petty Officer"
                                    CFrameQuest = CFrame.new(-4699.3, 4.7, 4227.6, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                    CFrameMon = CFrame.new(-4763.7, 13.4, 4288.8)
                                end
                            else
                                Mon = "Snow Bandit"
                                LevelQuest = 1
                                NameQuest = "SnowQuest"
                                NameMon = "Snow Bandit"
                                CFrameQuest = CFrame.new(1400.6, 77.4, -1311.3, -0.342042685, -0, 0.939684391, -0, 1, -0, -0.939684391, -0, -0.342042685)
                                CFrameMon = CFrame.new(1431.8, 78.0, -1444.9)
                            end
                        else
                            Mon = "Desert Officer"
                            LevelQuest = 2
                            NameQuest = "DesertQuest"
                            NameMon = "Desert Officer"
                            CFrameQuest = CFrame.new(931.4, 4.7, 4198.2, 0.819155693, -0, -0.573571265, -0, 1, -0, 0.573571265, -0, 0.819155693)
                            CFrameMon = CFrame.new(1615.5, 14.2, 4187.4)
                        end
                    else
                        Mon = "Brute"
                        LevelQuest = 2
                        NameQuest = "BuggyQuest1"
                        NameMon = "Brute"
                        CFrameQuest = CFrame.new(-1151.6, 16.6, 3863.1, 0.965929627, -0, -0.258804798, -0, 1, -0, 0.258804798, -0, 0.965929627)
                        CFrameMon = CFrame.new(-1094.9, 26.0, 4442.9)
                    end
                else
                    Mon = "Pirate"
                    LevelQuest = 1
                    NameQuest = "BuggyQuest1"
                    NameMon = "Pirate"
                    CFrameQuest = CFrame.new(-1151.6, 16.6, 3863.1, 0.965929627, -0, -0.258804798, -0, 1, -0, 0.258804798, -0, 0.965929627)
                    CFrameMon = CFrame.new(-1285.1, 16.0, 3887.0)
                end
            else
                Mon = "Gorilla"
                LevelQuest = 2
                NameQuest = "JungleQuest"
                NameMon = "Gorilla"
                CFrameQuest = CFrame.new(-1679.8, 48.7, 175.6, -0, -0, 1, -0, 1, -0, -1, -0, -0)
                CFrameMon = CFrame.new(-1129.8836669921875, 40.46354675292969, -525.4237060546875)
            end
        else
            Mon = "Monkey"
            LevelQuest = 1
            NameQuest = "JungleQuest"
            NameMon = "Monkey"
            CFrameQuest = CFrame.new(-1679.8, 48.7, 175.6, -0, -0, 1, -0, 1, -0, -1, -0, -0)
            CFrameMon = CFrame.new(-1299.4, 17.6, 81.4)
        end
    elseif not World2 then
        if World3 then
            if MyLevel >= 1500 and MyLevel <= 1524 or SelectMonster == "Pirate Millionaire" then
                Mon = "Pirate Millionaire"
                LevelQuest = 1
                NameQuest = "PiratePortQuest"
                NameMon = "Pirate Millionaire"
                CFrameQuest = CFrame.new(-450.104645, 107.681458, 5950.72607, 0.957107544, -0, -0.289732844, -0, 1, -0, 0.289732844, -0, 0.957107544)
                CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)
            elseif (MyLevel < 1525 or MyLevel > 1574) and SelectMonster ~= "Pistol Billionaire" then
                if MyLevel >= 1575 and MyLevel <= 1599 or SelectMonster == "Dragon Crew Warrior" then
                    Mon = "Dragon Crew Warrior"
                    LevelQuest = 1
                    NameQuest = "DragonCrewQuest"
                    NameMon = "Dragon Crew Warrior"
                    CFrameQuest = CFrame.new(6750.4931640625, 127.44916534423828, -711.0308837890625)
                    CFrameMon = CFrame.new(6709.76367, 52.3442993, -1139.02966, -0.763515472, -0, 0.645789504, -0, 1, -0, -0.645789504, -0, -0.763515472)
                elseif MyLevel >= 1600 and MyLevel <= 1624 or SelectMonster == "Dragon Crew Archer" then
                    Mon = "Dragon Crew Archer"
                    NameQuest = "DragonCrewQuest"
                    LevelQuest = 2
                    NameMon = "Dragon Crew Archer"
                    CFrameQuest = CFrame.new(6750.4931640625, 127.44916534423828, -711.0308837890625)
                    CFrameMon = CFrame.new(6668.76172, 481.376923, 329.12207, -0.121787429, -0, -0.992556155, -0, 1, -0, 0.992556155, -0, -0.121787429)
                elseif (MyLevel < 1625 or MyLevel > 1649) and SelectMonster ~= "Hydra Enforcer" then
                    if (MyLevel < 1650 or MyLevel > 1699) and SelectMonster ~= "Venomous Assailant" then
                        if (MyLevel < 1700 or MyLevel > 1724) and SelectMonster ~= "Marine Commodore" then
                            if (MyLevel < 1725 or MyLevel > 1774) and SelectMonster ~= "Marine Rear Admiral" then
                                if (MyLevel < 1775 or MyLevel > 1799) and SelectMonster ~= "Fishman Raider" then
                                    if MyLevel >= 1800 and MyLevel <= 1824 or SelectMonster == "Fishman Captain" then
                                        Mon = "Fishman Captain"
                                        LevelQuest = 2
                                        NameQuest = "DeepForestIsland3"
                                        NameMon = "Fishman Captain"
                                        CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, -0, 0.469463557, -0, 1, -0, -0.469463557, -0, -0.882952213)
                                        CFrameMon = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625)
                                    elseif (MyLevel < 1825 or MyLevel > 1849) and SelectMonster ~= "Forest Pirate" then
                                        if (MyLevel < 1850 or MyLevel > 1899) and SelectMonster ~= "Mythological Pirate" then
                                            if MyLevel >= 1900 and MyLevel <= 1924 or SelectMonster == "Jungle Pirate" then
                                                Mon = "Jungle Pirate"
                                                LevelQuest = 1
                                                NameQuest = "DeepForestIsland2"
                                                NameMon = "Jungle Pirate"
                                                CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, -0.0871315002)
                                                CFrameMon = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625)
                                            elseif MyLevel >= 1925 and MyLevel <= 1974 or SelectMonster == "Musketeer Pirate" then
                                                Mon = "Musketeer Pirate"
                                                LevelQuest = 2
                                                NameQuest = "DeepForestIsland2"
                                                NameMon = "Musketeer Pirate"
                                                CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, -0.0871315002)
                                                CFrameMon = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375)
                                            elseif MyLevel >= 1975 and MyLevel <= 1999 or SelectMonster == "Reborn Skeleton" then
                                                Mon = "Reborn Skeleton"
                                                LevelQuest = 1
                                                NameQuest = "HauntedQuest1"
                                                NameMon = "Reborn Skeleton"
                                                CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, -0, -0, 1, -0, 1, -0, -1, -0, -0)
                                                CFrameMon = CFrame.new(-8763.7236328125, 165.72299194335938, 6159.86181640625)
                                            elseif (MyLevel < 2000 or MyLevel > 2024) and SelectMonster ~= "Living Zombie" then
                                                if MyLevel >= 2025 and MyLevel <= 2049 or SelectMonster == "Demonic Soul" then
                                                    Mon = "Demonic Soul"
                                                    LevelQuest = 1
                                                    NameQuest = "HauntedQuest2"
                                                    NameMon = "Demonic Soul"
                                                    CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                    CFrameMon = CFrame.new(-9505.8720703125, 172.10482788085938, 6158.9931640625)
                                                elseif MyLevel >= 2050 and MyLevel <= 2074 or SelectMonster == "Posessed Mummy" then
                                                    Mon = "Posessed Mummy"
                                                    LevelQuest = 2
                                                    NameQuest = "HauntedQuest2"
                                                    NameMon = "Posessed Mummy"
                                                    CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                    CFrameMon = CFrame.new(-9582.0224609375, 6.251527309417725, 6205.478515625)
                                                elseif (MyLevel < 2075 or MyLevel > 2099) and SelectMonster ~= "Peanut Scout" then
                                                    if MyLevel >= 2100 and MyLevel <= 2124 or SelectMonster == "Peanut President" then
                                                        Mon = "Peanut President"
                                                        LevelQuest = 2
                                                        NameQuest = "NutsIslandQuest"
                                                        NameMon = "Peanut President"
                                                        CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                        CFrameMon = CFrame.new(-1859.35400390625, 38.10316848754883, -10422.4296875)
                                                    elseif MyLevel >= 2125 and MyLevel <= 2149 or SelectMonster == "Ice Cream Chef" then
                                                        Mon = "Ice Cream Chef"
                                                        LevelQuest = 1
                                                        NameQuest = "IceCreamIslandQuest"
                                                        NameMon = "Ice Cream Chef"
                                                        CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                        CFrameMon = CFrame.new(-872.24658203125, 65.81957244873047, -10919.95703125)
                                                    elseif MyLevel >= 2150 and MyLevel <= 2199 or SelectMonster == "Ice Cream Commander" then
                                                        Mon = "Ice Cream Commander"
                                                        LevelQuest = 2
                                                        NameQuest = "IceCreamIslandQuest"
                                                        NameMon = "Ice Cream Commander"
                                                        CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                        CFrameMon = CFrame.new(-558.06103515625, 112.04895782470703, -11290.7744140625)
                                                    elseif MyLevel >= 2200 and MyLevel <= 2224 or SelectMonster == "Cookie Crafter" then
                                                        Mon = "Cookie Crafter"
                                                        LevelQuest = 1
                                                        NameQuest = "CakeQuest1"
                                                        NameMon = "Cookie Crafter"
                                                        CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053E-8, 0.288177818, 6.9301187E-8, 1, 7.51931211E-8, -0.288177818, -5.2032135E-8, 0.957576931)
                                                        CFrameMon = CFrame.new(-2374.13671875, 37.79826354980469, -12125.30859375)
                                                    elseif (MyLevel < 2225 or MyLevel > 2249) and SelectMonster ~= "Cake Guard" then
                                                        if MyLevel >= 2250 and MyLevel <= 2274 or SelectMonster == "Baking Staff" then
                                                            Mon = "Baking Staff"
                                                            LevelQuest = 1
                                                            NameQuest = "CakeQuest2"
                                                            NameMon = "Baking Staff"
                                                            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143E-8, 0.250778586, 4.74911062E-8, 1, 1.49904711E-8, -0.250778586, 2.64211941E-8, -0.96804446)
                                                            CFrameMon = CFrame.new(-1887.8099365234375, 77.6185073852539, -12998.3505859375)
                                                        elseif MyLevel >= 2275 and MyLevel <= 2299 or SelectMonster == "Head Baker" then
                                                            Mon = "Head Baker"
                                                            LevelQuest = 2
                                                            NameQuest = "CakeQuest2"
                                                            NameMon = "Head Baker"
                                                            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143E-8, 0.250778586, 4.74911062E-8, 1, 1.49904711E-8, -0.250778586, 2.64211941E-8, -0.96804446)
                                                            CFrameMon = CFrame.new(-2216.188232421875, 82.884521484375, -12869.2939453125)
                                                        elseif (MyLevel < 2300 or MyLevel > 2324) and SelectMonster ~= "Cocoa Warrior" then
                                                            if MyLevel >= 2325 and MyLevel <= 2349 or SelectMonster == "Chocolate Bar Battler" then
                                                                Mon = "Chocolate Bar Battler"
                                                                LevelQuest = 2
                                                                NameQuest = "ChocQuest1"
                                                                NameMon = "Chocolate Bar Battler"
                                                                CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
                                                                CFrameMon = CFrame.new(582.590576171875, 77.18809509277344, -12463.162109375)
                                                            elseif MyLevel >= 2350 and MyLevel <= 2374 or SelectMonster == "Sweet Thief" then
                                                                Mon = "Sweet Thief"
                                                                LevelQuest = 1
                                                                NameQuest = "ChocQuest2"
                                                                NameMon = "Sweet Thief"
                                                                CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
                                                                CFrameMon = CFrame.new(165.1884765625, 76.05885314941406, -12600.8369140625)
                                                            elseif MyLevel >= 2375 and MyLevel <= 2399 or SelectMonster == "Candy Rebel" then
                                                                Mon = "Candy Rebel"
                                                                LevelQuest = 2
                                                                NameQuest = "ChocQuest2"
                                                                NameMon = "Candy Rebel"
                                                                CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
                                                                CFrameMon = CFrame.new(134.86563110351562, 77.2476806640625, -12876.5478515625)
                                                            elseif (MyLevel < 2400 or MyLevel > 2424) and SelectMonster ~= "Candy Pirate" then
                                                                if MyLevel >= 2425 and MyLevel <= 2449 or SelectMonster == "Snow Demon" then
                                                                    Mon = "Snow Demon"
                                                                    LevelQuest = 2
                                                                    NameQuest = "CandyQuest1"
                                                                    NameMon = "Snow Demon"
                                                                    CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
                                                                    CFrameMon = CFrame.new(-880.2006225585938, 71.24776458740234, -14538.609375)
                                                                elseif MyLevel >= 2450 and MyLevel <= 2474 or SelectMonster == "Isle Outlaw" then
                                                                    Mon = "Isle Outlaw"
                                                                    LevelQuest = 1
                                                                    NameQuest = "TikiQuest1"
                                                                    NameMon = "Isle Outlaw"
                                                                    CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812)
                                                                    CFrameMon = CFrame.new(-16442.814453125, 116.13899993896484, -264.4637756347656)
                                                                elseif (MyLevel < 2475 or MyLevel > 2524) and SelectMonster ~= "Island Boy" then
                                                                    if MyLevel >= 2525 and MyLevel <= 2550 or SelectMonster == "Isle Champion" then
                                                                        Mon = "Isle Champion"
                                                                        LevelQuest = 2
                                                                        NameQuest = "TikiQuest2"
                                                                        NameMon = "Isle Champion"
                                                                        CFrameQuest = CFrame.new(-16539.078125, 55.68632888793945, 1051.5738525390625)
                                                                        CFrameMon = CFrame.new(-16641.6796875, 235.7825469970703, 1031.282958984375)
                                                                    elseif (MyLevel < 2550 or MyLevel > 2574) and SelectMonster ~= "Serpent Hunter" then
                                                                        if MyLevel >= 2575 or SelectMonster == "Skull Slayer" then
                                                                            Mon = "Skull Slayer"
                                                                            LevelQuest = 2
                                                                            NameQuest = "TikiQuest3"
                                                                            NameMon = "Skull Slayer"
                                                                            CFrameQuest = CFrame.new(-16665.1914, 104.596405, 1579.69434, 0.951068401, -0, -0.308980465, -0, 1, -0, 0.308980465, -0, 0.951068401)
                                                                            CFrameMon = CFrame.new(-16855.043, 122.457253, 1478.15308, -0.999392271, -0, -0.0348687991, -0, 1, -0, 0.0348687991, -0, -0.999392271)
                                                                        end
                                                                    else
                                                                        Mon = "Serpent Hunter"
                                                                        LevelQuest = 1
                                                                        NameQuest = "TikiQuest3"
                                                                        NameMon = "Serpent Hunter"
                                                                        CFrameQuest = CFrame.new(-16665.1914, 104.596405, 1579.69434, 0.951068401, -0, -0.308980465, -0, 1, -0, 0.308980465, -0, 0.951068401)
                                                                        CFrameMon = CFrame.new(-16521.0625, 106.09285, 1488.78467, 0.469467044, -0, 0.882950008, -0, 1, -0, -0.882950008, -0, 0.469467044)
                                                                    end
                                                                else
                                                                    Mon = "Island Boy"
                                                                    LevelQuest = 2
                                                                    NameQuest = "TikiQuest1"
                                                                    NameMon = "Island Boy"
                                                                    CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812)
                                                                    CFrameMon = CFrame.new(-16901.26171875, 84.06756591796875, -192.88906860351562)
                                                                end
                                                            else
                                                                Mon = "Candy Pirate"
                                                                LevelQuest = 1
                                                                NameQuest = "CandyQuest1"
                                                                NameMon = "Candy Pirate"
                                                                CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
                                                                CFrameMon = CFrame.new(-1310.5003662109375, 26.016523361206055, -14562.404296875)
                                                            end
                                                        else
                                                            Mon = "Cocoa Warrior"
                                                            LevelQuest = 1
                                                            NameQuest = "ChocQuest1"
                                                            NameMon = "Cocoa Warrior"
                                                            CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
                                                            CFrameMon = CFrame.new(-21.55328369140625, 80.57499694824219, -12352.3876953125)
                                                        end
                                                    else
                                                        Mon = "Cake Guard"
                                                        LevelQuest = 2
                                                        NameQuest = "CakeQuest1"
                                                        NameMon = "Cake Guard"
                                                        CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053E-8, 0.288177818, 6.9301187E-8, 1, 7.51931211E-8, -0.288177818, -5.2032135E-8, 0.957576931)
                                                        CFrameMon = CFrame.new(-1598.3070068359375, 43.773197174072266, -12244.5810546875)
                                                    end
                                                else
                                                    Mon = "Peanut Scout"
                                                    LevelQuest = 1
                                                    NameQuest = "NutsIslandQuest"
                                                    NameMon = "Peanut Scout"
                                                    CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                    CFrameMon = CFrame.new(-2143.241943359375, 47.72198486328125, -10029.9951171875)
                                                end
                                            else
                                                Mon = "Living Zombie"
                                                LevelQuest = 2
                                                NameQuest = "HauntedQuest1"
                                                NameMon = "Living Zombie"
                                                CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, -0, -0, 1, -0, 1, -0, -1, -0, -0)
                                                CFrameMon = CFrame.new(-10144.1318359375, 138.62667846679688, 5838.0888671875)
                                            end
                                        else
                                            Mon = "Mythological Pirate"
                                            LevelQuest = 2
                                            NameQuest = "DeepForestIsland"
                                            NameMon = "Mythological Pirate"
                                            CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, -0, 1, -0, 0.707079291, -0, 0.707134247)
                                            CFrameMon = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125)
                                        end
                                    else
                                        Mon = "Forest Pirate"
                                        LevelQuest = 1
                                        NameQuest = "DeepForestIsland"
                                        NameMon = "Forest Pirate"
                                        CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, -0, 1, -0, 0.707079291, -0, 0.707134247)
                                        CFrameMon = CFrame.new(-13274.478515625, 332.3781433105469, -7769.58056640625)
                                    end
                                else
                                    Mon = "Fishman Raider"
                                    LevelQuest = 1
                                    NameQuest = "DeepForestIsland3"
                                    NameMon = "Fishman Raider"
                                    CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, -0, 0.469463557, -0, 1, -0, -0.469463557, -0, -0.882952213)
                                    CFrameMon = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625)
                                end
                            else
                                Mon = "Marine Rear Admiral"
                                LevelQuest = 2
                                NameQuest = "MarineTreeIsland"
                                NameMon = "Marine Rear Admiral"
                                CFrameQuest = CFrame.new(2481.09228515625, 74.27049255371094, -6779.640625)
                                CFrameMon = CFrame.new(3761.81006, 123.912003, -6823.52197, 0.961273968, -0, 0.275594592, -0, 1, -0, -0.275594592, -0, 0.961273968)
                            end
                        else
                            Mon = "Marine Commodore"
                            LevelQuest = 1
                            NameQuest = "MarineTreeIsland"
                            NameMon = "Marine Commodore"
                            CFrameQuest = CFrame.new(2481.09228515625, 74.27049255371094, -6779.640625)
                            CFrameMon = CFrame.new(2577.25391, 75.6100006, -7739.87207, 0.499959469, -0, 0.866048813, -0, 1, -0, -0.866048813, -0, 0.499959469)
                        end
                    else
                        Mon = "Venomous Assailant"
                        NameQuest = "VenomCrewQuest"
                        LevelQuest = 2
                        NameMon = "Venomous Assailant"
                        CFrameQuest = CFrame.new(5206.40185546875, 1004.10498046875, 748.3504638671875)
                        CFrameMon = CFrame.new(4674.92676, 1134.82654, 996.308838, 0.731321394, -0, -0.682033002, -0, 1, -0, 0.682033002, -0, 0.731321394)
                    end
                else
                    Mon = "Hydra Enforcer"
                    NameQuest = "VenomCrewQuest"
                    LevelQuest = 1
                    NameMon = "Hydra Enforcer"
                    CFrameQuest = CFrame.new(5206.40185546875, 1004.10498046875, 748.3504638671875)
                    CFrameMon = CFrame.new(4547.11523, 1003.10217, 334.194824, 0.388810456, -0, -0.921317935, -0, 1, -0, 0.921317935, -0, 0.388810456)
                end
            else
                Mon = "Pistol Billionaire"
                LevelQuest = 2
                NameQuest = "PiratePortQuest"
                NameMon = "Pistol Billionaire"
                CFrameQuest = CFrame.new(-450.104645, 107.681458, 5950.72607, 0.957107544, -0, -0.289732844, -0, 1, -0, 0.289732844, -0, 0.957107544)
                CFrameMon = CFrame.new(-54.8110352, 83.7698746, 5947.84082, -0.965929747, -0, 0.258804798, -0, 1, -0, -0.258804798, -0, -0.965929747)
            end
        end
    elseif (MyLevel < 700 or MyLevel > 724) and SelectMonster ~= "Raider" then
        if MyLevel >= 725 and MyLevel <= 774 or SelectMonster == "Mercenary" then
            Mon = "Mercenary"
            LevelQuest = 2
            NameQuest = "Area1Quest"
            NameMon = "Mercenary"
            CFrameQuest = CFrame.new(-628.8, 3.6, 1512.5, -0.22495985, -0, -0.974368095, -0, 1, -0, 0.974368095, -0, -0.22495985)
            CFrameMon = CFrame.new(-1004.3244018554688, 80.15886688232422, 1424.619384765625)
        elseif MyLevel >= 775 and MyLevel <= 799 or SelectMonster == "Swan Pirate" then
            Mon = "Swan Pirate"
            LevelQuest = 1
            NameQuest = "Area2Quest"
            NameMon = "Swan Pirate"
            CFrameQuest = CFrame.new(873.6, 1.8, 1322.4, 0.139203906, -0, 0.99026376, -0, 1, -0, -0.99026376, -0, 0.139203906)
            CFrameMon = CFrame.new(928.0, 13.2, 1597.3)
        elseif (MyLevel < 800 or MyLevel > 874) and SelectMonster ~= "Factory Staff" then
            if MyLevel >= 875 and MyLevel <= 899 or SelectMonster == "Marine Lieutenant" then
                Mon = "Marine Lieutenant"
                LevelQuest = 1
                NameQuest = "MarineQuest3"
                NameMon = "Marine Lieutenant"
                CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                CFrameMon = CFrame.new(-2821.372314453125, 75.89727783203125, -3070.089111328125)
            elseif MyLevel >= 900 and MyLevel <= 949 or SelectMonster == "Marine Captain" then
                Mon = "Marine Captain"
                LevelQuest = 2
                NameQuest = "MarineQuest3"
                NameMon = "Marine Captain"
                CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                CFrameMon = CFrame.new(-1861.2310791015625, 80.17658233642578, -3254.697509765625)
            elseif (MyLevel < 950 or MyLevel > 974) and SelectMonster ~= "Zombie" then
                if MyLevel >= 975 and MyLevel <= 999 or SelectMonster == "Vampire" then
                    Mon = "Vampire"
                    LevelQuest = 2
                    NameQuest = "ZombieQuest"
                    NameMon = "Vampire"
                    CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, -0, -0.95628953, -0, 1, -0, 0.95628953, -0, -0.29242146)
                    CFrameMon = CFrame.new(-6037.66796875, 32.18463897705078, -1340.6597900390625)
                elseif (MyLevel < 1000 or MyLevel > 1049) and SelectMonster ~= "Snow Trooper" then
                    if MyLevel >= 1050 and MyLevel <= 1099 or SelectMonster == "Winter Warrior" then
                        Mon = "Winter Warrior"
                        LevelQuest = 2
                        NameQuest = "SnowMountainQuest"
                        NameMon = "Winter Warrior"
                        CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, -0, 0.92718488, -0, 1, -0, -0.92718488, -0, -0.374604106)
                        CFrameMon = CFrame.new(1142.7451171875, 475.6398010253906, -5199.41650390625)
                    elseif MyLevel >= 1100 and MyLevel <= 1124 or SelectMonster == "Lab Subordinate" then
                        Mon = "Lab Subordinate"
                        LevelQuest = 1
                        NameQuest = "IceSideQuest"
                        NameMon = "Lab Subordinate"
                        CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, -0, 1, -0, 0.891015649, -0, 0.453972578)
                        CFrameMon = CFrame.new(-5707.4716796875, 15.951709747314453, -4513.39208984375)
                    elseif MyLevel >= 1125 and MyLevel <= 1174 or SelectMonster == "Horned Warrior" then
                        Mon = "Horned Warrior"
                        LevelQuest = 2
                        NameQuest = "IceSideQuest"
                        NameMon = "Horned Warrior"
                        CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, -0, 1, -0, 0.891015649, -0, 0.453972578)
                        CFrameMon = CFrame.new(-6341.36669921875, 15.951770782470703, -5723.162109375)
                    elseif (MyLevel < 1175 or MyLevel > 1199) and SelectMonster ~= "Magma Ninja" then
                        if (MyLevel < 1200 or MyLevel > 1249) and SelectMonster ~= "Lava Pirate" then
                            if MyLevel >= 1250 and MyLevel <= 1274 or SelectMonster == "Ship Deckhand" then
                                Mon = "Ship Deckhand"
                                LevelQuest = 1
                                NameQuest = "ShipQuest1"
                                NameMon = "Ship Deckhand"
                                CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
                                CFrameMon = CFrame.new(1212.0111083984375, 150.79205322265625, 33059.24609375)
                                if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                                end
                            elseif (MyLevel < 1275 or MyLevel > 1299) and SelectMonster ~= "Ship Engineer" then
                                if MyLevel >= 1300 and MyLevel <= 1324 or SelectMonster == "Ship Steward" then
                                    Mon = "Ship Steward"
                                    LevelQuest = 1
                                    NameQuest = "ShipQuest2"
                                    NameMon = "Ship Steward"
                                    CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
                                    CFrameMon = CFrame.new(919.4385375976562, 129.55599975585938, 33436.03515625)
                                    if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                                    end
                                elseif (MyLevel < 1325 or MyLevel > 1349) and SelectMonster ~= "Ship Officer" then
                                    if (MyLevel < 1350 or MyLevel > 1374) and SelectMonster ~= "Arctic Warrior" then
                                        if MyLevel >= 1375 and MyLevel <= 1424 or SelectMonster == "Snow Lurker" then
                                            Mon = "Snow Lurker"
                                            LevelQuest = 2
                                            NameQuest = "FrostQuest"
                                            NameMon = "Snow Lurker"
                                            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, -0, -0.358349502, -0, 1, -0, 0.358349502, -0, -0.933587909)
                                            CFrameMon = CFrame.new(5407.07373046875, 69.19437408447266, -6880.88037109375)
                                        elseif (MyLevel < 1425 or MyLevel > 1449) and SelectMonster ~= "Sea Soldier" then
                                            if MyLevel >= 1450 or SelectMonster == "Water Fighter" then
                                                Mon = "Water Fighter"
                                                LevelQuest = 2
                                                NameQuest = "ForgottenQuest"
                                                NameMon = "Water Fighter"
                                                CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, -0, 1, -0, 0.13915664, -0, 0.990270376)
                                                CFrameMon = CFrame.new(-3352.9013671875, 285.01556396484375, -10534.841796875)
                                            end
                                        else
                                            Mon = "Sea Soldier"
                                            LevelQuest = 1
                                            NameQuest = "ForgottenQuest"
                                            NameMon = "Sea Soldier"
                                            CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, -0, 1, -0, 0.13915664, -0, 0.990270376)
                                            CFrameMon = CFrame.new(-3028.2236328125, 64.67451477050781, -9775.4267578125)
                                        end
                                    else
                                        Mon = "Arctic Warrior"
                                        LevelQuest = 1
                                        NameQuest = "FrostQuest"
                                        NameMon = "Arctic Warrior"
                                        CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, -0, -0.358349502, -0, 1, -0, 0.358349502, -0, -0.933587909)
                                        CFrameMon = CFrame.new(5966.24609375, 62.97002029418945, -6179.3828125)
                                        if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-6508.5581054688, 5000.034996032715, -132.83953857422))
                                        end
                                    end
                                else
                                    Mon = "Ship Officer"
                                    LevelQuest = 2
                                    NameQuest = "ShipQuest2"
                                    NameMon = "Ship Officer"
                                    CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
                                    CFrameMon = CFrame.new(1036.0179443359375, 181.4390411376953, 33315.7265625)
                                    if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                                    end
                                end
                            else
                                Mon = "Ship Engineer"
                                LevelQuest = 2
                                NameQuest = "ShipQuest1"
                                NameMon = "Ship Engineer"
                                CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
                                CFrameMon = CFrame.new(919.4786376953125, 43.54401397705078, 32779.96875)
                                if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                                end
                            end
                        else
                            Mon = "Lava Pirate"
                            LevelQuest = 2
                            NameQuest = "FireSideQuest"
                            NameMon = "Lava Pirate"
                            CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, -0, 0.469463557, -0, 1, -0, -0.469463557, -0, -0.882952213)
                            CFrameMon = CFrame.new(-5213.33154296875, 49.73788070678711, -4701.451171875)
                        end
                    else
                        Mon = "Magma Ninja"
                        LevelQuest = 1
                        NameQuest = "FireSideQuest"
                        NameMon = "Magma Ninja"
                        CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, -0, 0.469463557, -0, 1, -0, -0.469463557, -0, -0.882952213)
                        CFrameMon = CFrame.new(-5449.6728515625, 76.65874481201172, -5808.20068359375)
                    end
                else
                    Mon = "Snow Trooper"
                    LevelQuest = 1
                    NameQuest = "SnowMountainQuest"
                    NameMon = "Snow Trooper"
                    CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, -0, 0.92718488, -0, 1, -0, -0.92718488, -0, -0.374604106)
                    CFrameMon = CFrame.new(549.1473388671875, 427.3870544433594, -5563.69873046875)
                end
            else
                Mon = "Zombie"
                LevelQuest = 1
                NameQuest = "ZombieQuest"
                NameMon = "Zombie"
                CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, -0, -0.95628953, -0, 1, -0, 0.95628953, -0, -0.29242146)
                CFrameMon = CFrame.new(-5221.6, 280.7, -1068.6)
            end
        else
            Mon = "Factory Staff"
            NameQuest = "Area2Quest"
            LevelQuest = 2
            NameMon = "Factory Staff"
            CFrameQuest = CFrame.new(873.6, 1.8, 1322.4, -0.0319722369, 8.96074881E-10, -0.999488771, 1.36326533E-10, 1, 8.92172336E-10, 0.999488771, -1.07732087E-10, -0.0319722369)
            CFrameMon = CFrame.new(73.07867431640625, 81.86344146728516, -27.470672607421875)
        end
    else
        Mon = "Raider"
        LevelQuest = 1
        NameQuest = "Area1Quest"
        NameMon = "Raider"
        CFrameQuest = CFrame.new(-628.8, 3.6, 1512.5, -0.22495985, -0, -0.974368095, -0, 1, -0, 0.974368095, -0, -0.22495985)
        CFrameMon = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125)
    end
end
function Hop()
    local l_PlaceId_0 = game.PlaceId
    local v1 = {}
    local v2 = ""
    local l_hour_0 = os.date("!*t").hour
    local _ = false
    function TPReturner()
        local v5
        if v2 ~= "" then
            v5 = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. l_PlaceId_0 .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. v2))
        else
            v5 = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. l_PlaceId_0 .. "/servers/Public?sortOrder=Asc&limit=100"))
        end
        local v6 = ""
        if v5.nextPageCursor and v5.nextPageCursor ~= "null" and v5.nextPageCursor ~= "null" then
            v2 = v5.nextPageCursor
        end
        local v7 = 0
        for _, v9 in pairs(v5.data) do
            local v10 = true
            v6 = tostring(v9.id)
            if tonumber(v9.maxPlayers) > tonumber(v9.playing) then
                for _, v12 in pairs(v1) do
                    if v7 ~= 0 then
                        if v6 == tostring(v12) then
                            v10 = false
                        end
                    elseif tonumber(l_hour_0) ~= tonumber(v12) then
                        local _ = pcall(function()
                            v1 = {}
                            table.insert(v1, l_hour_0)
                        end)
                    end
                    v7 = v7 + 1
                end
                if v10 == true then
                    table.insert(v1, v6)
                    wait(0.1)
                    pcall(function()
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(l_PlaceId_0, v6, game.Players.LocalPlayer)
                    end)
                    wait(0.1)
                end
            end
        end
    end
    function Teleport()
        while wait(0.1) do
            pcall(function()
                TPReturner()
                if v2 ~= "" then
                    TPReturner()
                end
            end)
        end
    end
    Teleport()
end
function CheckItem(v14)
    for _, v16 in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
        if v16.Name == v14 then
            return v16
        end
    end
end
function UpdateIslandESP()
    for _, v18 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v18_0 = v18
            pcall(function()
                if IslandESP then
                    if l_v18_0.Name ~= "Sea" then
                        if not l_v18_0:FindFirstChild("NameEsp") then
                            local v20 = Instance.new("BillboardGui", l_v18_0)
                            v20.Name = "NameEsp"
                            v20.ExtentsOffset = Vector3.new(0, 1, 0)
                            v20.Size = UDim2.new(1, 200, 1, 30)
                            v20.Adornee = l_v18_0
                            v20.AlwaysOnTop = true
                            local v21 = Instance.new("TextLabel", v20)
                            v21.Font = "GothamSemibold"
                            v21.FontSize = "Size14"
                            v21.TextWrapped = true
                            v21.Size = UDim2.new(1, 0, 1, 0)
                            v21.TextYAlignment = "Top"
                            v21.BackgroundTransparency = 1
                            v21.TextStrokeTransparency = 0.5
                            v21.TextColor3 = Color3.fromRGB(255, 255, 255)
                        else
                            l_v18_0.NameEsp.TextLabel.Text = l_v18_0.Name .. "   \n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v18_0.Position).Magnitude / 3) .. " Distance"
                        end
                    end
                elseif l_v18_0:FindFirstChild("NameEsp") then
                    l_v18_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end
function isnil(v22)
    local v23 = nil
    if v22 ~= v23 then
        local _ = false
    end
    return true
end
local function v26(v25)
    return math.floor(tonumber(v25) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
    for _, v28 in pairs(game:GetService("Players"):GetChildren()) do
        do
            local l_v28_0 = v28
            pcall(function()
                if not isnil(l_v28_0.Character) then
                    if not ESPPlayer then
                        if l_v28_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            l_v28_0.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                        end
                    elseif not isnil(l_v28_0.Character.Head) and not l_v28_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        local v30 = Instance.new("BillboardGui", l_v28_0.Character.Head)
                        v30.Name = "NameEsp" .. Number
                        v30.ExtentsOffset = Vector3.new(0, 1, 0)
                        v30.Size = UDim2.new(1, 200, 1, 30)
                        v30.Adornee = l_v28_0.Character.Head
                        v30.AlwaysOnTop = true
                        local v31 = Instance.new("TextLabel", v30)
                        v31.Font = Enum.Font.GothamSemibold
                        v31.FontSize = "Size14"
                        v31.TextWrapped = true
                        v31.Text = l_v28_0.Name .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v28_0.Character.Head.Position).Magnitude / 3) .. " Distance"
                        v31.Size = UDim2.new(1, 0, 1, 0)
                        v31.TextYAlignment = "Top"
                        v31.BackgroundTransparency = 1
                        v31.TextStrokeTransparency = 0.5
                        if l_v28_0.Team == game.Players.LocalPlayer.Team then
                            v31.TextColor3 = Color3.new(0, 255, 0)
                        else
                            v31.TextColor3 = Color3.new(255, 0, 0)
                        end
                    else
                        l_v28_0.Character.Head["NameEsp" .. Number].TextLabel.Text = l_v28_0.Name .. " | " .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v28_0.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v26(l_v28_0.Character.Humanoid.Health * 100 / l_v28_0.Character.Humanoid.MaxHealth) .. "%"
                    end
                end
            end)
        end
    end
end
function UpdateChestESP()
    for _, v33 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v33_0 = v33
            pcall(function()
                if _G.ChestESP then
                    if not l_v33_0:GetAttribute("IsDisabled") then
                        if not l_v33_0:FindFirstChild("ChestEsp") then
                            local v35 = Instance.new("BillboardGui", l_v33_0)
                            v35.Name = "ChestEsp"
                            v35.ExtentsOffset = Vector3.new(0, 1, 0)
                            v35.Size = UDim2.new(1, 200, 1, 30)
                            v35.Adornee = l_v33_0
                            v35.AlwaysOnTop = true
                            local v36 = Instance.new("TextLabel", v35)
                            v36.Font = "Code"
                            v36.FontSize = "Size14"
                            v36.TextWrapped = true
                            v36.Size = UDim2.new(1, 0, 1, 0)
                            v36.TextYAlignment = "Top"
                            v36.BackgroundTransparency = 1
                            v36.TextStrokeTransparency = 0.5
                            v36.TextColor3 = Color3.fromRGB(255, 215, 0)
                        else
                            local v37 = v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v33_0:GetPivot().Position).Magnitude / 3)
                            l_v33_0.ChestEsp.TextLabel.Text = "Chest\n" .. v37 .. " M"
                        end
                    end
                elseif l_v33_0:FindFirstChild("ChestEsp") then
                    l_v33_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end
function v26(v38)
    return math.floor(v38 + 0.5)
end
function UpdateDevilChams()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character
    if not Character or not Character:FindFirstChild("Head") then return end

    for _, v in pairs(workspace:GetChildren()) do
        pcall(function()
            if v:IsA("Tool") and string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
                local handle = v.Handle
                local espName = "NameEsp" .. Number
                local distance = math.floor((Character.Head.Position - handle.Position).Magnitude)

                if DevilFruitESP then
                    if not handle:FindFirstChild(espName) then
                        local bill = Instance.new("BillboardGui")
                        bill.Name = espName
                        bill.Size = UDim2.new(0, 220, 0, 40)
                        bill.ExtentsOffset = Vector3.new(0, 1.5, 0)
                        bill.AlwaysOnTop = true
                        bill.Adornee = handle
                        bill.Parent = handle

                        local text = Instance.new("TextLabel")
                        text.Size = UDim2.new(1, 0, 1, 0)
                        text.BackgroundTransparency = 1
                        text.TextScaled = true
                        text.Font = Enum.Font.GothamBold
                        text.TextColor3 = Color3.fromRGB(120, 0, 0)
                        text.TextStrokeTransparency = 0
                        text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                        text.Parent = bill
                    end

                    handle[espName].TextLabel.Text = "Fruit | " .. v.Name .. " | < " .. distance .. " >"
                    handle[espName].TextLabel.TextColor3 = Color3.fromRGB(120, 0, 0)
                else
                    if handle:FindFirstChild(espName) then
                        handle[espName]:Destroy()
                    end
                end
            end
        end)
    end
end
function UpdateFlowerChams()
    for _, v45 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v45_0 = v45
            pcall(function()
                if l_v45_0.Name == "Flower2" or l_v45_0.Name == "Flower1" then
                    if FlowerESP then
                        if l_v45_0:FindFirstChild("NameEsp" .. Number) then
                            l_v45_0["NameEsp" .. Number].TextLabel.Text = l_v45_0.Name .. "   \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v45_0.Position).Magnitude / 3) .. " Distance"
                        else
                            local v47 = Instance.new("BillboardGui", l_v45_0)
                            v47.Name = "NameEsp" .. Number
                            v47.ExtentsOffset = Vector3.new(0, 1, 0)
                            v47.Size = UDim2.new(1, 200, 1, 30)
                            v47.Adornee = l_v45_0
                            v47.AlwaysOnTop = true
                            local v48 = Instance.new("TextLabel", v47)
                            v48.Font = Enum.Font.GothamSemibold
                            v48.FontSize = "Size14"
                            v48.TextWrapped = true
                            v48.Size = UDim2.new(1, 0, 1, 0)
                            v48.TextYAlignment = "Top"
                            v48.BackgroundTransparency = 1
                            v48.TextStrokeTransparency = 0.5
                            v48.TextColor3 = Color3.fromRGB(255, 0, 0)
                            if l_v45_0.Name == "Flower1" then
                                v48.Text = "Blue Flower" .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v45_0.Position).Magnitude / 3) .. " Distance"
                                v48.TextColor3 = Color3.fromRGB(0, 0, 255)
                            end
                            if l_v45_0.Name == "Flower2" then
                                v48.Text = "Red Flower" .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v45_0.Position).Magnitude / 3) .. " Distance"
                                v48.TextColor3 = Color3.fromRGB(255, 0, 0)
                            end
                        end
                    elseif l_v45_0:FindFirstChild("NameEsp" .. Number) then
                        l_v45_0:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end
function UpdateRealFruitChams()
    for _, v50 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v50:IsA("Tool") then
            if not RealFruitESP then
                if v50.Handle:FindFirstChild("NameEsp" .. Number) then
                    v50.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif v50.Handle:FindFirstChild("NameEsp" .. Number) then
                v50.Handle["NameEsp" .. Number].TextLabel.Text = v50.Name .. " " .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v50.Handle.Position).Magnitude / 3) .. " Distance"
            else
                local v51 = Instance.new("BillboardGui", v50.Handle)
                v51.Name = "NameEsp" .. Number
                v51.ExtentsOffset = Vector3.new(0, 1, 0)
                v51.Size = UDim2.new(1, 200, 1, 30)
                v51.Adornee = v50.Handle
                v51.AlwaysOnTop = true
                local v52 = Instance.new("TextLabel", v51)
                v52.Font = Enum.Font.GothamSemibold
                v52.FontSize = "Size14"
                v52.TextWrapped = true
                v52.Size = UDim2.new(1, 0, 1, 0)
                v52.TextYAlignment = "Top"
                v52.BackgroundTransparency = 1
                v52.TextStrokeTransparency = 0.5
                v52.TextColor3 = Color3.fromRGB(255, 0, 0)
                v52.Text = v50.Name .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v50.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
    for _, v54 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v54:IsA("Tool") then
            if RealFruitESP then
                if v54.Handle:FindFirstChild("NameEsp" .. Number) then
                    v54.Handle["NameEsp" .. Number].TextLabel.Text = v54.Name .. " " .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v54.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v55 = Instance.new("BillboardGui", v54.Handle)
                    v55.Name = "NameEsp" .. Number
                    v55.ExtentsOffset = Vector3.new(0, 1, 0)
                    v55.Size = UDim2.new(1, 200, 1, 30)
                    v55.Adornee = v54.Handle
                    v55.AlwaysOnTop = true
                    local v56 = Instance.new("TextLabel", v55)
                    v56.Font = Enum.Font.GothamSemibold
                    v56.FontSize = "Size14"
                    v56.TextWrapped = true
                    v56.Size = UDim2.new(1, 0, 1, 0)
                    v56.TextYAlignment = "Top"
                    v56.BackgroundTransparency = 1
                    v56.TextStrokeTransparency = 0.5
                    v56.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v56.Text = v54.Name .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v54.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v54.Handle:FindFirstChild("NameEsp" .. Number) then
                v54.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v58 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v58:IsA("Tool") then
            if RealFruitESP then
                if not v58.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v59 = Instance.new("BillboardGui", v58.Handle)
                    v59.Name = "NameEsp" .. Number
                    v59.ExtentsOffset = Vector3.new(0, 1, 0)
                    v59.Size = UDim2.new(1, 200, 1, 30)
                    v59.Adornee = v58.Handle
                    v59.AlwaysOnTop = true
                    local v60 = Instance.new("TextLabel", v59)
                    v60.Font = Enum.Font.GothamSemibold
                    v60.FontSize = "Size14"
                    v60.TextWrapped = true
                    v60.Size = UDim2.new(1, 0, 1, 0)
                    v60.TextYAlignment = "Top"
                    v60.BackgroundTransparency = 1
                    v60.TextStrokeTransparency = 0.5
                    v60.TextColor3 = Color3.fromRGB(251, 255, 0)
                    v60.Text = v58.Name .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v58.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v58.Handle["NameEsp" .. Number].TextLabel.Text = v58.Name .. " " .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v58.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v58.Handle:FindFirstChild("NameEsp" .. Number) then
                v58.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
end
function UpdateIslandESP()
    for _, v62 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v62_0 = v62
            pcall(function()
                if IslandESP then
                    if l_v62_0.Name ~= "Sea" then
                        if not l_v62_0:FindFirstChild("NameEsp") then
                            local v64 = Instance.new("BillboardGui", l_v62_0)
                            v64.Name = "NameEsp"
                            v64.ExtentsOffset = Vector3.new(0, 1, 0)
                            v64.Size = UDim2.new(1, 200, 1, 30)
                            v64.Adornee = l_v62_0
                            v64.AlwaysOnTop = true
                            local v65 = Instance.new("TextLabel", v64)
                            v65.Font = "GothamSemibold"
                            v65.FontSize = "Size14"
                            v65.TextWrapped = true
                            v65.Size = UDim2.new(1, 0, 1, 0)
                            v65.TextYAlignment = "Top"
                            v65.BackgroundTransparency = 1
                            v65.TextStrokeTransparency = 0.5
                            v65.TextColor3 = Color3.fromRGB(8, 247, 255)
                        else
                            l_v62_0.NameEsp.TextLabel.Text = l_v62_0.Name .. "   \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v62_0.Position).Magnitude / 3) .. " Distance"
                        end
                    end
                elseif l_v62_0:FindFirstChild("NameEsp") then
                    l_v62_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end
function isnil(v66)
    local v67 = nil
    if v66 ~= v67 then
        local _ = false
    end
    return true
end
local function v70(v69)
    return math.floor(tonumber(v69) + 0.5)
end
Number = math.random(1, 1000000)

Players = game:GetService("Players")
RunService = game:GetService("RunService")
LocalPlayer = Players.LocalPlayer

ESPConnections = {}

function UpdatePlayerChams()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            pcall(function()
                local char = player.Character
                if not char then return end

                local hrp = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChild("Humanoid")
                if not hrp or not hum then return end
                if not ESPPlayer then
                    if hrp:FindFirstChild("PlayerESP") then
                        hrp.PlayerESP:Destroy()
                    end
                    if ESPConnections[player] then
                        ESPConnections[player]:Disconnect()
                        ESPConnections[player] = nil
                    end
                    return
                end

                if hrp:FindFirstChild("PlayerESP") then return end

                local gui = Instance.new("BillboardGui")
                gui.Name = "PlayerESP"
                gui.Adornee = hrp
                gui.Size = UDim2.new(0, 200, 0, 50)
                gui.StudsOffset = Vector3.new(0, 2.5, 0)
                gui.AlwaysOnTop = true
                gui.Parent = hrp

                local nameLabel = Instance.new("TextLabel")
                nameLabel.BackgroundTransparency = 1
                nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
                nameLabel.TextStrokeTransparency = 0
                nameLabel.TextScaled = true
                nameLabel.Font = Enum.Font.SourceSansBold
                nameLabel.Parent = gui

                local hpLabel = Instance.new("TextLabel")
                hpLabel.BackgroundTransparency = 1
                hpLabel.Size = UDim2.new(1, 0, 0.5, 0)
                hpLabel.Position = UDim2.new(0, 0, 0.5, 0)
                hpLabel.TextStrokeTransparency = 0
                hpLabel.TextScaled = true
                hpLabel.Font = Enum.Font.SourceSansBold
                hpLabel.Parent = gui

                ESPConnections[player] = RunService.RenderStepped:Connect(function()
                    if not ESPPlayer or not char or not hrp or not hum or hum.Health <= 0 then
                        gui.Enabled = false
                        return
                    end

                    gui.Enabled = true

                    local dist = math.floor(
                        (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                    )

                    nameLabel.Text = player.Name .. " [" .. dist .. "m]"
                    hpLabel.Text = "[" .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth) .. "]"

                    if player.Team == LocalPlayer.Team then
                        nameLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    else
                        nameLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                    end
                end)
            end)
        end
    end
end
function UpdateChestESP()
    for _, v77 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v77_0 = v77
            pcall(function()
                if _G.ChestESP then
                    if not l_v77_0:GetAttribute("IsDisabled") then
                        if l_v77_0:FindFirstChild("ChestEsp") then
                            local v79 = v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v77_0:GetPivot().Position).Magnitude / 3)
                            l_v77_0.ChestEsp.TextLabel.Text = "Chest\n" .. v79 .. " M"
                        else
                            local v80 = Instance.new("BillboardGui", l_v77_0)
                            v80.Name = "ChestEsp"
                            v80.ExtentsOffset = Vector3.new(0, 1, 0)
                            v80.Size = UDim2.new(1, 200, 1, 30)
                            v80.Adornee = l_v77_0
                            v80.AlwaysOnTop = true
                            local v81 = Instance.new("TextLabel", v80)
                            v81.Font = "Code"
                            v81.FontSize = "Size14"
                            v81.TextWrapped = true
                            v81.Size = UDim2.new(1, 0, 1, 0)
                            v81.TextYAlignment = "Top"
                            v81.BackgroundTransparency = 1
                            v81.TextStrokeTransparency = 0.5
                            v81.TextColor3 = Color3.fromRGB(255, 215, 0)
                        end
                    end
                elseif l_v77_0:FindFirstChild("ChestEsp") then
                    l_v77_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end
function v70(v82)
    return math.floor(v82 + 0.5)
end
function UpdateDevilChams()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character
    if not Character or not Character:FindFirstChild("Head") then return end

    for _, v in pairs(workspace:GetChildren()) do
        pcall(function()
            if v:IsA("Tool") and string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
                local handle = v.Handle
                local espName = "NameEsp" .. Number
                local distance = math.floor((Character.Head.Position - handle.Position).Magnitude)

                if DevilFruitESP then
                    if not handle:FindFirstChild(espName) then
                        local bill = Instance.new("BillboardGui")
                        bill.Name = espName
                        bill.Size = UDim2.new(0, 220, 0, 40)
                        bill.ExtentsOffset = Vector3.new(0, 1.5, 0)
                        bill.AlwaysOnTop = true
                        bill.Adornee = handle
                        bill.Parent = handle

                        local text = Instance.new("TextLabel")
                        text.Size = UDim2.new(1, 0, 1, 0)
                        text.BackgroundTransparency = 1
                        text.TextScaled = true
                        text.Font = Enum.Font.GothamBold
                        text.TextColor3 = Color3.fromRGB(120, 0, 0) 
                        text.TextStrokeTransparency = 0
                        text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                        text.Parent = bill
                    end

                    handle[espName].TextLabel.Text = "Fruit | " .. v.Name .. " | < " .. distance .. " >"
                    handle[espName].TextLabel.TextColor3 = Color3.fromRGB(120, 0, 0)
                else
                    if handle:FindFirstChild(espName) then
                        handle[espName]:Destroy()
                    end
                end
            end
        end)
    end
end
function UpdateFlowerChams()
    for _, v89 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v89_0 = v89
            pcall(function()
                if l_v89_0.Name == "Flower2" or l_v89_0.Name == "Flower1" then
                    if not FlowerESP then
                        if l_v89_0:FindFirstChild("NameEsp" .. Number) then
                            l_v89_0:FindFirstChild("NameEsp" .. Number):Destroy()
                        end
                    elseif l_v89_0:FindFirstChild("NameEsp" .. Number) then
                        l_v89_0["NameEsp" .. Number].TextLabel.Text = l_v89_0.Name .. "   \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v89_0.Position).Magnitude / 3) .. " Distance"
                    else
                        local v91 = Instance.new("BillboardGui", l_v89_0)
                        v91.Name = "NameEsp" .. Number
                        v91.ExtentsOffset = Vector3.new(0, 1, 0)
                        v91.Size = UDim2.new(1, 200, 1, 30)
                        v91.Adornee = l_v89_0
                        v91.AlwaysOnTop = true
                        local v92 = Instance.new("TextLabel", v91)
                        v92.Font = Enum.Font.GothamSemibold
                        v92.FontSize = "Size14"
                        v92.TextWrapped = true
                        v92.Size = UDim2.new(1, 0, 1, 0)
                        v92.TextYAlignment = "Top"
                        v92.BackgroundTransparency = 1
                        v92.TextStrokeTransparency = 0.5
                        v92.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if l_v89_0.Name == "Flower1" then
                            v92.Text = "Blue Flower" .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v89_0.Position).Magnitude / 3) .. " Distance"
                            v92.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if l_v89_0.Name == "Flower2" then
                            v92.Text = "Red Flower" .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v89_0.Position).Magnitude / 3) .. " Distance"
                            v92.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                end
            end)
        end
    end
end
function UpdateRealFruitChams()
    for _, v94 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v94:IsA("Tool") then
            if not RealFruitESP then
                if v94.Handle:FindFirstChild("NameEsp" .. Number) then
                    v94.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif v94.Handle:FindFirstChild("NameEsp" .. Number) then
                v94.Handle["NameEsp" .. Number].TextLabel.Text = v94.Name .. " " .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v94.Handle.Position).Magnitude / 3) .. " Distance"
            else
                local v95 = Instance.new("BillboardGui", v94.Handle)
                v95.Name = "NameEsp" .. Number
                v95.ExtentsOffset = Vector3.new(0, 1, 0)
                v95.Size = UDim2.new(1, 200, 1, 30)
                v95.Adornee = v94.Handle
                v95.AlwaysOnTop = true
                local v96 = Instance.new("TextLabel", v95)
                v96.Font = Enum.Font.GothamSemibold
                v96.FontSize = "Size14"
                v96.TextWrapped = true
                v96.Size = UDim2.new(1, 0, 1, 0)
                v96.TextYAlignment = "Top"
                v96.BackgroundTransparency = 1
                v96.TextStrokeTransparency = 0.5
                v96.TextColor3 = Color3.fromRGB(255, 0, 0)
                v96.Text = v94.Name .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v94.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
    for _, v98 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v98:IsA("Tool") then
            if RealFruitESP then
                if not v98.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v99 = Instance.new("BillboardGui", v98.Handle)
                    v99.Name = "NameEsp" .. Number
                    v99.ExtentsOffset = Vector3.new(0, 1, 0)
                    v99.Size = UDim2.new(1, 200, 1, 30)
                    v99.Adornee = v98.Handle
                    v99.AlwaysOnTop = true
                    local v100 = Instance.new("TextLabel", v99)
                    v100.Font = Enum.Font.GothamSemibold
                    v100.FontSize = "Size14"
                    v100.TextWrapped = true
                    v100.Size = UDim2.new(1, 0, 1, 0)
                    v100.TextYAlignment = "Top"
                    v100.BackgroundTransparency = 1
                    v100.TextStrokeTransparency = 0.5
                    v100.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v100.Text = v98.Name .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v98.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v98.Handle["NameEsp" .. Number].TextLabel.Text = v98.Name .. " " .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v98.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v98.Handle:FindFirstChild("NameEsp" .. Number) then
                v98.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v102 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v102:IsA("Tool") then
            if not RealFruitESP then
                if v102.Handle:FindFirstChild("NameEsp" .. Number) then
                    v102.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif not v102.Handle:FindFirstChild("NameEsp" .. Number) then
                local v103 = Instance.new("BillboardGui", v102.Handle)
                v103.Name = "NameEsp" .. Number
                v103.ExtentsOffset = Vector3.new(0, 1, 0)
                v103.Size = UDim2.new(1, 200, 1, 30)
                v103.Adornee = v102.Handle
                v103.AlwaysOnTop = true
                local v104 = Instance.new("TextLabel", v103)
                v104.Font = Enum.Font.GothamSemibold
                v104.FontSize = "Size14"
                v104.TextWrapped = true
                v104.Size = UDim2.new(1, 0, 1, 0)
                v104.TextYAlignment = "Top"
                v104.BackgroundTransparency = 1
                v104.TextStrokeTransparency = 0.5
                v104.TextColor3 = Color3.fromRGB(251, 255, 0)
                v104.Text = v102.Name .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v102.Handle.Position).Magnitude / 3) .. " Distance"
            else
                v102.Handle["NameEsp" .. Number].TextLabel.Text = v102.Name .. " " .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v102.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
end
function UpdateIslandESP()
    for _, v106 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v106_0 = v106
            pcall(function()
                if not IslandESP then
                    if l_v106_0:FindFirstChild("NameEsp") then
                        l_v106_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v106_0.Name ~= "Sea" then
                    if l_v106_0:FindFirstChild("NameEsp") then
                        l_v106_0.NameEsp.TextLabel.Text = l_v106_0.Name .. "   \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v106_0.Position).Magnitude / 3) .. " Distance"
                    else
                        local v108 = Instance.new("BillboardGui", l_v106_0)
                        v108.Name = "NameEsp"
                        v108.ExtentsOffset = Vector3.new(0, 1, 0)
                        v108.Size = UDim2.new(1, 200, 1, 30)
                        v108.Adornee = l_v106_0
                        v108.AlwaysOnTop = true
                        local v109 = Instance.new("TextLabel", v108)
                        v109.Font = "GothamSemibold"
                        v109.FontSize = "Size14"
                        v109.TextWrapped = true
                        v109.Size = UDim2.new(1, 0, 1, 0)
                        v109.TextYAlignment = "Top"
                        v109.BackgroundTransparency = 1
                        v109.TextStrokeTransparency = 0.5
                        v109.TextColor3 = Color3.fromRGB(8, 247, 255)
                    end
                end
            end)
        end
    end
end
function isnil(v110)
    local v111 = nil
    if v110 ~= v111 then
        local _ = false
    end
    return true
end
local function v114(v113)
    return math.floor(tonumber(v113) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
    for _, v116 in pairs(game:GetService("Players"):GetChildren()) do
        do
            local l_v116_0 = v116
            pcall(function()
                if not isnil(l_v116_0.Character) then
                    if ESPPlayer then
                        if isnil(l_v116_0.Character.Head) or l_v116_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            l_v116_0.Character.Head["NameEsp" .. Number].TextLabel.Text = l_v116_0.Name .. " | " .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v116_0.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v114(l_v116_0.Character.Humanoid.Health * 100 / l_v116_0.Character.Humanoid.MaxHealth) .. "%"
                        else
                            local v118 = Instance.new("BillboardGui", l_v116_0.Character.Head)
                            v118.Name = "NameEsp" .. Number
                            v118.ExtentsOffset = Vector3.new(0, 1, 0)
                            v118.Size = UDim2.new(1, 200, 1, 30)
                            v118.Adornee = l_v116_0.Character.Head
                            v118.AlwaysOnTop = true
                            local v119 = Instance.new("TextLabel", v118)
                            v119.Font = Enum.Font.GothamSemibold
                            v119.FontSize = "Size14"
                            v119.TextWrapped = true
                            v119.Text = l_v116_0.Name .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v116_0.Character.Head.Position).Magnitude / 3) .. " Distance"
                            v119.Size = UDim2.new(1, 0, 1, 0)
                            v119.TextYAlignment = "Top"
                            v119.BackgroundTransparency = 1
                            v119.TextStrokeTransparency = 0.5
                            if l_v116_0.Team ~= game.Players.LocalPlayer.Team then
                                v119.TextColor3 = Color3.new(255, 0, 0)
                            else
                                v119.TextColor3 = Color3.new(0, 255, 0)
                            end
                        end
                    elseif l_v116_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        l_v116_0.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end
function UpdateChestESP()
    for _, v121 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v121_0 = v121
            pcall(function()
                if _G.ChestESP then
                    if not l_v121_0:GetAttribute("IsDisabled") then
                        if l_v121_0:FindFirstChild("ChestEsp") then
                            local v123 = v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v121_0:GetPivot().Position).Magnitude / 3)
                            l_v121_0.ChestEsp.TextLabel.Text = "Chest\n" .. v123 .. " M"
                        else
                            local v124 = Instance.new("BillboardGui", l_v121_0)
                            v124.Name = "ChestEsp"
                            v124.ExtentsOffset = Vector3.new(0, 1, 0)
                            v124.Size = UDim2.new(1, 200, 1, 30)
                            v124.Adornee = l_v121_0
                            v124.AlwaysOnTop = true
                            local v125 = Instance.new("TextLabel", v124)
                            v125.Font = "Code"
                            v125.FontSize = "Size14"
                            v125.TextWrapped = true
                            v125.Size = UDim2.new(1, 0, 1, 0)
                            v125.TextYAlignment = "Top"
                            v125.BackgroundTransparency = 1
                            v125.TextStrokeTransparency = 0.5
                            v125.TextColor3 = Color3.fromRGB(255, 215, 0)
                        end
                    end
                elseif l_v121_0:FindFirstChild("ChestEsp") then
                    l_v121_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end
function v114(v126)
    return math.floor(v126 + 0.5)
end
function UpdateDevilChams()
    for _, v128 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v128_0 = v128
            pcall(function()
                if not DevilFruitESP then
                    if l_v128_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v128_0.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                elseif string.find(l_v128_0.Name, "Fruit") then
                    if l_v128_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v128_0.Handle["NameEsp" .. Number].TextLabel.Text = l_v128_0.Name .. "   \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v128_0.Handle.Position).Magnitude / 3) .. " Distance"
                    else
                        local v130 = Instance.new("BillboardGui", l_v128_0.Handle)
                        v130.Name = "NameEsp" .. Number
                        v130.ExtentsOffset = Vector3.new(0, 1, 0)
                        v130.Size = UDim2.new(1, 200, 1, 30)
                        v130.Adornee = l_v128_0.Handle
                        v130.AlwaysOnTop = true
                        local v131 = Instance.new("TextLabel", v130)
                        v131.Font = Enum.Font.GothamSemibold
                        v131.FontSize = "Size14"
                        v131.TextWrapped = true
                        v131.Size = UDim2.new(1, 0, 1, 0)
                        v131.TextYAlignment = "Top"
                        v131.BackgroundTransparency = 1
                        v131.TextStrokeTransparency = 0.5
                        v131.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v131.Text = l_v128_0.Name .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v128_0.Handle.Position).Magnitude / 3) .. " Distance"
                    end
                end
            end)
        end
    end
end
function UpdateFlowerChams()
    for _, v133 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v133_0 = v133
            pcall(function()
                if l_v133_0.Name == "Flower2" or l_v133_0.Name == "Flower1" then
                    if FlowerESP then
                        if l_v133_0:FindFirstChild("NameEsp" .. Number) then
                            l_v133_0["NameEsp" .. Number].TextLabel.Text = l_v133_0.Name .. "   \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v133_0.Position).Magnitude / 3) .. " Distance"
                        else
                            local v135 = Instance.new("BillboardGui", l_v133_0)
                            v135.Name = "NameEsp" .. Number
                            v135.ExtentsOffset = Vector3.new(0, 1, 0)
                            v135.Size = UDim2.new(1, 200, 1, 30)
                            v135.Adornee = l_v133_0
                            v135.AlwaysOnTop = true
                            local v136 = Instance.new("TextLabel", v135)
                            v136.Font = Enum.Font.GothamSemibold
                            v136.FontSize = "Size14"
                            v136.TextWrapped = true
                            v136.Size = UDim2.new(1, 0, 1, 0)
                            v136.TextYAlignment = "Top"
                            v136.BackgroundTransparency = 1
                            v136.TextStrokeTransparency = 0.5
                            v136.TextColor3 = Color3.fromRGB(255, 0, 0)
                            if l_v133_0.Name == "Flower1" then
                                v136.Text = "Blue Flower" .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v133_0.Position).Magnitude / 3) .. " Distance"
                                v136.TextColor3 = Color3.fromRGB(0, 0, 255)
                            end
                            if l_v133_0.Name == "Flower2" then
                                v136.Text = "Red Flower" .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v133_0.Position).Magnitude / 3) .. " Distance"
                                v136.TextColor3 = Color3.fromRGB(255, 0, 0)
                            end
                        end
                    elseif l_v133_0:FindFirstChild("NameEsp" .. Number) then
                        l_v133_0:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end
function UpdateRealFruitChams()
    for _, v138 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v138:IsA("Tool") then
            if RealFruitESP then
                if v138.Handle:FindFirstChild("NameEsp" .. Number) then
                    v138.Handle["NameEsp" .. Number].TextLabel.Text = v138.Name .. " " .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v138.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v139 = Instance.new("BillboardGui", v138.Handle)
                    v139.Name = "NameEsp" .. Number
                    v139.ExtentsOffset = Vector3.new(0, 1, 0)
                    v139.Size = UDim2.new(1, 200, 1, 30)
                    v139.Adornee = v138.Handle
                    v139.AlwaysOnTop = true
                    local v140 = Instance.new("TextLabel", v139)
                    v140.Font = Enum.Font.GothamSemibold
                    v140.FontSize = "Size14"
                    v140.TextWrapped = true
                    v140.Size = UDim2.new(1, 0, 1, 0)
                    v140.TextYAlignment = "Top"
                    v140.BackgroundTransparency = 1
                    v140.TextStrokeTransparency = 0.5
                    v140.TextColor3 = Color3.fromRGB(255, 0, 0)
                    v140.Text = v138.Name .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v138.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v138.Handle:FindFirstChild("NameEsp" .. Number) then
                v138.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v142 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v142:IsA("Tool") then
            if RealFruitESP then
                if v142.Handle:FindFirstChild("NameEsp" .. Number) then
                    v142.Handle["NameEsp" .. Number].TextLabel.Text = v142.Name .. " " .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v142.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v143 = Instance.new("BillboardGui", v142.Handle)
                    v143.Name = "NameEsp" .. Number
                    v143.ExtentsOffset = Vector3.new(0, 1, 0)
                    v143.Size = UDim2.new(1, 200, 1, 30)
                    v143.Adornee = v142.Handle
                    v143.AlwaysOnTop = true
                    local v144 = Instance.new("TextLabel", v143)
                    v144.Font = Enum.Font.GothamSemibold
                    v144.FontSize = "Size14"
                    v144.TextWrapped = true
                    v144.Size = UDim2.new(1, 0, 1, 0)
                    v144.TextYAlignment = "Top"
                    v144.BackgroundTransparency = 1
                    v144.TextStrokeTransparency = 0.5
                    v144.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v144.Text = v142.Name .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v142.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v142.Handle:FindFirstChild("NameEsp" .. Number) then
                v142.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v146 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v146:IsA("Tool") then
            if not RealFruitESP then
                if v146.Handle:FindFirstChild("NameEsp" .. Number) then
                    v146.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif not v146.Handle:FindFirstChild("NameEsp" .. Number) then
                local v147 = Instance.new("BillboardGui", v146.Handle)
                v147.Name = "NameEsp" .. Number
                v147.ExtentsOffset = Vector3.new(0, 1, 0)
                v147.Size = UDim2.new(1, 200, 1, 30)
                v147.Adornee = v146.Handle
                v147.AlwaysOnTop = true
                local v148 = Instance.new("TextLabel", v147)
                v148.Font = Enum.Font.GothamSemibold
                v148.FontSize = "Size14"
                v148.TextWrapped = true
                v148.Size = UDim2.new(1, 0, 1, 0)
                v148.TextYAlignment = "Top"
                v148.BackgroundTransparency = 1
                v148.TextStrokeTransparency = 0.5
                v148.TextColor3 = Color3.fromRGB(251, 255, 0)
                v148.Text = v146.Name .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v146.Handle.Position).Magnitude / 3) .. " Distance"
            else
                v146.Handle["NameEsp" .. Number].TextLabel.Text = v146.Name .. " " .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v146.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
end
function UpdateIslandESP()
    for _, v150 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v150_0 = v150
            pcall(function()
                if IslandESP then
                    if l_v150_0.Name ~= "Sea" then
                        if l_v150_0:FindFirstChild("NameEsp") then
                            l_v150_0.NameEsp.TextLabel.Text = l_v150_0.Name .. "   \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v150_0.Position).Magnitude / 3) .. " Distance"
                        else
                            local v152 = Instance.new("BillboardGui", l_v150_0)
                            v152.Name = "NameEsp"
                            v152.ExtentsOffset = Vector3.new(0, 1, 0)
                            v152.Size = UDim2.new(1, 200, 1, 30)
                            v152.Adornee = l_v150_0
                            v152.AlwaysOnTop = true
                            local v153 = Instance.new("TextLabel", v152)
                            v153.Font = "GothamSemibold"
                            v153.FontSize = "Size14"
                            v153.TextWrapped = true
                            v153.Size = UDim2.new(1, 0, 1, 0)
                            v153.TextYAlignment = "Top"
                            v153.BackgroundTransparency = 1
                            v153.TextStrokeTransparency = 0.5
                            v153.TextColor3 = Color3.fromRGB(255, 255, 255)
                        end
                    end
                elseif l_v150_0:FindFirstChild("NameEsp") then
                    l_v150_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end
function isnil(v154)
    local v155 = nil
    if v154 ~= v155 then
        local _ = false
    end
    return true
end
local function v158(v157)
    return math.floor(tonumber(v157) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
    for _, v160 in pairs(game:GetService("Players"):GetChildren()) do
        do
            local l_v160_0 = v160
            pcall(function()
                if not isnil(l_v160_0.Character) then
                    if not ESPPlayer then
                        if l_v160_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            l_v160_0.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                        end
                    elseif isnil(l_v160_0.Character.Head) or l_v160_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        l_v160_0.Character.Head["NameEsp" .. Number].TextLabel.Text = l_v160_0.Name .. " | " .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v160_0.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v158(l_v160_0.Character.Humanoid.Health * 100 / l_v160_0.Character.Humanoid.MaxHealth) .. "%"
                    else
                        local v162 = Instance.new("BillboardGui", l_v160_0.Character.Head)
                        v162.Name = "NameEsp" .. Number
                        v162.ExtentsOffset = Vector3.new(0, 1, 0)
                        v162.Size = UDim2.new(1, 200, 1, 30)
                        v162.Adornee = l_v160_0.Character.Head
                        v162.AlwaysOnTop = true
                        local v163 = Instance.new("TextLabel", v162)
                        v163.Font = Enum.Font.GothamSemibold
                        v163.FontSize = "Size14"
                        v163.TextWrapped = true
                        v163.Text = l_v160_0.Name .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v160_0.Character.Head.Position).Magnitude / 3) .. " Distance"
                        v163.Size = UDim2.new(1, 0, 1, 0)
                        v163.TextYAlignment = "Top"
                        v163.BackgroundTransparency = 1
                        v163.TextStrokeTransparency = 0.5
                        if l_v160_0.Team == game.Players.LocalPlayer.Team then
                            v163.TextColor3 = Color3.new(0, 255, 0)
                        else
                            v163.TextColor3 = Color3.new(255, 0, 0)
                        end
                    end
                end
            end)
        end
    end
end
function UpdateChestESP()
    for _, v165 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v165_0 = v165
            pcall(function()
                if _G.ChestESP then
                    if not l_v165_0:GetAttribute("IsDisabled") then
                        if l_v165_0:FindFirstChild("ChestEsp") then
                            local v167 = v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v165_0:GetPivot().Position).Magnitude / 3)
                            l_v165_0.ChestEsp.TextLabel.Text = "Chest\n" .. v167 .. " M"
                        else
                            local v168 = Instance.new("BillboardGui", l_v165_0)
                            v168.Name = "ChestEsp"
                            v168.ExtentsOffset = Vector3.new(0, 1, 0)
                            v168.Size = UDim2.new(1, 200, 1, 30)
                            v168.Adornee = l_v165_0
                            v168.AlwaysOnTop = true
                            local v169 = Instance.new("TextLabel", v168)
                            v169.Font = "Code"
                            v169.FontSize = "Size14"
                            v169.TextWrapped = true
                            v169.Size = UDim2.new(1, 0, 1, 0)
                            v169.TextYAlignment = "Top"
                            v169.BackgroundTransparency = 1
                            v169.TextStrokeTransparency = 0.5
                            v169.TextColor3 = Color3.fromRGB(255, 215, 0)
                        end
                    end
                elseif l_v165_0:FindFirstChild("ChestEsp") then
                    l_v165_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end
function v158(v170)
    return math.floor(v170 + 0.5)
end
function UpdateDevilChams()
    for _, v172 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v172_0 = v172
            pcall(function()
                if DevilFruitESP then
                    if string.find(l_v172_0.Name, "Fruit") then
                        if l_v172_0.Handle:FindFirstChild("NameEsp" .. Number) then
                            l_v172_0.Handle["NameEsp" .. Number].TextLabel.Text = l_v172_0.Name .. "   \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v172_0.Handle.Position).Magnitude / 3) .. " Distance"
                        else
                            local v174 = Instance.new("BillboardGui", l_v172_0.Handle)
                            v174.Name = "NameEsp" .. Number
                            v174.ExtentsOffset = Vector3.new(0, 1, 0)
                            v174.Size = UDim2.new(1, 200, 1, 30)
                            v174.Adornee = l_v172_0.Handle
                            v174.AlwaysOnTop = true
                            local v175 = Instance.new("TextLabel", v174)
                            v175.Font = Enum.Font.GothamSemibold
                            v175.FontSize = "Size14"
                            v175.TextWrapped = true
                            v175.Size = UDim2.new(1, 0, 1, 0)
                            v175.TextYAlignment = "Top"
                            v175.BackgroundTransparency = 1
                            v175.TextStrokeTransparency = 0.5
                            v175.TextColor3 = Color3.fromRGB(255, 255, 255)
                            v175.Text = l_v172_0.Name .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v172_0.Handle.Position).Magnitude / 3) .. " Distance"
                        end
                    end
                elseif l_v172_0.Handle:FindFirstChild("NameEsp" .. Number) then
                    l_v172_0.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end)
        end
    end
end
function UpdateFlowerChams()
    for _, v177 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v177_0 = v177
            pcall(function()
                if l_v177_0.Name == "Flower2" or l_v177_0.Name == "Flower1" then
                    if not FlowerESP then
                        if l_v177_0:FindFirstChild("NameEsp" .. Number) then
                            l_v177_0:FindFirstChild("NameEsp" .. Number):Destroy()
                        end
                    elseif l_v177_0:FindFirstChild("NameEsp" .. Number) then
                        l_v177_0["NameEsp" .. Number].TextLabel.Text = l_v177_0.Name .. "   \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v177_0.Position).Magnitude / 3) .. " Distance"
                    else
                        local v179 = Instance.new("BillboardGui", l_v177_0)
                        v179.Name = "NameEsp" .. Number
                        v179.ExtentsOffset = Vector3.new(0, 1, 0)
                        v179.Size = UDim2.new(1, 200, 1, 30)
                        v179.Adornee = l_v177_0
                        v179.AlwaysOnTop = true
                        local v180 = Instance.new("TextLabel", v179)
                        v180.Font = Enum.Font.GothamSemibold
                        v180.FontSize = "Size14"
                        v180.TextWrapped = true
                        v180.Size = UDim2.new(1, 0, 1, 0)
                        v180.TextYAlignment = "Top"
                        v180.BackgroundTransparency = 1
                        v180.TextStrokeTransparency = 0.5
                        v180.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if l_v177_0.Name == "Flower1" then
                            v180.Text = "Blue Flower" .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v177_0.Position).Magnitude / 3) .. " Distance"
                            v180.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if l_v177_0.Name == "Flower2" then
                            v180.Text = "Red Flower" .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v177_0.Position).Magnitude / 3) .. " Distance"
                            v180.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                end
            end)
        end
    end
end
function UpdateRealFruitChams()
    for _, v182 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v182:IsA("Tool") then
            if RealFruitESP then
                if v182.Handle:FindFirstChild("NameEsp" .. Number) then
                    v182.Handle["NameEsp" .. Number].TextLabel.Text = v182.Name .. " " .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v182.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v183 = Instance.new("BillboardGui", v182.Handle)
                    v183.Name = "NameEsp" .. Number
                    v183.ExtentsOffset = Vector3.new(0, 1, 0)
                    v183.Size = UDim2.new(1, 200, 1, 30)
                    v183.Adornee = v182.Handle
                    v183.AlwaysOnTop = true
                    local v184 = Instance.new("TextLabel", v183)
                    v184.Font = Enum.Font.GothamSemibold
                    v184.FontSize = "Size14"
                    v184.TextWrapped = true
                    v184.Size = UDim2.new(1, 0, 1, 0)
                    v184.TextYAlignment = "Top"
                    v184.BackgroundTransparency = 1
                    v184.TextStrokeTransparency = 0.5
                    v184.TextColor3 = Color3.fromRGB(255, 0, 0)
                    v184.Text = v182.Name .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v182.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v182.Handle:FindFirstChild("NameEsp" .. Number) then
                v182.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v186 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v186:IsA("Tool") then
            if RealFruitESP then
                if not v186.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v187 = Instance.new("BillboardGui", v186.Handle)
                    v187.Name = "NameEsp" .. Number
                    v187.ExtentsOffset = Vector3.new(0, 1, 0)
                    v187.Size = UDim2.new(1, 200, 1, 30)
                    v187.Adornee = v186.Handle
                    v187.AlwaysOnTop = true
                    local v188 = Instance.new("TextLabel", v187)
                    v188.Font = Enum.Font.GothamSemibold
                    v188.FontSize = "Size14"
                    v188.TextWrapped = true
                    v188.Size = UDim2.new(1, 0, 1, 0)
                    v188.TextYAlignment = "Top"
                    v188.BackgroundTransparency = 1
                    v188.TextStrokeTransparency = 0.5
                    v188.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v188.Text = v186.Name .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v186.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v186.Handle["NameEsp" .. Number].TextLabel.Text = v186.Name .. " " .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v186.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v186.Handle:FindFirstChild("NameEsp" .. Number) then
                v186.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v190 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v190:IsA("Tool") then
            if RealFruitESP then
                if v190.Handle:FindFirstChild("NameEsp" .. Number) then
                    v190.Handle["NameEsp" .. Number].TextLabel.Text = v190.Name .. " " .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v190.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v191 = Instance.new("BillboardGui", v190.Handle)
                    v191.Name = "NameEsp" .. Number
                    v191.ExtentsOffset = Vector3.new(0, 1, 0)
                    v191.Size = UDim2.new(1, 200, 1, 30)
                    v191.Adornee = v190.Handle
                    v191.AlwaysOnTop = true
                    local v192 = Instance.new("TextLabel", v191)
                    v192.Font = Enum.Font.GothamSemibold
                    v192.FontSize = "Size14"
                    v192.TextWrapped = true
                    v192.Size = UDim2.new(1, 0, 1, 0)
                    v192.TextYAlignment = "Top"
                    v192.BackgroundTransparency = 1
                    v192.TextStrokeTransparency = 0.5
                    v192.TextColor3 = Color3.fromRGB(251, 255, 0)
                    v192.Text = v190.Name .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v190.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v190.Handle:FindFirstChild("NameEsp" .. Number) then
                v190.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
end
function UpdateIslandESP()
    for _, v194 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v194_0 = v194
            pcall(function()
                if not IslandESP then
                    if l_v194_0:FindFirstChild("NameEsp") then
                        l_v194_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v194_0.Name ~= "Sea" then
                    if l_v194_0:FindFirstChild("NameEsp") then
                        l_v194_0.NameEsp.TextLabel.Text = l_v194_0.Name .. "   \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v194_0.Position).Magnitude / 3) .. " Distance"
                    else
                        local v196 = Instance.new("BillboardGui", l_v194_0)
                        v196.Name = "NameEsp"
                        v196.ExtentsOffset = Vector3.new(0, 1, 0)
                        v196.Size = UDim2.new(1, 200, 1, 30)
                        v196.Adornee = l_v194_0
                        v196.AlwaysOnTop = true
                        local v197 = Instance.new("TextLabel", v196)
                        v197.Font = "GothamSemibold"
                        v197.FontSize = "Size14"
                        v197.TextWrapped = true
                        v197.Size = UDim2.new(1, 0, 1, 0)
                        v197.TextYAlignment = "Top"
                        v197.BackgroundTransparency = 1
                        v197.TextStrokeTransparency = 0.5
                        v197.TextColor3 = Color3.fromRGB(8, 247, 255)
                    end
                end
            end)
        end
    end
end
function isnil(v198)
    local v199 = nil
    if v198 ~= v199 then
        local _ = false
    end
    return true
end
local function v202(v201)
    return math.floor(tonumber(v201) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
    for _, v204 in pairs(game:GetService("Players"):GetChildren()) do
        do
            local l_v204_0 = v204
            pcall(function()
                if not isnil(l_v204_0.Character) then
                    if ESPPlayer then
                        if isnil(l_v204_0.Character.Head) or l_v204_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            l_v204_0.Character.Head["NameEsp" .. Number].TextLabel.Text = l_v204_0.Name .. " | " .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v204_0.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v202(l_v204_0.Character.Humanoid.Health * 100 / l_v204_0.Character.Humanoid.MaxHealth) .. "%"
                        else
                            local v206 = Instance.new("BillboardGui", l_v204_0.Character.Head)
                            v206.Name = "NameEsp" .. Number
                            v206.ExtentsOffset = Vector3.new(0, 1, 0)
                            v206.Size = UDim2.new(1, 200, 1, 30)
                            v206.Adornee = l_v204_0.Character.Head
                            v206.AlwaysOnTop = true
                            local v207 = Instance.new("TextLabel", v206)
                            v207.Font = Enum.Font.GothamSemibold
                            v207.FontSize = "Size14"
                            v207.TextWrapped = true
                            v207.Text = l_v204_0.Name .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v204_0.Character.Head.Position).Magnitude / 3) .. " Distance"
                            v207.Size = UDim2.new(1, 0, 1, 0)
                            v207.TextYAlignment = "Top"
                            v207.BackgroundTransparency = 1
                            v207.TextStrokeTransparency = 0.5
                            if l_v204_0.Team ~= game.Players.LocalPlayer.Team then
                                v207.TextColor3 = Color3.new(255, 0, 0)
                            else
                                v207.TextColor3 = Color3.new(0, 255, 0)
                            end
                        end
                    elseif l_v204_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        l_v204_0.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end
function UpdateChestESP()
    for _, v209 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v209_0 = v209
            pcall(function()
                if _G.ChestESP then
                    if not l_v209_0:GetAttribute("IsDisabled") then
                        if not l_v209_0:FindFirstChild("ChestEsp") then
                            local v211 = Instance.new("BillboardGui", l_v209_0)
                            v211.Name = "ChestEsp"
                            v211.ExtentsOffset = Vector3.new(0, 1, 0)
                            v211.Size = UDim2.new(1, 200, 1, 30)
                            v211.Adornee = l_v209_0
                            v211.AlwaysOnTop = true
                            local v212 = Instance.new("TextLabel", v211)
                            v212.Font = "Code"
                            v212.FontSize = "Size14"
                            v212.TextWrapped = true
                            v212.Size = UDim2.new(1, 0, 1, 0)
                            v212.TextYAlignment = "Top"
                            v212.BackgroundTransparency = 1
                            v212.TextStrokeTransparency = 0.5
                            v212.TextColor3 = Color3.fromRGB(255, 215, 0)
                        else
                            local v213 = v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v209_0:GetPivot().Position).Magnitude / 3)
                            l_v209_0.ChestEsp.TextLabel.Text = "Chest\n" .. v213 .. " M"
                        end
                    end
                elseif l_v209_0:FindFirstChild("ChestEsp") then
                    l_v209_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end
function v202(v214)
    return math.floor(v214 + 0.5)
end
function UpdateDevilChams()
    for _, v216 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v216_0 = v216
            pcall(function()
                if not DevilFruitESP then
                    if l_v216_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v216_0.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                elseif string.find(l_v216_0.Name, "Fruit") then
                    if l_v216_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v216_0.Handle["NameEsp" .. Number].TextLabel.Text = l_v216_0.Name .. "   \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v216_0.Handle.Position).Magnitude / 3) .. " Distance"
                    else
                        local v218 = Instance.new("BillboardGui", l_v216_0.Handle)
                        v218.Name = "NameEsp" .. Number
                        v218.ExtentsOffset = Vector3.new(0, 1, 0)
                        v218.Size = UDim2.new(1, 200, 1, 30)
                        v218.Adornee = l_v216_0.Handle
                        v218.AlwaysOnTop = true
                        local v219 = Instance.new("TextLabel", v218)
                        v219.Font = Enum.Font.GothamSemibold
                        v219.FontSize = "Size14"
                        v219.TextWrapped = true
                        v219.Size = UDim2.new(1, 0, 1, 0)
                        v219.TextYAlignment = "Top"
                        v219.BackgroundTransparency = 1
                        v219.TextStrokeTransparency = 0.5
                        v219.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v219.Text = l_v216_0.Name .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v216_0.Handle.Position).Magnitude / 3) .. " Distance"
                    end
                end
            end)
        end
    end
end
function UpdateFlowerChams()
    for _, v221 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v221_0 = v221
            pcall(function()
                if l_v221_0.Name == "Flower2" or l_v221_0.Name == "Flower1" then
                    if not FlowerESP then
                        if l_v221_0:FindFirstChild("NameEsp" .. Number) then
                            l_v221_0:FindFirstChild("NameEsp" .. Number):Destroy()
                        end
                    elseif l_v221_0:FindFirstChild("NameEsp" .. Number) then
                        l_v221_0["NameEsp" .. Number].TextLabel.Text = l_v221_0.Name .. "   \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v221_0.Position).Magnitude / 3) .. " Distance"
                    else
                        local v223 = Instance.new("BillboardGui", l_v221_0)
                        v223.Name = "NameEsp" .. Number
                        v223.ExtentsOffset = Vector3.new(0, 1, 0)
                        v223.Size = UDim2.new(1, 200, 1, 30)
                        v223.Adornee = l_v221_0
                        v223.AlwaysOnTop = true
                        local v224 = Instance.new("TextLabel", v223)
                        v224.Font = Enum.Font.GothamSemibold
                        v224.FontSize = "Size14"
                        v224.TextWrapped = true
                        v224.Size = UDim2.new(1, 0, 1, 0)
                        v224.TextYAlignment = "Top"
                        v224.BackgroundTransparency = 1
                        v224.TextStrokeTransparency = 0.5
                        v224.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if l_v221_0.Name == "Flower1" then
                            v224.Text = "Blue Flower" .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v221_0.Position).Magnitude / 3) .. " Distance"
                            v224.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if l_v221_0.Name == "Flower2" then
                            v224.Text = "Red Flower" .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v221_0.Position).Magnitude / 3) .. " Distance"
                            v224.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                end
            end)
        end
    end
end
function UpdateRealFruitChams()
    for _, v226 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v226:IsA("Tool") then
            if not RealFruitESP then
                if v226.Handle:FindFirstChild("NameEsp" .. Number) then
                    v226.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif v226.Handle:FindFirstChild("NameEsp" .. Number) then
                v226.Handle["NameEsp" .. Number].TextLabel.Text = v226.Name .. " " .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v226.Handle.Position).Magnitude / 3) .. " Distance"
            else
                local v227 = Instance.new("BillboardGui", v226.Handle)
                v227.Name = "NameEsp" .. Number
                v227.ExtentsOffset = Vector3.new(0, 1, 0)
                v227.Size = UDim2.new(1, 200, 1, 30)
                v227.Adornee = v226.Handle
                v227.AlwaysOnTop = true
                local v228 = Instance.new("TextLabel", v227)
                v228.Font = Enum.Font.GothamSemibold
                v228.FontSize = "Size14"
                v228.TextWrapped = true
                v228.Size = UDim2.new(1, 0, 1, 0)
                v228.TextYAlignment = "Top"
                v228.BackgroundTransparency = 1
                v228.TextStrokeTransparency = 0.5
                v228.TextColor3 = Color3.fromRGB(255, 0, 0)
                v228.Text = v226.Name .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v226.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
    for _, v230 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v230:IsA("Tool") then
            if RealFruitESP then
                if v230.Handle:FindFirstChild("NameEsp" .. Number) then
                    v230.Handle["NameEsp" .. Number].TextLabel.Text = v230.Name .. " " .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v230.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v231 = Instance.new("BillboardGui", v230.Handle)
                    v231.Name = "NameEsp" .. Number
                    v231.ExtentsOffset = Vector3.new(0, 1, 0)
                    v231.Size = UDim2.new(1, 200, 1, 30)
                    v231.Adornee = v230.Handle
                    v231.AlwaysOnTop = true
                    local v232 = Instance.new("TextLabel", v231)
                    v232.Font = Enum.Font.GothamSemibold
                    v232.FontSize = "Size14"
                    v232.TextWrapped = true
                    v232.Size = UDim2.new(1, 0, 1, 0)
                    v232.TextYAlignment = "Top"
                    v232.BackgroundTransparency = 1
                    v232.TextStrokeTransparency = 0.5
                    v232.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v232.Text = v230.Name .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v230.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v230.Handle:FindFirstChild("NameEsp" .. Number) then
                v230.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v234 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v234:IsA("Tool") then
            if RealFruitESP then
                if not v234.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v235 = Instance.new("BillboardGui", v234.Handle)
                    v235.Name = "NameEsp" .. Number
                    v235.ExtentsOffset = Vector3.new(0, 1, 0)
                    v235.Size = UDim2.new(1, 200, 1, 30)
                    v235.Adornee = v234.Handle
                    v235.AlwaysOnTop = true
                    local v236 = Instance.new("TextLabel", v235)
                    v236.Font = Enum.Font.GothamSemibold
                    v236.FontSize = "Size14"
                    v236.TextWrapped = true
                    v236.Size = UDim2.new(1, 0, 1, 0)
                    v236.TextYAlignment = "Top"
                    v236.BackgroundTransparency = 1
                    v236.TextStrokeTransparency = 0.5
                    v236.TextColor3 = Color3.fromRGB(251, 255, 0)
                    v236.Text = v234.Name .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v234.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v234.Handle["NameEsp" .. Number].TextLabel.Text = v234.Name .. " " .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v234.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v234.Handle:FindFirstChild("NameEsp" .. Number) then
                v234.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
end
function UpdateIslandESP()
    for _, v238 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v238_0 = v238
            pcall(function()
                if IslandESP then
                    if l_v238_0.Name ~= "Sea" then
                        if l_v238_0:FindFirstChild("NameEsp") then
                            l_v238_0.NameEsp.TextLabel.Text = l_v238_0.Name .. "   \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v238_0.Position).Magnitude / 3) .. " Distance"
                        else
                            local v240 = Instance.new("BillboardGui", l_v238_0)
                            v240.Name = "NameEsp"
                            v240.ExtentsOffset = Vector3.new(0, 1, 0)
                            v240.Size = UDim2.new(1, 200, 1, 30)
                            v240.Adornee = l_v238_0
                            v240.AlwaysOnTop = true
                            local v241 = Instance.new("TextLabel", v240)
                            v241.Font = "GothamSemibold"
                            v241.FontSize = "Size14"
                            v241.TextWrapped = true
                            v241.Size = UDim2.new(1, 0, 1, 0)
                            v241.TextYAlignment = "Top"
                            v241.BackgroundTransparency = 1
                            v241.TextStrokeTransparency = 0.5
                            v241.TextColor3 = Color3.fromRGB(8, 247, 255)
                        end
                    end
                elseif l_v238_0:FindFirstChild("NameEsp") then
                    l_v238_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end
function isnil(v242)
    local v243 = nil
    if v242 ~= v243 then
        local _ = false
    end
    return true
end
local function v246(v245)
    return math.floor(tonumber(v245) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
    for _, v248 in pairs(game:GetService("Players"):GetChildren()) do
        do
            local l_v248_0 = v248
            pcall(function()
                if not isnil(l_v248_0.Character) then
                    if ESPPlayer then
                        if not isnil(l_v248_0.Character.Head) and not l_v248_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            local v250 = Instance.new("BillboardGui", l_v248_0.Character.Head)
                            v250.Name = "NameEsp" .. Number
                            v250.ExtentsOffset = Vector3.new(0, 1, 0)
                            v250.Size = UDim2.new(1, 200, 1, 30)
                            v250.Adornee = l_v248_0.Character.Head
                            v250.AlwaysOnTop = true
                            local v251 = Instance.new("TextLabel", v250)
                            v251.Font = Enum.Font.GothamSemibold
                            v251.FontSize = "Size14"
                            v251.TextWrapped = true
                            v251.Text = l_v248_0.Name .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v248_0.Character.Head.Position).Magnitude / 3) .. " Distance"
                            v251.Size = UDim2.new(1, 0, 1, 0)
                            v251.TextYAlignment = "Top"
                            v251.BackgroundTransparency = 1
                            v251.TextStrokeTransparency = 0.5
                            if l_v248_0.Team ~= game.Players.LocalPlayer.Team then
                                v251.TextColor3 = Color3.new(255, 0, 0)
                            else
                                v251.TextColor3 = Color3.new(0, 255, 0)
                            end
                        else
                            l_v248_0.Character.Head["NameEsp" .. Number].TextLabel.Text = l_v248_0.Name .. " | " .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v248_0.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v246(l_v248_0.Character.Humanoid.Health * 100 / l_v248_0.Character.Humanoid.MaxHealth) .. "%"
                        end
                    elseif l_v248_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        l_v248_0.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end
function UpdateChestESP()
    for _, v253 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v253_0 = v253
            pcall(function()
                if _G.ChestESP then
                    if not l_v253_0:GetAttribute("IsDisabled") then
                        if l_v253_0:FindFirstChild("ChestEsp") then
                            local v255 = v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v253_0:GetPivot().Position).Magnitude / 3)
                            l_v253_0.ChestEsp.TextLabel.Text = "Chest\n" .. v255 .. " M"
                        else
                            local v256 = Instance.new("BillboardGui", l_v253_0)
                            v256.Name = "ChestEsp"
                            v256.ExtentsOffset = Vector3.new(0, 1, 0)
                            v256.Size = UDim2.new(1, 200, 1, 30)
                            v256.Adornee = l_v253_0
                            v256.AlwaysOnTop = true
                            local v257 = Instance.new("TextLabel", v256)
                            v257.Font = "Code"
                            v257.FontSize = "Size14"
                            v257.TextWrapped = true
                            v257.Size = UDim2.new(1, 0, 1, 0)
                            v257.TextYAlignment = "Top"
                            v257.BackgroundTransparency = 1
                            v257.TextStrokeTransparency = 0.5
                            v257.TextColor3 = Color3.fromRGB(255, 215, 0)
                        end
                    end
                elseif l_v253_0:FindFirstChild("ChestEsp") then
                    l_v253_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end
function v246(v258)
    return math.floor(v258 + 0.5)
end
function UpdateDevilChams()
    for _, v260 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v260_0 = v260
            pcall(function()
                if not DevilFruitESP then
                    if l_v260_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v260_0.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                elseif string.find(l_v260_0.Name, "Fruit") then
                    if l_v260_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v260_0.Handle["NameEsp" .. Number].TextLabel.Text = l_v260_0.Name .. "   \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v260_0.Handle.Position).Magnitude / 3) .. " Distance"
                    else
                        local v262 = Instance.new("BillboardGui", l_v260_0.Handle)
                        v262.Name = "NameEsp" .. Number
                        v262.ExtentsOffset = Vector3.new(0, 1, 0)
                        v262.Size = UDim2.new(1, 200, 1, 30)
                        v262.Adornee = l_v260_0.Handle
                        v262.AlwaysOnTop = true
                        local v263 = Instance.new("TextLabel", v262)
                        v263.Font = Enum.Font.GothamSemibold
                        v263.FontSize = "Size14"
                        v263.TextWrapped = true
                        v263.Size = UDim2.new(1, 0, 1, 0)
                        v263.TextYAlignment = "Top"
                        v263.BackgroundTransparency = 1
                        v263.TextStrokeTransparency = 0.5
                        v263.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v263.Text = l_v260_0.Name .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v260_0.Handle.Position).Magnitude / 3) .. " Distance"
                    end
                end
            end)
        end
    end
end
function UpdateFlowerChams()
    for _, v265 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v265_0 = v265
            pcall(function()
                if l_v265_0.Name == "Flower2" or l_v265_0.Name == "Flower1" then
                    if FlowerESP then
                        if l_v265_0:FindFirstChild("NameEsp" .. Number) then
                            l_v265_0["NameEsp" .. Number].TextLabel.Text = l_v265_0.Name .. "   \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v265_0.Position).Magnitude / 3) .. " Distance"
                        else
                            local v267 = Instance.new("BillboardGui", l_v265_0)
                            v267.Name = "NameEsp" .. Number
                            v267.ExtentsOffset = Vector3.new(0, 1, 0)
                            v267.Size = UDim2.new(1, 200, 1, 30)
                            v267.Adornee = l_v265_0
                            v267.AlwaysOnTop = true
                            local v268 = Instance.new("TextLabel", v267)
                            v268.Font = Enum.Font.GothamSemibold
                            v268.FontSize = "Size14"
                            v268.TextWrapped = true
                            v268.Size = UDim2.new(1, 0, 1, 0)
                            v268.TextYAlignment = "Top"
                            v268.BackgroundTransparency = 1
                            v268.TextStrokeTransparency = 0.5
                            v268.TextColor3 = Color3.fromRGB(255, 0, 0)
                            if l_v265_0.Name == "Flower1" then
                                v268.Text = "Blue Flower" .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v265_0.Position).Magnitude / 3) .. " Distance"
                                v268.TextColor3 = Color3.fromRGB(0, 0, 255)
                            end
                            if l_v265_0.Name == "Flower2" then
                                v268.Text = "Red Flower" .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v265_0.Position).Magnitude / 3) .. " Distance"
                                v268.TextColor3 = Color3.fromRGB(255, 0, 0)
                            end
                        end
                    elseif l_v265_0:FindFirstChild("NameEsp" .. Number) then
                        l_v265_0:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end
function UpdateRealFruitChams()
    for _, v270 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v270:IsA("Tool") then
            if RealFruitESP then
                if not v270.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v271 = Instance.new("BillboardGui", v270.Handle)
                    v271.Name = "NameEsp" .. Number
                    v271.ExtentsOffset = Vector3.new(0, 1, 0)
                    v271.Size = UDim2.new(1, 200, 1, 30)
                    v271.Adornee = v270.Handle
                    v271.AlwaysOnTop = true
                    local v272 = Instance.new("TextLabel", v271)
                    v272.Font = Enum.Font.GothamSemibold
                    v272.FontSize = "Size14"
                    v272.TextWrapped = true
                    v272.Size = UDim2.new(1, 0, 1, 0)
                    v272.TextYAlignment = "Top"
                    v272.BackgroundTransparency = 1
                    v272.TextStrokeTransparency = 0.5
                    v272.TextColor3 = Color3.fromRGB(255, 0, 0)
                    v272.Text = v270.Name .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v270.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v270.Handle["NameEsp" .. Number].TextLabel.Text = v270.Name .. " " .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v270.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v270.Handle:FindFirstChild("NameEsp" .. Number) then
                v270.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v274 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v274:IsA("Tool") then
            if not RealFruitESP then
                if v274.Handle:FindFirstChild("NameEsp" .. Number) then
                    v274.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif not v274.Handle:FindFirstChild("NameEsp" .. Number) then
                local v275 = Instance.new("BillboardGui", v274.Handle)
                v275.Name = "NameEsp" .. Number
                v275.ExtentsOffset = Vector3.new(0, 1, 0)
                v275.Size = UDim2.new(1, 200, 1, 30)
                v275.Adornee = v274.Handle
                v275.AlwaysOnTop = true
                local v276 = Instance.new("TextLabel", v275)
                v276.Font = Enum.Font.GothamSemibold
                v276.FontSize = "Size14"
                v276.TextWrapped = true
                v276.Size = UDim2.new(1, 0, 1, 0)
                v276.TextYAlignment = "Top"
                v276.BackgroundTransparency = 1
                v276.TextStrokeTransparency = 0.5
                v276.TextColor3 = Color3.fromRGB(255, 174, 0)
                v276.Text = v274.Name .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v274.Handle.Position).Magnitude / 3) .. " Distance"
            else
                v274.Handle["NameEsp" .. Number].TextLabel.Text = v274.Name .. " " .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v274.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
    for _, v278 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v278:IsA("Tool") then
            if RealFruitESP then
                if not v278.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v279 = Instance.new("BillboardGui", v278.Handle)
                    v279.Name = "NameEsp" .. Number
                    v279.ExtentsOffset = Vector3.new(0, 1, 0)
                    v279.Size = UDim2.new(1, 200, 1, 30)
                    v279.Adornee = v278.Handle
                    v279.AlwaysOnTop = true
                    local v280 = Instance.new("TextLabel", v279)
                    v280.Font = Enum.Font.GothamSemibold
                    v280.FontSize = "Size14"
                    v280.TextWrapped = true
                    v280.Size = UDim2.new(1, 0, 1, 0)
                    v280.TextYAlignment = "Top"
                    v280.BackgroundTransparency = 1
                    v280.TextStrokeTransparency = 0.5
                    v280.TextColor3 = Color3.fromRGB(251, 255, 0)
                    v280.Text = v278.Name .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v278.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v278.Handle["NameEsp" .. Number].TextLabel.Text = v278.Name .. " " .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v278.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v278.Handle:FindFirstChild("NameEsp" .. Number) then
                v278.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
end
spawn(function()
    while task.wait(Settings.SmoothMode and 0.5 or 0) do
        pcall(function()
            if MobESP then
                for _, v282 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v282:FindFirstChild("HumanoidRootPart") then
                        if not v282:FindFirstChild("MobEap") then
                            local l_BillboardGui_0 = Instance.new("BillboardGui")
                            local l_TextLabel_0 = Instance.new("TextLabel")
                            l_BillboardGui_0.Parent = v282
                            l_BillboardGui_0.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            l_BillboardGui_0.Active = true
                            l_BillboardGui_0.Name = "MobEap"
                            l_BillboardGui_0.AlwaysOnTop = true
                            l_BillboardGui_0.LightInfluence = 1
                            l_BillboardGui_0.Size = UDim2.new(0, 200, 0, 50)
                            l_BillboardGui_0.StudsOffset = Vector3.new(0, 2.5, 0)
                            l_TextLabel_0.Parent = l_BillboardGui_0
                            l_TextLabel_0.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            l_TextLabel_0.BackgroundTransparency = 1
                            l_TextLabel_0.Size = UDim2.new(0, 200, 0, 50)
                            l_TextLabel_0.Font = Enum.Font.GothamBold
                            l_TextLabel_0.TextColor3 = Color3.fromRGB(7, 236, 240)
                            l_TextLabel_0.Text.Size = 35
                        end
                        local v285 = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v282.HumanoidRootPart.Position).Magnitude)
                        v282.MobEap.TextLabel.Text = v282.Name .. " - " .. v285 .. " Distance"
                    end
                end
            else
                for _, v287 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v287:FindFirstChild("MobEap") then
                        v287.MobEap:Destroy()
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while task.wait(Settings.SmoothMode and 0.5 or 0) do
        pcall(function()
            if not SeaESP then
                for _, v289 in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
                    if v289:FindFirstChild("Seaesps") then
                        v289.Seaesps:Destroy()
                    end
                end
            else
                for _, v291 in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
                    if v291:FindFirstChild("HumanoidRootPart") then
                        if not v291:FindFirstChild("Seaesps") then
                            local l_BillboardGui_1 = Instance.new("BillboardGui")
                            local l_TextLabel_1 = Instance.new("TextLabel")
                            l_BillboardGui_1.Parent = v291
                            l_BillboardGui_1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            l_BillboardGui_1.Active = true
                            l_BillboardGui_1.Name = "Seaesps"
                            l_BillboardGui_1.AlwaysOnTop = true
                            l_BillboardGui_1.LightInfluence = 1
                            l_BillboardGui_1.Size = UDim2.new(0, 200, 0, 50)
                            l_BillboardGui_1.StudsOffset = Vector3.new(0, 2.5, 0)
                            l_TextLabel_1.Parent = l_BillboardGui_1
                            l_TextLabel_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            l_TextLabel_1.BackgroundTransparency = 1
                            l_TextLabel_1.Size = UDim2.new(0, 200, 0, 50)
                            l_TextLabel_1.Font = Enum.Font.GothamBold
                            l_TextLabel_1.TextColor3 = Color3.fromRGB(7, 236, 240)
                            l_TextLabel_1.Text.Size = 35
                        end
                        local v294 = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v291.HumanoidRootPart.Position).Magnitude)
                        v291.Seaesps.TextLabel.Text = v291.Name .. " - " .. v294 .. " Distance"
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while task.wait(Settings.SmoothMode and 0.5 or 0) do
        pcall(function()
            if not NpcESP then
                for _, v296 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                    if v296:FindFirstChild("NpcEspes") then
                        v296.NpcEspes:Destroy()
                    end
                end
            else
                for _, v298 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                    if v298:FindFirstChild("HumanoidRootPart") then
                        if not v298:FindFirstChild("NpcEspes") then
                            local l_BillboardGui_2 = Instance.new("BillboardGui")
                            local l_TextLabel_2 = Instance.new("TextLabel")
                            l_BillboardGui_2.Parent = v298
                            l_BillboardGui_2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            l_BillboardGui_2.Active = true
                            l_BillboardGui_2.Name = "NpcEspes"
                            l_BillboardGui_2.AlwaysOnTop = true
                            l_BillboardGui_2.LightInfluence = 1
                            l_BillboardGui_2.Size = UDim2.new(0, 200, 0, 50)
                            l_BillboardGui_2.StudsOffset = Vector3.new(0, 2.5, 0)
                            l_TextLabel_2.Parent = l_BillboardGui_2
                            l_TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            l_TextLabel_2.BackgroundTransparency = 1
                            l_TextLabel_2.Size = UDim2.new(0, 200, 0, 50)
                            l_TextLabel_2.Font = Enum.Font.GothamBold
                            l_TextLabel_2.TextColor3 = Color3.fromRGB(7, 236, 240)
                            l_TextLabel_2.Text.Size = 35
                        end
                        local v301 = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v298.HumanoidRootPart.Position).Magnitude)
                        v298.NpcEspes.TextLabel.Text = v298.Name .. " - " .. v301 .. " Distance"
                    end
                end
            end
        end)
    end
end)
function isnil(v302)
    local v303 = nil
    if v302 ~= v303 then
        local _ = false
    end
    return true
end
local function v306(v305)
    return math.floor(tonumber(v305) + 0.5)
end
Number = math.random(1, 1000000)
function UpdateIslandMirageESP()
    for _, v308 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v308_0 = v308
            pcall(function()
                if not MirageIslandESP then
                    if l_v308_0:FindFirstChild("NameEsp") then
                        l_v308_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v308_0.Name == "Mirage Island" then
                    if l_v308_0:FindFirstChild("NameEsp") then
                        l_v308_0.NameEsp.TextLabel.Text = l_v308_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v308_0.Position).Magnitude / 3) .. " M"
                    else
                        local v310 = Instance.new("BillboardGui", l_v308_0)
                        v310.Name = "NameEsp"
                        v310.ExtentsOffset = Vector3.new(0, 1, 0)
                        v310.Size = UDim2.new(1, 200, 1, 30)
                        v310.Adornee = l_v308_0
                        v310.AlwaysOnTop = true
                        local v311 = Instance.new("TextLabel", v310)
                        v311.Font = "Code"
                        v311.FontSize = "Size14"
                        v311.TextWrapped = true
                        v311.Size = UDim2.new(1, 0, 1, 0)
                        v311.TextYAlignment = "Top"
                        v311.BackgroundTransparency = 1
                        v311.TextStrokeTransparency = 0.5
                        v311.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            end)
        end
    end
end
function UpdatePrehistoricIslandESP()
    for _, v313 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v313_0 = v313
            pcall(function()
                if not PrehistoricIslandESP then
                    if l_v313_0:FindFirstChild("NameEsp") then
                        l_v313_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v313_0.Name == "PrehistoricIsland" then
                    if not l_v313_0:FindFirstChild("NameEsp") then
                        local v315 = Instance.new("BillboardGui", l_v313_0)
                        v315.Name = "NameEsp"
                        v315.ExtentsOffset = Vector3.new(0, 1, 0)
                        v315.Size = UDim2.new(1, 200, 1, 30)
                        v315.Adornee = l_v313_0
                        v315.AlwaysOnTop = true
                        local v316 = Instance.new("TextLabel", v315)
                        v316.Font = "Code"
                        v316.FontSize = "Size14"
                        v316.TextWrapped = true
                        v316.Size = UDim2.new(1, 0, 1, 0)
                        v316.TextYAlignment = "Top"
                        v316.BackgroundTransparency = 1
                        v316.TextStrokeTransparency = 0.5
                        v316.TextColor3 = Color3.fromRGB(80, 245, 245)
                    else
                        l_v313_0.NameEsp.TextLabel.Text = l_v313_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v313_0.Position).Magnitude / 3) .. " M"
                    end
                end
            end)
        end
    end
end
function UpdateAfdESP()
    for _, v318 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
        do
            local l_v318_0 = v318
            pcall(function()
                if not AfdESP then
                    if l_v318_0:FindFirstChild("NameEsp") then
                        l_v318_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v318_0.Name == "Advanced Fruit Dealer" then
                    if l_v318_0:FindFirstChild("NameEsp") then
                        l_v318_0.NameEsp.TextLabel.Text = l_v318_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v318_0.Position).Magnitude / 3) .. " M"
                    else
                        local v320 = Instance.new("BillboardGui", l_v318_0)
                        v320.Name = "NameEsp"
                        v320.ExtentsOffset = Vector3.new(0, 1, 0)
                        v320.Size = UDim2.new(1, 200, 1, 30)
                        v320.Adornee = l_v318_0
                        v320.AlwaysOnTop = true
                        local v321 = Instance.new("TextLabel", v320)
                        v321.Font = "Code"
                        v321.FontSize = "Size14"
                        v321.TextWrapped = true
                        v321.Size = UDim2.new(1, 0, 1, 0)
                        v321.TextYAlignment = "Top"
                        v321.BackgroundTransparency = 1
                        v321.TextStrokeTransparency = 0.5
                        v321.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            end)
        end
    end
end
function UpdateAuraESP()
    for _, v323 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
        do
            local l_v323_0 = v323
            pcall(function()
                if AuraESP then
                    if l_v323_0.Name == "Master of Enhancement" then
                        if l_v323_0:FindFirstChild("NameEsp") then
                            l_v323_0.NameEsp.TextLabel.Text = l_v323_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v323_0.Position).Magnitude / 3) .. " M"
                        else
                            local v325 = Instance.new("BillboardGui", l_v323_0)
                            v325.Name = "NameEsp"
                            v325.ExtentsOffset = Vector3.new(0, 1, 0)
                            v325.Size = UDim2.new(1, 200, 1, 30)
                            v325.Adornee = l_v323_0
                            v325.AlwaysOnTop = true
                            local v326 = Instance.new("TextLabel", v325)
                            v326.Font = "Code"
                            v326.FontSize = "Size14"
                            v326.TextWrapped = true
                            v326.Size = UDim2.new(1, 0, 1, 0)
                            v326.TextYAlignment = "Top"
                            v326.BackgroundTransparency = 1
                            v326.TextStrokeTransparency = 0.5
                            v326.TextColor3 = Color3.fromRGB(80, 245, 245)
                        end
                    end
                elseif l_v323_0:FindFirstChild("NameEsp") then
                    l_v323_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end
function UpdateLSDESP()
    for _, v328 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
        do
            local l_v328_0 = v328
            pcall(function()
                if LADESP then
                    if l_v328_0.Name == "Legendary Sword Dealer" then
                        if l_v328_0:FindFirstChild("NameEsp") then
                            l_v328_0.NameEsp.TextLabel.Text = l_v328_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v328_0.Position).Magnitude / 3) .. " M"
                        else
                            local v330 = Instance.new("BillboardGui", l_v328_0)
                            v330.Name = "NameEsp"
                            v330.ExtentsOffset = Vector3.new(0, 1, 0)
                            v330.Size = UDim2.new(1, 200, 1, 30)
                            v330.Adornee = l_v328_0
                            v330.AlwaysOnTop = true
                            local v331 = Instance.new("TextLabel", v330)
                            v331.Font = "Code"
                            v331.FontSize = "Size14"
                            v331.TextWrapped = true
                            v331.Size = UDim2.new(1, 0, 1, 0)
                            v331.TextYAlignment = "Top"
                            v331.BackgroundTransparency = 1
                            v331.TextStrokeTransparency = 0.5
                            v331.TextColor3 = Color3.fromRGB(80, 245, 245)
                        end
                    end
                elseif l_v328_0:FindFirstChild("NameEsp") then
                    l_v328_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end
spawn(function()
    while wait() do
        if InfAbility then
            InfAb()
        end
    end
end)
function InfAb()
    if InfAbility then
        if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
            local l_ParticleEmitter_0 = Instance.new("ParticleEmitter")
            l_ParticleEmitter_0.Acceleration = Vector3.new(0, 0, 0)
            l_ParticleEmitter_0.Archivable = true
            l_ParticleEmitter_0.Drag = 20
            l_ParticleEmitter_0.EmissionDirection = Enum.NormalId.Top
            l_ParticleEmitter_0.Enabled = true
            l_ParticleEmitter_0.Lifetime = NumberRange.new(0, 0)
            l_ParticleEmitter_0.LightInfluence = 0
            l_ParticleEmitter_0.LockedToPart = true
            l_ParticleEmitter_0.Name = "Agility"
            l_ParticleEmitter_0.Rate = 500
            local v333 = {NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 4)}
            l_ParticleEmitter_0.Size = NumberSequence.new(v333)
            l_ParticleEmitter_0.RotSpeed = NumberRange.new(9999, 99999)
            l_ParticleEmitter_0.Rotation = NumberRange.new(0, 0)
            l_ParticleEmitter_0.Speed = NumberRange.new(30, 30)
            l_ParticleEmitter_0.SpreadAngle = Vector2.new(0, 0, 0, 0)
            l_ParticleEmitter_0.Texture = ""
            l_ParticleEmitter_0.VelocityInheritance = 0
            l_ParticleEmitter_0.ZOffset = 2
            l_ParticleEmitter_0.Transparency = NumberSequence.new(0)
            l_ParticleEmitter_0.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 0, 0))
            l_ParticleEmitter_0.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
        end
    elseif game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility"):Destroy()
    end
end
function UpdateGeaESP()
    for _, v335 in pairs(game:GetService("Workspace").Map.MysticIsland:GetChildren()) do
        do
            local l_v335_0 = v335
            pcall(function()
                if not GearESP then
                    if l_v335_0:FindFirstChild("NameEsp") then
                        l_v335_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v335_0.Name == "MeshPart" then
                    if not l_v335_0:FindFirstChild("NameEsp") then
                        local v337 = Instance.new("BillboardGui", l_v335_0)
                        v337.Name = "NameEsp"
                        v337.ExtentsOffset = Vector3.new(0, 1, 0)
                        v337.Size = UDim2.new(1, 200, 1, 30)
                        v337.Adornee = l_v335_0
                        v337.AlwaysOnTop = true
                        local v338 = Instance.new("TextLabel", v337)
                        v338.Font = "Code"
                        v338.FontSize = "Size14"
                        v338.TextWrapped = true
                        v338.Size = UDim2.new(1, 0, 1, 0)
                        v338.TextYAlignment = "Top"
                        v338.BackgroundTransparency = 1
                        v338.TextStrokeTransparency = 0.5
                        v338.TextColor3 = Color3.fromRGB(80, 245, 245)
                    else
                        l_v335_0.NameEsp.TextLabel.Text = l_v335_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v335_0.Position).Magnitude / 3) .. " M"
                    end
                end
            end)
        end
    end
end
function UpdateBerriesESP()
    local l_Tagged_0 = game:GetService("CollectionService"):GetTagged("BerryBush")
    for _, v341 in pairs(l_Tagged_0) do
        do
            local l_v341_0 = v341
            pcall(function()
                for _, v344 in pairs(l_v341_0:GetAttributes()) do
                    if not v344 then
                        if l_v341_0.Parent:FindFirstChild("NameEsp") then
                            l_v341_0.Parent:FindFirstChild("NameEsp"):Destroy()
                        end
                    else
                        if not l_v341_0.Parent:FindFirstChild("BerryESP") then
                            local v345 = Instance.new("BillboardGui", l_v341_0.Parent)
                            v345.Name = "BerryESP"
                            v345.ExtentsOffset = Vector3.new(0, 2, 0)
                            v345.Size = UDim2.new(1, 200, 1, 30)
                            v345.Adornee = l_v341_0.Parent
                            v345.AlwaysOnTop = true
                            local v346 = Instance.new("TextLabel", v345)
                            v346.Font = Enum.Font.GothamSemibold
                            v346.TextSize = 14
                            v346.TextWrapped = true
                            v346.Size = UDim2.new(1, 0, 1, 0)
                            v346.TextYAlignment = Enum.TextYAlignment.Top
                            v346.BackgroundTransparency = 1
                            v346.TextStrokeTransparency = 0.5
                            v346.TextColor3 = Color3.fromRGB(255, 255, 0)
                            v346.Text = v344
                        end
                        if l_v341_0.Parent:FindFirstChild("BerryESP") then
                            local l_LocalPlayer_0 = game.Players.LocalPlayer
                            if l_LocalPlayer_0 and l_LocalPlayer_0.Character and l_LocalPlayer_0.Character:FindFirstChild("Head") then
                                local l_Position_0 = l_LocalPlayer_0.Character.Head.Position
                                local l_Magnitude_0 = (l_v341_0.Parent:GetPivot().Position - l_Position_0).Magnitude
                                l_v341_0.Parent.BerryESP.TextLabel.Text = v344 .. "\n" .. math.floor(l_Magnitude_0) .. "m"
                            end
                        end
                    end
                end
            end)
        end
    end
end
function UpdateIslandKisuneESP()
    for _, v351 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v351_0 = v351
            pcall(function()
                if not KitsuneIslandEsp then
                    if l_v351_0:FindFirstChild("NameEsp") then
                        l_v351_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v351_0.Name == "Kitsune Island" then
                    if l_v351_0:FindFirstChild("NameEsp") then
                        l_v351_0.NameEsp.TextLabel.Text = l_v351_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v351_0.Position).Magnitude / 3) .. " M"
                    else
                        local v353 = Instance.new("BillboardGui", l_v351_0)
                        v353.Name = "NameEsp"
                        v353.ExtentsOffset = Vector3.new(0, 1, 0)
                        v353.Size = UDim2.new(1, 200, 1, 30)
                        v353.Adornee = l_v351_0
                        v353.AlwaysOnTop = true
                        local v354 = Instance.new("TextLabel", v353)
                        v354.Font = "Code"
                        v354.FontSize = "Size14"
                        v354.TextWrapped = true
                        v354.Size = UDim2.new(1, 0, 1, 0)
                        v354.TextYAlignment = "Top"
                        v354.BackgroundTransparency = 1
                        v354.TextStrokeTransparency = 0.5
                        v354.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            end)
        end
    end
end
function AutoHaki()
    local l_Character_0 = game:GetService("Players").LocalPlayer.Character
    if l_Character_0 and not l_Character_0:FindFirstChild("HasBuso") then
        local l_CommF__0 = game:GetService("ReplicatedStorage").Remotes.CommF_
        if l_CommF__0 then
            l_CommF__0:InvokeServer("Buso")
        end
    end
end
function UnEquipWeapon(v357)
    if game.Players.LocalPlayer.Character:FindFirstChild(v357) then
        _G.NotAutoEquip = true
        wait(0.5)
        game.Players.LocalPlayer.Character:FindFirstChild(v357).Parent = game.Players.LocalPlayer.Backpack
        wait(0.1)
        _G.NotAutoEquip = false
    end
end
function EquipWeapon(v358)
    if not _G.NotAutoEquip and game.Players.LocalPlayer.Backpack:FindFirstChild(v358) then
        Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(v358)
        wait(0.1)
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
    end
end
spawn(function()
    pcall(function()
        if getrawmetatable and (setreadonly or make_writeable) and newcclosure then
            local v359 = getrawmetatable(game)
            local l___namecall_0 = v359.__namecall
            if setreadonly then
                setreadonly(v359, false)
            else
                make_writeable(v359)
            end
            v359.__namecall = newcclosure(function(...)
                local v361 = getnamecallmethod()
                local v362 = {...}
                if (tostring(v361) == "FireServer" or tostring(v361) == "InvokeServer") then
                    local targetPos = nil
                    if _G.UseSkill and PosMon then
                        targetPos = PosMon.Position
                    elseif _G.AutoShootGun and _G.ShootTargetPos then
                        targetPos = _G.ShootTargetPos
                    end
                    
                    if targetPos then
                        local modified = false
                        for i = 2, #v362 do
                            local t = typeof(v362[i])
                            if t == "CFrame" then
                                v362[i] = CFrame.new(targetPos)
                                modified = true
                            elseif t == "Vector3" then
                                v362[i] = targetPos
                                modified = true
                            end
                        end
                        if modified then
                            return l___namecall_0(unpack(v362))
                        end
                    end
                end
                return l___namecall_0(...)
            end)
        end
    end)
end)
spawn(function()
    pcall(function()
        while task.wait() do
            for _, v364 in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                if v364:IsA("Tool") and v364:FindFirstChild("RemoteFunctionShoot") then
                    CurrentEquipGun = v364.Name
                end
            end
        end
    end)
end)
function StopTween(state)
    local player = game:GetService("Players").LocalPlayer
    local char = player.Character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if not state then
        _G.StopTween = true

        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        hrp.Velocity = Vector3.zero

        for _,obj in pairs(hrp:GetChildren()) do
            if obj:IsA("BodyVelocity")
            or obj:IsA("BodyGyro")
            or obj:IsA("BodyPosition")
            or obj:IsA("AlignPosition")
            or obj:IsA("AlignOrientation") then
                obj:Destroy()
            end
        end

        if hrp:FindFirstChild("BodyClip") then
            hrp.BodyClip:Destroy()
        end
        if char:FindFirstChild("Block") then
            char.Block:Destroy()
        end
    end
end
function CancelTween23()
    if _G.StopTween then return end

    if plr.Character.Head:FindFirstChild("BodyVelocity") then
        plr.Character.Head.BodyVelocity:Destroy()
    end
    if plr.Character:FindFirstChild("PartTele") then
        plr.Character.PartTele:Destroy()
    end
    NoClip = false
end

_G.FarmDistance = _G.FarmDistance or 10
_G.FarmHeight = _G.FarmHeight or 20
_G.OrbitSpeed = _G.OrbitSpeed or 4
_G.StarIndex = _G.StarIndex or 1
_G.StarDelay = _G.StarDelay or 0.50
_G.LastStar = _G.LastStar or 0
_G.BringDistance = _G.BringDistance or 50

local StarPoints = {
    Vector3.new(10, _G.FarmHeight, 0),
    Vector3.new(-10, _G.FarmHeight, 0),
    Vector3.new(0, _G.FarmHeight, 10),
    Vector3.new(0, _G.FarmHeight, -10),
    Vector3.new(7, _G.FarmHeight, 7),
    Vector3.new(-7, _G.FarmHeight, -7)
}

function FarmModePosition(basePos)
    local t = tick()
    local d = _G.FarmDistance
    local h = _G.FarmHeight

    if _G.FarmMode == "Orbit" then
        return CFrame.new(basePos + Vector3.new(
            math.cos(t * _G.OrbitSpeed) * d,
            h,
            math.sin(t * _G.OrbitSpeed) * d
        ))

    elseif _G.FarmMode == "Star" then
        if tick() - _G.LastStar > _G.StarDelay then
            _G.LastStar = tick()
            _G.StarIndex = (_G.StarIndex % #StarPoints) + 1
        end

        return CFrame.new(basePos + StarPoints[_G.StarIndex])

    else
        return CFrame.new(basePos + Vector3.new(0, h, 0))
    end
end

function KillMob(v373, v374)
    pcall(function()
        local thismob = DetectMob2(v373)
        if thismob and thismob:FindFirstChild("HumanoidRootPart") and thismob:FindFirstChild("Humanoid") and thismob.Humanoid.Health > 0 then
            repeat
                task.wait()
                if type(Buso) == "function" then Buso() end
                if type(EquipWeapon) == "function" then EquipWeapon() end
                NoClip = true

                local hrp = thismob.HumanoidRootPart
                local pos = hrp.Position
                
                local novaPosicao = FarmModePosition(pos)
                
                Tween23(CFrame.new(novaPosicao))
                BringPos = hrp.CFrame
                MonFarm = thismob.Name
                PosMon = hrp.CFrame
                StartBring = true
            until not thismob.Parent or not thismob:FindFirstChild("Humanoid") or thismob.Humanoid.Health <= 0 or not thismob:FindFirstChild("HumanoidRootPart") or v374()

            NoClip = false
            CancelTween23()
            StartBring = false
        end
    end)
end

spawn(function()
    while wait() do
        pcall(function()
            if NoClip ~= true then
                if plr.Character.Head:FindFirstChild("Nigga") then
                    plr.Character.Head:FindFirstChild("Nigga"):Destroy()
                end
            else
                if not plr.Character.Head:FindFirstChild("Nigga") then
                    local v375 = Instance.new("BodyVelocity", plr.Character.Head)
                    v375.P = 1500
                    v375.Name = "Nigga"
                    v375.MaxForce = Vector3.new(0, 100000, 0)
                    v375.Velocity = Vector3.new(0, 0, 0)
                end
                for _, v377 in pairs(plr.Character:GetDescendants()) do
                    if v377:IsA("BasePart") then
                        v377.CanCollide = false
                    end
                end
            end
        end)
    end
end)
function EquipAllWeapon()
    pcall(function()
        for _, v389 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v389:IsA("Tool") and v389.Name ~= "Summon Sea Beast" and v389.Name ~= "Water Body" and v389.Name ~= "Awakening" then
                local l_FirstChild_0 = game.Players.LocalPlayer.Backpack:FindFirstChild(v389.Name)
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(l_FirstChild_0)
                wait(1)
            end
        end
    end)
end
v391 = false
function WaitHRP(v392)
    if v392 then
        return v392.Character:WaitForChild("HumanoidRootPart", 9)
    else
        return 
    end
end
function CheckNearestTeleporter(v393)
    local l_Position_1 = v393.Position
    local l_huge_0 = math.huge
    local v396 = nil
    local l_PlaceId_1 = game.PlaceId
    local v398 = {}
    if l_PlaceId_1 ~= 2753915549 then
        if l_PlaceId_1 ~= 4442272183 then
            if l_PlaceId_1 == 7449423635 then
                v398 = {
                    ["Floating Turtle"] = Vector3.new(-12462, 375, -7552),
                    ["Hydra Island"] = Vector3.new(5657.88623046875, 1013.0790405273438, -335.4996337890625),
                    Mansion = Vector3.new(-12462, 375, -7552),
                    Castle = Vector3.new(-5036, 315, -3179),
                    ["Dimensional Shift"] = Vector3.new(-2097.3447265625, 4776.24462890625, -15013.4990234375),
                    ["Beautiful Pirate"] = Vector3.new(5319, 23, -93),
                    ["Beautiful Room"] = Vector3.new(5314.58203, 22.5364361, -125.942276, 1, 2.14762768E-8, -1.99111154E-13, -2.14762768E-8, 1, -3.0510602E-8, 1.98455903E-13, 3.0510602E-8, 1),
                    ["Temple of Time"] = Vector3.new(28286, 14897, 103)
                }
            end
        else
            v398 = {
                ["Swan Mansion"] = Vector3.new(-390, 332, 673),
                ["Swan Room"] = Vector3.new(2285, 15, 905),
                ["Cursed Ship"] = Vector3.new(923, 126, 32852),
                ["Zombie Island"] = Vector3.new(-6509, 83, -133)
            }
        end
    else
        v398 = {
            Sky3 = Vector3.new(-7894, 5547, -380),
            Sky3Exit = Vector3.new(-4607, 874, -1667),
            UnderWater = Vector3.new(61163, 11, 1819),
            ["Underwater City"] = Vector3.new(61165.19140625, 0.18704631924629211, 1897.379150390625),
            ["Pirate Village"] = Vector3.new(-1242.4625244140625, 4.787059783935547, 3901.282958984375),
            UnderwaterExit = Vector3.new(4050, -1, -1814)
        }
    end
    for _, v400 in pairs(v398) do
        local l_Magnitude_1 = (v400 - l_Position_1).Magnitude
        if l_Magnitude_1 < l_huge_0 then
            l_huge_0 = l_Magnitude_1
            v396 = v400
        end
    end
    if l_huge_0 <= (l_Position_1 - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude then
        return v396
    else
        return 
    end
end
function requestEntrance(v402)
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", v402)
    local l_HumanoidRootPart_3 = game.Players.LocalPlayer.Character.HumanoidRootPart
    l_HumanoidRootPart_3.CFrame = l_HumanoidRootPart_3.CFrame + Vector3.new(0, 50, 0)
    task.wait(0.5)
end
function TelePPlayer(v404)
    if _G.PlayerRespawning then return end
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v404
end


-- ========== TWEEN BAY CUA HIRU HUB (be nguyen cau truc tu Hiru) ==========
-- Toc do bay mac dinh = 191, lien ket voi setting farm: Misc Tween Speed + FarmMode/Distance/Height
if not TweenSpeed then TweenSpeed = 191 end
if not _G.TweenSpeed then _G.TweenSpeed = 191 end
if not getgenv().TweenSpeed then getgenv().TweenSpeed = 191 end
if not _G.FlySpeed then _G.FlySpeed = 191 end
if not getgenv().FlySpeed then getgenv().FlySpeed = 191 end
-- Dong bo toc do bay: Misc (Tween Speed) <-> Farm (FarmModule) <-> Hiru TweenSpeed
local function _HiruSyncFlySpeed()
    local s = getgenv().TweenSpeed or _G.TweenSpeed or getgenv().FlySpeed or _G.FlySpeed or TweenSpeed or 191
    TweenSpeed = s; _G.TweenSpeed = s; getgenv().TweenSpeed = s; _G.FlySpeed = s; getgenv().FlySpeed = s
    return s
end
function CheckNearestTeleporter(aI)
    local MyLevel = 0
    pcall(function() MyLevel = game.Players.LocalPlayer.Data.Level.Value end)
    local vcspos = aI.Position
    local min = math.huge
    local min2 = math.huge
    local y = game.PlaceId
    local World1, World2, World3
    if y == 2753915549 then
        World1 = true
    elseif y == 4442272183 then
        World2 = true
    elseif y == 7449423635 then
        World3 = true
    end
    local TableLocations = {}
    if World3 then
        TableLocations = {
            ["Mansion"] = Vector3.new(-12471, 374, -7551),
            ["Hydra"] = Vector3.new(5659, 1013, -341),
            ["Caslte On The Sea"] = Vector3.new(-5092, 315, -3130),
            ["Floating Turtle"] = Vector3.new(-12001, 332, -8861),
            ["Beautiful Pirate"] = Vector3.new(5319, 23, -93),
            ["Temple Of Time"] = Vector3.new(28286, 14897, 103)
        }
    elseif World2 then
        TableLocations = {
            ["Flamingo Mansion"] = Vector3.new(-317, 331, 597),
            ["Flamingo Room"] = Vector3.new(2283, 15, 867),
            ["Cursed Ship"] = Vector3.new(923, 125, 32853),
            ["Zombie Island"] = Vector3.new(-6509, 83, -133)
        }
    elseif World1 then
        TableLocations = {
            ["Sky Island 1"] = Vector3.new(-4652, 873, -1754),
            ["Sky Island 2"] = Vector3.new(-7895, 5547, -380),
            ["Under Water Island"] = Vector3.new(61164, 5, 1820),
            ["Under Water Island Entrace"] = Vector3.new(3865, 5, -1926)
        }
    end
    local TableLocations2 = {}
    for r, v in pairs(TableLocations) do
        TableLocations2[r] = (v - vcspos).Magnitude
    end
    for r, v in pairs(TableLocations2) do
        if v < min then
            min = v
            min2 = v
        end
    end
    local choose
    for r, v in pairs(TableLocations2) do
        if v <= min then
            choose = TableLocations[r]
        end
    end
    local min3 = (vcspos - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if min2 <= min3 then
        return choose
    end
end
function requestEntrance(aJ)
    local args = {"requestEntrance", aJ}
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
    local oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    local char = game.Players.LocalPlayer.Character.HumanoidRootPart
    char.CFrame = CFrame.new(oldcframe.X, oldcframe.Y + 50, oldcframe.Z)
    task.wait(0.5)
end
function topos(Tween_Pos)
    pcall(function()
        if game:GetService("Players").LocalPlayer
            and game:GetService("Players").LocalPlayer.Character
            and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
            and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            and game:GetService("Players").LocalPlayer.Character.Humanoid.Health > 0
            and game:GetService("Players").LocalPlayer.Character.HumanoidRootPart then
            -- Lien ket toc do bay: 191 mac dinh, doi theo Misc Tween Speed
            _HiruSyncFlySpeed()
            if not TweenSpeed then
                TweenSpeed = 191
            end
            -- Lien ket Farm Mode: dich gan (dang farm mob) thi ap dung Up/Orbit/Star
            local _finalPos = Tween_Pos
            local _dist0 = (Tween_Pos.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
            if _dist0 <= 300 and _G.FarmModule and _G.FarmModule.GetFarmCFrame and ((_G.FarmMode or "Up") ~= "Up") then
                pcall(function() _finalPos = _G.FarmModule.GetFarmCFrame(Tween_Pos) end)
            end
            DefualtY = _finalPos.Y
            TargetY = _finalPos.Y
            targetCFrameWithDefualtY = CFrame.new(_finalPos.X, DefualtY, _finalPos.Z)
            targetPos = _finalPos.Position
            oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            Distance = (targetPos - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
            if Distance <= 300 and ((_G.FarmMode or "Up") == "Up") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = _finalPos
            end
            local aM = CheckNearestTeleporter(_finalPos)
            if aM then
                pcall(function()
                    tween:Cancel()
                end)
                requestEntrance(aM)
            end
            b1 = CFrame.new(
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,
                DefualtY,
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z
            )
            IngoreY = true
            if IngoreY and (b1.Position - targetCFrameWithDefualtY.Position).Magnitude > 5 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,
                    DefualtY,
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z
                )
                local tweenfunc = {}
                local aN = game:GetService("TweenService")
                local aO = TweenInfo.new(
                    (targetPos - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude / TweenSpeed,
                    Enum.EasingStyle.Linear
                )
                tween = aN:Create(
                    game:GetService("Players").LocalPlayer.Character["HumanoidRootPart"],
                    aO,
                    {CFrame = targetCFrameWithDefualtY}
                )
                tween:Play()
                function tweenfunc:Stop()
                    tween:Cancel()
                end
                tween.Completed:Wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,
                    TargetY,
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z
                )
            else
                local tweenfunc = {}
                local aN = game:GetService("TweenService")
                local aO = TweenInfo.new(
                    (targetPos - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude / TweenSpeed,
                    Enum.EasingStyle.Linear
                )
                tween = aN:Create(
                    game:GetService("Players").LocalPlayer.Character["HumanoidRootPart"],
                    aO,
                    {CFrame = _finalPos}
                )
                tween:Play()
                function tweenfunc:Stop()
                    tween:Cancel()
                end
                tween.Completed:Wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,
                    TargetY,
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z
                )
            end
            if not tween then
                return tween
            end
            return tweenfunc
        end
    end)
end
function StopTween(target)
    pcall(function()
        if not target then
            getgenv().StopTween = true
            if tween then
                tween:Cancel()
                tween = nil
            end
            if getgenv().currentTween then
                pcall(function() getgenv().currentTween:Cancel() end)
                getgenv().currentTween = nil
            end
            local player = game:GetService("Players").LocalPlayer
            local character = player and player.Character
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                humanoidRootPart.Anchored = true
                task.wait(0.1)
                humanoidRootPart.CFrame = humanoidRootPart.CFrame
                humanoidRootPart.Anchored = false
            end
            local bodyClip = humanoidRootPart and humanoidRootPart:FindFirstChild("BodyClip")
            if bodyClip then
                bodyClip:Destroy()
            end
            getgenv().StopTween = false
            getgenv().Clip = false
        end
    end)
end
-- ========== HET TWEEN HIRU ==========
function stopTeleport()
    v391 = false
    local l_LocalPlayer_2 = game.Players.LocalPlayer
    if l_LocalPlayer_2.Character:FindFirstChild("PartTele") then
        l_LocalPlayer_2.Character.PartTele:Destroy()
    end
end
spawn(function()
    while task.wait() do
        if not v391 then
            stopTeleport()
        end
    end
end)
spawn(function()
    local l_LocalPlayer_3 = game.Players.LocalPlayer
    while task.wait() do
        pcall(function()
            if l_LocalPlayer_3.Character:FindFirstChild("PartTele") and (l_LocalPlayer_3.Character.HumanoidRootPart.Position - l_LocalPlayer_3.Character.PartTele.Position).Magnitude >= 500 then
                stopTeleport()
            end
        end)
    end
end)
l_LocalPlayer_4 = game.Players.LocalPlayer
local function v417(v416)
    v416:WaitForChild("Humanoid").Died:Connect(function()
        stopTeleport()
    end)
end
l_LocalPlayer_4.CharacterAdded:Connect(v417)
if l_LocalPlayer_4.Character then
    v417(l_LocalPlayer_4.Character)
end
function TP1(v418)
    topos(v418)
end
spawn(function()
    while wait() do
        if _G.SpinPos then
            Pos = CFrame.new(0, PosY, -20)
            wait(0.1)
            Pos = CFrame.new(-20, PosY, 0)
            wait(0.1)
            Pos = CFrame.new(0, PosY, 20)
            wait(0.1)
            Pos = CFrame.new(20, PosY, 0)
        else
            Pos = CFrame.new(0, PosY, 0)
        end
    end
end)
spawn(function()
    while task.wait() do
        pcall(function()
            if _G.FarmBone or _G.AutoFarm or _G.AutoFarmMastery or _G.Pray or _G.Trylux or _G.Hallow or _G.FarmCake or _G.FarmDaiBan or _G.Greybeard or _G.CursedCaptain or _G.AutoDarkBoss or _G.ChiefWarden or _G.Trident or _G.Longsword or _G.GravityBlade or _G.SwodsFlail or _G.AutoRengoku or _G.SwodsDRTrident or _G.SwodCanvande or _G.SwodsBuddy or _G.FarmBlazeEM or _G.AutoFindPrehistoric or _G.TweenVolcano or _G.DefendVolcano or _G.KillGolem or _G.SwodTwinHooks or _G.Fullykatakuri or _G.AutoBoss or _G.SwodCanvander or _G.AutoFarmMaterial or _G.AutoSecondSea or _G.Autosaw or _G.ChiefWarden or _G.Trident or _G.AutoSaber or _G.ThirdSea or _G.AutoBartilo or _G.AutoFactory or _G.Longsword or _G.GravityBlade or _G.SwodsFlail or _G.AutoRengoku or _G.SwodsDRTrident or _G.SwodTwinHooks or _G.SwodCanvander or _G.AutoRaidPirate or _G.AutoQuestYama or _G.AutoYamaQuest or _G.AutoSaber or _G.DefendVolcano or _G.TPB or _G.SailBoat or _G.Autoterrorshark or _G.KillShark or _G.KillPiranha or _G.KillFishCrew or _G.AutoQuestRace or _G.Dungeon or _G.AutoLawRaid or _G.Tweenfruit or ProjectTrialPro or _G.TweenMGear or _G.AutoMysticIsland or AutoUpgradeRace or AutoRaceEvo1 or _G.AutoFarmFruits or _G.Autopole or _G.Autosaw or _G.AutoElitehunter or FarmMtrFruit or _G.AutoNear or _G.CollectBerry or _G.RipIndraKill or _G.FarmChocola or SoulGuitar or _G.AutoHolyTorch or _G.AutoGetTushita or _G.AutoYama or _G.AutoMobDragon or _G.AutoHydraTree or _G.TweenToKitsune or _G.AutoDooHee or _G.AutoAzuerEmber or _G.TweenVolcano or _G.Dungeon or _G.AutoLawRaid or _G.TweenFruit or _G.Grabfruit or _G.TeleportIsland or _G.TeleportNPC or _G.SafeMode or _G.AutoPlayerHunter or _G.AutoKillPlayer or _G.TeleportPly or _G.AutoQuestBoss or _G.AutoAllBoss or _G.AutoFarmLevelNew or _G.FarmSummer or _G.BossPain then
                if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                    local l_BodyVelocity_2 = Instance.new("BodyVelocity")
                    l_BodyVelocity_2.Name = "BodyClip"
                    l_BodyVelocity_2.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                    l_BodyVelocity_2.MaxForce = Vector3.new(100000, 100000, 100000)
                    l_BodyVelocity_2.Velocity = Vector3.new(0, 0, 0)
                end
            else
                local _bc = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip")
                if _bc then _bc:Destroy() end
                -- Neu khong con Farm nao bat thi cung xoa BodyVelocity Anti-Gravity cua minh (tranh 2 he giu nhau)
                if not FarmAG_AnyOn() then pcall(function() RemoveAntiGravity() end) end
            end
        end)
    end
end)
spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if _G.FarmBone or _G.AutoFarm or _G.AutoFarmMastery or _G.Pray or _G.Trylux or _G.Hallow or _G.FarmCake or _G.FarmDaiBan or _G.Fullykatakuri or _G.AutoBoss or _G.AutoMateria or _G.AutoSecondSea or _G.Autosaw or _G.ChiefWarden or _G.Trident or _G.AutoSaber or _G.Greybeard or _G.CursedCaptain or _G.AutoDarkBoss or _G.ChiefWarden or _G.Trident or _G.Longsword or _G.GravityBlade or _G.SwodsFlail or _G.AutoRengoku or _G.SwodsDRTrident or _G.SwodCanvande or _G.SwodTwinHooks or _G.ThirdSea or _G.AutoBartilo or _G.AutoFactory or _G.Longsword or _G.GravityBlade or _G.SwodsFlail or _G.AutoRengoku or _G.SwodsDRTrident or _G.SwodTwinHooks or _G.SwodCanvander or _G.SwodsBuddy or _G.FarmBlazeEM or _G.AutoFindPrehistoric or _G.TweenVolcano or _G.DefendVolcano or _G.KillGolem or _G.AutoRaidPirate or _G.AutoQuestYama or _G.AutoYamaQuest or _G.AutoElitehunter or FarmMtrFruit or AutoUpgradeRace or _G.AutoFarmMaterial or AutoRaceEvo1 or AutoSaber or _G.Autopole or _G.SwodCanvander or _G.DefendVolcano or _G.SailBoat or _G.Autoterrorshark or _G.KillShark or _G.KillPiranha or _G.KillFishCrew or _G.AutoQuestRace or _G.Dungeon or _G.AutoLawRaid or _G.Tweenfruit or ProjectTrialPro or _G.AutoMysticIsland or _G.TweenMGear or _G.Autosaw or _G.AutoNear or _G.AutoFarmFruits or _G.CollectBerry or _G.RipIndraKill or _G.FarmChocola or SoulGuitar or _G.AutoHolyTorch or _G.AutoGetTushita or _G.AutoYama or _G.AutoMobDragon or _G.AutoHydraTree or _G.TweenToKitsune or _G.AutoDooHee or _G.AutoAzuerEmber or _G.TweenVolcano or _G.Dungeon or _G.AutoLawRaid or _G.TweenFruit or _G.Grabfruit or _G.TeleportIsland or _G.TeleportNPC or _G.SafeMode or _G.AutoPlayerHunter or _G.AutoKillPlayer or _G.TeleportPly or _G.AutoQuestBoss or _G.AutoAllBoss or _G.AutoFarmLevelNew or _G.FarmSummer or _G.BossPain then
                for _, v421 in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                    if v421:IsA("BasePart") then
                        v421.CanCollide = false
                    end
                end
            end
        end)
    end)
end)
v422 = {}
function TP13(v423)
    local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
    local distance = (v423.Position - hrp.Position).Magnitude
    local duration = TweenSpeed > 0 and distance / TweenSpeed or 0.001

    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    local tween = game:GetService("TweenService"):Create(hrp, tweenInfo, {CFrame = v423})
    tween:Play()
    v422.Stop = function()
        tween:Cancel()
        hrp.CFrame = v423 
    end
    if TweenSpeed == 0 then
        tween:Cancel()
        hrp.CFrame = v423
    end

    return v422
end
function fastpos(v427)
    Distance = (v427.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    Speed = 1000
    game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear), {CFrame = v427}):Play()
end
function slowpos(v428)
    Distance = (v428.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    Speed = 150
    game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear), {CFrame = v428}):Play()
end
_ = {}
function BTP(v430)
    pcall(function()
        if (v430.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1500 and not Auto_Raid and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
            repeat
                wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v430
                wait(0.05)
                game.Players.LocalPlayer.Character.Head:Destroy()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v430
            until (v430.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 1500 and game.Players.LocalPlayer.Character.Humanoid.Health > 0
        end
    end)
end
function TelePPlayer(v431)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v431
end
function TPB(v432)
    local v433 = game:service("TweenService")
    local v434 = TweenInfo.new((game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat.CFrame.Position - v432.Position).Magnitude / 300, Enum.EasingStyle.Linear)
    tween = v433:Create(game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat, v434, {CFrame = v432})
    tween:Play()
    return {Stop = function(_)
        tween:Cancel()
    end}
end
function TPP(v436)
    if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 and game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") then
        local v437 = game:service("TweenService")
        local v438 = TweenInfo.new((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - v436.Position).Magnitude / 325, Enum.EasingStyle.Linear)
        tween = v437:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, v438, {CFrame = v436})
        tween:Play()
        return {Stop = function(_)
            tween:Cancel()
        end}
    else
        tween:Cancel()
        repeat
            wait()
        until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") and game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0
        wait(7)
        return 
    end
end
-- StopTween: merged definition — properly stops active tweens and cleans up physics
function StopTween(v440)
    if not v440 then
        _G.StopTween = true
        pcall(function()
            local player = game:GetService("Players").LocalPlayer
            local char = player and player.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            -- Cancel active PartTele tween and destroy it
            stopTeleport()

            -- Zero out velocities
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
            pcall(function() hrp.Velocity = Vector3.zero end)

            -- Destroy all body movers
            for _, obj in pairs(hrp:GetChildren()) do
                if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") or obj:IsA("BodyPosition") or obj:IsA("AlignPosition") or obj:IsA("AlignOrientation") then
                    obj:Destroy()
                end
            end

            if hrp:FindFirstChild("BodyClip") then
                hrp.BodyClip:Destroy()
            end
            if char:FindFirstChild("Block") then
                char.Block:Destroy()
            end

            -- Un-anchor if stuck
            hrp.Anchored = false
        end)
        _G.StopTween = false
        _G.Clip = false
    end
end
spawn(function()
    pcall(function()
        while wait() do
            for _, v442 in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                if v442:IsA("Tool") and v442:FindFirstChild("RemoteFunctionShoot") then
                    _G.SelectWeaponGun = v442.Name
                end
            end
        end
    end)
end)
game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
function CheckColorRipIndra()
    mmb = {}
    for _, v444 in next, game:GetService("Workspace").Map["Boat Castle"].Summoner.Circle:GetChildren() do
        if v444:IsA("Part") and v444:FindFirstChild("Part") and v444.Part.BrickColor.Name == "Dark stone grey" then
            mmb[v444.BrickColor.Name] = v444
        end
    end
    return mmb
end
function ActivateColor(v445)
    haki = {["Hot pink"] = "Winter Sky", ["Really red"] = "Pure Red", Oyster = "Snow White"}
    runnay = haki[v445]
    if runnay then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor", runnay)
    end
end
function AutoActiveColorRip_Indra()
    for v446, v447 in pairs(CheckColorRipIndra()) do
        ActivateColor(v446)
        topos(v447.CFrame)
        firetouchinterest(v447.TouchInterest)
    end
end
function CheckRace()
    local v448 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
    local v449 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1")
    if not game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
        if v448 == -2 then
            return game:GetService("Players").LocalPlayer.Data.Race.Value .. " V3"
        elseif v449 == -2 then
            return game:GetService("Players").LocalPlayer.Data.Race.Value .. " V2"
        else
            return game:GetService("Players").LocalPlayer.Data.Race.Value .. " V1"
        end
    else
        return game:GetService("Players").LocalPlayer.Data.Race.Value .. " V4"
    end
end
_G.TargTrial = "TargTrial"
function targettrial()
    if _G.TargTrial == "TargTrial" then
        local v450 = nil
        local v451 = 450
        for _, v453 in pairs(game.Players:GetChildren()) do
            c = (v453.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if c <= v451 and v453 ~= game.Players.LocalPlayer then
                v451 = c
                v450 = v453
            end
        end
        if v450 == "c" then
            return 
        elseif _G.TargTrial == "c" then
            _G.TargTrial = v450
            return 
        else
            return 
        end
    else
        return 
    end
end
function CheckPirateBoat()
    local v454 = {"PirateBrigade", "PirateBrigade"}
    for _, v456 in next, game:GetService("Workspace").Enemies:GetChildren() do
        if table.find(v454, v456.Name) and v456:FindFirstChild("Health") and v456.Health.Value > 0 then
            return v456
        end
    end
end
function CheckPirateBoat()
    local v457 = {"FishBoat"}
    for _, v459 in next, game:GetService("Workspace").Enemies:GetChildren() do
        if table.find(v457, v459.Name) and v459:FindFirstChild("Health") and v459.Health.Value > 0 then
            return v459
        end
    end
end
function StoreFruit()
    for _, v461 in pairs(thelocal.Backpack:GetChildren()) do
        if v461:IsA("Tool") and string.find(v461.Name, "Fruit") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", v461:GetAttribute("OriginalName"), v461)
        end
    end
end
function TpEntrance(v462)
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", v462)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
    wait(0.5)
end
function CheckItemBPCRBPCR(v463)
    chbp = {game.Players.LocalPlayer.Character, game.Players.LocalPlayer.Backpack}
    for _, v465 in pairs(chbp) do
        if v465:FindFirstChild(v463) then
            return v465:FindFirstChild(v463)
        end
    end
end
vu32 = loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz999/NewRedz/refs/heads/main/Library/main.lua"))()
v466 = vu32:MakeWindow({
    Title = "redz hub : Blox Fruits",
    SubTitle = "by real_redz",
    SaveFolder = "Redz | redz lib v5.lua"
})

v466:AddMinimizeButton({
    Button = { Image = "rbxassetid://15298567397", BackgroundTransparency = 0 },
    Size = UDim2.new(0, 35, 0, 35),
    Corner = { CornerRadius = UDim.new(0.25, 0) },
})

v484 = v466:MakeTab({"Discord", "info"})
v485 = v466:MakeTab({"Farm", "home"})
v487 = v466:MakeTab({"Quest | Items", "swords"})
v486 = v466:MakeTab({"Auto Fishing", "rbxassetid://127664059821666"})
v489 = v466:MakeTab({"Sea Event", "waves"})
v490 = v466:MakeTab({"Race V4", "crown"})
v498 = v466:MakeTab({"Islands", "palmtree"})
v491 = v466:MakeTab({"Raid/Fruits", "cherry"})
v497 = v466:MakeTab({"Stats", "Signal"})
v493 = v466:MakeTab({"Teleport", "locate"})
-- Status tab moved to Discord
v494 = v466:MakeTab({"Visual", "user"})
v495 = v466:MakeTab({"Shop", "shoppingCart"})
v496 = v466:MakeTab({"Misc", "settings"})
local function createCustomDiscordInvite(Configs)
    local container = Configs.Tab.Cont
    if not container then return end

    local inviteHolder = Instance.new("Frame")
    inviteHolder.Name = "InviteHolder"
    inviteHolder.Size = UDim2.new(0, 220, 0, 150)
    inviteHolder.AnchorPoint = Vector2.new(0.5, 0)
    inviteHolder.Position = UDim2.new(0.5, 0, 0, 10)
    inviteHolder.BackgroundTransparency = 1
    inviteHolder.Parent = container

    local inviteLabel = Instance.new("TextLabel")
    inviteLabel.Name = "InviteLabel"
    inviteLabel.Size = UDim2.new(1, 0, 0, 15)
    inviteLabel.Position = UDim2.new(0, 5, 0, 0)
    inviteLabel.BackgroundTransparency = 1
    inviteLabel.Font = Enum.Font.GothamBold
    inviteLabel.Text = Configs.Invite or ""
    inviteLabel.TextColor3 = Color3.fromRGB(40, 150, 255)
    inviteLabel.TextSize = 9
    inviteLabel.TextXAlignment = Enum.TextXAlignment.Left
    inviteLabel.Parent = inviteHolder

    local card = Instance.new("Frame")
    card.Name = "Card"
    card.Size = UDim2.new(1, 0, 0, 135)
    card.Position = UDim2.new(0, 0, 0, 15)
    card.BackgroundColor3 = Color3.fromRGB(24, 25, 28)
    card.BorderSizePixel = 0
    card.Parent = inviteHolder

    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 8)
    cardCorner.Parent = card

    local cardStroke = Instance.new("UIStroke")
    cardStroke.Color = Color3.fromRGB(47, 49, 54)
    cardStroke.Thickness = 1
    cardStroke.Parent = card

    -- Banner (Solid red/pink header frame)
    local banner = Instance.new("Frame")
    banner.Name = "Banner"
    banner.Size = UDim2.new(1, 0, 0, 45)
    banner.BackgroundColor3 = Color3.fromRGB(243, 80, 100)
    banner.BorderSizePixel = 0
    banner.Parent = card

    local bannerCorner = Instance.new("UICorner")
    bannerCorner.CornerRadius = UDim.new(0, 8)
    bannerCorner.Parent = banner

    local bannerCover = Instance.new("Frame")
    bannerCover.Size = UDim2.new(1, 0, 0, 10)
    bannerCover.Position = UDim2.new(0, 0, 0, 35)
    bannerCover.BackgroundColor3 = Color3.fromRGB(24, 25, 28)
    bannerCover.BorderSizePixel = 0
    bannerCover.ZIndex = 1
    bannerCover.Parent = card

    -- Logo
    local logo = Instance.new("ImageLabel")
    logo.Name = "Logo"
    logo.Size = UDim2.new(0, 38, 0, 38)
    logo.Position = UDim2.new(0, 15, 0, 25)
    logo.Image = Configs.Logo or ""
    logo.BackgroundTransparency = 0
    logo.BackgroundColor3 = Color3.fromRGB(24, 25, 28)
    logo.ZIndex = 2
    logo.Parent = card

    local logoCorner = Instance.new("UICorner")
    logoCorner.CornerRadius = UDim.new(0, 10)
    logoCorner.Parent = logo

    local logoStroke = Instance.new("UIStroke")
    logoStroke.Color = Color3.fromRGB(24, 25, 28)
    logoStroke.Thickness = 3
    logoStroke.Parent = logo

    -- Server Name
    local serverName = Instance.new("TextLabel")
    serverName.Name = "ServerName"
    serverName.Size = UDim2.new(1, -30, 0, 20)
    serverName.Position = UDim2.new(0, 15, 0, 70)
    serverName.BackgroundTransparency = 1
    serverName.Font = Enum.Font.GothamBold
    serverName.Text = Configs.Name or "Community"
    serverName.TextColor3 = Color3.fromRGB(255, 255, 255)
    serverName.TextSize = 12
    serverName.TextXAlignment = Enum.TextXAlignment.Left
    serverName.Parent = card

    -- Description
    local desc = Instance.new("TextLabel")
    desc.Name = "Description"
    desc.Size = UDim2.new(1, -30, 0, 15)
    desc.Position = UDim2.new(0, 15, 0, 88)
    desc.BackgroundTransparency = 1
    desc.Font = Enum.Font.Gotham
    desc.Text = Configs.Description or "Join our community!"
    desc.TextColor3 = Color3.fromRGB(185, 187, 190)
    desc.TextSize = 9
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = card

    -- Join Button
    local btn = Instance.new("TextButton")
    btn.Name = "JoinButton"
    btn.Size = UDim2.new(1, -30, 0, 24)
    btn.Position = UDim2.new(0, 15, 0, 105)
    btn.BackgroundColor3 = Color3.fromRGB(36, 128, 70)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamBold
    btn.Text = "Go to Server"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 10
    btn.Parent = card

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn

    local clickDelay = false
    btn.Activated:Connect(function()
        setclipboard(Configs.Invite or "")
        if clickDelay then return end
        clickDelay = true
        btn.Text = "Copied to Clipboard!"
        btn.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
        task.wait(3)
        btn.Text = "Go to Server"
        btn.BackgroundColor3 = Color3.fromRGB(36, 128, 70)
        clickDelay = false
    end)
end

createCustomDiscordInvite({
    Tab = v484,
    Name = "RedzHub | Community",
    Description = "Join The Server To Recieve Updates!",
    Logo = "rbxthumb://type=Asset&id=93070017822513&w=420&h=420",
    Invite = "https://discord.gg/redzhub"
})
_G.SelectWeapon = "Melee"
task.spawn(function()
    while task.wait() do
        pcall(function()
            if _G.SelectWeapon ~= "Melee" then
                if _G.SelectWeapon ~= "Sword" then
                    if _G.SelectWeapon == "Gun" then
                        for _, v499 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v499.ToolTip == "Gun" then
                                _G.SelectWeapon = v499.Name
                            end
                        end
                    elseif _G.SelectWeapon == "Fruit" or _G.SelectWeapon == "Blox Fruit" then
                        for _, v501 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v501.ToolTip == "Blox Fruit" then
                                _G.SelectWeapon = v501.Name
                            end
                        end
                    end
                else
                    for _, v503 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if v503.ToolTip == "Sword" then
                            _G.SelectWeapon = v503.Name
                        end
                    end
                end
            else
                for _, v505 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v505.ToolTip == "Melee" then
                        _G.SelectWeapon = v505.Name
                    end
                end
            end
        end)
    end
end)

local FarmModule = {}
_G.FarmModule = FarmModule; getgenv().FarmModule = FarmModule
FarmModule.Mode = _G.FarmMode or ((GetSetting and GetSetting("Mode", "Up")) or "Up")
function FarmModule.SetMode(mode)
    if mode ~= "Up" and mode ~= "Orbit" and mode ~= "Star" then mode = "Up" end
    FarmModule.Mode = mode
    _G.FarmMode = mode; _G.Mode = mode; getgenv().FarmMode = mode; getgenv().Mode = mode
    _G.SaveData.Mode = mode; _G.SaveData.FarmMode = mode
    if SaveSettings then pcall(SaveSettings) end
    return mode
end
-- Vi tri farm theo Mode: Up = tren dau mob, Orbit = xoay tron, Star = doi diem ngoi sao
function FarmModule.GetFarmCFrame(mobCFrame)
    local base = mobCFrame.Position
    local d = _G.FarmDistance or 15
    local h = _G.FarmHeight or 10
    local mode = _G.FarmMode or FarmModule.Mode or "Up"
    if mode == "Orbit" then
        local a = tick() * (_G.OrbitSpeed or 4)
        return CFrame.new(base + Vector3.new(math.cos(a) * d, h, math.sin(a) * d))
    elseif mode == "Star" then
        local pts = {Vector3.new(10,h,0), Vector3.new(-10,h,0), Vector3.new(0,h,10), Vector3.new(0,h,-10), Vector3.new(7,h,7), Vector3.new(-7,h,-7)}
        if tick() - (_G.LastStar or 0) > (_G.StarDelay or 0.5) then _G.LastStar = tick(); _G.StarIndex = ((_G.StarIndex or 1) % #pts) + 1 end
        return CFrame.new(base + pts[_G.StarIndex or 1])
    else
        return CFrame.new(base + Vector3.new(0, h, 0))
    end
end
FarmModule.SetMode(FarmModule.Mode)

-- ========== TAB FARM CUA REDZ HUD (thay Farm Kurri cu cua 999) ==========
-- Giu FarmModule cua 999 de topos (Hiru, toc 191) + Misc dong bo Farm Mode
-- Cau noi hud <-> 999: hud dung getgenv()/_G, 999 dung _G.SaveData/GetSetting -> dong bo 2 chieu
if not RunSer then RunSer = game:GetService("RunService") end
if not Settings then Settings = _G.SaveData or {} end
if not _G.SaveData then _G.SaveData = Settings end
if getgenv().FarmMode == nil then getgenv().FarmMode = _G.FarmMode or "Up" end
if _G.FarmMode == nil then _G.FarmMode = getgenv().FarmMode end
if getgenv().FarmDistance == nil then getgenv().FarmDistance = _G.FarmDistance or 15 end
if getgenv().FarmHeight == nil then getgenv().FarmHeight = _G.FarmHeight or 15 end
if getgenv().TweenSpeed == nil then getgenv().TweenSpeed = 191 end
if not _tp and topos then _tp = topos end
if not topos and _tp then topos = _tp end
if not notween and _tp then notween = _tp end
-- Attack fallback: hud Farm goi Attack.Kill/Mas/Masgun/Sword, 999 co ham giet mob rieng -> noi qua EquipWeapon/topos neu Attack chua co
if not Attack then Attack = {} end
if not Attack.Kill then Attack.Kill = function(mob, on) pcall(function() if mob and mob:FindFirstChild("HumanoidRootPart") then topos(mob.HumanoidRootPart.CFrame * CFrame.new(0, (_G.FarmHeight or 15), 0)) end end) end end
if not Attack.Mas then Attack.Mas = Attack.Kill end
if not Attack.Masgun then Attack.Masgun = Attack.Kill end
if not Attack.Sword then Attack.Sword = Attack.Kill end
-- Ham hud Farm co the goi, neu 999 chua co thi stub an toan (khong chet script)
if not GetConnectionEnemies then GetConnectionEnemies = function(_) return nil end end
if not GetAllNearbyEnemies then GetAllNearbyEnemies = function() return nil end end
if not GetLevelMob then GetLevelMob = function() return nil end end
if not Mastery_TakeQuestIfNeeded then Mastery_TakeQuestIfNeeded = function() end end
if not GetBP then GetBP = function(_) return false end end
-- Farm Mode trong Farm tab (hud de o Settings, 999 de o Farm - giu o Farm cho de bat)
v485:AddDropdown({Name = "Farm Mode", Default = (getgenv().FarmMode or _G.FarmMode or "Up"), Options = {"Up", "Orbit", "Star"}, Callback = function(v) if _G.FarmModule and _G.FarmModule.SetMode then _G.FarmModule.SetMode(v) else getgenv().FarmMode = v; _G.FarmMode = v end end})
v485:AddSlider({Name = "Farm Distance", Min = 5, Max = 30, Default = (getgenv().FarmDistance or _G.FarmDistance or 15), Increase = 1, Callback = function(v) getgenv().FarmDistance = v; _G.FarmDistance = v; if _G.SaveData then _G.SaveData.FarmDistance = v end if SaveSettings then pcall(SaveSettings) end end})
v485:AddSlider({Name = "Farm Height", Min = 5, Max = 30, Default = (getgenv().FarmHeight or _G.FarmHeight or 15), Increase = 1, Callback = function(v) getgenv().FarmHeight = v; _G.FarmHeight = v; if _G.SaveData then _G.SaveData.FarmHeight = v end if SaveSettings then pcall(SaveSettings) end end})
-- Dong bo FarmMode lien tuc: hud <-> FarmModule <-> Misc (0.5s/lan, khong block)
task.spawn(function() while task.wait(0.5) do pcall(function() local m = getgenv().FarmMode or _G.FarmMode if m and _G.FarmModule and _G.FarmModule.Mode ~= m then _G.FarmModule.SetMode(m) end if _G.FarmModule and _G.FarmModule.Mode and getgenv().FarmMode ~= _G.FarmModule.Mode then getgenv().FarmMode = _G.FarmModule.Mode; _G.FarmMode = _G.FarmModule.Mode end end) end end)

-- ========== BRING MOB QUANTUM (nguyen bo code Quantum, lien ket Misc) ==========
-- Quantum goc: BringEnemies + Tag "QuantumBringTag" + BodyPosition BringBodyPos (P 8000, D 600).
-- Lien ket Misc (nguon duy nhat):
--   Bring Mobs (Misc, Bringgay / SaveData.B) -> bat / tat Bring
--   Bring Distance (Misc, _G.BringDistance / SaveData.BringDistance) -> BringMonsterRadius
--   Max Mob Bring (Misc, _G.MaxMobBring / SaveData.MaxMobBring) -> gioi han so mob dang bi keo + so mob moi / lan goi
local QuantumCollection = game:GetService("CollectionService")
local QuantumPlayers = game:GetService("Players")
local QuantumLocal = QuantumPlayers.LocalPlayer
local QuantumBringTag = "QuantumBringTag"
local QuantumBringCache = {}
local QuantumLastBringTick = 0
local QuantumLastSimTick = 0
local function QuantumFarmOn()
    return _G.StartFarm_Banana or _G.AutoFarm or _G.AutoFarmNear or _G.AutoFarm_Bone or _G.AutoFarmLevel_Banana or _G.FarmMastery or _G.FarmMastery_Dev or _G.FarmMastery_G or _G.FarmMastery_S or _G.AutoFarmEctoplasm or _G.AutoChest or _G.AutoCollectBerries or _G.AutoFarmAllBoss or _G.Level
end
local function QuantumBringEnabled()
    if Bringgay ~= nil then return Bringgay end
    if _G.SaveData and _G.SaveData.B ~= nil then return _G.SaveData.B end
    return true
end
local function QuantumBringRadius()
    local r = _G.BringDistance or (_G.SaveData and _G.SaveData.BringDistance) or 450
    return math.clamp(tonumber(r) or 450, 50, 1000)
end
local function QuantumMaxBring()
    local m = _G.MaxMobBring or (_G.SaveData and _G.SaveData.MaxMobBring) or 4
    return math.clamp(tonumber(m) or 4, 2, 8)
end
local function QuantumIsReady(mob)
    if not mob then return false end
    if QuantumPlayers:GetPlayerFromCharacter(mob) then return false end
    local hum = mob:FindFirstChildOfClass("Humanoid")
    local hrp = mob:FindFirstChild("HumanoidRootPart") or mob.PrimaryPart
    if not hum or not hrp then return false end
    if hum.Health <= 0 then return false end
    if mob:HasTag(QuantumBringTag) then return false end
    if hum.MaxHealth > 50000 then return false end
    if BossList and table.find(BossList, mob.Name) then return false end
    return true
end
-- Ham Bring chinh cua Quantum (nguyen logic)
local function QuantumBringEnemies(targetMob)
    if not QuantumBringEnabled() then return end
    if not QuantumFarmOn() then return end
    local char = QuantumLocal.Character
    local myHRP = char and char:FindFirstChild("HumanoidRootPart")
    local targetHRP = targetMob and (targetMob:FindFirstChild("HumanoidRootPart") or targetMob.PrimaryPart)
    if not myHRP or not targetHRP then return end
    local now = tick()
    if now - QuantumLastBringTick < 0.25 then return end
    QuantumLastBringTick = now
    local radius = QuantumBringRadius()
    local simRadius = math.clamp(radius + 50, 100, 500)
    if now - QuantumLastSimTick > 3 then
        QuantumLastSimTick = now
        pcall(function() sethiddenproperty(QuantumLocal, "SimulationRadius", simRadius) sethiddenproperty(QuantumLocal, "MaxSimulationRadius", simRadius) end)
    end
    QuantumBringCache[targetMob.Name] = targetHRP.CFrame
    -- Clean tag cua mob chet / mat
    for _, v in ipairs(QuantumCollection:GetTagged(QuantumBringTag)) do
        local h = v:FindFirstChildOfClass("Humanoid")
        if not v.Parent or not h or h.Health <= 0 then pcall(function() v:RemoveTag(QuantumBringTag) end) end
    end
    if #QuantumCollection:GetTagged(QuantumBringTag) >= QuantumMaxBring() then return end
    -- Vi tri nguoi choi khac (Quantum khong keo mob ve gan nguoi khac)
    local otherPositions = {}
    local charsFolder = workspace:FindFirstChild("Characters")
    if charsFolder then
        for _, v in ipairs(charsFolder:GetChildren()) do
            if v ~= char and v:IsA("Model") then
                local hr = v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart
                if hr then table.insert(otherPositions, hr.Position) end
            end
        end
    end
    local enemiesFolder = workspace:FindFirstChild("Enemies")
    if not enemiesFolder then return end
    local perCall = math.min(4, QuantumMaxBring())
    local added = 0
    for _, mob in ipairs(enemiesFolder:GetChildren()) do
        if mob ~= targetMob and mob.Name == targetMob.Name and QuantumIsReady(mob) and not QuantumPlayers:GetPlayerFromCharacter(mob) then
            local mHRP = mob:FindFirstChild("HumanoidRootPart") or mob.PrimaryPart
            local mHum = mob:FindFirstChildOfClass("Humanoid")
            if mHRP and mHum and mHum.Health > 0 then
                local pos = mHRP.Position
                if (pos - targetHRP.Position).Magnitude <= radius and (pos - myHRP.Position).Magnitude <= radius then
                    local nearOther = false
                    for _, op in ipairs(otherPositions) do if (pos - op).Magnitude <= 55 then nearOther = true break end end
                    if not nearOther then
                        mob:AddTag(QuantumBringTag)
                        added = added + 1
                        if added >= perCall then return end
                    end
                end
            end
        end
    end
end
-- Tag handler cua Quantum (nguyen logic): BodyPosition keo mob ve cache, het 25s / tat Bring / het Farm thi don dep + tra CanCollide
QuantumCollection:GetInstanceAddedSignal(QuantumBringTag):Connect(function(mob)
    task.spawn(function()
        local mHRP = mob:FindFirstChild("HumanoidRootPart") or mob.PrimaryPart
        local mHum = mob:FindFirstChildOfClass("Humanoid")
        if not mHRP or not mHum then pcall(function() mob:RemoveTag(QuantumBringTag) end) return end
        local name = mob.Name
        local bringBodyPos = mHRP:FindFirstChild("BringBodyPos")
        if not bringBodyPos then
            bringBodyPos = Instance.new("BodyPosition")
            bringBodyPos.Name = "BringBodyPos"
            bringBodyPos.MaxForce = Vector3.new(1000000, 1000000, 1000000)
            bringBodyPos.P = 8000
            bringBodyPos.D = 600
            bringBodyPos.Position = mHRP.Position
            bringBodyPos.Parent = mHRP
        end
        local deadline = tick() + 25
        local failCount = 0
        while true do
            if QuantumBringEnabled() and QuantumFarmOn() and mob.Parent and mHRP.Parent and mHum.Health > 0 and mob:HasTag(QuantumBringTag) and tick() < deadline then
                local myChar = QuantumLocal.Character
                local myHRP2 = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local cache = QuantumBringCache[name]
                local radius = QuantumBringRadius()
                if myHRP2 and cache then
                    if (myHRP2.Position - mHRP.Position).Magnitude <= radius + 50 then
                        for _, part in ipairs(mob:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end
                        mHRP.AssemblyLinearVelocity = Vector3.zero
                        mHRP.AssemblyAngularVelocity = Vector3.zero
                        bringBodyPos.Position = cache.Position
                        failCount = 0
                    else failCount = failCount + 1 end
                else failCount = failCount + 1 end
                if not (failCount > 15) then task.wait(0.04) continue end
            end
            break
        end
        pcall(function()
            if bringBodyPos and bringBodyPos.Parent then bringBodyPos:Destroy() end
            if mob:HasTag(QuantumBringTag) then mob:RemoveTag(QuantumBringTag) end
            for _, part in ipairs(mob:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = true end end
        end)
    end)
end)
-- Vong goi Quantum Bring: moi 0.25s, chi khi Bring bat + dang Farm, lay mob gan nguoi nhat trong Bring Distance
task.spawn(function()
    while task.wait(0.25) do
        pcall(function()
            if not QuantumBringEnabled() then return end
            if not QuantumFarmOn() then return end
            local plr = QuantumLocal
            local pr = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
            local enemiesFolder = workspace:FindFirstChild("Enemies")
            if not pr or not enemiesFolder then return end
            local radius = QuantumBringRadius()
            local target = nil local best = math.huge
            for _, m in ipairs(enemiesFolder:GetChildren()) do
                local mr = m:FindFirstChild("HumanoidRootPart")
                local mh = m:FindFirstChildOfClass("Humanoid")
                if mr and mh and mh.Health > 0 and not m:FindFirstChild("Ignored") and not QuantumPlayers:GetPlayerFromCharacter(m) then
                    local d = (mr.Position - pr.Position).Magnitude
                    if d <= radius and d < best then best = d target = m end
                end
            end
            if target then QuantumBringEnemies(target) end
        end)
    end
end)
-- Toggle Bring Mob trong Farm: chi la nut tat/mo nhanh, ghi thang vao nguon Misc (Bringgay / SaveData.B)
v485:AddToggle({Name = "Bring Mob (Quantum)", Default = (function() if Bringgay ~= nil then return Bringgay end if _G.SaveData and _G.SaveData.B ~= nil then return _G.SaveData.B end return true end)(), Callback = function(v) Bringgay = v if _G.SaveData then _G.SaveData.B = v end if SaveSettings then pcall(SaveSettings) end end})
-- ========== HET BRING MOB QUANTUM ==========

-- ========== FAST ATTACK REDZ HUB (nguyen bo code Redz Hub) ==========
-- Redz Hub goc: FastAttackModule (RegisterAttack/RegisterHit) + HitRegistrationModule (seed + Remote co Id).
-- Chi chay khi Misc "Auto Attack" bat (_G.FastV2 / SaveData.FastAttack, mac dinh bat). Khong di chuyen nhan vat, chi fire remote khi co Tool + mob trong 60 stud.
local _RA_Replicated = game:GetService("ReplicatedStorage")
local _RA_Workspace = game:GetService("Workspace")
local _RA_RunService = game:GetService("RunService")
local _RA_Players = game:GetService("Players")
local _RA_Local = _RA_Players.LocalPlayer
local _RA_Enemies = _RA_Workspace:WaitForChild("Enemies", 5)
local _RA_Characters = _RA_Workspace:WaitForChild("Characters", 5)
local _RA_Modules = _RA_Replicated:WaitForChild("Modules", 5)
local _RA_Net = _RA_Modules and _RA_Modules:WaitForChild("Net", 5)
local RedzFastAttack = {}
RedzFastAttack.Rate = 0.0001
RedzFastAttack.Enabled = true
local function _RA_FastOn()
    if _G.FastV2 ~= nil then return _G.FastV2 end
    if _G.SaveData and _G.SaveData.FastAttack ~= nil then return _G.SaveData.FastAttack end
    return true
end
function RedzFastAttack.IsAlive(target)
    local h = target:FindFirstChild("Humanoid")
    return h and h.Health > 0
end
function RedzFastAttack.GetNearbyTargets(character, folder)
    if not folder then return {} end
    local charPos = character:GetPivot().Position
    local out = {}
    for _, target in ipairs(folder:GetChildren()) do
        local h = target:FindFirstChild("Humanoid")
        local rp = target:FindFirstChild("HumanoidRootPart")
        if h and rp and h.Health > 0 then
            if (rp.Position - charPos).Magnitude <= 60 then
                table.insert(out, target)
                if _G.FastAttack1Mob or getgenv().FastAttack1Mob then break end
            end
        end
    end
    return out
end
function RedzFastAttack.GetTargetParts(list)
    local out = {}
    for _, target in ipairs(list) do
        local head = target:FindFirstChild("Head") or target.PrimaryPart
        if head then
            table.insert(out, {target, head})
            if _G.FastAttack1Mob or getgenv().FastAttack1Mob then break end
        end
    end
    return out
end
function RedzFastAttack.GetAllTargets(character)
    local all = {}
    for _, t in ipairs(RedzFastAttack.GetNearbyTargets(character, _RA_Enemies)) do table.insert(all, t) if _G.FastAttack1Mob or getgenv().FastAttack1Mob then return all end end
    for _, t in ipairs(RedzFastAttack.GetNearbyTargets(character, _RA_Characters)) do table.insert(all, t) if _G.FastAttack1Mob or getgenv().FastAttack1Mob then break end end
    return all
end
function RedzFastAttack.Execute()
    if not _RA_FastOn() then return end
    local char = _RA_Local.Character
    if not char then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then return end
    local targets = RedzFastAttack.GetAllTargets(char)
    if #targets < 1 then return end
    local parts = RedzFastAttack.GetTargetParts(targets)
    if #parts < 1 then return end
    if not _RA_Net then return end
    pcall(function()
        _RA_Net["RE/RegisterAttack"]:FireServer(RedzFastAttack.Rate)
        _RA_Net["RE/RegisterHit"]:FireServer(parts[1][2], parts)
    end)
end
local _RA_AttackRemoteTarget = nil
local _RA_AttackRemoteId = nil
local function _RA_InitHitReg()
    local folders = {_RA_Replicated:FindFirstChild("Util"), _RA_Replicated:FindFirstChild("Common"), _RA_Replicated:FindFirstChild("Remotes"), _RA_Replicated:FindFirstChild("Assets"), _RA_Replicated:FindFirstChild("FX")}
    for _, folder in ipairs(folders) do
        if folder then
            for _, child in ipairs(folder:GetChildren()) do
                if child:IsA("RemoteEvent") and child:GetAttribute("Id") then _RA_AttackRemoteTarget = child _RA_AttackRemoteId = child:GetAttribute("Id") end
            end
            folder.ChildAdded:Connect(function(child) if child:IsA("RemoteEvent") and child:GetAttribute("Id") then _RA_AttackRemoteTarget = child _RA_AttackRemoteId = child:GetAttribute("Id") end end)
        end
    end
end
_RA_InitHitReg()
local function RedzHitRegExecute()
    if not _RA_FastOn() then return end
    local char = _RA_Local.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local hitTargets = {}
    local foundOne = false
    local function ScanFolder(folder)
        if not folder then return end
        for _, target in ipairs(folder:GetChildren()) do
            local h = target:FindFirstChild("Humanoid")
            local rp = target:FindFirstChild("HumanoidRootPart")
            if h and rp and h.Health > 0 and target ~= char then
                if (rp.Position - hrp.Position).Magnitude <= 60 then
                    if (_G.FastAttack1Mob or getgenv().FastAttack1Mob) and foundOne then return end
                    for _, child in ipairs(target:GetChildren()) do if child:IsA("BasePart") then table.insert(hitTargets, {target, child}) end end
                    if _G.FastAttack1Mob or getgenv().FastAttack1Mob then foundOne = true return end
                end
            end
        end
    end
    ScanFolder(_RA_Enemies) ScanFolder(_RA_Characters)
    local tool = char:FindFirstChildOfClass("Tool")
    if #hitTargets > 0 and tool and (tool:GetAttribute("WeaponType") == "Melee" or tool:GetAttribute("WeaponType") == "Sword") and _RA_Net then
        pcall(function()
            local seed = _RA_Modules.Net.seed:InvokeServer()
            _RA_Net["RE/RegisterAttack"]:FireServer()
            local head = hitTargets[1][1]:FindFirstChild("Head")
            if not head then return end
            _RA_Net["RE/RegisterHit"]:FireServer(head, hitTargets, {})
            if _RA_AttackRemoteTarget then
                local code = "RE/RegisterHit"
                local key = math.floor(_RA_Workspace:GetServerTimeNow() / 10 % 10) + 1
                local enc = string.gsub(code, ".", function(ch) return string.char(bit32.bxor(string.byte(ch), key)) end)
                local finalId = bit32.bxor(_RA_AttackRemoteId + 909090, seed * 2)
                local fn = (cloneref or function(x) return x end)(_RA_AttackRemoteTarget)
                fn:FireServer(enc, finalId, head, hitTargets)
            end
        end)
    end
end
task.spawn(function() while task.wait(RedzFastAttack.Rate) do pcall(RedzFastAttack.Execute) end end)
_RA_RunService.Heartbeat:Connect(function() pcall(RedzHitRegExecute) end)
-- ========== HET FAST ATTACK REDZ HUB ==========

-- ========== ANTI-GRAVITY TICH HOP THANG VAO TUNG CHUC NANG TAB FARM ==========
-- Nguyen tac chong giat (ban cu bi giat vi 3 loi):
-- 1) BodyVelocity giu Y ca khi dang di bo duoi dat -> danh nhau voi vat ly -> giat. Fix: chi ap dung khi dang BAY (tren khong / dang tween), dung dat thi tha ngay.
-- 2) Remove cu set WalkSpeed/JumpPower + AssemblyLinearVelocity = 0 + ChangeState -> danh nhau voi code Farm -> giat. Fix: Remove CHI xoa BodyVelocity, khong dung WalkSpeed/Jump/velocity/state.
-- 3) Tao/xoa BodyVelocity lien tuc. Fix: giu 1 BodyVelocity duy nhat, chi tao/xoa khi doi trang thai.
-- Moi toggle Farm goi AntiGravityAcquire("TenToggle") khi BAT, AntiGravityRelease("TenToggle") khi TAT.
-- Chi khi KHONG con chuc nang Farm nao bat thi moi tha roi -> tat rieng 1 chuc nang thi roi xuong, di lai binh thuong.
FarmAGOwners = FarmAGOwners or {}
function AntiGravityAcquire(owner)
    if owner then FarmAGOwners[owner] = true end
end
function AntiGravityRelease(owner)
    if owner then FarmAGOwners[owner] = nil end
    if next(FarmAGOwners) == nil then RemoveAntiGravity() end
end
function FarmAG_AnyOn()
    return next(FarmAGOwners) ~= nil
end
local AG_BV = nil
local function AG_IsFlying()
    local plr = game.Players.LocalPlayer
    local char = plr and plr.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return false end
    -- Dang tween = dang bay (topos/Hiru)
    if shouldTween then return true end
    if getgenv().OnFarm then return true end
    -- Tren khong = dang bay/roi, dung dat = dang di bo -> khong ap dung
    local ok, fm = pcall(function() return hum.FloorMaterial end)
    if ok and fm == Enum.Material.Air then return true end
    return false
end
function ApplyAntiGravity()
    if not FarmAG_AnyOn() then return end
    if not AG_IsFlying() then RemoveAntiGravity() return end
    local plr = game.Players.LocalPlayer
    local char = plr and plr.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if not AG_BV or AG_BV.Parent ~= hrp then
        if AG_BV then pcall(function() AG_BV:Destroy() end) end
        AG_BV = Instance.new("BodyVelocity")
        AG_BV.Name = "FarmAntiGravityBV"
        AG_BV.MaxForce = Vector3.new(0, math.huge, 0)
        AG_BV.Velocity = Vector3.new(0, 0, 0)
        AG_BV.P = 1250
        AG_BV.Parent = hrp
    end
end
function RemoveAntiGravity()
    if AG_BV then pcall(function() AG_BV:Destroy() end) AG_BV = nil end
    -- FIX dung tren khong: 999 co 2 vong rieng tao BodyClip (MaxForce 100000, Velocity 0) o HRP, chi xoa FarmAntiGravityBV thi BodyClip van giu nguoi loi lung.
    -- Xoa HET BodyVelocity/BodyGyro/BodyPosition o HRP khi het farm, ke ca BodyClip.
    local plr = game.Players.LocalPlayer
    local char = plr and plr.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hrp then pcall(function()
        for _, obj in ipairs(hrp:GetChildren()) do
            if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") or obj:IsA("BodyPosition") then obj:Destroy() end
        end
        hrp.Anchored = false
    end) end
    if char then pcall(function()
        -- Khoi phuc va cham cho toan bo part (vong Stepped cua 999 set CanCollide=false khi farm, tat farm ma khong tra lai thi nguoi xuyen dat / dung khong)
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then part.CanCollide = true end
        end
        if hrp then hrp.CanCollide = true end
    end) end
    if hum then pcall(function() hum.PlatformStand = false hum.AutoRotate = true end) end
    -- CHI tha roi, khong dung WalkSpeed/JumpPower/velocity/state -> khong giat, khong cung
end
_G.ApplyAntiGravity = ApplyAntiGravity
_G.RemoveAntiGravity = RemoveAntiGravity
_G.AntiGravityAcquire = AntiGravityAcquire
_G.AntiGravityRelease = AntiGravityRelease
-- Dong bo owner tu cac flag Farm (phong khi toggle nao do khong goi Acquire truc tiep, vd toggle cu / toggle tu tab khac):
-- moi flag la 1 owner rieng -> tat rieng flag do thi owner do mat, het flag thi tha.
local _FarmAG_Flags = {"StartFarm_Banana","AutoFarmNear","AutoFarm_Bone","AutoFarm","AutoFarmLevel_Banana","FarmMastery","FarmMastery_Dev","FarmMastery_G","FarmMastery_S","AutoFarmEctoplasm","AutoChest","AutoCollectBerries","AutoKillBoss","AutoFarmAllBoss","AutoFarmMaterials","AutoSecretQuest","AutoKillSoulReaper","AutoRandomBones","AutoFarmBoss","Level"}
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            for _, flag in ipairs(_FarmAG_Flags) do
                local on = false
                if _G[flag] then on = true end
                if getgenv()[flag] then on = true end
                if flag == "StartFarm_Banana" and getgenv().BananaSettings and getgenv().BananaSettings.StartFarm then on = true end
                if on then FarmAGOwners["flag:"..flag] = true else FarmAGOwners["flag:"..flag] = nil end
            end
            local _nowOn = FarmAG_AnyOn()
            if _nowOn then ApplyAntiGravity() _FarmAG_WasOn = true
            elseif _FarmAG_WasOn then -- chi 1 lan khi vua tat het Farm, khong goi lai moi 0.1s (goi lai = Anchored on/off lien tuc = ca nac / dich len)
                _FarmAG_WasOn = false
                RemoveAntiGravity()
                if StopTween then pcall(function() StopTween() end) end
            end
        end)
    end
end)
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    pcall(function() if AG_BV then AG_BV:Destroy() end AG_BV = nil end)
end)
-- ========== HET ANTI-GRAVITY TICH HOP ==========

-- ========== BAT DAU FARM HUD (pcall de 1 loi trong Farm khong giet menu) ==========
local _okFarmHud, _errFarmHud = pcall(function()
WeaponDropdown = v485:AddDropdown({
    Name = "Select Tool",
    Options = {"Melee","Sword","Blox Fruit","Gun"},
    Default = "Melee",
    Callback = function(Value)
    _G.ChooseWP = Value
end})


spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if _G.ChooseWP == "Melee" then
                for _,v in pairs(plr.Backpack:GetChildren()) do
                    if v.ToolTip == "Melee" then
                        _G.SelectWeapon = v.Name
                    end
                end
            elseif _G.ChooseWP == "Sword" then
                for _,v in pairs(plr.Backpack:GetChildren()) do
                    if v.ToolTip == "Sword" then
                        _G.SelectWeapon = v.Name
                    end
                end
            elseif _G.ChooseWP == "Gun" then
                for _,v in pairs(plr.Backpack:GetChildren()) do
                    if v.ToolTip == "Gun" then
                        _G.SelectWeapon = v.Name
                    end
                end
            elseif _G.ChooseWP == "Blox Fruit" then
                for _,v in pairs(plr.Backpack:GetChildren()) do
                    if v.ToolTip == "Blox Fruit" then
                        _G.SelectWeapon = v.Name
                    end
                end
            end
        end)
    end
end)


-- ========== UI SCALE THAT (fix: slider truoc goi ham khong ton tai) ==========
getgenv().UIScaleValue = getgenv().UIScaleValue or 1
function ApplyUIScaleReal(scale)
    scale = math.clamp(tonumber(scale) or 1, 0.5, 1.5)
    getgenv().UIScaleValue = scale
    if _G.SaveData then _G.SaveData.UIScale = scale end
    local function tryGui(gui)
        if not gui or not gui:IsA("ScreenGui") then return false end
        -- Chi scale GUI cua Redz (co chu "redz hub"), khong scale GUI game
        local isRedz = false
        for _, obj in ipairs(gui:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                local ok, txt = pcall(function() return obj.Text end)
                if ok and txt and string.find(string.lower(txt), "redz hub", 1, true) then isRedz = true break end
            end
        end
        if not isRedz then return false end
        -- Da co UIScale thi set, chua co thi gan vao Frame to nhat
        for _, obj in ipairs(gui:GetDescendants()) do
            if obj:IsA("UIScale") then obj.Scale = scale return true end
        end
        local top = nil
        for _, c in ipairs(gui:GetChildren()) do if c:IsA("Frame") then top = c break end end
        if top then
            local us = Instance.new("UIScale") us.Scale = scale us.Parent = top return true
        end
        return false
    end
    local done = false
    pcall(function()
        for _, parent in ipairs({game:GetService("CoreGui"), game.Players.LocalPlayer.PlayerGui}) do
            for _, sg in ipairs(parent:GetChildren()) do if tryGui(sg) then done = true end end
        end
        local ok, hui = pcall(function() return gethui and gethui() end)
        if ok and hui then for _, sg in ipairs(hui:GetChildren()) do if tryGui(sg) then done = true end end end
    end)
    -- Menu chua tao xong thi thu lai sau 1s
    if not done then task.spawn(function() task.wait(1) pcall(function() ApplyUIScaleReal(scale) end) end) end
    return done
end
-- Ap lai scale da luu khi vao game
task.spawn(function() task.wait(2) pcall(function() ApplyUIScaleReal(getgenv().UIScaleValue or 1) end) end)

-- UI Scale - Redz Hub Plock Style - Thay theo yeu cau
-- UI Scale - Redz Hub Beta Style - Chi de Redz Beta
v485:AddSlider({
    Name = "UI Scale",
    Min = (typeof(redzlib) == "table" and redzlib.GetMinScale and redzlib:GetMinScale() or 0.5),
    Max = (typeof(redzlib) == "table" and redzlib.GetMaxScale and redzlib:GetMaxScale() or 1.5),
    Default = 1,
    Increment = 0.01,
    Flag = "ui_scale",
    Callback = function(Value)
        -- FIX UI Scale: lib Redz V5 khong co SetUIScale/SetScale -> tu gan UIScale vao ScreenGui cua menu
        pcall(function() ApplyUIScaleReal(Value) end)
    end
})

if not getgenv().BananaSettings then getgenv().BananaSettings = {} end
v485:AddSection({"Main Farm"})

v485:AddToggle({
    Name = "Auto Farm Level",
    Description = "",
    Default = false,
    Callback = function(Value)
        if Value then AntiGravityAcquire("Auto Farm Level") else AntiGravityRelease("Auto Farm Level") end
        getgenv().BananaSettings.SelectMethodFarm = "Level Farm"
        getgenv().BananaSettings.StartFarm = Value
        _G.SelectMethodFarm = "Level Farm"
        _G.StartFarm_Banana = Value
        getgenv().AutoFarmLevel_Banana = Value
        _G.Level = Value
        if Value then _G.AutoFarm_Bone = false end
    end
})

ClosetMons = v485:AddToggle({
Name = "Auto Farm Nearest", 
Flag = "ClosetMons",
Description = "", 
Default = false, 
Callback = function(Value)
        if Value then AntiGravityAcquire("Auto Farm Nearest") else AntiGravityRelease("Auto Farm Nearest") end
  _G.AutoFarmNear = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    pcall(function()
      if _G.AutoFarmNear then
        local found = false
        for i,v in pairs(workspace.Enemies:GetChildren()) do
          if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
            found = true
            _G.CurrentFarmMob = v.Name
            repeat task.wait() Attack.Kill(v,_G.AutoFarmNear) until not _G.AutoFarmNear or not v.Parent or v.Humanoid.Health <= 0
          end
        end
        if not found then
            local mobName = _G.CurrentFarmMob or "Bandit"
            local spawnCF = GetSpawnCFrame(mobName)
            if spawnCF then
                local d = (plr.Character.HumanoidRootPart.Position - spawnCF.Position).Magnitude
                if d > 100 then _tp(spawnCF * CFrame.new(0,15,0)) end
            end
        end
      end
    end)
  end
end)
local localPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Đảm bảo các biến toàn cục hoặc bảng điều khiển được khai báo an toàn
local HiddenEvent = HiddenEvent or {
    running = false,
    errors = 0,
    holdTime = 0,
    step = "Idle"
}

-- Định nghĩa hàm xử lý toggle
local function fn(arg)
    -- Kiểm tra điều kiện Sea 1 nếu có hàm EnforceGate
    if arg and type(EnforceGate) == "function" and not EnforceGate(v6, "Auto Secret Quest", Place_Id.sea1(), "Only works in Sea 1") then
        return
    end
    
    if type(SaveSettings) == "function" then
        SaveSettings("Auto Secret Quest", arg)
    end

    if not arg then
        HiddenEvent.current = nil
        HiddenEvent.fighting = nil
        HiddenEvent.walking = false
        HiddenEvent.farmHeight = nil
        getgenv().AimPos = nil
        
        if type(SetHiddenStep) == "function" then SetHiddenStep("Idle") end
        pcall(function() LeaveHiddenCannon() end)
        pcall(function() HiddenRelease() end)
        pcall(function() StopHiddenDodge() end)
        pcall(function() require(ReplicatedStorage.DialogueController).close() end)
        pcall(function() TweenManager.CancelCurrent() end)

        task.spawn(function()
            task.wait(0.2)
            local character = localPlayer.Character
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then
                return
            end
            humanoidRootPart.Anchored = false
            humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
            
            local raycastParams = RaycastParams.new()
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude
            raycastParams.FilterDescendantsInstances = { character, workspace.Characters, workspace.Enemies }
            local hit = workspace:Raycast(humanoidRootPart.Position, Vector3.new(0, -900, 0), raycastParams)

            if hit and humanoidRootPart.Position.Y - hit.Position.Y > 25 then
                humanoidRootPart.CFrame = CFrame.new(hit.Position + Vector3.new(0, 4, 0))
                task.wait(0.2)
                humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
            elseif not hit then
                local v7 = travelFunctions and travelFunctions.GetSpawnPosition(localPlayer.Data.LastSpawnPoint.Value)
                if v7 then
                    humanoidRootPart.CFrame = CFrame.new(v7 + Vector3.new(0, 4, 0))
                end
            end

            local n = 0
            while HiddenEvent.running and n < 5 do
                task.wait(0.1)
                n = n + 0.1
            end

            if type(ReleaseTweenPhysics) == "function" then ReleaseTweenPhysics() end
        end)

        return
    end

    if type(Place_Id) == "table" and Place_Id.sea1 and not Place_Id.sea1() then
        if type(HiddenNotify) == "function" then
            HiddenNotify("Hidden Event only works in First Sea", nil, "warning")
        end
        return
    end

    if HiddenEvent.running then
        return
    end
    HiddenEvent.running = true

    task.spawn(function()
        pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
        end)
    end)

    if type(HiddenDialogueLoop) == "function" then
        task.spawn(HiddenDialogueLoop)
    end

    task.spawn(function()
        while Settings and Settings["Auto Secret Quest"] and task.wait(0.15) do
            local ok, result

            if StackFarmOther then
                ok, result = pcall(AutoHiddenEvent)
            else
                if type(SetHiddenStep) == "function" then
                    SetHiddenStep("Paused while another feature is running")
                end
                ok = true
                result = nil
            end

            if not ok then
                print(result)
                HiddenEvent.lastError = tostring(result)
                HiddenEvent.errors = (HiddenEvent.errors or 0) + 1

                if HiddenEvent.errors % 20 == 1 and type(HiddenNotify) == "function" then
                    HiddenNotify("Error: " .. tostring(result):sub(1, 120), "error", "error")
                end
            end

            if type(CheckHiddenStall) == "function" then
                pcall(CheckHiddenStall)
            end
            
            local anchored = HiddenEvent.anchored
            if anchored then
                anchored = tick() - (HiddenEvent.holdTime or 0) > 0.6
            end

            if anchored and type(HiddenRelease) == "function" then
                HiddenRelease()
            end

            local str2 = tostring(HiddenEvent.step or "")
            if str2:find("^Waiting") or str2:find(" stirs on ") or str2 == "Idle" then
                task.wait(0.6)
            end
        end

        if type(HiddenRelease) == "function" then HiddenRelease() end
        HiddenEvent.running = false
    end)
end

-- Tạo Toggle chính xác thông qua UI Library của bạn
local bone = v485:AddToggle({
    Name = "Auto Secret Quest", 
    Flag = "ClosetMons",
    Description = "Auto Complete Sea 1 Secret", 
    Default = false, 
    Callback = function(Value)
        if Value then AntiGravityAcquire("Auto Secret Quest") else AntiGravityRelease("Auto Secret Quest") end
        _G.HiddEvent = Value
        fn(Value)
    end
})

-- [ADDED] Auto Farm Level from BananaCat Hub - placed above Farm Bone
-- [REWORK] GUI quest check + quest info + spawn flying: port tu BananaCat.lua
getgenv().AutoFarmLevel_Banana = false
getgenv().NameMobQuest_Banana = ""
getgenv().NameQuest_Banana = ""
getgenv().IDQuest_Banana = 0
getgenv().SpawnPointDelay = 0.8   -- delay sau khi toi spawn point
getgenv().SpawnPointLift = getgenv().SpawnPointLift or 30    -- Y + 30 truoc khi bay toi point tiep
getgenv().TableMobSpawn = getgenv().TableMobSpawn or {}

-- Boc trong do...end de khong an them local o top-level (gioi han 200 local / chunk)
do
    local Players = game:GetService("Players")
    local RS = game:GetService("ReplicatedStorage")

    --==================== QUEST GUI CHECK (nguyen van BananaCat.lua) ====================
    -- V1 (PlayerGui.Main.Quest) + V2 (PlayerGui.TrackedQuestFrame)
    local function readText(inst)
        if not inst then return nil end
        if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
            return inst.Text ~= "" and inst.Text or nil
        end
        for _, d in ipairs(inst:GetDescendants()) do
            if d:IsA("TextLabel") and d.Text ~= "" then
                return d.Text
            end
        end
        return nil
    end

    function GetQuestTitle()
        local lp = Players.LocalPlayer
        local pg = lp and lp:FindFirstChild("PlayerGui")
        if not pg then return nil end
        -- V1
        local main = pg:FindFirstChild("Main") or pg:FindFirstChild("Main (minimal)")
        local q = main and main:FindFirstChild("Quest")
        if q and q.Visible then
            local c = q:FindFirstChild("Container")
            local qt = c and c:FindFirstChild("QuestTitle")
            local txt = readText(qt and qt:FindFirstChild("Title"))
            if txt then return txt end
        end
        -- V2
        local tr = pg:FindFirstChild("TrackedQuestFrame")
        if tr then
            local on = (tr:IsA("ScreenGui") and tr.Enabled) or (tr:IsA("GuiObject") and tr.Visible)
            local fr = tr:FindFirstChild("Frame")
            if on and fr and fr.Visible then
                return readText(fr:FindFirstChild("header"))
            end
        end
        return nil
    end

    local _rawHasQuest = function() return GetQuestTitle() ~= nil end
    local _questSeenUntil = 0
    function HasQuest()
        -- Giu trang thai "co quest" 1s sau lan cuoi thay UI, tranh doc UI luc dang animation/lag
        if _rawHasQuest() then
            _questSeenUntil = tick() + 1
            return true
        end
        return tick() < _questSeenUntil
    end
    local function ResetQuestSeen() _questSeenUntil = 0 end

    -- Lay TOAN BO text UI quest (V1 + V2) - port tu BananaCat.lua
    local function collectText(root)
        local out = {}
        if not root then return out end
        local function add(i)
            if (i:IsA("TextLabel") or i:IsA("TextButton") or i:IsA("TextBox")) and i.Text ~= "" then
                out[#out + 1] = i.Text
            end
        end
        add(root)
        for _, d in ipairs(root:GetDescendants()) do add(d) end
        return out
    end
    function GetQuestText()
        local pg = Players.LocalPlayer and Players.LocalPlayer:FindFirstChild("PlayerGui")
        if not pg then return "" end
        local parts = {}
        local main = pg:FindFirstChild("Main") or pg:FindFirstChild("Main (minimal)")
        local q = main and main:FindFirstChild("Quest")
        if q and q.Visible then
            for _, s in ipairs(collectText(q)) do parts[#parts + 1] = s end
        end
        local tr = pg:FindFirstChild("TrackedQuestFrame")
        if tr then
            local on = (tr:IsA("ScreenGui") and tr.Enabled) or (tr:IsA("GuiObject") and tr.Visible)
            if on then
                for _, s in ipairs(collectText(tr)) do parts[#parts + 1] = s end
            end
        end
        return table.concat(parts, " | ")
    end

    -- alias cho code cu
    GetQuestTitle_Banana = GetQuestTitle
    HasQuest_Banana = HasQuest

    --==================== QUEST INFO (port tu BananaCat.lua: GuideModule.NPCList) ====================
    local Quests = require(RS:WaitForChild("Quests"))
    local Guide = require(RS:WaitForChild("GuideModule"))
    local excludeQuest = { "BartiloQuest", "Trainees", "MarineQuest", "CitizenQuest" }

    local function GetActiveQuestMob()
        local qd = Guide.Data and Guide.Data.QuestData
        if qd and qd.Task then
            return (next(qd.Task))
        end
        return nil
    end

    local function GetLevelQuestInfo(lvl)
        local curMob = GetActiveQuestMob()
        local lastLv, c = 0, {}
        local npcList = Guide.Data and Guide.Data.NPCList
        if not npcList then return c end
        for _, r in pairs(npcList) do
            if not table.find(excludeQuest, r.InternalQuestName) and Quests[r.InternalQuestName] then
                for qid, reqLv in pairs(r.Levels) do
                    local D = Quests[r.InternalQuestName][qid]
                    if D then
                        local mobName, cnt = next(D.Task)
                        if cnt and cnt > 1 and reqLv <= lvl and reqLv >= lastLv then
                            c = {
                                Level = reqLv,
                                Name = r.NPCName,
                                QuestName = r.InternalQuestName,
                                Pos = r.Position,
                                Id = qid,
                                Mob = mobName,
                                BaseMob = mobName,
                                Mobs = { mobName },
                            }
                            if qid > 1 then
                                local pq = Quests[r.InternalQuestName][qid - 1]
                                if pq and pq.Task then
                                    for pm, pc in pairs(pq.Task) do
                                        if pm ~= mobName and pc > 1 then
                                            table.insert(c.Mobs, pm)
                                            break
                                        end
                                    end
                                end
                            end
                            if curMob == mobName and qid > 1 then
                                local prev = Quests[r.InternalQuestName][qid - 1]
                                if prev and prev.Task then
                                    for pm, pc in pairs(prev.Task) do
                                        if pm ~= curMob and pc > 1 then
                                            c.Mob = pm
                                            c.Id = qid - 1
                                            break
                                        end
                                    end
                                end
                            end
                            lastLv = reqLv
                        end
                    end
                end
            end
        end
        return c
    end

    -- Tat ca ten mob co trong quest -> doc mob THAT cua quest dang giu tu GUI
    local AllQuestMobs = {}
    do
        local seen = {}
        for _, qs in pairs(Quests) do
            if typeof(qs) == "table" then
                for _, qd in pairs(qs) do
                    if typeof(qd) == "table" and qd.Task then
                        for mn, cnt in pairs(qd.Task) do
                            if cnt > 1 and not seen[mn] then
                                seen[mn] = true
                                table.insert(AllQuestMobs, mn)
                            end
                        end
                    end
                end
            end
        end
    end
    local function escPat(s) return (s:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0")) end
    -- Tra ve ten mob (dai nhat khop) trong text quest GUI, nil neu khong doc duoc
    local function GetGuiQuestMob()
        local txt = GetQuestText():lower()
        if txt == "" then return nil end
        local best
        for _, mn in ipairs(AllQuestMobs) do
            if txt:find("%f[%w]" .. escPat(mn:lower()) .. "s?%f[%W]") then
                if not best or #mn > #best then best = mn end
            end
        end
        return best
    end

    --==================== SPAWN POINT (port tu BananaCat.lua) ====================
    local function stripLv(n) return (n:gsub(" %p?Lv%.? %d+%p?", "")) end

    local function DetectPartSpawnMob(name, skipIgnored)
        local base = string.find(name, "Lv.") and stripLv(name) or name
        local TableMobSpawn = getgenv().TableMobSpawn
        for _, F in pairs(TableMobSpawn) do
            if F:IsA("Part") then
                local J = string.find(F.Name, "Lv.") and stripLv(F.Name) or F.Name
                if (J == name or J == base) and (not skipIgnored or not F:FindFirstChild("Ignored")) then
                    return F
                end
            end
        end
        local es = workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("EnemySpawns")
        if es then
            for _, F in pairs(es:GetChildren()) do
                if F:IsA("Part") then
                    local J = string.find(F.Name, "Lv.") and stripLv(F.Name) or F.Name
                    if (J == name or J == base) and (not skipIgnored or not F:FindFirstChild("Ignored")) then
                        table.insert(TableMobSpawn, F)
                        return F
                    end
                end
            end
        end
        if getnilinstances then
            local okN, nils = pcall(getnilinstances)
            if okN and nils then
                for _, F in pairs(nils) do
                    if F:IsA("Part") then
                        local J = string.find(F.Name, "Lv.") and stripLv(F.Name) or F.Name
                        if (J == name or J == base) and (not skipIgnored or not F:FindFirstChild("Ignored")) then
                            table.insert(TableMobSpawn, F)
                            return F
                        end
                    end
                end
            end
        end
        return nil
    end

    local function DeleteIgnoredMobSpawn()
        for _, V in pairs(getgenv().TableMobSpawn) do
            local ig = V:FindFirstChild("Ignored")
            if ig then ig:Destroy() end
        end
        local es = workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("EnemySpawns")
        if es then
            for _, V in pairs(es:GetChildren()) do
                local ig = V:FindFirstChild("Ignored")
                if ig then ig:Destroy() end
            end
        end
    end
    getgenv().DeleteIgnoredMobSpawn = DeleteIgnoredMobSpawn

    --==================== HELPERS ====================
    local function HRP()
        local ch = Players.LocalPlayer.Character
        return ch and ch:FindFirstChild("HumanoidRootPart")
    end
    local function Alive()
        local ch = Players.LocalPlayer.Character
        local h = ch and ch:FindFirstChildOfClass("Humanoid")
        return h and h.Health > 0
    end
    local function FarmOn() return getgenv().AutoFarmLevel_Banana end

    local function FindMob(name)
        local hrp = HRP()
        local best, bestD = nil, math.huge
        for _, v in pairs(workspace.Enemies:GetChildren()) do
            if v.Name == name then
                local h = v:FindFirstChild("Humanoid")
                local r = v:FindFirstChild("HumanoidRootPart")
                if h and r and h.Health > 0 then
                    local d = hrp and (r.Position - hrp.Position).Magnitude or 0
                    if d < bestD then best, bestD = v, d end
                end
            end
        end
        return best
    end

    -- Goi _tp 1 lan roi cho toi noi (tranh spam tween chong nhau)
    -- stopFn() tra true -> huy bay ngay
    local function FlyTo(cf, stopFn, closeDist)
        local hrp = HRP()
        if not hrp then return false end
        closeDist = closeDist or 8
        _tp(cf)
        local t0 = tick()
        local speed = math.max(getgenv().TweenSpeedFar or 170, 10)
        local maxT = (cf.Position - hrp.Position).Magnitude / speed + 5
        while tick() - t0 < maxT do
            task.wait(0.05)
            hrp = HRP()
            if not hrp or not Alive() then return false end
            if not FarmOn() or (stopFn and stopFn()) then
                shouldTween = false   -- _tp watcher se Cancel tween
                task.wait(0.15)
                return false
            end
            if (hrp.Position - cf.Position).Magnitude <= closeDist then
                return true
            end
        end
        shouldTween = false
        task.wait(0.15)
        return false
    end

    --==================== NHAN QUEST (port TakeQuestLevel) ====================
    local function TakeQuest(lvl)
        local info = GetLevelQuestInfo(lvl)
        if not info or not info.Pos then return end
        getgenv().NameMobQuest_Banana = info.Mob
        getgenv().NameQuest_Banana = info.QuestName
        getgenv().IDQuest_Banana = info.Id
        local pos = typeof(info.Pos) == "CFrame" and info.Pos.Position or info.Pos
        local hrp = HRP()
        if not hrp or not Alive() then return end
        if (pos - hrp.Position).Magnitude > 8 then
            FlyTo(CFrame.new(pos) * CFrame.new(0, 4, 2), nil, 8)
        end
        hrp = HRP()
        if hrp and (pos - hrp.Position).Magnitude <= 12 and Alive() then
            task.wait(2)
            RS.Remotes.CommF_:InvokeServer("StartQuest", tostring(info.QuestName), info.Id)
            -- cho GUI quest hien len roi moi farm
            for _ = 1, 20 do
                if HasQuest() then break end
                task.wait(0.15)
            end
        end
    end

    --==================== VONG FARM LEVEL DUY NHAT ====================
    local staleSince, lastAbandon = nil, 0
    local needLift = false   -- true sau khi da toi 1 spawn point ma van chua co mob

    task.spawn(function()
        while true do
            task.wait(0.15)
            if not FarmOn() then needLift = false; continue end
            pcall(function()
                local hrp = HRP()
                if not hrp or not Alive() then return end
                local lvl = Players.LocalPlayer.Data.Level.Value

                -- 1) chua co quest -> nhan quest
                if not HasQuest() then
                    needLift = false
                    TakeQuest(lvl)
                    return
                end

                -- 2) co quest -> xac dinh mob (uu tien mob cua quest dang giu, giong FarmMethod script 1)
                local info = GetLevelQuestInfo(lvl)
                if not info or not info.Mobs then return end
                local guiMob = GetGuiQuestMob()
                local valid = false
                if guiMob then
                    for _, m in ipairs(info.Mobs) do
                        if m == guiMob then valid = true break end
                    end
                end
                if not valid then
                    -- quest dang giu khong thuoc tier cua level hien tai (hoac chua doc duoc GUI)
                    staleSince = staleSince or tick()
                    if tick() - staleSince >= 1.5 and tick() - lastAbandon >= 3 then
                        lastAbandon = tick()
                        staleSince = nil
                        needLift = false
                        pcall(function() RS.Remotes.CommF_:InvokeServer("AbandonQuest") end)
                        ResetQuestSeen()
                        for _ = 1, 20 do
                            if not _rawHasQuest() then break end
                            task.wait(0.15)
                        end
                    end
                    return
                end
                staleSince = nil
                local mobName = guiMob
                _G.CurrentFarmMob = mobName

                local mob = FindMob(mobName)
                if mob then
                    needLift = false
                    repeat
                        task.wait()
                        Attack.Kill(mob, true)
                    until not FarmOn() or not Alive()
                        or not mob.Parent or not mob:FindFirstChild("Humanoid") or mob.Humanoid.Health <= 0
                        or not HasQuest()
                        or Players.LocalPlayer.Data.Level.Value ~= lvl
                    return
                end

                -- 3) het mob -> bay toi spawn point (logic script 1, khac cho Y)
                local part = DetectPartSpawnMob(mobName, true)
                if part then
                    Instance.new("IntValue", part).Name = "Ignored"   -- danh dau da toi, lan sau lay point tiep
                    if needLift then
                        -- tele len Y + 30 roi moi bay toi point tiep
                        local h = HRP()
                        if h then
                            shouldTween = false
                            h.CFrame = h.CFrame + Vector3.new(0, getgenv().SpawnPointLift or 30, 0)
                            task.wait(0.1)
                        end
                    end
                    -- bay thang toi point, khong cong them Y
                    FlyTo(part.CFrame, function() return FindMob(mobName) ~= nil end, 8)
                    -- delay tai point, co mob thi thoat som
                    local t0 = tick()
                    while tick() - t0 < (getgenv().SpawnPointDelay or 1) do
                        if not FarmOn() or FindMob(mobName) then break end
                        task.wait(0.1)
                    end
                    needLift = true
                else
                    -- het point chua toi -> reset co "Ignored" va lap lai
                    DeleteIgnoredMobSpawn()
                    needLift = false
                    -- fallback: neu khong tim duoc part nao thi bay toi spawn da luu cua script 2
                    local cf = GetSpawnCFrame and GetSpawnCFrame(mobName)
                    if cf then
                        FlyTo(cf, function() return FindMob(mobName) ~= nil end, 8)
                    end
                    task.wait(1)
                end
            end)
        end
    end)
end

-- [NEW] Banana Cat Style Farm - Replaces old Farm Bone/Level toggles
getgenv().BananaSettings = getgenv().BananaSettings or {
    SelectMethodFarm = "Level Farm",
    DistanceAura = 300,
    IgnoreKatakuri = false,
    HopKatakuri = false,
    AutoQuestKBT = false,
    StartFarm = false
}

local MethodList = {"Level Farm", "Farm Bones", "Farm Katakuri", "Farm Tyrant of the Skies", "Aura Farm"}


v485:AddSection({"Bones"})

local bone = v485:AddToggle({
    Name = "Auto Farm Bone", 
    Flag = "ClosetMons",
    Description = "", 
    Default = false, 
    Callback = function(Value)
        if Value then AntiGravityAcquire("Auto Farm Bone") else AntiGravityRelease("Auto Farm Bone") end
        _G.AutoFarm_Bone = Value -- Đã sửa đúng tên biến cho khớp với vòng lặp bên dưới

        if not Value then
            getgenv().CurrentBoneTarget = nil
            getgenv().CurrentBoneName = nil
        end
    end
})

spawn(function()
    while true do
        task.wait(Sec or 0.5) -- Đảm bảo có giá trị mặc định nếu Sec chưa được định nghĩa
        if _G.AutoFarm_Bone then
            pcall(function()

                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local root = character:FindFirstChild("HumanoidRootPart")
                local questUI = player.PlayerGui.Main.Quest

                if not root then
                    return
                end

                local BonesTable = {
                    "Reborn Skeleton",
                    "Living Zombie",
                    "Demonic Soul",
                    "Posessed Mummy"
                }

                local enemies = workspace:FindFirstChild("Enemies")
                local boneTarget = nil

                if getgenv().CurrentBoneTarget and getgenv().CurrentBoneTarget.Parent then
                    local hum = getgenv().CurrentBoneTarget:FindFirstChild("Humanoid")

                    if hum and hum.Health > 0 then
                        boneTarget = getgenv().CurrentBoneTarget
                    else
                        getgenv().CurrentBoneTarget = nil
                        getgenv().CurrentBoneName = nil
                    end
                end

                if not boneTarget and enemies then
                    local closestDist = math.huge

                    for _, mob in pairs(enemies:GetChildren()) do
                        local hum = mob:FindFirstChild("Humanoid")
                        local mobRoot = mob:FindFirstChild("HumanoidRootPart")

                        local valid = false
                        for _, name in ipairs(BonesTable) do
                            if mob.Name == name then
                                valid = true
                                break
                            end
                        end

                        if valid and hum and mobRoot and hum.Health > 0 then
                            local dist = (mobRoot.Position - root.Position).Magnitude

                            if dist < closestDist then
                                closestDist = dist
                                boneTarget = mob
                                getgenv().CurrentBoneTarget = mob
                                getgenv().CurrentBoneName = mob.Name
                            end
                        end
                    end
                end

                if boneTarget then

                    if _G.AcceptQuestC and not questUI.Visible then

                        local questPos = CFrame.new(
                            -9516.99316,
                            172.017181,
                            6078.46533,
                            0,0,-1,
                            0,1,0,
                            1,0,0
                        )

                        _tp(questPos)

                        while (questPos.Position - root.Position).Magnitude > 50 do
                            task.wait(0.2)
                        end

                        local randomQuest = math.random(1,4)

                        local questData = {
                            [1] = {"StartQuest","HauntedQuest2",2},
                            [2] = {"StartQuest","HauntedQuest2",1},
                            [3] = {"StartQuest","HauntedQuest1",1},
                            [4] = {"StartQuest","HauntedQuest1",2}
                        }

                        pcall(function()
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer(
                                unpack(questData[randomQuest])
                            )
                        end)
                    end

                    repeat
                        task.wait()

                        if not boneTarget.Parent
                        or not boneTarget:FindFirstChild("Humanoid")
                        or boneTarget.Humanoid.Health <= 0 then
                            getgenv().CurrentBoneTarget = nil
                            getgenv().CurrentBoneName = nil
                            break
                        end

                        if boneTarget:FindFirstChild("HumanoidRootPart") then
                            _tp(boneTarget.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                        end

                        if Attack and Attack.Kill then
                            Attack.Kill(boneTarget, _G.AutoFarm_Bone)
                        end

                    until not _G.AutoFarm_Bone
                    or boneTarget.Humanoid.Health <= 0
                    or not boneTarget.Parent
                    or (_G.AcceptQuestC and not questUI.Visible)

                else

                    local nearMob = false

                    if enemies and root then
                        for _, mob in pairs(enemies:GetChildren()) do
                            local hum = mob:FindFirstChild("Humanoid")
                            local mobRoot = mob:FindFirstChild("HumanoidRootPart")

                            if hum and mobRoot and hum.Health > 0 then
                                if (mobRoot.Position - root.Position).Magnitude <= 50 then
                                    nearMob = true
                                    break
                                end
                            end
                        end
                    end

                    if not nearMob then
                        _tp(CFrame.new(
                            -9495.6806640625,
                            453.58624267578125,
                            5977.3486328125
                        ))
                    end
                end

            end)
        end
    end
end)

local CakeQuestMapping = {
    ["Baking Staff"]   = {"StartQuest", "CakeQuest1", 1},
    ["Head Baker"]     = {"StartQuest", "CakeQuest1", 2},
    ["Cake Guard"]     = {"StartQuest", "CakeQuest2", 1},
    ["Cookie Crafter"] = {"StartQuest", "CakeQuest2", 2}
}

v485:AddToggle({
Name = "Auto kill Soul Reaper", 
Description = "", 
Default = false,
Callback = function(Value)
        if Value then AntiGravityAcquire("Auto kill Soul Reaper") else AntiGravityRelease("Auto kill Soul Reaper") end
  _G.AutoHytHallow = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.AutoHytHallow then
      pcall(function()
        local v = GetConnectionEnemies("Soul Reaper")
	    if v then
          repeat task.wait() Attack.Kill(v,_G.AutoHytHallow) until v.Humanoid.Health <= 0 or _G.AutoHytHallow == false
        else
          if not GetBP("Hallow Essence") then
            repeat task.wait(.1)replicated.Remotes.CommF_:InvokeServer("Bones","Buy",1,1)until _G.AutoHytHallow == false or GetBP("Hallow Essence")
          else
            repeat wait(.1) _tp(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125))until _G.AutoHytHallow == false or (plr.Character.HumanoidRootPart.CFrame == CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125))
		    EquipWeapon("Hallow Essence")
          end
        end
      end)
    end
  end
end)
RanBone = v485:AddToggle({
Name = "Auto Random Bones", 
Description = "", 
Default = false,
Callback = function(Value)
        if Value then AntiGravityAcquire("Auto Random Bones") else AntiGravityRelease("Auto Random Bones") end
  _G.Auto_Random_Bone = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Auto_Random_Bone then    
  	    repeat task.wait() replicated.Remotes.CommF_:InvokeServer("Bones","Buy",1,1) until not _G.Auto_Random_Bone
      end
    end)
  end
end)

v485:AddSection({"Ectoplasm"})

Ecto = v485:AddToggle({
Name = "Auto Farm Ectoplasm", 
Description = "", 
Default = false,
Callback = function(Value)
        if Value then AntiGravityAcquire("Auto Farm Ectoplasm") else AntiGravityRelease("Auto Farm Ectoplasm") end
  _G.AutoEctoplasm = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.AutoEctoplasm then
        local EctoTable = {"Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer","Arctic Warrior"}    
        local v = GetConnectionEnemies(EctoTable)
		if Attack.Alive(v) then
		  repeat wait() Attack.Kill(v, _G.AutoEctoplasm)until not _G.AutoEctoplasm or not v.Parent or v.Humanoid.Health <= 0		        
	    else
	      replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
	    end
      end
    end)
  end
end)

v485:AddSection({"Chest"})

ChestTW = v485:AddToggle({
Name = "Auto Chest [ Tween ]", 
Description = "1B Ez No Reset Level", 
Default = false,
Callback = function(Value)
        if Value then AntiGravityAcquire("Auto Chest [ Tween ]") else AntiGravityRelease("Auto Chest [ Tween ]") end
  _G.AutoFarmChest = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.AutoFarmChest then
      pcall(function()
        local CollectionService = game:GetService("CollectionService")
        local Players = game:GetService("Players")
        local Player = Players.LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()                
        if not Character then return end                
        local Position = Character:GetPivot().Position
        local Chests = CollectionService:GetTagged("_ChestTagged")      
        local Distance, Nearest = math.huge, nil  
        for i = 1, #Chests do
          local Chest = Chests[i]
          local Magnitude = (Chest:GetPivot().Position - Position).Magnitude        
          if not SelectedIsland or Chest:IsDescendantOf(SelectedIsland) then
            if not Chest:GetAttribute("IsDisabled") and Magnitude < Distance then
              Distance = Magnitude
              Nearest = Chest
            end
          end
        end
      if Nearest then _tp(Nearest:GetPivot()) end
      end)
    end
  end
end)

Berry = v485:AddToggle({
Name = "Auto Collect Berries", 
Description = "", 
Default = false,
Callback = function(Value)
        if Value then AntiGravityAcquire("Auto Collect Berries") else AntiGravityRelease("Auto Collect Berries") end
  _G.AutoBerry = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.AutoBerry then
      local CollectionService= game:GetService("CollectionService")
      local Players= game:GetService("Players")
      local Player = Players.LocalPlayer
      local BerryBush = CollectionService:GetTagged("BerryBush")      
      local Distance, Nearest = math.huge      
      for i = 1, #BerryBush do
        local Bush = BerryBush[i]        
        for AttributeName, BerryName in pairs(Bush:GetAttributes()) do
          if not BerryArray or table.find(BerryArray, BerryName) then           
            _tp(Bush.Parent:GetPivot())
            for i = 1, #BerryBush do
            local Bush = BerryBush[i]        
              for AttributeName, BerryName in pairs(Bush:GetChildren()) do
                if not BerryArray or table.find(BerryArray, BerryName) then
                  _tp(BerryName.WorldPivot)
                  fireproximityprompt(BerryName.ProximityPrompt,math.huge)
                end
              end
            end      
          end
        end
      end      
    end
  end
end)
 
 
v485:AddSection({"Bosses"})

BossDropdown = v485:AddDropdown({
		Name = "Boss List",
		Description = "",
		Options = BossList,
		Callback = function(value)
			_G.FindBoss = value
		end
		})

FarmBoss = v485:AddToggle({
    Name = "Auto Kill Boss Selected",
    Description = "",
    Default = false,
    Callback = function(value)
        if value then AntiGravityAcquire("Auto Kill Boss Selected") else AntiGravityRelease("Auto Kill Boss Selected") end
        _G.FarmBoss = value
        spawn(function()
            while wait(Sec) do
                if _G.FarmBoss then
                    pcall(function()
                        local HasQuest = QuestBeta()[2] ~= nil and QuestBeta()[3] ~= nil
                        local QuestTitle = plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text

                       
                        if _G.AcceptQuestBoss and HasQuest then
                            if not string.find(QuestTitle, QuestBeta()[0]) then
                                replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
                            end

                            if plr.PlayerGui.Main.Quest.Visible == false then
                                _tp(QuestBeta()[5])
                                if (Root.Position - QuestBeta()[5].Position).Magnitude <= 5 then
                                    replicated.Remotes.CommF_:InvokeServer("StartQuest", QuestBeta()[3], QuestBeta()[2])
                                end
                            elseif plr.PlayerGui.Main.Quest.Visible == true then
                                if workspace.Enemies:FindFirstChild(QuestBeta()[1]) then
                                    for i, v in pairs(workspace.Enemies:GetChildren()) do
                                        if Attack.Alive(v) and v.Name == QuestBeta()[1] then
                                            if string.find(QuestTitle, QuestBeta()[0]) then
                                                repeat
                                                    wait()
                                                    Attack.Kill(v, _G.FarmBoss)
                                                until not _G.FarmBoss or v.Humanoid.Health <= 0 or not v.Parent or plr.PlayerGui.Main.Quest.Visible == false
                                            else
                                                replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
                                            end
                                        end
                                    end
                                else
                                    _tp(QuestBeta()[4])
                                    if replicated:FindFirstChild(QuestBeta()[1]) then
                                        _tp(replicated:FindFirstChild(QuestBeta()[1]).HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                    end
                                end
                            end
                        else
                           
                            if workspace.Enemies:FindFirstChild(QuestBeta()[1]) then
                                for i, v in pairs(workspace.Enemies:GetChildren()) do
                                    if Attack.Alive(v) and v.Name == QuestBeta()[1] then
                                        repeat
                                            wait()
                                            Attack.Kill(v, _G.FarmBoss)
                                        until not _G.FarmBoss or v.Humanoid.Health <= 0 or not v.Parent
                                    end
                                end
                            else
                                _tp(QuestBeta()[4])
                                if replicated:FindFirstChild(QuestBeta()[1]) then
                                    _tp(replicated:FindFirstChild(QuestBeta()[1]).HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                end
                            end
                        end
                    end)
                end
            end
        end)
    end
})

FarmAllBoss = v485:AddToggle({
   Name = "Auto Farm All Boss",
    Default = false,
Callback = function(Value)
        if Value then AntiGravityAcquire("Auto Farm All Boss") else AntiGravityRelease("Auto Farm All Boss") end
    _G.AutoFarmAllBoss = Value
end})

task.spawn(function()
    while task.wait(0.3) do
        if _G.AutoFarmAllBoss then
            pcall(function()
                local player = game.Players.LocalPlayer
                if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
                local hrp = player.Character.HumanoidRootPart

                local nearestBoss, nearestDist = nil, math.huge

                for _, boss in pairs(workspace.Enemies:GetChildren()) do
                    if boss:FindFirstChild("HumanoidRootPart") and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                        if table.find(BossList, boss.Name) then
                            local dist = (hrp.Position - boss.HumanoidRootPart.Position).Magnitude
                            if dist < nearestDist then
                                nearestBoss = boss
                                nearestDist = dist
                            end
                        end
                    end
                end

                if nearestBoss and nearestBoss:FindFirstChild("HumanoidRootPart") then
                    local bossHRP = nearestBoss.HumanoidRootPart
                    local humanoid = nearestBoss.Humanoid

                    repeat
                        task.wait(0.1)
                        if not _G.AutoFarmAllBoss then break end

                        local targetCFrame = bossHRP.CFrame * CFrame.new(0, 5, 0)
                        if (hrp.Position - targetCFrame.Position).Magnitude > 100 then
                            player.Character:PivotTo(targetCFrame)
                        else
                            _tp(targetCFrame)
                        end

                        if Attack and typeof(Attack.Kill) == "function" then
                            Attack.Kill(nearestBoss, true)
                        end
                    until not nearestBoss.Parent or humanoid.Health <= 0 or not _G.AutoFarmAllBoss
                end
            end)
        end
    end
end)

BossQ = v485:AddToggle({
    Name = "⚠️ Take Boss Quest",
    Description = "",
    Default = true,
    Callback = function(Value)
        if Value then AntiGravityAcquire("⚠️ Take Boss Quest") else AntiGravityRelease("⚠️ Take Boss Quest") end
        _G.AcceptQuestBoss = Value
    end
})

v485:AddSection({"Material"})

Test = v485:AddDropdown({
Name = "Choose Material",
		Description = "",
		Options = MaterialList,
		Callback = function(Value)
			getgenv().SelectMaterial = Value
		end
		})
Toggle = v485:AddToggle({
Name = "Auto Farm Materials", 
Description = "", 
Default = false,
Callback = function(Value)
        if Value then AntiGravityAcquire("Auto Farm Materials") else AntiGravityRelease("Auto Farm Materials") end
    getgenv().AutoMaterial = Value
end})
spawn(function()
  local function processEnemy(v, EnemyName)
    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
      if v.Name == EnemyName then repeat wait() Attack.Kill(v,getgenv().AutoMaterial) until not getgenv().AutoMaterial or not v.Parent or v.Humanoid.Health <= 0 end
    end
  end
  local function handleEnemySpawns()
    for _, v in pairs(game:GetService("Workspace")["_WorldOrigin"].EnemySpawns:GetChildren()) do
      for _, EnemyName in ipairs(MMon) do
        if string.find(v.Name, EnemyName) then
          if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude >= 10 then
            _tp(v.CFrame * Pos)
          end
        end
      end
    end
  end
  while wait() do
    if getgenv().AutoMaterial then
      pcall(function()
        if getgenv().SelectMaterial then MaterialMon(getgenv().SelectMaterial) _tp(MPos) end
        for _, EnemyName in ipairs(MMon) do
          for _, v in pairs(workspace.Enemies:GetChildren()) do processEnemy(v, EnemyName) end
        end
        handleEnemySpawns()
      end)
    end
  end
end)


v485:AddSection({"Mastery"})

-- ===== KOKO MASTERY CORE 100% =====
_G.MasteryHealthPct = _G.MasteryHealthPct or 70
_G.SelectedMasterySkills = _G.SelectedMasterySkills or {Z=true,X=true,C=true,V=true,F=true}
HeartMastery = _G.MasteryHealthPct
SelectIsland = SelectIsland or "Cake"
HealthM = 0
MousePos = Vector3.new(0,0,0)
PosMon = Vector3.new(0,0,0)
SoulGuitar = false

-- mastery lists
if not mastery1 then mastery1 = {"Cookie Crafter"} end
if not mastery2 then mastery2 = {"Reborn Skeleton"} end

-- Fix GetConnectionEnemies 100% KOKO style
GetConnectionEnemies = function(a)
  for i,v in pairs(replicated:GetChildren()) do
    if v:IsA("Model") and ((typeof(a) == "table" and table.find(a, v.Name)) or v.Name == a) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
      return v
    end
  end
  for i,v in next,workspace.Enemies:GetChildren() do
    if v:IsA("Model") and ((typeof(a) == "table" and table.find(a, v.Name)) or v.Name == a) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
      return v
    end
  end
  return nil
end

-- Get all nearby enemies for Near mode
GetAllNearbyEnemies = function()
  local closest = nil
  local minDist = math.huge
  local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
  if not hrp then return nil end
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
      local d = (v.HumanoidRootPart.Position - hrp.Position).Magnitude
      if d < minDist then
        minDist = d
        closest = v
      end
    end
  end
  return closest
end

-- Get spawn CFrame for mob name (for Near mode when no mob)
if not GetSpawnCFrame then
  GetSpawnCFrame = function(mobName)
    if PosMsList and PosMsList[mobName] then return PosMsList[mobName] end
    -- fallback check WorldOrigin EnemySpawns
    pcall(function()
      local spawns = workspace._WorldOrigin:FindFirstChild("EnemySpawns")
      if spawns then
        for _,sp in pairs(spawns:GetChildren()) do
          if sp.Name == mobName or string.find(sp.Name, mobName) then
            return sp.CFrame
          end
        end
      end
    end)
    return nil
  end
end

-- Ensure Attack table exists
if not Attack then Attack = {} end

-- KOKO Mas - Fruit mastery 100% - FIXED NO DROOP/DROP
Attack.Mas = function(v, enabled)
  if not v or not enabled then return end
  if not v:FindFirstChild("HumanoidRootPart") or not v:FindFirstChild("Humanoid") then return end
  if not v:GetAttribute("Locked") then
    v:SetAttribute("Locked", v.HumanoidRootPart.CFrame)
  end
  PosMon = v:GetAttribute("Locked").Position
  pcall(function() BringEnemy() end)
  if v.Humanoid.Health <= HealthM then
    -- FIX DROP: dùng GetSafeFarmCFrame nếu bật SafeFarm, không thì giữ độ cao 20 và bật noclip
    local targetCF = v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
    pcall(function()
      if getgenv().SafeFarmMode and typeof(GetSafeFarmCFrame)=="function" then
        targetCF = GetSafeFarmCFrame(v, false) or targetCF
      end
    end)
    _tp(targetCF)
    -- Anti drop - giữ shouldTween và OnFarm
    shouldTween = true
    getgenv().OnFarm = true
    local skills = _G.SelectedMasterySkills
    if type(skills) ~= "table" or next(skills)==nil then skills = {Z=true,X=true,C=true,V=true,F=true} end
    -- Dùng tất cả skill đã chọn, không phải 1 skill
    for k, val in pairs(skills) do
      local skillKey = nil
      if type(k)=="number" then skillKey = val
      elseif type(k)=="string" and val==true then skillKey = k end
      if skillKey then
        Useskills("Blox Fruit", skillKey)
        task.wait(0.15)
      end
    end
  else
    pcall(function() weaponSc("Melee") end)
    local meleeCF = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
    pcall(function()
      if getgenv().SafeFarmMode and typeof(GetSafeFarmCFrame)=="function" then
        meleeCF = GetSafeFarmCFrame(v, false) or meleeCF
      end
    end)
    _tp(meleeCF)
    shouldTween = true
    getgenv().OnFarm = true
  end
end

-- KOKO Masgun - Gun mastery 100% - FIXED NO DROP + MULTI SKILL
Attack.Masgun = function(v, enabled)
  if not v or not enabled then return end
  if not v:FindFirstChild("HumanoidRootPart") then return end
  if not v:GetAttribute("Locked") then
    v:SetAttribute("Locked", v.HumanoidRootPart.CFrame)
  end
  PosMon = v:GetAttribute("Locked").Position
  pcall(function() BringEnemy() end)
  if v.Humanoid.Health <= HealthM then
    local gunCF = v.HumanoidRootPart.CFrame * CFrame.new(0, 35, 8)
    pcall(function()
      if getgenv().SafeFarmMode and typeof(GetSafeFarmCFrame)=="function" then
        gunCF = GetSafeFarmCFrame(v, false) or gunCF
      end
    end)
    _tp(gunCF)
    shouldTween = true
    getgenv().OnFarm = true
    local skills = _G.SelectedMasterySkills
    if type(skills) ~= "table" or next(skills)==nil then skills = {Z=true,X=true,C=true,V=true,F=true} end
    for k, val in pairs(skills) do
      local skillKey = nil
      if type(k)=="number" then skillKey = val
      elseif type(k)=="string" and val==true then skillKey = k end
      if skillKey then
        Useskills("Gun", skillKey)
        task.wait(0.15)
      end
    end
  else
    pcall(function() weaponSc("Melee") end)
    local meleeCF = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
    pcall(function()
      if getgenv().SafeFarmMode and typeof(GetSafeFarmCFrame)=="function" then
        meleeCF = GetSafeFarmCFrame(v, false) or meleeCF
      end
    end)
    _tp(meleeCF)
    shouldTween = true
    getgenv().OnFarm = true
  end
end

-- KOKO Sword mastery 100% - FIXED NO DROP
Attack.Sword = function(v, enabled)
  if not v or not enabled then return end
  if not v:FindFirstChild("HumanoidRootPart") then return end
  if not v:GetAttribute("Locked") then
    v:SetAttribute("Locked", v.HumanoidRootPart.CFrame)
  end
  PosMon = v:GetAttribute("Locked").Position
  pcall(function() BringEnemy() end)
  pcall(function() weaponSc("Sword") end)
  local swordCF = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
  pcall(function()
    if getgenv().SafeFarmMode and typeof(GetSafeFarmCFrame)=="function" then
      swordCF = GetSafeFarmCFrame(v, false) or swordCF
    end
  end)
  _tp(swordCF)
  shouldTween = true
  getgenv().OnFarm = true
end

-- Level mode helper - use same logic as AutoFarm level but with mastery
GetLevelMob = function()
  -- simplified: find mob near level (use same as auto farm near but based on level)
  -- For real level mode, we will reuse CheckLevel or Quest
  local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
  if not hrp then return nil end
  -- try to get quest mob from Redz/ Skira level system
  if _G.CurrentFarmMob then
    return GetConnectionEnemies(_G.CurrentFarmMob)
  end
  return GetAllNearbyEnemies()
end

local posMastery = {"Cake","Bone","Near","Level"}
local skillOptions = {"Z","X","C","V","F"}

v485:AddSlider({
  Name = "Select Enemy Health [ % ]",
  Description = "",
  Default = _G.MasteryHealthPct or 70,
  Min = 1, Max = 95, Rounding = 1,
  Callback = function(Value)
    HeartMastery = Value
    _G.MasteryHealthPct = Value
    print("[Mastery] Health %: "..Value)
  end
})

v485:AddDropdown({
  Name = "Select Method Farm",
  Description = "",
  Options = posMastery,
  Default = "Cake",
  Callback = function(Value)
    SelectIsland = Value
    print("[Mastery] Island: "..Value)
  end
})


_G.SelectedMasterySkills = _G.SelectedMasterySkills or {Z=true,X=true,C=true,V=true,F=true}

-- Redz V5 remake hỗ trợ Multi = true / Multiselect = true, trả về bảng {Z=true,X=true,...}
-- Để tương thích mọi bản Redz, ta thử cả 2 cách
local MasterySkillDropdown = v485:AddDropdown({
  Name = "Select Skill Mastery",
  Description = "",
  Options = {"Z","X","C","V","F"},
  Default = {"Z"},
  Multiselect = true,
  Multi = true,
  Callback = function(Value)
    print("[Mastery] Dropdown callback: "..tostring(Value))
    local newSkills = {}
    if type(Value) == "table" then
      -- Trường hợp Redz trả về array {"Z","X"} hoặc dict {Z=true, X=true}
      if #Value > 0 then
        for _, skillName in ipairs(Value) do
          if type(skillName)=="string" then newSkills[skillName]=true end
        end
      else
        -- dict style
        for k,v in pairs(Value) do
          if type(k)=="string" and v==true then
            newSkills[k]=true
          elseif type(v)=="string" then
            newSkills[v]=true
          end
        end
      end
    elseif type(Value) == "string" then
      newSkills[Value]=true
    end
    if next(newSkills) ~= nil then
      _G.SelectedMasterySkills = newSkills
      local list = {}
      for k,_ in pairs(newSkills) do table.insert(list,k) end
      print("[Mastery] Đã chọn skill: "..table.concat(list,", "))
    end
  end
})

-- Fix Redz không tự gọi callback lúc đầu -> set default
task.spawn(function()
  task.wait(1)
  if _G.SelectedMasterySkills and next(_G.SelectedMasterySkills) then
    print("[Mastery] Skills mặc định: Z,X,C,V,F")
  end
end)


_G.SelectedMasteryType = _G.SelectedMasteryType or {Fruits=true}
_G.FarmMastery = _G.FarmMastery or false
_G.FarmMastery_Dev = _G.FarmMastery_Dev or false
_G.FarmMastery_G = _G.FarmMastery_G or false
_G.FarmMastery_S = _G.FarmMastery_S or false

-- Dropdown chọn loại mastery: Fruits / Gun / Sword - có thể chọn nhiều loại cùng lúc
v485:AddDropdown({
  Name = "Select Tools Mastery",
  Description = "",
  Options = {"Fruits", "Gun", "Sword"},
  Default = {"Fruits"},
  Multiselect = true,
  Multi = true,
  Callback = function(Value)
    local selected = {}
    if type(Value) == "table" then
      if #Value > 0 then
        for _, v in ipairs(Value) do
          if type(v)=="string" then selected[v]=true end
        end
      else
        for k,v in pairs(Value) do
          if type(k)=="string" and v==true then selected[k]=true
          elseif type(v)=="string" then selected[v]=true end
        end
      end
    elseif type(Value)=="string" then
      selected[Value]=true
    end
    if next(selected) then
      _G.SelectedMasteryType = selected
      local list={}
      for k,_ in pairs(selected) do table.insert(list,k) end
      print("[Mastery Type] Đã chọn: "..table.concat(list,", "))
      if _G.FarmMastery then
        _G.FarmMastery_Dev = selected["Fruits"] and true or false
        _G.FarmMastery_G = selected["Gun"] and true or false
        _G.FarmMastery_S = selected["Sword"] and true or false
      end
    end
  end
})

-- Toggle duy nhất để bật farm mastery
v485:AddToggle({
  Name = "Auto Farm Mastery",
  Description = "Bật để farm mastery theo loại đã chọn ở trên",
  Default = false,
  Callback = function(Value)
        if Value then AntiGravityAcquire("Auto Farm Mastery") else AntiGravityRelease("Auto Farm Mastery") end
    _G.FarmMastery = Value
    local sel = _G.SelectedMasteryType or {Fruits=true}
    if Value then
      _G.FarmMastery_Dev = sel["Fruits"] and true or false
      _G.FarmMastery_G = sel["Gun"] and true or false
      _G.FarmMastery_S = sel["Sword"] and true or false
      print("[Auto Farm Mastery] ON - Types: "..table.concat((function()
        local t={}
        for k,_ in pairs(sel) do table.insert(t,k) end
        return t
      end)(), ", "))
    else
      _G.FarmMastery_Dev = false
      _G.FarmMastery_G = false
      _G.FarmMastery_S = false
      print("[Auto Farm Mastery] OFF")
    end
  end
})

spawn(function()
  RunSer.RenderStepped:Connect(function()
    pcall(function()
      if _G.FarmMastery or _G.FarmMastery_Dev or _G.FarmMastery_G or _G.FarmMastery_S then
        for a,b in pairs(plr.PlayerGui.Notifications:GetChildren()) do
          if b.Name=="NotificationTemplate" and string.find(b.Text,"Skill locked!") then
            b:Destroy()
          end
        end
      end
    end)
  end)
end)

-- Fruits Mastery
spawn(function()
  while task.wait(0.1) do
    if _G.FarmMastery_Dev then
      pcall(function()
        local target = nil
        if SelectIsland == "Cake" then
          target = GetConnectionEnemies(mastery1)
          if not target then _tp(CFrame.new(-1943.676513671875, 251.5095672607422, -12337.880859375)) return end
        elseif SelectIsland == "Bone" then
          target = GetConnectionEnemies(mastery2)
          if not target then _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)) return end
        elseif SelectIsland == "Near" then
          target = GetAllNearbyEnemies()
          if not target then return end
        elseif SelectIsland == "Level" then
          Mastery_TakeQuestIfNeeded()
          target = GetLevelMob() or GetAllNearbyEnemies()
          if not target then return end
        end
        if target then
          _G.CurrentFarmMob = target.Name
          HealthM = target.Humanoid.MaxHealth * (_G.MasteryHealthPct/100)
          MousePos = target.HumanoidRootPart.Position
          repeat wait()
            MousePos = target.HumanoidRootPart.Position
            Attack.Mas(target,_G.FarmMastery_Dev)
          until _G.FarmMastery_Dev == false or not target.Parent or target.Humanoid.Health <= 0
        end
      end)
    end
  end
end)

-- Gun Mastery
spawn(function()
  while task.wait(0.1) do
    if _G.FarmMastery_G then
      pcall(function()
        local target = nil
        if SelectIsland == "Cake" then
          target = GetConnectionEnemies(mastery1)
          if not target then _tp(CFrame.new(-1943.676513671875, 251.5095672607422, -12337.880859375)) return end
        elseif SelectIsland == "Bone" then
          target = GetConnectionEnemies(mastery2)
          if not target then _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)) return end
        elseif SelectIsland == "Near" then
          target = GetAllNearbyEnemies()
          if not target then return end
        elseif SelectIsland == "Level" then
          Mastery_TakeQuestIfNeeded()
          target = GetLevelMob() or GetAllNearbyEnemies()
          if not target then return end
        end
        if target then
          HealthM = target.Humanoid.MaxHealth * (_G.MasteryHealthPct/100)
          repeat wait()
            MousePos = target.HumanoidRootPart.Position
            Attack.Masgun(target,_G.FarmMastery_G)
            local Modules = replicated:FindFirstChild("Modules")
            local Net = Modules and Modules:FindFirstChild("Net")
            local RE_ShootGunEvent = Net and Net:FindFirstChild("RE/ShootGunEvent")
            if plr.Character:FindFirstChildOfClass("Tool") and plr.Character:FindFirstChildOfClass("Tool").ToolTip == "Gun" then
              if plr.Character:FindFirstChildOfClass("Tool").Name == "Skull Guitar" then
                SoulGuitar = true
                plr.Character:FindFirstChildOfClass("Tool").RemoteEvent:FireServer("TAP", MousePos)
              else
                SoulGuitar = false
                if RE_ShootGunEvent then RE_ShootGunEvent:FireServer(MousePos, {target.HumanoidRootPart}) end
              end
              vim1:SendMouseButtonEvent(0,0,0,true,game,1);wait(0.05)
              vim1:SendMouseButtonEvent(0,0,0,false,game,1);wait(0.05)
            end
          until _G.FarmMastery_G == false or not target.Parent or target.Humanoid.Health <= 0
          SoulGuitar = false
        end
      end)
    end
  end
end)

-- Sword Mastery
spawn(function()
  while task.wait(0.1) do
    pcall(function()
      if _G.FarmMastery_S then
        local target = nil
        if SelectIsland == "Cake" then
          target = GetConnectionEnemies(mastery1)
          if not target then _tp(CFrame.new(-1943.676513671875, 251.5095672607422, -12337.880859375)) return end
        elseif SelectIsland == "Bone" then
          target = GetConnectionEnemies(mastery2)
          if not target then _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)) return end
        elseif SelectIsland == "Near" then
          target = GetAllNearbyEnemies()
          if not target then return end
        elseif SelectIsland == "Level" then
          Mastery_TakeQuestIfNeeded()
          target = GetLevelMob() or GetAllNearbyEnemies()
          if not target then return end
        end
        if target then
          local swordName = nil
          for _,v in next, replicated.Remotes.CommF_:InvokeServer("getInventory") do
            if type(v)=="table" and v.Type=="Sword" and tonumber(v.Mastery) and tonumber(v.Mastery) < 600 then swordName = v.Name break end
          end
          if swordName then
            if not GetBP(swordName) then
              replicated.Remotes.CommF_:InvokeServer("LoadItem", swordName)
            else
              repeat wait() Attack.Sword(target,_G.FarmMastery_S) until _G.FarmMastery_S == false or not target.Parent or target.Humanoid.Health <= 0
            end
          else
            repeat wait() Attack.Sword(target,_G.FarmMastery_S) until _G.FarmMastery_S == false or not target.Parent or target.Humanoid.Health <= 0
          end
        end
      end
    end)
  end
end)

end)
if not _okFarmHud then warn('[Farm Hud] '..tostring(_errFarmHud)) end
-- ========== HET FARM HUD ==========
_ = v486:AddSection({" Auto Fishing "})

local rs = game:GetService("ReplicatedStorage")
local netModules = rs:WaitForChild("Modules"):WaitForChild("Net")
local CraftRemote = netModules:WaitForChild("RF/Craft")
local JobsRemote = netModules:WaitForChild("RF/JobsRemoteFunction")
local ToolAbilities = netModules:WaitForChild("RF/JobToolAbilities")
local FishReplicated = rs:WaitForChild("FishReplicated")
local FishingRequest = FishReplicated:WaitForChild("FishingRequest")
local FishingClientConfig = require(FishReplicated:WaitForChild("FishingClient"):WaitForChild("Config"))
local GetWaterHeight = require(rs:WaitForChild("Util"):WaitForChild("GetWaterHeightAtLocation"))

v486:AddToggle({
    Title = "Auto Fish",
    Description = "",
    Default = false,
    Callback = function(v)
       _G.AutoFishing = v
    end
})

v486:AddToggle({
    Name = "Auto use skill of the rod",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoSkillZ = Value
    end
})

task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoSkillZ then
            pcall(function()
                ToolAbilities:InvokeServer("Z", true)
            end)
        end
    end
end)

v486:AddButton({
    Name = "Save Fish Position",
    Callback = function()
        local plr = game.Players.LocalPlayer
        local char = plr.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            _G.SavedFishPosition = char.HumanoidRootPart.CFrame
        end
    end
})

_ = v486:AddSection({" Bait "})

v486:AddDropdown({
    Name = "Select Bait",
    Description = "",
    Options = {"Basic Bait", "Kelp Bait", "Good Bait", "Abyssal Bait", "Frozen Bait", "Epic Bait", "Carnivore Bait"},
    Default = "Basic Bait",
    Callback = function(v)
        _G.SelectedBait = v
    end
})

v486:AddSlider({
    Name = "Max Baits",
    Min = 1,
    Max = 90,
    Default = 10,
    Callback = function(v)
        _G.MaxBaits = v
    end
})

v486:AddToggle({
    Name = "Auto Buy Baits",
    Description = "",
    Default = false,
    Callback = function(v)
        _G.AutoBuyBait = v
    end
})

v486:AddButton({
    Name = "Buy Bait",
    Callback = function()
        pcall(function()
            if _G.SelectedBait then
                CraftRemote:InvokeServer("Craft", _G.SelectedBait, {})
            end
        end)
    end
})

task.spawn(function()
    while task.wait(2) do
        if _G.AutoBuyBait then
            pcall(function()
                if _G.SelectedBait then
                    for i = 1, _G.MaxBaits or 1 do
                        CraftRemote:InvokeServer("Craft", _G.SelectedBait, {})
                        task.wait(0.1)
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if _G.AutoFishing then
            pcall(function()
                local plr = game.Players.LocalPlayer
                local char = plr.Character or plr.CharacterAdded:Wait()
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChildOfClass("Humanoid")
                local head = char:FindFirstChild("Head")

                if hrp and hum and head then
                    if _G.SavedFishPosition then
                        hrp.CFrame = _G.SavedFishPosition
                    end

                    local equippedTool = char:FindFirstChildOfClass("Tool")

                    if _G.SelectedRod and (not equippedTool or equippedTool.Name ~= _G.SelectedRod) then
                        local rod = plr.Backpack:FindFirstChild(_G.SelectedRod)
                        if rod then
                            hum:EquipTool(rod)
                            equippedTool = rod
                        end
                    end

                    if equippedTool and equippedTool.Name == _G.SelectedRod then
                        local maxLaunch = FishingClientConfig.Rod.MaxLaunchDistance
                        local waterHeight = 0

                        pcall(function()
                            waterHeight = GetWaterHeight(hrp.Position)
                        end)

                        local rayOrigin = head.Position
                        local rayDirection = hrp.CFrame.LookVector * maxLaunch

                        local ignore = {char, workspace:FindFirstChild("Characters"), workspace:FindFirstChild("Enemies")}
                        local _, hitPos = workspace:FindPartOnRayWithIgnoreList(Ray.new(rayOrigin, rayDirection), ignore)

                        local targetPos = hitPos and Vector3.new(hitPos.X, math.max(hitPos.Y, waterHeight), hitPos.Z)

                        local state = equippedTool:GetAttribute("State")
                        local serverState = equippedTool:GetAttribute("ServerState")

                        if targetPos and (state == "ReeledIn" or serverState == "ReeledIn") then
                            FishingRequest:InvokeServer("StartCasting")
                            task.wait()
                            FishingRequest:InvokeServer("CastLineAtLocation", targetPos, 100, true)
                        elseif serverState == "Biting" then
                            FishingRequest:InvokeServer("Catching", true)
                            task.wait(0.1)
                            FishingRequest:InvokeServer("Catch", 1)
                        end
                    end
                end
            end)
        end
    end
end)

_ = v486:AddSection({" Quest "})

v486:AddDropdown({
    Name = "Skip Quests",
    Description = "",
    Options = {"None", "Skip Get", "Skip Complete", "Skip Get, Complete"},
    Default = "None",
    Callback = function(v)
        _G.SkipQuestMode = v
    end
})

v486:AddToggle({
    Name = "Auto Quest [Skip Get, Complete]",
    Description = "",
    Default = false,
    Callback = function(v)
        _G.AutoFishingQuest = v
    end
})

v486:AddToggle({
    Name = "Take Quest Only When Fishing",
    Description = "",
    Default = false,
    Callback = function(v)
        _G.TakeQuestOnlyWhenFishing = v
    end
})

local function HasQuest()
    local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        local questGui = playerGui:FindFirstChild("Quest") or playerGui:FindFirstChild("QuestGui")
        if questGui and questGui:FindFirstChild("Container") and questGui.Container:FindFirstChild("QuestTitle") then
            return true
        end
    end
    return false
end

task.spawn(function()
    while task.wait(1) do
        if _G.AutoFishingQuest then
            pcall(function()
                if _G.TakeQuestOnlyWhenFishing and not _G.AutoFishing then return end
                if not HasQuest() then
                    if _G.SkipQuestMode ~= "Skip Get" and _G.SkipQuestMode ~= "Skip Get, Complete" then
                        JobsRemote:InvokeServer("FishingNPC","Angler","AskQuest")
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(5) do
        if _G.AutoFishingQuest then
            pcall(function()
                if _G.SkipQuestMode ~= "Skip Complete" and _G.SkipQuestMode ~= "Skip Get, Complete" then
                    JobsRemote:InvokeServer("FishingNPC","FinishQuest")
                end
            end)
        end
    end
end)

_ = v486:AddSection({" Sell "})

v486:AddDropdown({
    Name = "Select Fish Kind",
    Description = "",
    Options = {"All Fish", "Common", "Rare", "Legendary"},
    Default = "All Fish",
    Callback = function(v)
        _G.SelectedFishKind = v
    end
})

v486:AddToggle({
    Name = "Auto Sell Fish",
    Description = "",
    Default = false,
    Callback = function(v)
        _G.AutoSellFish = v
    end
})

task.spawn(function()
    while task.wait(5) do
        if _G.AutoSellFish then
            pcall(function()
                if _G.SelectedFishKind == "All Fish" then
                    JobsRemote:InvokeServer("FishingNPC","SellFish")
                else
                    JobsRemote:InvokeServer("FishingNPC","SellFishByKind", _G.SelectedFishKind)
                end
            end)
        end
    end
end)

_ = v486:AddSection({" Manual "})

v486:AddToggle({
    Name = "Instant Catch",
    Description = "",
    Default = false,
    Callback = function(v)
        _G.InstantCatch = v
    end
})

task.spawn(function()
    while task.wait(0.1) do
        if _G.InstantCatch then
            pcall(function()
                local plr = game.Players.LocalPlayer
                local char = plr.Character
                if char then
                    local tool = char:FindFirstChildOfClass("Tool")
                    if tool and tool:GetAttribute("ServerState") == "Casted" then
                        FishingRequest:InvokeServer("Catching", true)
                        task.wait(0.1)
                        FishingRequest:InvokeServer("Catch", 1)
                    end
                end
            end)
        end
    end
end)

_ = v486:AddSection({" Settings "})

v486:AddDropdown({
    Name = "Select Fishing Rod",
    Description = "",
    Options = {"Fishing Rod", "Gold Rod", "Shark Rod", "Shell Rod", "Treasure Rod"},
    Default = "Fishing Rod",
    Callback = function(v691)
        _G.SelectedRod = v691
    end
})
if World1 then
    local _ = v487:AddSection({" Quest Sea 1 "})
    v487:AddToggle({
        Name = "AutoSecondSea",
        Description = "",
        Default = false,
        Callback = function(v693)
            _G.AutoSecondSea = v693
            StopTween(_G.AutoSecondSea)
        end
    })
    spawn(function()
        while wait() do
            if _G.AutoSecondSea then
                pcall(function()
                    if game.Players.LocalPlayer.Data.Level.Value >= 700 and World1 then
                        _G.AutoFarm = false
                        if game.Workspace.Map.Ice.Door.CanCollide == true and game.Workspace.Map.Ice.Door.Transparency == 0 then
                            repeat
                                wait()
                                topos(CFrame.new(4851.8720703125, 5.6514348983765, 718.47094726563))
                            until (CFrame.new(4851.8720703125, 5.6514348983765, 718.47094726563).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.AutoSecondSea
                            wait(1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
                            EquipWeapon("Key")
                            local v694 = CFrame.new(1347.7124, 37.3751602, -1325.6488)
                            repeat
                                wait()
                                topos(v694)
                            until (v694.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.AutoSecondSea
                            wait(3)
                        elseif game.Workspace.Map.Ice.Door.CanCollide ~= false or game.Workspace.Map.Ice.Door.Transparency ~= 1 then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                        elseif game:GetService("Workspace").Enemies:FindFirstChild("Ice Admiral") then
                            for _, v696 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v696.Name == "Ice Admiral" and v696.Humanoid.Health > 0 then
                                    repeat
                                        wait()
                                        AutoHaki()
                                        EquipWeapon(_G.SelectWeapon)
                                        v696.HumanoidRootPart.CanCollide = false
                                        StartBring = true
                                        v696.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                        v696.HumanoidRootPart.Transparency = 1
                                        topos(v696.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                        game:GetService("VirtualUser"):CaptureController()
                                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 870), workspace.CurrentCamera.CFrame)
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 870), workspace.CurrentCamera.CFrame)
                                    until v696.Humanoid.Health <= 0 or not v696.Parent or not _G.AutoSecondSea
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                                end
                            end
                        else
                            topos(CFrame.new(1347.7124, 37.3751602, -1325.6488))
                        end
                    end
                end)
            end
        end
    end)
    local _ = v487:AddSection({" Boss Greybeard "})
    v487:AddToggle({
        Name = "Kill Greybeard",
        Description = "",
        Default = false,
        Callback = function(v698)
            _G.Greybeard = v698
            StopTween(_G.Greybeard)
        end
    })
    spawn(function()
        while wait() do
            if _G.Greybeard then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Greybeard") then
                        for _, v700 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v700.Name == "Greybeard" and v700:FindFirstChild("Humanoid") and v700:FindFirstChild("HumanoidRootPart") and v700.Humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    v700.HumanoidRootPart.CanCollide = false
                                    v700.Humanoid.WalkSpeed = 0
                                    v700.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                    topos(v700.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                    game:GetService("VirtualUser"):CaptureController()
                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.Greybeard or not v700.Parent or v700.Humanoid.Health <= 0
                            end
                        end
                    else
                        topos(CFrame.new(-5023.38330078125, 28.65203285217285, 4332.3818359375))
                        if not game:GetService("ReplicatedStorage"):FindFirstChild("Greybeard") then
                            if _G.Greybeardhop then
                                Hop()
                            end
                        else
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Greybeard").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
    local _ = v487:AddSection({" Quest Sword "})
    v487:AddToggle({
        Name = "Auto Get Saber",
        Description = "",
        Default = false,
        Callback = function(v702)
            _G.AutoSaber = v702
            StopTween(_G.AutoSaber)
        end
    })
    spawn(function()
        while task.wait() do
            if _G.AutoSaber and game.Players.LocalPlayer.Data.Level.Value >= 200 then
                pcall(function()
                    if game:GetService("Workspace").Map.Jungle.Final.Part.Transparency ~= 0 then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Saber Expert") or game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert") then
                            for _, v704 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v704:FindFirstChild("Humanoid") and v704:FindFirstChild("HumanoidRootPart") and v704.Humanoid.Health > 0 and v704.Name == "Saber Expert" then
                                    repeat
                                        task.wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        topos(v704.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                        v704.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                        v704.HumanoidRootPart.Transparency = 1
                                        v704.Humanoid.JumpPower = 0
                                        v704.Humanoid.WalkSpeed = 0
                                        v704.HumanoidRootPart.CanCollide = false
                                        FarmPos = v704.HumanoidRootPart.CFrame
                                        MonFarm = v704.Name
                                        game:GetService("VirtualUser"):CaptureController()
                                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672), workspace.CurrentCamera.CFrame)
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672), workspace.CurrentCamera.CFrame)
                                    until v704.Humanoid.Health <= 0 or not _G.AutoSaber
                                    if v704.Humanoid.Health <= 0 then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "PlaceRelic")
                                    end
                                end
                            end
                        end
                    elseif game:GetService("Workspace").Map.Jungle.QuestPlates.Door.Transparency == 0 then
                        if (CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151E-9, -0.928667724, 3.97099491E-8, 1, 1.91679348E-8, 0.928667724, -4.39869794E-8, 0.37091279).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 100 then
                            topos(CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151E-9, -0.928667724, 3.97099491E-8, 1, 1.91679348E-8, 0.928667724, -4.39869794E-8, 0.37091279))
                        else
                            topos(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
                            wait(1)
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate1.Button.CFrame
                            wait(1)
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate2.Button.CFrame
                            wait(1)
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate3.Button.CFrame
                            wait(1)
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate4.Button.CFrame
                            wait(1)
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate5.Button.CFrame
                            wait(1)
                        end
                    elseif game:GetService("Workspace").Map.Desert.Burn.Part.Transparency == 0 then
                        if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Torch") then
                            EquipWeapon("Torch")
                            topos(CFrame.new(1114.61475, 5.04679728, 4350.22803, -0.648466587, -1.28799094E-9, 0.761243105, -5.70652914E-10, 1, 1.20584542E-9, -0.761243105, 3.47544882E-10, -0.648466587))
                        else
                            topos(CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 3.42372805E-5, -0.258850515, 0.965917408))
                        end
                    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan") ~= 0 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "GetCup")
                        wait(0.5)
                        EquipWeapon("Cup")
                        wait(0.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "FillCup", game:GetService("Players").LocalPlayer.Character.Cup)
                        wait(0)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan")
                    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == "RichSon" then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")
                    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") ~= 0 then
                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 1 then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")
                            wait(0.5)
                            EquipWeapon("Relic")
                            wait(0.5)
                            topos(CFrame.new(-1404.91504, 29.9773273, 3.80598116, 0.876514494, 5.66906877E-9, 0.481375456, 2.53851997E-8, 1, -5.79995607E-8, -0.481375456, 6.30572643E-8, 0.876514494))
                        end
                    elseif game:GetService("Workspace").Enemies:FindFirstChild("Mob Leader") or game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader") then
                        topos(CFrame.new(-2967.59521, -4.91089821, 5328.70703, 0.342208564, -0.0227849055, 0.939347804, 0.0251603816, 0.999569714, 0.0150796166, -0.939287126, 0.0184739735, 0.342634559))
                        for _, v706 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v706.Name == "Mob Leader" then
                                if game:GetService("Workspace").Enemies:FindFirstChild("Mob Leader") and v706:FindFirstChild("Humanoid") and v706:FindFirstChild("HumanoidRootPart") and v706.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        AutoHaki()
                                        EquipWeapon(_G.SelectWeapon)
                                        v706.HumanoidRootPart.CanCollide = false
                                        v706.Humanoid.WalkSpeed = 0
                                        v706.HumanoidRootPart.Size = Vector3.new(80, 80, 80)
                                        topos(v706.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                        game:GetService("VirtualUser"):CaptureController()
                                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
                                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                    until v706.Humanoid.Health <= 0 or not _G.AutoSaber
                                end
                                if game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader [Lv. 120] [Boss]") then
                                    topos(game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader [Lv. 120] [Boss]").HumanoidRootPart.CFrame * Farm_Mode)
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)
    v487:AddToggle({
        Name = "Auto Get Sword Pole",
        Description = "",
        Default = false,
        Callback = function(v707)
            _G.Autopole = v707
            StopTween(_G.Autopole)
        end
    })
    spawn(function()
        while wait() do
            if _G.Autopole then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Thunder God") then
                        for _, v709 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v709.Name == "Thunder God" and v709:FindFirstChild("Humanoid") and v709:FindFirstChild("HumanoidRootPart") and v709.Humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    v709.HumanoidRootPart.CanCollide = false
                                    StartBring = true
                                    v709.Humanoid.WalkSpeed = 0
                                    v709.HumanoidRootPart.Size = Vector3.new(80, 80, 80)
                                    topos(v709.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.Autopole or not v709.Parent or v709.Humanoid.Health <= 0
                            end
                        end
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God") then
                        TP1(game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God").HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
                    end
                end)
            end
        end
    end)
    v487:AddToggle({
        Name = "Auto Get Sword Saw",
        Description = "",
        Default = false,
        Callback = function(v710)
            _G.Autosaw = v710
            StopTween(_G.Autosaw)
        end
    })
    local v711 = CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094)
    do
        local l_v711_0 = v711
        spawn(function()
            while wait() do
                if _G.Autosaw then
                    pcall(function()
                        if not game:GetService("Workspace").Enemies:FindFirstChild("The Saw") then
                            if BypassTP then
                                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - l_v711_0.Position).Magnitude > 1500 then
                                    BTP(l_v711_0)
                                elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - l_v711_0.Position).Magnitude < 1500 then
                                    topos(l_v711_0)
                                end
                            else
                                topos(l_v711_0)
                            end
                            EquipWeapon(_G.SelectWeapon)
                            topos(CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094))
                            if game:GetService("ReplicatedStorage"):FindFirstChild("The Saw") then
                                topos(game:GetService("ReplicatedStorage"):FindFirstChild("The Saw").HumanoidRootPart.CFrame * CFrame.new(2, 40, 2))
                            end
                        else
                            for _, v714 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v714.Name == "The Saw" and v714:FindFirstChild("Humanoid") and v714:FindFirstChild("HumanoidRootPart") and v714.Humanoid.Health > 0 then
                                    repeat
                                        task.wait(_G.FastAttackDelay)
                                        AutoHaki()
                                        EquipWeapon(_G.SelectWeapon)
                                        v714.HumanoidRootPart.CanCollide = false
                                        v714.Humanoid.WalkSpeed = 0
                                        v714.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                        topos(v714.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                        AttackNoCD()
                                    until not _G.Autosaw or not v714.Parent or v714.Humanoid.Health <= 0
                                end
                            end
                        end
                    end)
                end
            end
        end)
        v487:AddToggle({
            Name = "Auto Get Sword Wardens",
            Description = "",
            Default = false,
            Callback = function(v715)
                _G.ChiefWarden = v715
                StopTween(_G.ChiefWarden)
            end
        })
        spawn(function()
            while wait() do
                if _G.ChiefWarden then
                    pcall(function()
                        if game:GetService("Workspace").Enemies:FindFirstChild("Chief Warden") then
                            for _, v717 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v717.Name == "Chief Warden" and v717:FindFirstChild("Humanoid") and v717:FindFirstChild("HumanoidRootPart") and v717.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        AutoHaki()
                                        EquipWeapon(_G.SelectWeapon)
                                        v717.HumanoidRootPart.CanCollide = false
                                        StartBring = true
                                        v717.Humanoid.WalkSpeed = 0
                                        v717.HumanoidRootPart.Size = Vector3.new(80, 80, 80)
                                        topos(v717.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                    until not _G.ChiefWarden or not v717.Parent or v717.Humanoid.Health <= 0
                                end
                            end
                        elseif game:GetService("ReplicatedStorage"):FindFirstChild("Chief Warden") then
                            TP1(game:GetService("ReplicatedStorage"):FindFirstChild("Chief Warden").HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
                        end
                    end)
                end
            end
        end)
        v487:AddToggle({
            Name = "Auto Get Sword Trident",
            Description = "",
            Default = false,
            Callback = function(v718)
                _G.Trident = v718
                StopTween(_G.Trident)
            end
        })
        spawn(function()
            while wait() do
                if _G.Trident then
                    pcall(function()
                        if game:GetService("Workspace").Enemies:FindFirstChild("Fishman Lord") then
                            for _, v720 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v720.Name == "Fishman Lord" and v720:FindFirstChild("Humanoid") and v720:FindFirstChild("HumanoidRootPart") and v720.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        AutoHaki()
                                        EquipWeapon(_G.SelectWeapon)
                                        v720.HumanoidRootPart.CanCollide = false
                                        StartBring = true
                                        v720.Humanoid.WalkSpeed = 0
                                        v720.HumanoidRootPart.Size = Vector3.new(80, 80, 80)
                                        topos(v720.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                    until not _G.Trident or not v720.Parent or v720.Humanoid.Health <= 0
                                end
                            end
                        elseif game:GetService("ReplicatedStorage"):FindFirstChild("Fishman Lord") then
                            TP1(game:GetService("ReplicatedStorage"):FindFirstChild("Fishman Lord").HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
                        end
                    end)
                end
            end
        end)
    end
end
if World2 then
    local _ = v487:AddSection({" Quest Sea 2 "})
    v487:AddToggle({
        Name = "Auto Quest Sea Bartilo",
        Description = "",
        Default = false,
        Callback = function(v722)
            _G.AutoBartilo = v722
            StopTween(_G.AutoBartilo)
        end
    })
    spawn(function()
        pcall(function()
            while wait(0.1) do
                if _G.AutoBartilo then
                    if game:GetService("Players").LocalPlayer.Data.Level.Value >= 800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 0 then
                        if not string.find(GetQuestText(), "Swan Pirates") or not string.find(GetQuestText(), "50") or GetQuestActive() ~= true then
                            repeat
                                topos(CFrame.new(-456.28952, 73.0200958, 299.895966))
                                wait()
                            until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-456.28952, 73.0200958, 299.895966)).Magnitude <= 10
                            wait(1.1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "BartiloQuest", 1)
                        elseif game:GetService("Workspace").Enemies:FindFirstChild("Swan Pirate") then
                            Ms = "Swan Pirate"
                            for _, v724 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                do
                                    local l_v724_0 = v724
                                    if l_v724_0.Name == Ms then
                                        pcall(function()
                                            repeat
                                                task.wait()
                                                sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                                EquipWeapon(_G.SelectWeapon)
                                                AutoHaki()
                                                l_v724_0.HumanoidRootPart.Transparency = 1
                                                l_v724_0.HumanoidRootPart.CanCollide = false
                                                l_v724_0.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                                topos(l_v724_0.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                                PosMonBarto = l_v724_0.HumanoidRootPart.CFrame
                                                game:GetService("VirtualUser"):CaptureController()
                                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
                                                StartBring = true
                                            until not l_v724_0.Parent or l_v724_0.Humanoid.Health <= 0 or _G.AutoBartilo == false or GetQuestActive() == false
                                            StartBring = false
                                        end)
                                    end
                                end
                            end
                        else
                            repeat
                                topos(CFrame.new(932.624451, 156.106079, 1180.27466, -0.973085582, 4.55137119E-8, -0.230443969, 2.67024713E-8, 1, 8.47491108E-8, 0.230443969, 7.63147128E-8, -0.973085582))
                                wait()
                            until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(932.624451, 156.106079, 1180.27466, -0.973085582, 4.55137119E-8, -0.230443969, 2.67024713E-8, 1, 8.47491108E-8, 0.230443969, 7.63147128E-8, -0.973085582)).Magnitude <= 10
                        end
                    elseif game:GetService("Players").LocalPlayer.Data.Level.Value < 800 or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") ~= 1 then
                        if game:GetService("Players").LocalPlayer.Data.Level.Value >= 800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
                            repeat
                                topos(CFrame.new(-1850.49329, 13.1789551, 1750.89685))
                                wait()
                            until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-1850.49329, 13.1789551, 1750.89685)).Magnitude <= 10
                            wait(1)
                            repeat
                                topos(CFrame.new(-1858.87305, 19.3777466, 1712.01807))
                                wait()
                            until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-1858.87305, 19.3777466, 1712.01807)).Magnitude <= 10
                            wait(1)
                            repeat
                                topos(CFrame.new(-1803.94324, 16.5789185, 1750.89685))
                                wait()
                            until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-1803.94324, 16.5789185, 1750.89685)).Magnitude <= 10
                            wait(1)
                            repeat
                                topos(CFrame.new(-1858.55835, 16.8604317, 1724.79541))
                                wait()
                            until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-1858.55835, 16.8604317, 1724.79541)).Magnitude <= 10
                            wait(1)
                            repeat
                                topos(CFrame.new(-1869.54224, 15.987854, 1681.00659))
                                wait()
                            until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-1869.54224, 15.987854, 1681.00659)).Magnitude <= 10
                            wait(1)
                            repeat
                                topos(CFrame.new(-1800.0979, 16.4978027, 1684.52368))
                                wait()
                            until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-1800.0979, 16.4978027, 1684.52368)).Magnitude <= 10
                            wait(1)
                            repeat
                                topos(CFrame.new(-1819.26343, 14.795166, 1717.90625))
                                wait()
                            until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-1819.26343, 14.795166, 1717.90625)).Magnitude <= 10
                            wait(1)
                            repeat
                                topos(CFrame.new(-1813.51843, 14.8604736, 1724.79541))
                                wait()
                            until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-1813.51843, 14.8604736, 1724.79541)).Magnitude <= 10
                        end
                    elseif not game:GetService("Workspace").Enemies:FindFirstChild("Jeremy") then
                        if not game:GetService("ReplicatedStorage"):FindFirstChild("Jeremy") then
                            repeat
                                topos(CFrame.new(2099.88159, 448.931, 648.997375))
                                wait()
                            until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(2099.88159, 448.931, 648.997375)).Magnitude <= 10
                        else
                            repeat
                                topos(CFrame.new(-456.28952, 73.0200958, 299.895966))
                                wait()
                            until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-456.28952, 73.0200958, 299.895966)).Magnitude <= 10
                            wait(1.1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo")
                            wait(1)
                            repeat
                                topos(CFrame.new(2099.88159, 448.931, 648.997375))
                                wait()
                            until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(2099.88159, 448.931, 648.997375)).Magnitude <= 10
                            wait(2)
                        end
                    else
                        Ms = "Jeremy"
                        for _, v727 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v727.Name == Ms then
                                OldCFrameBartlio = v727.HumanoidRootPart.CFrame
                                repeat
                                    task.wait()
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                    EquipWeapon(_G.SelectWeapon)
                                    AutoHaki()
                                    v727.HumanoidRootPart.Transparency = 1
                                    v727.HumanoidRootPart.CanCollide = false
                                    v727.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                    v727.HumanoidRootPart.CFrame = OldCFrameBartlio
                                    topos(v727.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                    game:GetService("VirtualUser"):CaptureController()
                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                until not v727.Parent or v727.Humanoid.Health <= 0 or _G.AutoBartilo == false
                            end
                        end
                    end
                end
            end
        end)
    end)
    v487:AddToggle({
        Name = "Auto Quest Sea 3",
        Description = "",
        Default = false,
        Callback = function(v728)
            _G.ThirdSea = v728
            StopTween(_G.ThirdSea)
        end
    })
    spawn(function()
        while wait() do
            if _G.ThirdSea then
                pcall(function()
                    if game:GetService("Players").LocalPlayer.Data.Level.Value >= 1500 and World2 then
                        _G.AutoFarm = false
                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress", "General") == 0 then
                            topos(CFrame.new(-1926.3221435547, 12.819851875305, 1738.3092041016))
                            if (CFrame.new(-1926.3221435547, 12.819851875305, 1738.3092041016).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                                wait(1.5)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress", "Begin")
                            end
                            wait(1.8)
                            if not game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") then
                                if not game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") and (CFrame.new(-26880.93359375, 22.848554611206, 473.18951416016).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
                                    TP1(CFrame.new(-26880.93359375, 22.848554611206, 473.18951416016))
                                end
                            else
                                for _, v730 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v730.Name == "rip_indra" then
                                        OldCFrameThird = v730.HumanoidRootPart.CFrame
                                        repeat
                                            task.wait()
                                            AutoHaki()
                                            EquipWeapon(_G.SelectWeapon)
                                            topos(v730.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                            v730.HumanoidRootPart.CFrame = OldCFrameThird
                                            v730.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                            v730.HumanoidRootPart.CanCollide = false
                                            StartBring = true
                                            v730.Humanoid.WalkSpeed = 0
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
                                            sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                        until _G.ThirdSea == false or v730.Humanoid.Health <= 0 or not v730.Parent
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)

    local _ = v487:AddSection({" Boss Dark Beard "})
    v487:AddToggle({
        Name = "Auto Kill Dark Beard",
        Description = "",
        Default = false,
        Callback = function(v736)
            _G.AutoDarkBoss = v736
            StopTween(_G.AutoDarkBoss)
        end
    })
    spawn(function()
        while wait() do
            if _G.AutoDarkBoss then
                pcall(function()
                    if not game:GetService("Workspace").Enemies:FindFirstChild("Darkbeard") then
                        NeedAttacking = true
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Darkbeard") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Darkbeard").HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
                        end
                    else
                        for _, v738 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v738.Name == "Darkbeard" and v738:FindFirstChild("Humanoid") and v738:FindFirstChild("HumanoidRootPart") and v738.Humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    NeedAttacking = true
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    v738.HumanoidRootPart.CanCollide = false
                                    v738.Humanoid.WalkSpeed = 0
                                    topos(v738.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.AutoDarkBoss or not v738.Parent or v738.Humanoid.Health <= 0
                            end
                        end
                    end
                end)
            end
        end
    end)
    v487:AddToggle({
        Name = "Auto Kill Cursed Captain",
        Description = "",
        Default = false,
        Callback = function(v739)
            _G.CursedCaptain = v739
            StopTween(_G.CursedCaptain)
        end
    })
    spawn(function()
        while wait() do
            if _G.CursedCaptain then
                pcall(function()
                    if not game:GetService("Workspace").Enemies:FindFirstChild("Cursed Captain") then
                        NeedAttacking = true
                        if (Vector3.new(911.35827636719, 125.95812988281, 33159.5390625) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 18000 and game:GetService("ReplicatedStorage"):FindFirstChild("Cursed Captain") then
                            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Cursed Captain").HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
                        end
                    else
                        for _, v741 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v741.Name == "Cursed Captain" and v741:FindFirstChild("Humanoid") and v741:FindFirstChild("HumanoidRootPart") and v741.Humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    NeedAttacking = true
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    v741.HumanoidRootPart.CanCollide = false
                                    v741.Humanoid.WalkSpeed = 0
                                    topos(v741.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.CursedCaptain or not v741.Parent or v741.Humanoid.Health <= 0
                            end
                        end
                    end
                end)
            end
        end
    end)
    local _ = v487:AddSection({" Auto Buy Haki   "})
    v487:AddToggle({
        Name = "Auto Buy Haki Colors",
        Description = "",
        Default = false,
        Callback = function(v743)
            _G.AutoBuyEnchancementColour = v743
            StopTween(_G.AutoBuyEnchancementColour)
        end
    })
    spawn(function()
        while wait() do
            if _G.AutoBuyEnchancementColour then
                local v744 = {[1] = "ColorsDealer", [2] = "2"}
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v744))
            end
        end
    end)
    v487:AddToggle({
        Title = "Auto Buy Legendary Sword",
        Value = false,
        Callback = function(v745)
            _G.AutoBuyLegendarySword = v745
        end
    })
    spawn(function()
        while wait() do
            if _G.AutoBuyLegendarySword then
                pcall(function()
                    local v746 = {[1] = "LegendarySwordDealer", [2] = "1"}
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v746))
                    local v747 = {[1] = "LegendarySwordDealer", [2] = "2"}
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v747))
                    local v748 = {[1] = "LegendarySwordDealer", [2] = "3"}
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v748))
                end)
            end
        end
    end)
    local _ = v487:AddSection({" Quest Sword "})
    v487:AddToggle({
        Name = "Auto Get Longsword",
        Description = "",
        Default = false,
        Callback = function(v750)
            _G.Longsword = v750
            StopTween(_G.Longsword)
        end
    })
    spawn(function()
        while wait() do
            if _G.Longsword then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Diamond") then
                        for _, v752 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v752.Name == "Diamond" and v752:FindFirstChild("Humanoid") and v752:FindFirstChild("HumanoidRootPart") and v752.Humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    v752.HumanoidRootPart.CanCollide = false
                                    StartBring = true
                                    v752.Humanoid.WalkSpeed = 0
                                    v752.HumanoidRootPart.Size = Vector3.new(80, 80, 80)
                                    topos(v752.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.Longsword or not v752.Parent or v752.Humanoid.Health <= 0
                            end
                        end
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Diamond") then
                        TP1(game:GetService("ReplicatedStorage"):FindFirstChild("Diamond").HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
                    end
                end)
            end
        end
    end)
    v487:AddToggle({
        Name = "Auto Get Sword Gravity Blade",
        Description = "",
        Default = false,
        Callback = function(v753)
            _G.GravityBlade = v753
            StopTween(_G.GravityBlade)
        end
    })
    spawn(function()
        while wait() do
            if _G.GravityBlade then
                pcall(function()
                    if not game:GetService("Workspace").Enemies:FindFirstChild("Fajita") then
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Fajita") then
                            TP1(game:GetService("ReplicatedStorage"):FindFirstChild("Fajita").HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
                        end
                    else
                        for _, v755 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v755.Name == "Fajita" and v755:FindFirstChild("Humanoid") and v755:FindFirstChild("HumanoidRootPart") and v755.Humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    v755.HumanoidRootPart.CanCollide = false
                                    StartBring = true
                                    v755.Humanoid.WalkSpeed = 0
                                    v755.HumanoidRootPart.Size = Vector3.new(80, 80, 80)
                                    topos(v755.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.GravityBlade or not v755.Parent or v755.Humanoid.Health <= 0
                            end
                        end
                    end
                end)
            end
        end
    end)
    v487:AddToggle({
        Name = "Auto Get Sword Flail",
        Description = "",
        Default = false,
        Callback = function(v756)
            _G.SwodsFlail = v756
            StopTween(_G.SwodsFlail)
        end
    })
    spawn(function()
        while wait() do
            if _G.SwodsFlail then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Smoke Admiral") then
                        for _, v758 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v758.Name == "Smoke Admiral" and v758:FindFirstChild("Humanoid") and v758:FindFirstChild("HumanoidRootPart") and v758.Humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    v758.HumanoidRootPart.CanCollide = false
                                    StartBring = true
                                    v758.Humanoid.WalkSpeed = 0
                                    v758.HumanoidRootPart.Size = Vector3.new(80, 80, 80)
                                    topos(v758.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.SwodsFlail or not v758.Parent or v758.Humanoid.Health <= 0
                            end
                        end
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Smoke Admiral") then
                        TP1(game:GetService("ReplicatedStorage"):FindFirstChild("Smoke Admiral").HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
                    end
                end)
            end
        end
    end)
    v487:AddToggle({
        Name = "Auto Get Sword Rengoku",
        Description = "",
        Default = false,
        Callback = function(v759)
            _G.AutoRengoku = v759
            StopTween(_G.AutoRengoku)
        end
    })
    spawn(function()
        pcall(function()
            while wait() do
                if _G.AutoRengoku then
                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hidden Key") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Hidden Key") then
                        EquipWeapon("Hidden Key")
                        topos(CFrame.new(6571.1201171875, 299.23028564453, -6967.841796875))
                    elseif not game:GetService("Workspace").Enemies:FindFirstChild("Awakened Ice Admiral") then
                        StartBring = false
                        topos(CFrame.new(5439.716796875, 84.420944213867, -6715.1635742188))
                    else
                        for _, v761 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v761.Name == "Awakened Ice Admiral" and v761:FindFirstChild("Humanoid") and v761:FindFirstChild("HumanoidRootPart") and v761.Humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    AutoHaki()
                                    v761.HumanoidRootPart.CanCollide = false
                                    v761.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                    PosMon = v761.HumanoidRootPart.CFrame
                                    MonFarm = v761.Name
                                    topos(v761.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                    AttackNoCD()
                                    StartBring = true
                                until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hidden Key") or _G.AutoRengoku == false or not v761.Parent or v761.Humanoid.Health <= 0
                                StartBring = false
                            end
                        end
                    end
                end
            end
        end)
    end)
    v487:AddToggle({
        Name = "Auto Get Sword Dragon Trident",
        Description = "",
        Default = false,
        Callback = function(v762)
            _G.SwodsDRTrident = v762
            StopTween(_G.SwodsDRTrident)
        end
    })
    spawn(function()
        while wait() do
            if _G.SwodsDRTrident then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Tide Keeper") then
                        for _, v764 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v764.Name == "Tide Keeper" and v764:FindFirstChild("Humanoid") and v764:FindFirstChild("HumanoidRootPart") and v764.Humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    v764.HumanoidRootPart.CanCollide = false
                                    StartBring = true
                                    v764.Humanoid.WalkSpeed = 0
                                    v764.HumanoidRootPart.Size = Vector3.new(80, 80, 80)
                                    topos(v764.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.SwodsDRTrident or not v764.Parent or v764.Humanoid.Health <= 0
                            end
                        end
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Tide Keeper") then
                        TP1(game:GetService("ReplicatedStorage"):FindFirstChild("Tide Keeper").HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
                    end
                end)
            end
        end
    end)
end
if World3 then
    local _ = v487:AddSection({" Quest Sea 3 "})
    local _ = v487:AddSection({" Boss Rip indra "})
    v487:AddToggle({
        Name = "Auto kill Rip Indra",
        Description = "",
        Default = false,
        Callback = function(v767)
            _G.RipIndraKill = v767
            StopTween(_G.RipIndraKill)
        end
    })
    local v768 = CFrame.new(-5344.822265625, 423.98541259766, -2725.0930175781)
    do
        local l_v768_0 = v768
        spawn(function()
            pcall(function()
                while wait() do
                    if _G.RipIndraKill then
                        if not game:GetService("Workspace").Enemies:FindFirstChild("rip_indra True Form") and not game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") then
                            if BypassTP then
                                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - l_v768_0.Position).Magnitude > 1500 then
                                    TP1(l_v768_0)
                                elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - l_v768_0.Position).Magnitude < 1500 then
                                    TP1(l_v768_0)
                                end
                            else
                                TP1(l_v768_0)
                            end
                            TP1(CFrame.new(-5344.822265625, 423.98541259766, -2725.0930175781))
                        else
                            for _, v771 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                local l_Name_0 = v771.Name
                                local v773 = "rip_indra True Form"
                                if not v773 then
                                    if v771.Name ~= "rip_indra" then
                                        v773 = false
                                    end
                                    v773 = true
                                end
                                do
                                    local l_v771_0 = v771
                                    if l_Name_0 == v773 and l_v771_0.Humanoid.Health > 0 and l_v771_0:IsA("Model") and l_v771_0:FindFirstChild("Humanoid") and l_v771_0:FindFirstChild("HumanoidRootPart") then
                                        repeat
                                            task.wait()
                                            pcall(function()
                                                AutoHaki()
                                                EquipWeapon(_G.SelectWeapon)
                                                l_v771_0.HumanoidRootPart.CanCollide = false
                                                l_v771_0.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                                topos(l_v771_0.HumanoidRootPart.CFrame * CFrame.new(0, -40, 0))
                                                game:GetService("VirtualUser"):CaptureController()
                                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 670), workspace.CurrentCamera.CFrame)
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 670), workspace.CurrentCamera.CFrame)
                                            end)
                                        until _G.RipIndraKill == false or l_v771_0.Humanoid.Health <= 0
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end)
        v487:AddToggle({
            Name = "Auto Haki Colors",
            Description = "",
            Default = false,
            Callback = function(v775)
                _G.RipIndraKill = v775
                StopTween(_G.RipIndraKill)
            end
        })
        spawn(function()
            while wait() do
                if _G.AutoBuyEnchancementColour then
                    local v776 = {[1] = "ColorsDealer", [2] = "2"}
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v776))
                end
            end
        end)
        local _ = v487:AddSection({" Quest Skull Guitar "})
        v487:AddToggle({
            Name = "Auto Skull Guitar",
            Description = "",
            Default = false,
            Callback = function(v778)
                _G.AutoSkullGuitar = v778
                getgenv().AutoSkullGuitar = v778
                StopTween(_G.AutoSkullGuitar)
            end
        })
        spawn(function()
            while task.wait() do
                if getgenv().AutoSkullGuitar then
                    pcall(function()
                        if not GetWeaponInventory("Skull Guitar") then
                            local l_LocalPlayer_11 = game:GetService("Players").LocalPlayer
                            local v780 = l_LocalPlayer_11.Character and l_LocalPlayer_11.Character:FindFirstChild("HumanoidRootPart")
                            if v780 and (Vector3.new(-9681.458, 6.139, 6341.372) - v780.Position).Magnitude <= 5000 then
                                if game:GetService("Workspace").NPCs:FindFirstChild("Skeleton Machine") then
                                    game:GetService("ReplicatedStorage").Remotes.CommF:InvokeServer("soulGuitarBuy", true)
                                else
                                    local l_FirstChild_3 = game:GetService("Workspace").Map:FindFirstChild("Haunted Castle")
                                    if not l_FirstChild_3 or l_FirstChild_3.Candle1.Transparency ~= 0 then
                                        if not l_FirstChild_3 or not l_FirstChild_3.Tablet or not l_FirstChild_3.Tablet:FindFirstChild("Segment1") then
                                            if game:GetService("Workspace").NPCs:FindFirstChild("Ghost") then
                                                game:GetService("ReplicatedStorage").Remotes.CommF:InvokeServer("GuitarPuzzleProgress", "Ghost")
                                            end
                                            local l_Enemies_2 = game.Workspace:FindFirstChild("Enemies")
                                            if l_Enemies_2 and l_Enemies_2:FindFirstChild("Living Zombie") then
                                                for _, v784 in pairs(l_Enemies_2:GetChildren()) do
                                                    if v784:FindFirstChild("HumanoidRootPart") and v784:FindFirstChild("Humanoid") and v784.Humanoid.Health > 0 and v784.Name == "Living Zombie" then
                                                        AutoHaki()
                                                        EquipWeapon(getgenv().SelectWeapon)
                                                        v784.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                                        v784.HumanoidRootPart.Transparency = 1
                                                        v784.Humanoid.JumpPower = 0
                                                        v784.Humanoid.WalkSpeed = 0
                                                        v784.HumanoidRootPart.CanCollide = false
                                                        v784.HumanoidRootPart.CFrame = v780.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0)
                                                        topos(CFrame.new(-10160.787, 138.662, 5955.031))
                                                        task.wait(0.5)
                                                        local l_VirtualUser_0 = game:GetService("VirtualUser")
                                                        l_VirtualUser_0:CaptureController()
                                                        l_VirtualUser_0:Button1Down(Vector2.new(1280, 672))
                                                        l_VirtualUser_0:Button1Up(Vector2.new(1280, 672))
                                                    end
                                                end
                                            else
                                                topos(CFrame.new(-10160.787, 138.662, 5955.031))
                                            end
                                        else
                                            local l_l_FirstChild_3_FirstChild_0 = l_FirstChild_3:FindFirstChild("Lab Puzzle")
                                            if not l_l_FirstChild_3_FirstChild_0 or not l_l_FirstChild_3_FirstChild_0.ColorFloor.Model.Part1:FindFirstChild("ClickDetector") then
                                                Quest3 = true
                                            else
                                                Quest4 = true
                                                topos(CFrame.new(-9553.599, 65.623, 6041.588))
                                                task.wait(1)
                                                for _, v788 in ipairs({3, 4, 4, 4, 6, 6, 8, 10, 10, 10}) do
                                                    local l_FirstChild_4 = l_l_FirstChild_3_FirstChild_0.ColorFloor.Model:FindFirstChild("Part" .. v788)
                                                    if l_FirstChild_4 and l_FirstChild_4:FindFirstChild("ClickDetector") then
                                                        topos(l_FirstChild_4.CFrame)
                                                        task.wait(1)
                                                        fireclickdetector(l_FirstChild_4.ClickDetector)
                                                        task.wait(0.5)
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        local l_Placard1_0 = l_FirstChild_3:FindFirstChild("Placard1")
                                        if l_Placard1_0 and l_Placard1_0.Left.Part.Transparency == 0 then
                                            Quest2 = true
                                            topos(CFrame.new(-8762.691, 176.847, 6171.308))
                                            task.wait(1)
                                            for v791 = 7, 1, -1 do
                                                local l_l_FirstChild_3_FirstChild_1 = l_FirstChild_3:FindFirstChild("Placard" .. v791)
                                                if l_l_FirstChild_3_FirstChild_1 and l_l_FirstChild_3_FirstChild_1:FindFirstChild("Left") and l_l_FirstChild_3_FirstChild_1.Left:FindFirstChild("ClickDetector") then
                                                    fireclickdetector(l_l_FirstChild_3_FirstChild_1.Left.ClickDetector)
                                                    task.wait(0.5)
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        elseif not string.find(game:GetService("ReplicatedStorage").Remotes.CommF:InvokeServer("gravestoneEvent", 2), "Error") then
                            if string.find(game:GetService("ReplicatedStorage").Remotes.CommF:InvokeServer("gravestoneEvent", 2), "Nothing") then
                                topos("Wait Full Moon")
                            else
                                game:GetService("ReplicatedStorage").Remotes.CommF:InvokeServer("gravestoneEvent", 2, true)
                            end
                        else
                            topos(CFrame.new(-8653.206, 140.985, 6160.033))
                        end
                    end)
                end
            end
        end)

        local _ = v487:AddSection({" Auto CDK "})
        v487:AddToggle({
            Name = "Auto Cdk",
            Description = "Completes all 6 CDK trials + Boss automatically",
            Default = false,
            Callback = function(v797)
                _G.AutoGetCDK = v797
                getgenv().AutoGetCDK = v797
                StopTween(_G.AutoGetCDK)
            end
        })
                task.spawn(function()
            local lastNotification = ""
            local function Notify(text)
                if lastNotification ~= text then
                    game.StarterGui:SetCore("SendNotification", {Title = "CDK System", Text = text, Duration = 5})
                    lastNotification = text
                end
            end

            while task.wait(1) do
                if getgenv().AutoGetCDK then
                    pcall(function()
                        local CommF = game:GetService("ReplicatedStorage").Remotes.CommF_
                        local l_Player = game.Players.LocalPlayer
                        local hrp = HRP()
                        if not hrp then return end

                        local inventory = CommF:InvokeServer("getInventory")
                        local fragments = 0
                        local hasYama = false
                        local hasTushita = false
                        for _, v in pairs(inventory) do
                            if type(v) == "table" then
                                if v.Name == "Alucard Fragment" then fragments = v.Count or 0 end
                                if v.Name == "Yama" then hasYama = true end
                                if v.Name == "Tushita" then hasTushita = true end
                            end
                        end
                        
                        if fragments >= 6 then
                            Notify("Both scrolls completed! Heading to Boss.")
                            local boss = game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton Boss")
                            if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                                EquipWeapon("Yama")
                                AutoHaki()
                                boss.HumanoidRootPart.CanCollide = false
                                boss.Humanoid.WalkSpeed = 0
                                boss.HumanoidRootPart.Size = Vector3.new(80, 80, 80)
                                topos(boss.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                sethiddenproperty(l_Player, "SimulationRadius", math.huge)
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
                            else
                                CommF:InvokeServer("CDKQuest", "StartTrial", "Boss")
                                task.wait(1)
                                if not game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton Boss") then
                                    topos(CFrame.new(-12318, 601, -6538))
                                end
                            end
                            return
                        end

                        if not (hasYama and hasTushita) then
                            Notify("Error: You do not own Yama & Tushita! Disabling.")
                            getgenv().AutoGetCDK = false
                            _G.AutoGetCDK = false
                            return
                        end

                        local doorStatus = tostring(CommF:InvokeServer("CDKQuest", "OpenDoor"))
                        if doorStatus ~= "opened" then
                            CommF:InvokeServer("CDKQuest", "OpenDoor")
                            CommF:InvokeServer("CDKQuest", "OpenDoor", true)
                            task.wait(1)
                            if tostring(CommF:InvokeServer("CDKQuest", "OpenDoor")) ~= "opened" then
                                Notify("Failed to open door. Ensure masteries are 350+! Disabling.")
                                getgenv().AutoGetCDK = false
                                _G.AutoGetCDK = false
                                return
                            end
                        end

                        local pGood = CommF:InvokeServer("CDKQuest", "Progress", "Good")
                        local pEvil = CommF:InvokeServer("CDKQuest", "Progress", "Evil")
                        local activeTrial = nil
                        
                        if type(pGood) == "table" and pGood["Finished"] == false then activeTrial = "Good"
                        elseif type(pEvil) == "table" and pEvil["Finished"] == false then activeTrial = "Evil" end

                        if not activeTrial then
                            CommF:InvokeServer("CDKQuest", "StartTrial", "Good")
                            task.wait(1)
                            pGood = CommF:InvokeServer("CDKQuest", "Progress", "Good")
                            if type(pGood) == "table" and pGood["Finished"] == false then
                                Notify("Started Tushita (Good) Trial!")
                                activeTrial = "Good"
                            else
                                CommF:InvokeServer("CDKQuest", "StartTrial", "Evil")
                                task.wait(1)
                                pEvil = CommF:InvokeServer("CDKQuest", "Progress", "Evil")
                                if type(pEvil) == "table" and pEvil["Finished"] == false then
                                    Notify("Started Yama (Evil) Trial!")
                                    activeTrial = "Evil"
                                end
                            end
                        end

                        if activeTrial == "Good" then
                            local step = tonumber(pGood["Good"])
                            if step == -3 then
                                Notify("Good Trial: Dock Legend (Boat Dealers)")
                                local locs = {CFrame.new(-4602, 16, -2880), CFrame.new(4001, 10, -2654), CFrame.new(-9530, 7, -8375)}
                                for _, loc in ipairs(locs) do
                                    if not getgenv().AutoGetCDK then return end
                                    topos(loc)
                                    if (hrp.Position - loc.Position).Magnitude <= 15 then
                                        CommF:InvokeServer("CDKQuest","BoatQuest",workspace.NPCs:FindFirstChild("Luxury Boat Dealer"),"Check")
                                        CommF:InvokeServer("CDKQuest","BoatQuest",workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))
                                    end
                                    task.wait(1)
                                end
                            elseif step == -4 then
                                Notify("Good Trial: Sense of Duty (Please do Pirate Raid!)")
                                _G.AutoRaidCastle = true
                            elseif step == -5 then
                                Notify("Good Trial: Soulless (Heavenly Dimension)")
                                if workspace.Map:FindFirstChild("HeavenlyDimension") then
                                    if (hrp.Position - workspace.Map.HeavenlyDimension.Spawn.Position).Magnitude <= 1000 then
                                        local torches = {CFrame.new(-22529, 5275, 3873), CFrame.new(-22637, 5281, 3749), CFrame.new(-22791, 5277, 3764)}
                                        for _, loc in ipairs(torches) do
                                            topos(loc)
                                            for _, v in pairs(workspace.Map.HeavenlyDimension:GetDescendants()) do
                                                if v:IsA("ProximityPrompt") then fireproximityprompt(v) end
                                            end
                                            task.wait(1)
                                        end
                                        for _, v in pairs(workspace.Enemies:GetChildren()) do
                                            if (v:FindFirstChild("HumanoidRootPart").Position - CFrame.new(-22695, 5270, 3814).Position).Magnitude <= 300 then
                                                EquipWeapon("Tushita")
                                                topos(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0))
                                                game:GetService("VirtualUser"):CaptureController()
                                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
                                            end
                                        end
                                    end
                                else
                                    local m = game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen")
                                    if m then topos(m.HumanoidRootPart.CFrame * CFrame.new(0,15,0)) else topos(CFrame.new(-709, 381, -11011)) end
                                end
                            end

                        elseif activeTrial == "Evil" then
                            local step = tonumber(pEvil["Evil"])
                            if step == -3 then
                                Notify("Evil Trial: Pain & Suffering")
                                EquipWeapon("Yama")
                                local m = game:GetService("Workspace").Enemies:FindFirstChild("Forest Pirate")
                                if m then
                                    topos(m.HumanoidRootPart.CFrame * CFrame.new(0,15,0))
                                    game:GetService("VirtualUser"):CaptureController()
                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
                                else
                                    topos(CFrame.new(-13223, 428, -7766))
                                end
                            elseif step == -4 then
                                Notify("Evil Trial: Haze of Misery")
                                EquipWeapon("Yama")
                                -- simplified logic: kill enemies marked by quest
                                local marked = nil
                                if l_Player:FindFirstChild("QuestHaze") then
                                    for _, q in pairs(l_Player.QuestHaze:GetChildren()) do
                                        for _, m in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                            if string.find(q.Name, m.Name) and m:FindFirstChild("HumanoidRootPart") and m.Humanoid.Health > 0 then
                                                marked = m
                                                break
                                            end
                                        end
                                    end
                                end
                                if marked then
                                    topos(marked.HumanoidRootPart.CFrame * CFrame.new(0,15,0))
                                    game:GetService("VirtualUser"):CaptureController()
                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
                                else
                                    -- Teleport around main islands to spawn them
                                    topos(CFrame.new(-226, 20, 5538))
                                end
                            elseif step == -5 then
                                Notify("Evil Trial: Fear the Reaper")
                                EquipWeapon("Yama")
                                if workspace.Map:FindFirstChild("HellDimension") then
                                    if (hrp.Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 1000 then
                                        for i = 1, 3 do
                                            local torch = workspace.Map.HellDimension:FindFirstChild("Torch"..i)
                                            if torch and torch:FindFirstChild("Particles") then
                                                topos(torch.Particles.CFrame)
                                                for _, v in pairs(workspace.Map.HellDimension:GetDescendants()) do
                                                    if v:IsA("ProximityPrompt") then fireproximityprompt(v) end
                                                end
                                            end
                                        end
                                        for _, v in pairs(workspace.Enemies:GetChildren()) do
                                            if (v:FindFirstChild("HumanoidRootPart").Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 300 then
                                                topos(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0))
                                                game:GetService("VirtualUser"):CaptureController()
                                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
                                            end
                                        end
                                    end
                                else
                                    local sr = game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper")
                                    if sr then
                                        topos(sr.HumanoidRootPart.CFrame) -- Must die to him
                                    else
                                        topos(CFrame.new(-8932, 146, 6062))
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end)
        v487:AddToggle({
            Name = "Auto Get Yama",
            Description = "",
            Default = false,
            Callback = function(v807)
                _G.AutoYama = v807
                StopTween(_G.AutoYama)
            end
        })
        spawn(function()
            while wait() do
                if _G.AutoYama and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress") >= 30 then
                    repeat
                        wait()
                        fireclickdetector(game:GetService("Workspace").Map.Waterfall.SealedKatana.Handle.ClickDetector)
                    until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Yama") or not _G.AutoYama
                end
            end
        end)
        v487:AddToggle({
            Name = "Auto Holy Torch Tushita",
            Description = "",
            Default = false,
            Callback = function(v808)
                _G.AutoHolyTorch = v808
                StopTween(_G.AutoHolyTorch)
            end
        })
        spawn(function()
            while wait() do
                if _G.AutoHolyTorch then
                    pcall(function()
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5657.88623046875, 1013.0790405273438, -335.4996337890625))
                        wait(1)
                        topos(CFrame.new(5711.87451171875, 45.82802963256836, 254.17005920410156))
                        wait(15)
                        EquipWeapon("Holy Torch")
                        repeat
                            topos(CFrame.new(-10752, 417, -9366))
                            wait()
                        until not _G.AutoHolyTorch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-10752, 417, -9366)).Magnitude <= 10
                        wait(1)
                        repeat
                            topos(CFrame.new(-11672, 334, -9474))
                            wait()
                        until not _G.AutoHolyTorch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-11672, 334, -9474)).Magnitude <= 10
                        wait(1)
                        repeat
                            topos(CFrame.new(-12132, 521, -10655))
                            wait()
                        until not _G.AutoHolyTorch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-12132, 521, -10655)).Magnitude <= 10
                        wait(1)
                        repeat
                            topos(CFrame.new(-13336, 486, -6985))
                            wait()
                        until not _G.AutoHolyTorch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-13336, 486, -6985)).Magnitude <= 10
                        wait(1)
                        repeat
                            topos(CFrame.new(-13489, 332, -7925))
                            wait()
                        until not _G.AutoHolyTorch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-13489, 332, -7925)).Magnitude <= 10
                    end)
                end
            end
        end)
        v487:AddToggle({
            Name = "Auto Get Tushita",
            Description = "",
            Default = false,
            Callback = function(v809)
                _G.AutoGetTushita = v809
                StopTween(_G.AutoGetTushita)
            end
        })
        spawn(function()
            while wait() do
                if _G.AutoGetTushita then
                    pcall(function()
                        if game:GetService("Workspace").Enemies:FindFirstChild("Longma") then
                            for _, v811 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v811.Name == "Longma" and v811:FindFirstChild("Humanoid") and v811:FindFirstChild("HumanoidRootPart") and v811.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        AutoHaki()
                                        EquipWeapon(_G.SelectWeapon)
                                        v811.HumanoidRootPart.CanCollide = false
                                        StartBring = true
                                        v811.Humanoid.WalkSpeed = 0
                                        v811.HumanoidRootPart.Size = Vector3.new(80, 80, 80)
                                        topos(v811.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                    until not _G.AutoGetTushita or not v811.Parent or v811.Humanoid.Health <= 0
                                end
                            end
                        elseif game:GetService("ReplicatedStorage"):FindFirstChild("Longma") then
                            TP1(game:GetService("ReplicatedStorage"):FindFirstChild("Longma").HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
                        end
                    end)
                end
            end
        end)
        local _ = v487:AddSection({" Tyrant of the Skies "})
        local v548 = v487:AddParagraph({Title = "Check Eyes Status", Content = "Loading..."})
        task.spawn(function()
            while task.wait(1) do
                pcall(function()
                    local v549 = 0
                    local v550 = {
                        workspace.Map.TikiOutpost.IslandModel:FindFirstChild("Eye1"),
                        workspace.Map.TikiOutpost.IslandModel:FindFirstChild("Eye2"),
                        workspace.Map.TikiOutpost.IslandModel:FindFirstChild("Eye3"),
                        workspace.Map.TikiOutpost.IslandModel:FindFirstChild("Eye4")
                    }
                    for _, v552 in ipairs(v550) do
            if v552 then
                local lit = false
                if v552:IsA("BasePart") and v552.Transparency < 1 then lit = true end
                if not lit then
                    for _, child in pairs(v552:GetDescendants()) do
                        if child:IsA("BasePart") and child.Transparency < 1 then lit = true; break end
                        if child:IsA("Light") and child.Enabled then lit = true; break end
                        if child:IsA("ParticleEmitter") and child.Enabled then lit = true; break end
                    end
                end
                if lit then v549 = v549 + 1 end
            end
        end
                    v548:Set("Status: " .. v549 .. " Eye(s)" .. (not (v549 ~= 4) and "       " or ""))
                end)
            end
        end)
        v487:AddToggle({
            Name = "Auto Farm Tyrant",
            Description = "",
            Default = false,
            Callback = function(v553)
                _G.FarmDaiBan = v553
                StopTween(_G.FarmDaiBan)
            end
        })
        local v554 = CFrame.new(-16194.0048828125, 155.21844482421875, 1420.719970703125)
        task.spawn(function()
            while task.wait() do
                if _G.FarmDaiBan then
                    pcall(function()
                        local player = game.Players.LocalPlayer
                        local character = player.Character
                        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                        local playerPos = character.HumanoidRootPart.Position

                        if not game:GetService("Workspace").Enemies:FindFirstChild("Tyrant of the Skies") then
                            local v556 = false
                            for _, v558 in pairs({"Isle Outlaw", "Island Boy", "Isle Champion", "Serpent Hunter", "Skull Slayer"}) do
                                if game:GetService("Workspace").Enemies:FindFirstChild(v558) then
                                    v556 = true
                                    break
                                end
                            end
                            if not v556 then
                                if (playerPos - v554.Position).Magnitude > 50 then
                                    if not BypassTP then
                                        topos(v554)
                                    elseif (playerPos - v554.Position).Magnitude > 1500 then
                                        BTP(v554)
                                    else
                                        topos(v554)
                                    end
                                    UnEquipWeapon(_G.Selectweapon)
                                end
                            else
                                for _, v611_mob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if (v611_mob.Name == "Isle Outlaw" or v611_mob.Name == "Island Boy" or v611_mob.Name == "Isle Champion" or v611_mob.Name == "Serpent Hunter" or v611_mob.Name == "Skull Slayer") and v611_mob:FindFirstChild("Humanoid") and v611_mob:FindFirstChild("HumanoidRootPart") and v611_mob.Humanoid.Health > 0 then
                                        repeat
                                            task.wait()
                                            AutoHaki()
                                            EquipWeapon(getToolToEquip(v611_mob))
                                            v611_mob.HumanoidRootPart.CanCollide = false
                                            v611_mob.Humanoid.WalkSpeed = 0
                                            StartBring = true
                                            v611_mob.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                            PosMon = v611_mob.HumanoidRootPart.CFrame
                                            MonFarm = v611_mob.Name
                                            v611_mob.Head.CanCollide = false

                                            local targetPos = v611_mob.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0)
                                            if (character.HumanoidRootPart.Position - targetPos.Position).Magnitude > 5 then
                                                topos(targetPos)
                                            end

                                            NeedAttacking = true
                                            if v611_mob.Name ~= "Isle Outlaw" then
                                                if v611_mob.Name == "Island Boy" then
                                                    Bring(v611_mob.Name, CFrame.new(-16901.26171875, 84.06756591796875, -192.88906860351562))
                                                elseif v611_mob.Name ~= "Isle Champion" then
                                                    if v611_mob.Name ~= "Serpent Hunter" then
                                                        if v611_mob.Name == "Skull Slayer" then
                                                            Bring(v611_mob.Name, CFrame.new(-16855.043, 122.457253, 1478.15308, -0.999392271, 0, -0.0348687991, 0, 1, 0, 0.0348687991, 0, -0.999392271))
                                                        end
                                                    else
                                                        Bring(v611_mob.Name, CFrame.new(-16521.0625, 106.09285, 1488.78467, 0.469467044, 0, 0.882950008, 0, 1, 0, -0.882950008, 0, 0.469467044))
                                                    end
                                                else
                                                    Bring(v611_mob.Name, CFrame.new(-16641.6796875, 235.7825469970703, 1031.282958984375))
                                                end
                                            else
                                                Bring(v611_mob.Name, CFrame.new(-16442.814453125, 116.13899993896484, -264.4637756347656))
                                            end
                                        until not _G.FarmDaiBan or not v611_mob.Parent or v611_mob.Humanoid.Health <= 0 or game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 or game:GetService("ReplicatedStorage"):FindFirstChild("Tyrant of the Skies [Lv. 2600] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Tyrant of the Skies [Lv. 2600] [Raid Boss]")
                                        DamageAura = false
                                    end
                                end
                            end
                        else
                            for _, v563 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v563.Name == "Tyrant of the Skies" and v563:FindFirstChild("Humanoid") and v563:FindFirstChild("HumanoidRootPart") and v563.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        AutoHaki()
                                        EquipWeapon(_G.SelectWeapon)
                                        v563.HumanoidRootPart.CanCollide = false
                                        v563.Humanoid.WalkSpeed = 0
                                        v563.HumanoidRootPart.Size = Vector3.new(50, 50, 50)

                                        local targetPos = v563.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0)
                                        if (character.HumanoidRootPart.Position - targetPos.Position).Magnitude > 5 then
                                            topos(targetPos)
                                        end

                                        NeedAttacking = true
                                    until not _G.FarmDaiBan or not v563.Parent or v563.Humanoid.Health <= 0
                                    wait(1)
                                end
                            end
                        end
                    end)
                end
            end
        end)
        v487:AddToggle({
            Name = "Summon Tyrant Of The Skies",
            Description = "",
            Default = false,
            Callback = function(v564)
                _G.Farm8Binhs = v564
                StopTween(_G.Farm8Binhs)
            end
        })
        local v565 = {
            CFrame.new(-16250.2354, 158.167007, 1313.01904, 0.999388874, 0, 0.0349550731, 0, 1, 0, -0.0349550731, 0, 0.999388874),
            CFrame.new(-16250.2354, 158.167007, 1313.01904, 0.999388874, 0, 0.0349550731, 0, 1, 0, -0.0349550731, 0, 0.999388874),
            CFrame.new(-16297.0596, 159.322998, 1317.224, -0.463313937, 0, 0.886194229, 0, 1, 0, -0.886194229, 0, -0.463313937),
            CFrame.new(-16335.0967, 159.334, 1324.88599, 0.999388874, 0, 0.0349550731, 0, 1, 0, -0.0349550731, 0, 0.999388874),
            CFrame.new(-16288.6094, 158.167007, 1470.36804, 0.999388874, 0, 0.0349550731, 0, 1, 0, -0.0349550731, 0, 0.999388874),
            CFrame.new(-16258.001, 156.761002, 1461.40405, 0.999388874, 0, 0.0349550731, 0, 1, 0, -0.0349550731, 0, 0.999388874),
            CFrame.new(-16245.4121, 158.436996, 1463.36597, -0.993159413, 0, 0.116766132, 0, 1, 0, -0.116766132, 0, -0.993159413),
            CFrame.new(-16212.4688, 158.167007, 1466.34399, 0.999388874, 0, 0.0349550731, 0, 1, 0, -0.0349550731, 0, 0.999388874)
        }
        function TweenToPosition(v566)
            local l_Character_5 = game.Players.LocalPlayer.Character
            local v568 = l_Character_5 and l_Character_5:FindFirstChild("HumanoidRootPart")
            if not v568 then
                return 
            else
                local l_TweenService_0 = game:GetService("TweenService")
                local v570 = (v568.Position - v566.Position).Magnitude / 300
                local v571 = l_TweenService_0:Create(v568, TweenInfo.new(v570, Enum.EasingStyle.Linear), {CFrame = v566})
                v571:Play()
                v571.Completed:Wait()
                return 
            end
        end
        task.spawn(function()
            while task.wait(1) do
                if _G.Farm8Binhs then
                    local activeCount = 0
                    local eyes = {
                        workspace.Map.TikiOutpost.IslandModel:FindFirstChild("Eye1"),
                        workspace.Map.TikiOutpost.IslandModel:FindFirstChild("Eye2"),
                        workspace.Map.TikiOutpost.IslandModel:FindFirstChild("Eye3"),
                        workspace.Map.TikiOutpost.IslandModel:FindFirstChild("Eye4")
                    }
                    for _, eye in ipairs(eyes) do
                        if eye then
                            local lit = false
                            if eye:IsA("BasePart") and eye.Transparency < 1 then lit = true end
                            if not lit then
                                for _, child in pairs(eye:GetDescendants()) do
                                    if child:IsA("BasePart") and child.Transparency < 1 then lit = true; break end
                                    if child:IsA("Light") and child.Enabled then lit = true; break end
                                    if child:IsA("ParticleEmitter") and child.Enabled then lit = true; break end
                                end
                            end
                            if lit then activeCount = activeCount + 1 end
                        end
                    end
                    if activeCount == 4 then
                        for _, v587 in ipairs(v565) do
                            if _G.Farm8Binhs then
                                TweenToPosition(v587 * CFrame.new(0, _G.FarmHeight or 10, 0))
                                task.wait(0.5)
                                AttackAllSkills()
                                task.wait(3)
                            else
                                break
                            end
                        end
                    end
                end
            end
        end)

        local _ = v487:AddSection({" Katakuri "})
        local v606 = v487:AddParagraph({Title = "Check Cake Prince", Content = "Loading..."})
        local sentKatakuriNotif = false
        task.spawn(function()
            while task.wait(1) do
                pcall(function()
                    local v607 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
                    if string.find(v607, "open the portal") or string.find(v607, "portal now") then
                        v606:Set("Killed : 500 / 500 (Ready!)")
                        if not sentKatakuriNotif then
                            sentKatakuriNotif = true
                            _G.Fullykatakuri = false
                            _G.FarmCake = false
                            task.spawn(function()
                                for i = 1, 5 do
                                    topos(CFrame.new(-1820.0634765625, 210.74781799316406, -12297.49609375))
                                    task.wait(0.5)
                                end
                            end)
                            game.StarterGui:SetCore("SendNotification", {
                                Title = "Redz Hub",
                                Text = "Killed 500/500 Npcs!",
                                Duration = 10
                            })
                        end
                    else
                        sentKatakuriNotif = false
                        if string.len(v607) == 88 then
                            v606:Set("Killed : " .. string.sub(v607, 39, 41) .. " / 500")
                        elseif string.len(v607) ~= 87 then
                            if string.len(v607) == 86 then
                                v606:Set("Killed : " .. string.sub(v607, 39, 39) .. " / 500")
                            else
                                v606:Set("Prince King Spawned    ")
                            end
                        else
                            v606:Set("Killed : " .. string.sub(v607, 39, 40) .. " / 500")
                        end
                    end
                end)
            end
        end)
        v487:AddToggle({
            Name = "Farm Katakuri",
            Description = "",
            Default = false,
            Callback = function(v608)
                _G.FarmCake = v608
                StopTween(_G.FarmCake)
            end
        })
        local v609 = CFrame.new(-2130.80712890625, 69.95634460449219, -12327.83984375)
        task.spawn(function()
            while task.wait() do
                if _G.FarmCake then
                    pcall(function()
                        if not game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
                            local v611 = false
                            for _, v613 in pairs({"Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker"}) do
                                if game:GetService("Workspace").Enemies:FindFirstChild(v613) then
                                    v611 = true
                                    break
                                end
                            end
                            if v611 then
                                for _, v615 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if (v615.Name == "Cookie Crafter" or v615.Name == "Cake Guard" or v615.Name == "Baking Staff" or v615.Name == "Head Baker") and v615:FindFirstChild("Humanoid") and v615:FindFirstChild("HumanoidRootPart") and v615.Humanoid.Health > 0 then
                                        repeat
                                            task.wait()
                                            AutoHaki()
                                            EquipWeapon(_G.SelectWeapon)
                                            v615.HumanoidRootPart.CanCollide = false
                                            v615.Humanoid.WalkSpeed = 0
                                            StartBring = true
                                            v615.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                            PosMon = v615.HumanoidRootPart.CFrame
                                            MonFarm = v615.Name
                                            v615.Head.CanCollide = false
                                            topos(v615.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                            NeedAttacking = true
                                            if v615.Name ~= "Cookie Crafter" then
                                                if v615.Name == "Cake Guard" then
                                                    Bring(v615.Name, CFrame.new(-1693.98047, 35.2188225, -12436.8438, -0.716115236, 0, -0.697982132, 0, 1, 0, 0.697982132, 0, -0.716115236))
                                                elseif v615.Name == "Baking Staff" then
                                                    Bring(v615.Name, CFrame.new(-1980.4375, 34.6653099, -12983.8408, -0.254338264, 0, -0.967115223, 0, 1, 0, 0.967115223, 0, -0.254338264))
                                                elseif v615.Name == "Head Baker" then
                                                    Bring(v615.Name, CFrame.new(-2151.37793, 51.0095749, -13033.3975, -0.996587753, 0, 0.0825396702, 0, 1, 0, -0.0825396702, 0, -0.996587753))
                                                end
                                            else
                                                Bring(v615.Name, CFrame.new(-2212.88965, 37.0051041, -11969.2568, 0.458114207, 0, -0.888893366, 0, 1, 0, 0.888893366, 0, 0.458114207))
                                            end
                                        until not _G.FarmCake or not v615.Parent or v615.Humanoid.Health <= 0 or game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 or game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]")
                                        DamageAura = false
                                    end
                                end
                            else
                                local v616 = math.random(1, 3)
                                if v616 ~= 1 then
                                    if v616 ~= 2 then
                                        if v616 == 3 then
                                            topos(CFrame.new(-2231.2793, 168.256653, -12845.7559))
                                        end
                                    else
                                        topos(CFrame.new(-2383.78979, 150.450592, -12126.4961))
                                    end
                                else
                                    topos(CFrame.new(-1436.86011, 167.753616, -12296.9512))
                                end
                            end
                            if BypassTP then
                                if (playerPos - v609.Position).Magnitude <= 1500 then
                                    topos(v609)
                                else
                                    BTP(v609)
                                end
                            else
                                topos(v609)
                            end
                            UnEquipWeapon(_G.Selectweapon)
                            topos(CFrame.new(-2130.80712890625, 69.95634460449219, -12327.83984375))
                        else
                            for _, v618 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v618.Name == "Cake Prince" and v618:FindFirstChild("Humanoid") and v618:FindFirstChild("HumanoidRootPart") and v618.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        AutoHaki()
                                        EquipWeapon(_G.SelectWeapon)
                                        v618.HumanoidRootPart.CanCollide = false
                                        v618.Humanoid.WalkSpeed = 0
                                        v618.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                        if game:GetService("Workspace")._WorldOrigin:FindFirstChild("Ring") or game:GetService("Workspace")._WorldOrigin:FindFirstChild("Fist") or game:GetService("Workspace")._WorldOrigin:FindFirstChild("MochiSwirl") then
                                            topos(v618.HumanoidRootPart.CFrame * CFrame.new(0, -40, 0))
                                        else
                                            topos(v618.HumanoidRootPart.CFrame * CFrame.new(4, 10, 10))
                                        end
                                        NeedAttacking = true
                                    until not _G.FarmCake or not v618.Parent or v618.Humanoid.Health <= 0
                                    wait(1)
                                end
                        end
                    end
                end)
            end
        end
    end)
    v487:AddToggle({
        Name = "Farm Katakuri V2",
        Description = "",
        Default = false,
        Callback = function(v619)
            _G.Fullykatakuri = v619
            StopTween(_G.Fullykatakuri)
        end
    })
    task.spawn(function()
        while wait() do
            if _G.Fullykatakuri then
                pcall(function()
                    if not game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") and not game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice") then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild("Sweet Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("Sweet Chalice") then
                            if game.Workspace.Enemies:FindFirstChild("Baking Staff") or game.Workspace.Enemies:FindFirstChild("Head Baker") or game.Workspace.Enemies:FindFirstChild("Cake Guard") or game.Workspace.Enemies:FindFirstChild("Cookie Crafter") then
                                for _, v621 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if (v621.Name == "Baking Staff" or v621.Name == "Head Baker" or v621.Name == "Cake Guard" or v621.Name == "Cookie Crafter") and v621.Humanoid.Health > 0 then
                                        repeat
                                            wait()
                                            AutoHaki()
                                            EquipWeapon(_G.SelectWeapon)
                                            AutoHaki()
                                            PosMon = v621.HumanoidRootPart.CFrame
                                            topos(v621.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                            v621.HumanoidRootPart.CanCollide = false
                                            v621.Humanoid.WalkSpeed = 0
                                            v621.Head.CanCollide = false
                                            attackGunEnemies(v621.Name, 5)
                                            v621.HumanoidRootPart.Size = Vector3.new(70, 70, 70)
                                            StartBring = false
                                            MonFarm = v621.Name
                                            game:GetService("VirtualUser"):CaptureController()
                                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
                                        until _G.Fullykatakuri == false or game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince") or not v621.Parent or v621.Humanoid.Health <= 0
                                    end
                                end
                            else
                                CakeBring = false
                                StartBring = false
                                topos(CFrame.new(-1820.0634765625, 210.74781799316406, -12297.49609375))
                            end
                        elseif game.ReplicatedStorage:FindFirstChild("Dough King") or game:GetService("Workspace").Enemies:FindFirstChild("Dough King") then
                            if not game:GetService("Workspace").Enemies:FindFirstChild("Dough King") then
                                topos(CFrame.new(-2009.2802734375, 4532.97216796875, -14937.3076171875))
                            else
                                for _, v623 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v623.Name == "Dough King" then
                                        repeat
                                            wait()
                                            AutoHaki()
                                            EquipWeapon(_G.SelectWeapon)
                                            v623.HumanoidRootPart.Size = Vector3.new(70, 70, 70)
                                            v623.HumanoidRootPart.CanCollide = false
                                            StartBring = false
                                            topos(v623.HumanoidRootPart.CFrame * CFrame.new(0, -40, 0))
                                            game:GetService("VirtualUser"):CaptureController()
                                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
                                        until _G.Fullykatakuri == false or not v623.Parent or v623.Humanoid.Health <= 0
                                    end
                                end
                            end
                        elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Red Key") or game.Players.LocalPlayer.Character:FindFirstChild("Red Key") then
                            local v624 = {[1] = "CakeScientist", [2] = "Check"}
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v624))
                        elseif GetQuestActive() ~= true then
                            wait(0.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
                        elseif string.find(GetQuestText(), "Diablo") or string.find(GetQuestText(), "Deandre") or string.find(GetQuestText(), "Urban") then
                            if not game:GetService("Workspace").Enemies:FindFirstChild("Diablo") and not game:GetService("Workspace").Enemies:FindFirstChild("Deandre") and not game:GetService("Workspace").Enemies:FindFirstChild("Urban") then
                                if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") then
                                    topos(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                                elseif not game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") then
                                    if game:GetService("ReplicatedStorage"):FindFirstChild("Urban") then
                                        topos(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                                    end
                                else
                                    topos(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                                end
                            else
                                for _, v626 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if (v626.Name == "Diablo" or v626.Name == "Deandre" or v626.Name == "Urban") and v626:FindFirstChild("Humanoid") and v626:FindFirstChild("HumanoidRootPart") and v626.Humanoid.Health > 0 then
                                        repeat
                                            wait()
                                            AutoHaki()
                                            EquipWeapon(_G.SelectWeapon)
                                            PosMon = v626.HumanoidRootPart.CFrame
                                            topos(v626.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                            v626.HumanoidRootPart.CanCollide = false
                                            v626.Humanoid.WalkSpeed = 0
                                            v626.Head.CanCollide = false
                                            attackGunEnemies(v626.Name, 5)
                                            v626.HumanoidRootPart.Size = Vector3.new(70, 70, 70)
                                            StartBring = false
                                            MonFarm = v626.Name
                                            game:GetService("VirtualUser"):CaptureController()
                                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
                                            sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                        until _G.Fullykatakuri == false or v626.Humanoid.Health <= 0 or not v626.Parent or game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice")
                                    end
                                end
                            end
                        end
                    elseif string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SweetChaliceNpc"), "Where") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SweetChaliceNpc")
                    end
                end)
            end
        end
    end)

        local _ = v487:AddSection({" Quest Sword "})
        v487:AddToggle({
            Name = "Auto Get Sword Twin Hooks",
            Description = "",
            Default = false,
            Callback = function(v813)
                _G.SwodTwinHooks = v813
                StopTween(_G.SwodTwinHooks)
            end
        })
        spawn(function()
            while wait() do
                if _G.SwodTwinHooks then
                    pcall(function()
                        if not game:GetService("Workspace").Enemies:FindFirstChild("Captain Elephant") then
                            if game:GetService("ReplicatedStorage"):FindFirstChild("Captain Elephant") then
                                TP1(game:GetService("ReplicatedStorage"):FindFirstChild("Captain Elephant").HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
                            end
                        else
                            for _, v815 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v815.Name == "Captain Elephant" and v815:FindFirstChild("Humanoid") and v815:FindFirstChild("HumanoidRootPart") and v815.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        AutoHaki()
                                        EquipWeapon(_G.SelectWeapon)
                                        v815.HumanoidRootPart.CanCollide = false
                                        StartBring = true
                                        v815.Humanoid.WalkSpeed = 0
                                        v815.HumanoidRootPart.Size = Vector3.new(80, 80, 80)
                                        topos(v815.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                    until not _G.SwodTwinHooks or not v815.Parent or v815.Humanoid.Health <= 0
                                end
                            end
                        end
                    end)
                end
            end
        end)
        v487:AddToggle({
            Name = "Auto Get Sword Canvander",
            Description = "",
            Default = false,
            Callback = function(v816)
                _G.SwodCanvander = v816
                StopTween(_G.SwodCanvander)
            end
        })
        spawn(function()
            while wait() do
                if _G.SwodCanvander then
                    pcall(function()
                        if game:GetService("Workspace").Enemies:FindFirstChild("Beautiful Pirate") then
                            for _, v818 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v818.Name == "Beautiful Pirate" and v818:FindFirstChild("Humanoid") and v818:FindFirstChild("HumanoidRootPart") and v818.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        AutoHaki()
                                        EquipWeapon(_G.SelectWeapon)
                                        v818.HumanoidRootPart.CanCollide = false
                                        StartBring = true
                                        v818.Humanoid.WalkSpeed = 0
                                        v818.HumanoidRootPart.Size = Vector3.new(80, 80, 80)
                                        topos(v818.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                    until not _G.SwodCanvander or not v818.Parent or v818.Humanoid.Health <= 0
                                end
                            end
                        elseif game:GetService("ReplicatedStorage"):FindFirstChild("Beautiful Pirate") then
                            TP1(game:GetService("ReplicatedStorage"):FindFirstChild("Beautiful Pirate").HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
                        end
                    end)
                end
            end
        end)
        v487:AddToggle({
            Name = "Auto Get Sword Buddy",
            Description = "",
            Default = false,
            Callback = function(v819)
                _G.SwodsBuddy = v819
                StopTween(_G.SwodsBuddy)
            end
        })
        spawn(function()
            while wait() do
                if _G.SwodsBuddy then
                    pcall(function()
                        if not game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen") then
                            if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen") then
                                TP1(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen").HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
                            end
                        else
                            for _, v821 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v821.Name == "Cake Queen" and v821:FindFirstChild("Humanoid") and v821:FindFirstChild("HumanoidRootPart") and v821.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        AutoHaki()
                                        EquipWeapon(_G.SelectWeapon)
                                        v821.HumanoidRootPart.CanCollide = false
                                        StartBring = true
                                        v821.Humanoid.WalkSpeed = 0
                                        v821.HumanoidRootPart.Size = Vector3.new(80, 80, 80)
                                        topos(v821.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                    until not _G.SwodsBuddy or not v821.Parent or v821.Humanoid.Health <= 0
                                end
                            end
                        end
                    end)
                end
            end
        end)
    end
end

-- ========== KURRI COMPAT SHIM + MODULE (lien ket Misc + Sea) ==========
-- Cac bien Kurri dung nhung Hu999 khong co - dinh nghia o day de khong loi nil
if not _G.SaveData then _G.SaveData = {} end
if not GetSetting then
    GetSetting = function(k, d) if _G.SaveData[k] == nil then return d end return _G.SaveData[k] end
end
if not SaveSettings then
    SaveSettings = function()
        pcall(function()
            if writefile then
                if makefolder and not isfolder("Redz Hub - OK Hub") then makefolder("Redz Hub - OK Hub") end
                writefile("Redz Hub - OK Hub/Configs.json", game:GetService("HttpService"):JSONEncode(_G.SaveData))
            end
        end)
    end
end
if not FolderName then FolderName = "Redz Hub - OK Hub" end
if not Player then Player = game.Players.LocalPlayer end
if not LocalPlayer3 then LocalPlayer3 = game.Players.LocalPlayer end
if not ReplicatedStorage6 then ReplicatedStorage6 = game:GetService("ReplicatedStorage") end
if not RunService6 then RunService6 = game:GetService("RunService") end
if not KurriRS then KurriRS = game:GetService("ReplicatedStorage") end
if not Sec then Sec = 0.1 end
if not rejoinConnection then rejoinConnection = nil end
if not AutoRejoinKick then AutoRejoinKick = true end
-- KurriTween: tween nhan vat toi CFrame (Kurri dung tween(CFrame), Hu999 khong co ham nay)
if not KurriTween then
    KurriTween = function(target)
        if getgenv().TweenPaused then return end
        if typeof(target) ~= "CFrame" then return end
        local c = game.Players.LocalPlayer.Character
        if not c then return end
        local hrp = c:FindFirstChild("HumanoidRootPart")
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end
        pcall(function()
            local dist = (hrp.Position - target.Position).Magnitude
            local speed = _G.TweenSpeed or getgenv().TweenSpeed or 300
            local dur = math.max(0.1, dist / math.max(1, speed))
            local tw = game:GetService("TweenService"):Create(hrp, TweenInfo.new(dur, Enum.EasingStyle.Linear), {CFrame = target})
            tw:Play()
            -- Cho toi khi toi noi hoac bi tat
            local t0 = tick()
            while tick() - t0 < dur + 2 do
                task.wait(0.1)
                if getgenv().TweenPaused then tw:Cancel() break end
                if (hrp.Position - target.Position).Magnitude < 15 then break end
            end
        end)
    end
end
-- SeaModule + MiscModule: de chuc nang chay that, lien ket voi _G
local SeaModule = {}
_G.SeaModule = SeaModule; getgenv().SeaModule = SeaModule
SeaModule.IsSeaEvent = function()
    local ok, r = pcall(function() return IsDoingSeaEvent and IsDoingSeaEvent() or false end)
    return ok and r or false
end
local MiscModule = {}
_G.MiscModule = MiscModule; getgenv().MiscModule = MiscModule
MiscModule.Hop = function()
    pcall(function()
        local HS = game:GetService("HttpService"); local TS = game:GetService("TeleportService")
        local servers = HS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for _, s in pairs(servers.data) do if s.playing < s.maxPlayers and s.id ~= game.JobId then TS:TeleportToPlaceInstance(game.PlaceId, s.id) break end end
    end)
end
MiscModule.Rejoin = function() pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer) end) end
-- Loop lien ket: Misc + Sea doc _G/getgenv, ap dung NoClip / Speed / WalkWater / AntiBan
if not _G._KurriLinkLoop then
    _G._KurriLinkLoop = true
    task.spawn(function()
        while task.wait(0.25) do
            pcall(function()
                if getgenv().NoClip or _G.NoClip then
                    local c = game.Players.LocalPlayer.Character
                    if c then for _, v in pairs(c:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
                end
                if _G.AntiBand then
                    for _, pl in pairs(game:GetService("Players"):GetPlayers()) do
                        if table.find({17884881,120173604,912348}, pl.UserId) then MiscModule.Hop() break end
                    end
                end
            end)
        end
    end)
end
-- ========== HET SHIM - BAT DAU CODE KURRI ==========

-- ===== SEA EVENT CUA KURRI (thay toan bo Sea Hu999) =====
local function _SeaKurri()
	v489:AddSection({"Sea"})
	v489:AddToggle({
		Name = "Auto Farm Sea",
		Default = false,
		Callback = function(p261)
			_G.AutoSeaEvent = p261

			if not p261 then
				_G.Shark = false
				_G.Piranha = false
				_G.TerrorShark = false
				_G.MobCrew = false
				_G.HCM = false
				_G.PGB = false
				_G.FishBoat = false
				_G.seabeatfarm = false
			end
		end
	})
	v489:AddToggle({
		Name = "Auto Drive Boat",
		Default = false,
		Callback = function(p262)
			_G.SailBoats = p262
		end
	})
	v489:AddSection({"Farm Select"})
	v489:AddDropdown({
		Name = "Fishs",
		Default = {},
		Options = {
			"Shark",
			"Piranha",
			"Terror Shark",
			"Fish Crew",
			"Haunted Crew",
			"Pirate Brigade",
			"Fish Boat",
			"Sea Beast"
		},
		MultiSelect = true,
		Callback = function(p263)
			if not _G.AutoSeaEvent then
				return
			end

			_G.Shark = p263.Shark
			_G.Piranha = p263.Piranha
			_G.TerrorShark = p263["Terror Shark"]
			_G.MobCrew = p263["Fish Crew"]
			_G.HCM = p263["Haunted Crew"]
			_G.PGB = p263["Pirate Brigade"]
			_G.FishBoat = p263["Fish Boat"]
			_G.seabeatfarm = p263["Sea Beast"]
		end
	})

	local t29 = {
		"Guardian",
		"PirateGrandBrigade",
		"MarineGrandBrigade",
		"PirateBrigade",
		"MarineBrigade",
		"PirateSloop",
		"MarineSloop",
		"Beast Hunter"
	}

	v489:AddDropdown({
		Name = "Select Boats",
		Default = t29[1] or "Guardian",
		Options = t29,
		Callback = function(p264)
			_G.SelectedBoat = p264
		end
	})
	v489:AddDropdown({
		Name = "Select Weapon Skill",
		Default = {
			Melee = true,
			Sword = true,
			Gun = true,
			Fruit = false
		},
		Options = {
			"Melee",
			"Sword",
			"Gun",
			"Fruit"
		},
		MultiSelect = true,
		Callback = function(p265)
			_G.UseMelee = p265.Melee
			_G.UseSword = p265.Sword
			_G.UseGun = p265.Gun
			_G.UseFruit = p265.Fruit
		end
	})
	v489:AddSlider({
		Name = "Skill Hold Time",
		Default = 0.1,
		Min = 0,
		Max = 2,
		Increase = 0.1,
		Callback = function(p266)
			HNCU = p266
		end
	})
	v489:AddSlider({
		Name = "Switch Tool Delay",
		Default = 3,
		Min = 1,
		Max = 10,
		Increase = 1,
		Callback = function(p267)
			NoSkid = p267
		end
	})

	local RunService5 = game:GetService("RunService")
	local u983
	local connection2

	v489:AddToggle({
		Name = "Lock Boat Y +100",
		Default = false,
		Callback = function(p268)
			_G.LockBoatY = p268

			if connection2 then
				connection2:Disconnect()
				connection2 = nil
			end

			if p268 then
				connection2 = RunService5.Heartbeat:Connect(function()
					local v985 = CheckBoat()

					if v985 then
						local VehicleSeat = v985:FindFirstChildWhichIsA("VehicleSeat")

						if VehicleSeat then
							if not v985.PrimaryPart then
								v985.PrimaryPart = VehicleSeat
							end

							if not u983 then
								u983 = VehicleSeat.Position.Y + 100
							end

							local PrimaryPart = v985.PrimaryPart
							local Position = PrimaryPart.Position
							local CFrame_ = PrimaryPart.CFrame

							PrimaryPart.CFrame = CFrame.new(Position.X, u983, Position.Z) * (CFrame_ - CFrame_.Position)
							PrimaryPart.AssemblyLinearVelocity = Vector3.new(PrimaryPart.AssemblyLinearVelocity.X, 0, PrimaryPart.AssemblyLinearVelocity.Z)
						end
					else
						u983 = nil
					end
				end)
			else
				u983 = nil
			end
		end
	})
	v489:AddToggle({
		Name = "Highlight My Boat",
		Default = false,
		Callback = function(p269)
			_G.EspMyBoat = p269
		end
	})

	local RunService6 = game:GetService("RunService")
	local t30 = {}

	createESP = function(p270)
		if t30[p270] then
			return
		end

		local Highlight = Instance.new("Highlight")

		Highlight.FillColor = Color3.fromRGB(255, 0, 0)
		Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
		Highlight.FillTransparency = 0.5
		Highlight.OutlineTransparency = 0
		Highlight.Adornee = p270
		Highlight.Parent = p270

		local BillboardGui = Instance.new("BillboardGui")

		BillboardGui.Size = UDim2.new(0, 200, 0, 50)
		BillboardGui.StudsOffset = Vector3.new(0, 5, 0)
		BillboardGui.AlwaysOnTop = true
		BillboardGui.Parent = p270

		local TextLabel = Instance.new("TextLabel")

		TextLabel.Size = UDim2.new(1, 0, 1, 0)
		TextLabel.BackgroundTransparency = 1
		TextLabel.Text = "My Boat"
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextScaled = true
		TextLabel.Font = Enum.Font.GothamBold
		TextLabel.TextStrokeTransparency = 0
		TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.Parent = BillboardGui
		t30[p270] = {
			Highlight,
			BillboardGui
		}
	end
	removeESP = function(p271)
		if t30[p271] then
			for _, v in pairs(t30[p271]) do
				v:Destroy()
			end

			t30[p271] = nil
		end
	end
	removeAllESP = function()
		for k in pairs(t30) do
			removeESP(k)
		end
	end
	checkBoat = function()
		if not _G.EspMyBoat then
			removeAllESP()

			return
		end

		local Character2 = LocalPlayer3.Character
		local HumanoidRootPart2 = Character2 and Character2:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart2 then
			return
		end

		local t31 = {}

		for _, child in pairs(workspace.Boats:GetChildren()) do
			local Owner = child:FindFirstChild("Owner")
			local VehicleSeat = child:FindFirstChildWhichIsA("VehicleSeat")

			if Owner and tostring(Owner.Value) == tostring(LocalPlayer3.Name) and VehicleSeat and (VehicleSeat.Position - HumanoidRootPart2.Position).Magnitude <= 1000 then
				t31[child] = true
				createESP(child)
			end
		end

		for k in pairs(t30) do
			if not t31[k] then
				removeESP(k)
			end
		end
	end
	v489:AddSection({"Settings [ Wait ]"})
	v489:AddSection({"Configs"})

	local t32 = {
		"Lv 1",
		"Lv 2",
		"Lv 3",
		"Lv 4",
		"Lv 5",
		"Lv 6",
		"Lv Infinite"
	}

	v489:AddDropdown({
		Name = "Select Sea Level",
		Default = t32[1] or "Lv 1",
		Options = t32,
		Callback = function(p272)
			_G.DangerSc = p272
		end
	})
	v489:AddSlider({
		Name = "Boat Tween Speed",
		Min = 100,
		Max = 350,
		Default = GetSetting("TweenSpeed2", 200),
		Increase = 1,
		Callback = function(p273)
			_G.TweenSpeed2 = p273
			_G.SaveData.TweenSpeed2 = p273
			SaveSettings()
		end
	})
	v489:AddSection({"NPCs"})
	v489:AddDropdown({
		Name = "Select NPC",
		Options = {
			"Spy",
			"Beast Hunter",
			"Shark Hunter",
			"Shipwright Teacher"
		},
		Default = "Spy",
		Callback = function(p274)
			_G.NpcMode = p274
		end
	})
	v489:AddToggle({
		Name = "Teleport To NPC",
		Default = false,
		Callback = function(p275)
			_G.TeleportNpcSea = p275
			StopTween(_G.TeleportNpcSea)
		end
	})
	spawn(function()
		while wait() do
			if _G.TeleportNpcSea and World3 then
				local NpcMode = _G.NpcMode

				if NpcMode == "Spy" then
					KurriTween(CFrame.new(-16470.1289, 528.018005, 539.729736, 0.923504472, 0.14256525, -0.356110483, -0.12577644, 0.989586353, 0.0699937791, 0.362380743, -0.0198492594, 0.931818783))
				elseif NpcMode == "Beast Hunter" then
					KurriTween(CFrame.new(-16282.7754, 72.8005219, 262.864899, 0.999961197, 1.3790713e-09, -0.00881191809, -9.40171052e-10, 1, 4.98117245e-08, 0.00881191809, -4.98015034e-08, 0.999961197))
				elseif NpcMode == "Shark Hunter" then
					KurriTween(CFrame.new(-16526.1348, 108.07634, 750.895447, -0.997955203, 9.56297868e-08, -0.0639176369, 9.5004161e-08, 1, 1.28273223e-08, 0.0639176369, 6.72865097e-09, -0.997955203))
				elseif NpcMode == "Shipwright Teacher" then
					KurriTween(CFrame.new(-16526, 78.5615463, 304.426758, -0.997302055, -0.0361390784, -0.0638951063, -0.0359273851, 0.999344468, -0.00445934385, 0.0640143752, -0.00215172861, -0.99794668))
				end
			end
		end
	end)
	v489:AddSection({"Draco Race"})
	GetQuestDracoLevel = function()
		return KurriRS.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({ {
			NPC = "Dragon Wizard",
			Command = "Upgrade"
		} }))
	end
	v489:AddToggle({
		Name = "Tween To Upgrade Draco Trial",
		Default = false,
		Callback = function(p276)
			_G.UPGDrago = p276
		end
	})
	spawn(function()
		while wait(1) do
			pcall(function()
				if _G.UPGDrago then
					if GetQuestDracoLevel() == false then
						return nil
					end

					if GetQuestDracoLevel() == true then
						if (CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375).Position - HumanoidRootPart.Position).Magnitude >= 300 then
							KurriTween(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))
						else
							KurriTween(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))
							KurriRS.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({ {
								NPC = "Dragon Wizard",
								Command = "Upgrade"
							} }))
						end
					end
				end
			end)
		end
	end)
	v489:AddToggle({
		Name = "Auto Draco V1",
		Default = false,
		Callback = function(p277)
			_G.dracov1 = p277
		end
	})
	spawn(function()
		while wait(1) do
			pcall(function()
				if _G.dracov1 and LayMaterial("Dragon Egg") <= 0 then
					while true do
						wait()
						_G.Prehis_Find = true
						_G.Prehis_Skills = true
						_G.Prehis_DE = true

						if not _G.dracov1 then
							break
						elseif LayMaterial("Dragon Egg") >= 1 then
							break
						end
					end

					_G.Prehis_Find = false
					_G.Prehis_Skills = false
					_G.Prehis_DE = false
				end
			end)
		end
	end)
	v489:AddToggle({
		Name = "Auto Draco V2",
		Default = false,
		Callback = function(p278)
			_G.AutoFireFlowers = p278
		end
	})
	spawn(function()
		while wait(1) do
			if _G.AutoFireFlowers then
				local FireFlowers = workspace:FindFirstChild("FireFlowers")
				local v1009 = MobCheck("Forest Pirate")

				if v1009 then
					while true do
						wait()
						Kill(v1009, _G.AutoFireFlowers)

						if not _G.AutoFireFlowers then
							break
						elseif not v1009.Parent or v1009.Humanoid.Health <= 0 or FireFlowers then
							break
						end
					end
				else
					KurriTween(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))
				end

				if FireFlowers then
					for _, child in pairs(FireFlowers:GetChildren()) do
						if child:IsA("Model") then
							if child.PrimaryPart then
								local Position = child.PrimaryPart.Position

								if (Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
									VirtualInputManager:SendKeyEvent(true, "E", false, game)
									wait(1.5)
									VirtualInputManager:SendKeyEvent(false, "E", false, game)
								else
									KurriTween(CFrame.new(Position))
								end
							end
						end
					end
				end
			end
		end
	end)
	v489:AddToggle({
		Name = "Auto Draco V3",
		Default = false,
		Callback = function(p279)
			_G.DragoV3 = p279
		end
	})
	spawn(function()
		while wait(1) do
			pcall(function()
				if _G.DragoV3 then
					repeat
						wait()
						_G.DangerSc = "Lv Infinite"
						_G.SailBoats = true
						_G.TerrorShark = true
					until not _G.DragoV3

					_G.DangerSc = "Lv 1"
					_G.SailBoats = false
					_G.TerrorShark = false
				end
			end)
		end
	end)
	v489:AddToggle({
		Name = "Auto Trial Draco",
		Default = false,
		Callback = function(p280)
			_G.Relic123 = p280
		end
	})
	spawn(function()
		while wait(1) do
			if _G.Relic123 then
				pcall(function()
					if workspace.Map:FindFirstChild("DracoTrial") then
						KurriRS.Remotes.DracoTrial:InvokeServer()
						wait(0.5)

						while true do
							wait()
							KurriTween(CFrame.new(-39934.9765625, 10685.359375, 22999.34375))

							if not _G.Relic123 then
								break
							elseif HumanoidRootPart.Position == CFrame.new(-39934.9765625, 10685.359375, 22999.34375).Position then
								break
							end
						end

						while true do
							wait()
							KurriTween(CFrame.new(-40511.25390625, 9376.4013671875, 23458.37890625))

							if not _G.Relic123 then
								break
							elseif HumanoidRootPart.Position == CFrame.new(-40511.25390625, 9376.4013671875, 23458.37890625).Position then
								break
							end
						end

						wait(2.5)

						while true do
							wait()
							KurriTween(CFrame.new(-39914.65625, 10685.384765625, 23000.177734375))

							if not _G.Relic123 then
								break
							elseif HumanoidRootPart.Position == CFrame.new(-39914.65625, 10685.384765625, 23000.177734375).Position then
								break
							end
						end

						while true do
							wait()
							KurriTween(CFrame.new(-40045.83203125, 9376.3984375, 22791.287109375))

							if not _G.Relic123 then
								break
							elseif HumanoidRootPart.Position == CFrame.new(-40045.83203125, 9376.3984375, 22791.287109375).Position then
								break
							end
						end

						wait(2.5)

						while true do
							wait()
							KurriTween(CFrame.new(-39908.5, 10685.4052734375, 22990.04296875))

							if not _G.Relic123 then
								break
							elseif HumanoidRootPart.Position == CFrame.new(-39908.5, 10685.4052734375, 22990.04296875).Position then
								break
							end
						end

						while true do
							wait()
							KurriTween(CFrame.new(-39609.5, 9376.400390625, 23472.94335975))

							if not _G.Relic123 then
								break
							elseif HumanoidRootPart.Position == CFrame.new(-39609.5, 9376.400390625, 23472.94335975).Position then
								break
							end
						end
					else
						local TrialTeleport = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")

						if TrialTeleport and TrialTeleport:IsA("Part") then
							KurriTween(CFrame.new(TrialTeleport.Position))
						end
					end
				end)
			end
		end
	end)
	v489:AddToggle({
		Name = "Auto Train Draco",
		Default = false,
		Callback = function(p281)
			_G.TrainDrago = p281
		end
	})
	spawn(function()
		while wait(1) do
			pcall(function()
				if _G.TrainDrago then
					local t33 = {
						"Venomous Assailant",
						"Hydra Enforcer"
					}

					for i = 1, #t33 do
						if LocalPlayer3.Character:FindFirstChild("RaceEnergy").Value == 1 then
							VirtualInputManager:SendKeyEvent(true, "Y", false, game)
							KurriRS.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
							KurriTween(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
						elseif LocalPlayer3.Character:FindFirstChild("RaceTransformed").Value == false then
							local v1016 = MobCheck(t33)

							if v1016 then
								while true do
									wait()
									Kill(v1016, _G.TrainDrago)

									if _G.TrainDrago == false then
										break
									elseif v1016.Humanoid.Health <= 0 or not v1016.Parent then
										break
									end
								end
							else
								KurriTween(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
							end
						end
					end
				end
			end)
		end
	end)
	v489:AddToggle({
		Name = "Tween to Draco Trial",
		Default = false,
		Callback = function(p282)
			_G.TpDrago_Prehis = p282
		end
	})
	spawn(function()
		while wait(1) do
			if _G.TpDrago_Prehis then
				local TrialTeleport = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")

				if TrialTeleport then
					if TrialTeleport:IsA("Part") then
						KurriTween(CFrame.new(TrialTeleport.Position))
					end
				end
			end
		end
	end)
	v489:AddToggle({
		Name = "Change To Draco Race",
		Default = false,
		Callback = function(p283)
			_G.buydracorace = p283
		end
	})
	spawn(function()
		while wait(1) do
			if _G.buydracorace then
				pcall(function()
					if (CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375).Position - HumanoidRootPart.Position).Magnitude >= 300 then
						KurriTween(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))
					else
						KurriTween(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))
						KurriRS.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({ {
							NPC = "Dragon Wizard",
							Command = "DragonRace"
						} }))
					end
				end)
			end
		end
	end)
	v489:AddToggle({
		Name = "Upgrade Dragon Talon",
		Default = false,
		Callback = function(p284)
			_G.DT_Uzoth = p284
		end
	})
	spawn(function()
		while wait(1) do
			if _G.DT_Uzoth then
				local cFrame = CFrame.new(5661.89014, 1211.31909, 864.836731, 0.811413169, -1.36805838e-08, -0.584473014, 4.75227395e-08, 1, 4.25682458e-08, 0.584473014, -6.23161966e-08, 0.811413169)

				KurriTween(cFrame)

				if (cFrame.Position - LocalPlayer3.Character.HumanoidRootPart.Position).Magnitude <= 25 then
					KurriRS.Modules.Net["RF/InteractDragonQuest"]:InvokeServer({
						NPC = "Uzoth",
						Command = "Upgrade"
					})
				end
			end
		end
	end)

	local LocalPlayer8 = game:GetService("Players").LocalPlayer
	local Map = workspace:WaitForChild("Map")

	workspace:WaitForChild("_WorldOrigin"):WaitForChild("Locations")

	local ReplicatedStorage6 = game:GetService("ReplicatedStorage")

	v318:AddSection("Prehistoric Island")
	v318:AddToggle({
		Name = "Auto Craft Volcanic Magnet",
		Default = false,
		Callback = function(p285)
			_G.CraftVM = p285

			if p285 then
				spawn(function()
					while _G.CraftVM do
						task.wait(1)
						pcall(function()
							if LayMaterial("Volcanic Magnet") < 1 then
								if LayMaterial("Scrap Metal") >= 10 and LayMaterial("Blaze Ember") >= 15 then
									ReplicatedStorage6.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Volcanic Magnet")
								elseif LayMaterial("Scrap Metal") < 10 then
									local v1022 = MobCheck("Forest Pirate")

									if v1022 then
										while true do
											task.wait()
											Kill(v1022, _G.CraftVM)

											if not _G.CraftVM then
												break
											elseif not v1022.Parent or v1022.Humanoid.Health <= 0 or LayMaterial("Scrap Metal") >= 10 then
												break
											end
										end
									else
										KurriTween(CFrame.new(-13206.452, 425.892, -7964.554))
									end
								elseif LayMaterial("Blaze Ember") < 15 then
									while true do
										task.wait()
										_G.FarmBlazeEM = true

										if not _G.CraftVM then
											break
										elseif LayMaterial("Blaze Ember") >= 15 then
											break
										end
									end

									_G.FarmBlazeEM = false
								end
							end
						end)
					end
				end)
			end
		end
	})
	v318:AddButton({
		Name = "Craft Volcanic Magnet",
		Callback = function()
			ReplicatedStorage6.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Volcanic Magnet")
		end
	})
	v318:AddToggle({
		Name = "Auto Prehistoric Island",
		Default = false,
		Callback = function(p286)
			_G.Prehis_Find = p286
		end
	})
	spawn(function()
		while wait() do
			if _G.Prehis_Find then
				pcall(function()
					if workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island", true) then
						local PrehistoricIsland = workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island")

						if PrehistoricIsland and (PrehistoricIsland.CFrame.Position - LocalPlayer8.Character.HumanoidRootPart.Position).Magnitude >= 2000 then
							tween2(PrehistoricIsland.CFrame)
						end

						if workspace.Map:FindFirstChild("PrehistoricIsland", true) then
							local ActivationPrompt = workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt")

							if ActivationPrompt then
								local ProximityPrompt = ActivationPrompt:FindFirstChild("ProximityPrompt", true)

								if ProximityPrompt then
									if LocalPlayer8:DistanceFromCharacter(ActivationPrompt.CFrame.Position) <= 150 then
										fireproximityprompt(ProximityPrompt, math.huge)
										VirtualInputManager:SendKeyEvent(true, "E", false, game)
										wait(1.5)
										VirtualInputManager:SendKeyEvent(false, "E", false, game)
									end

									tween2(ActivationPrompt.CFrame)
								end
							end
						end
					else
						local v1026 = CheckBoat()

						if not v1026 then
							local cFrame = CFrame.new(-16927.451, 9.086, 433.864)

							KurriTween(cFrame)

							if (cFrame.Position - LocalPlayer8.Character.HumanoidRootPart.Position).Magnitude <= 10 then
								ReplicatedStorage6.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
							end
						elseif LocalPlayer8.Character.Humanoid.Sit == false then
							tween2(v1026.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
						else
							while true do
								wait()

								local cFrame = CFrame.new(-10000000, 31, 37016.25)

								if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
									tween2(CFrame.new(-10000000, 150, 37016.25))
								else
									tween2(cFrame)
								end

								if _G.Prehis_Find and not ((cFrame.Position - LocalPlayer8.Character.HumanoidRootPart.Position).Magnitude <= 10) then
									if not workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") and LocalPlayer8.Character.Humanoid.Sit ~= false then
										continue
									end
								end

								break
							end

							LocalPlayer8.Character.Humanoid.Sit = false
						end
					end
				end)
			end
		end
	end)
	v318:AddToggle({
		Name = "Auto Kill Lava Golem",
		Default = false,
		Callback = function(p287)
			_G.Prehis_Skills = p287

			if p287 then
				spawn(function()
					while _G.Prehis_Skills do
						task.wait()
						pcall(function()
							local PrehistoricIsland = Map:FindFirstChild("PrehistoricIsland")

							if PrehistoricIsland then
								for _, descendant in pairs(PrehistoricIsland:GetDescendants()) do
									if descendant:IsA("Part") or descendant:IsA("MeshPart") then
										if descendant.Name:lower():find("lava") then
											descendant:Destroy()
										end
									end
								end

								local Core = PrehistoricIsland:FindFirstChild("Core")

								if Core then
									local InteriorLava = Core:FindFirstChild("InteriorLava")

									if InteriorLava and InteriorLava:IsA("Model") then
										InteriorLava:Destroy()
									end
								end

								local TrialTeleport = PrehistoricIsland:FindFirstChild("TrialTeleport")

								for _, descendant in pairs(PrehistoricIsland:GetDescendants()) do
									if descendant.Name == "TouchInterest" and (not TrialTeleport or not descendant:IsDescendantOf(TrialTeleport)) then
										descendant.Parent:Destroy()
									end
								end
							end
						end)
					end
				end)
				spawn(function()
					while _G.Prehis_Skills do
						task.wait()
						pcall(function()
							if workspace.Enemies:FindFirstChild("Lava Golem") then
								local v1037 = MobCheck("Lava Golem")

								if v1037 then
									while true do
										task.wait()
										Kill(v1037, _G.Prehis_Skills)
										v1037.Humanoid:ChangeState(15)

										if not _G.Prehis_Skills then
											break
										elseif not v1037.Parent or v1037.Humanoid.Health <= 0 then
											break
										end
									end
								end
							end

							local PrehistoricIsland = Map:FindFirstChild("PrehistoricIsland")

							if PrehistoricIsland then
								local Core = PrehistoricIsland:FindFirstChild("Core")

								if Core then
									local VolcanoRocks = Core:FindFirstChild("VolcanoRocks")

									if VolcanoRocks then
										for _, child in pairs(VolcanoRocks:GetChildren()) do
											local VFXLayer = child:FindFirstChild("VFXLayer")

											if VFXLayer and VFXLayer:FindFirstChild("At0") then
												local Glow = VFXLayer.At0:FindFirstChild("Glow")

												if Glow and Glow.Enabled then
													repeat
														task.wait()
														KurriTween(VFXLayer.CFrame)

														if Glow.Enabled and LocalPlayer8:DistanceFromCharacter(VFXLayer.Position) <= 150 then
															MousePos = VFXLayer.Position
															_S("Melee", "Z")
															task.wait(0.5)
															_S("Melee", "X")
															task.wait(0.5)
															_S("Melee", "C")
															task.wait(0.5)
															_S("Blox Fruit", "Z")
															task.wait(0.5)
															_S("Blox Fruit", "X")
															task.wait(0.5)
															_S("Blox Fruit", "C")
														end

														if not _G.Prehis_Skills then
															break
														end
													until not Glow.Enabled
												end
											end
										end
									end
								end
							end
						end)
					end
				end)
			end
		end
	})
	v318:AddToggle({
		Name = "Auto Collect Dragon Egg",
		Default = false,
		Callback = function(p288)
			_G.Prehis_DE = p288

			if p288 then
				spawn(function()
					while _G.Prehis_DE do
						task.wait(1)
						pcall(function()
							local PrehistoricIsland = Map:FindFirstChild("PrehistoricIsland")

							if PrehistoricIsland then
								local Core = PrehistoricIsland:FindFirstChild("Core")

								if Core then
									local SpawnedDragonEggs = Core:FindFirstChild("SpawnedDragonEggs")

									if SpawnedDragonEggs then
										local DragonEgg = SpawnedDragonEggs:FindFirstChild("DragonEgg")

										if DragonEgg then
											local Molten = DragonEgg:FindFirstChild("Molten")

											if Molten and Molten:FindFirstChild("ProximityPrompt") then
												KurriTween(Molten.CFrame)
												fireproximityprompt(Molten.ProximityPrompt, 30)
											end
										end
									end
								end
							end
						end)
					end
				end)
			end
		end
	})
	v318:AddToggle({
		Name = "Auto Collect Dinosaur Bones",
		Default = false,
		Callback = function(p289)
			_G.Prehis_DB = p289

			if p289 then
				spawn(function()
					while _G.Prehis_DB do
						task.wait(1)
						pcall(function()
							if workspace:FindFirstChild("DinoBone") then
								for _, child in pairs(workspace:GetChildren()) do
									if child.Name == "DinoBone" then
										KurriTween(child.CFrame)
									end
								end
							end
						end)
					end
				end)
			end
		end
	})
	v318:AddToggle({
		Name = "Auto Reset After Finishing",
		Default = false,
		Callback = function(p290)
			_G.ResetPH = p290

			if p290 then
				spawn(function()
					while _G.ResetPH do
						task.wait(1)
						pcall(function()
							local PrehistoricIsland = Map:FindFirstChild("PrehistoricIsland")

							if PrehistoricIsland then
								local TrialTeleport = PrehistoricIsland:FindFirstChild("TrialTeleport")

								if TrialTeleport and TrialTeleport:FindFirstChild("TouchInterest") then
									LocalPlayer8.Character.Humanoid.Health = 0
								elseif workspace:FindFirstChild("DinoBone") then
									for _, child in pairs(workspace:GetChildren()) do
										if child.Name == "DinoBone" then
											KurriTween(child.CFrame)
										end
									end
								end
							end
						end)
					end
				end)
			end
		end
	})

	local Spy = v489:AddParagraph("Spy", "")

	spawn(function()
		while wait(0.2) do
			pcall(function()
				local v1057 = string.match(ReplicatedStorage6.Remotes.CommF_:InvokeServer("InfoLeviathan", "1"), "%d+")

				if v1057 then
					Spy:Set(" Spy: " .. tostring(v1057))

					if tostring(v1057) == "5" then
						Spy:Set("Ready for Levi!")
					end
				end
			end)
		end
	end)
	RunService6.RenderStepped:Connect(checkBoat)
	_G.DodgeSkill = false
	IsDoingSeaEvent = function()
		local Shark = CheckShark() and _G.Shark

		return Shark or CheckTerrorShark() and _G.TerrorShark or CheckFishCrew() and _G.MobCrew or CheckPiranha() and _G.Piranha or CheckEnemiesBoat() and _G.FishBoat or CheckSeaBeast() and _G.seabeatfarm or _G.PGB and CheckPirateGrandBrigade() or _G.HCM and CheckHauntedCrew()
	end
	spawn(function()
		while wait() do
			if _G.SailBoats then
				pcall(function()
					local v1059 = CheckBoat()

					if not v1059 and not IsDoingSeaEvent() then
						local cFrame = CFrame.new(-16927.451, 9.086, 433.864)

						tween2(cFrame)

						if (cFrame.Position - LocalPlayer8.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							ReplicatedStorage6.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
						end
					elseif v1059 then
						local Humanoid = LocalPlayer8.Character:WaitForChild("Humanoid")

						if IsDoingSeaEvent() then
							Humanoid.Sit = false
							v230()

							return
						end

						if Humanoid.Sit == false then
							tween2(v1059.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
						else
							if _G.DangerSc == "Lv 1" then
								CFrameSelectedZone = CFrame.new(-21998.375, 30.0006084, -682.309143)
							elseif _G.DangerSc == "Lv 2" then
								CFrameSelectedZone = CFrame.new(-26779.5215, 30.0005474, -822.858032)
							elseif _G.DangerSc == "Lv 3" then
								CFrameSelectedZone = CFrame.new(-31171.957, 30.0001011, -2256.93774)
							elseif _G.DangerSc == "Lv 4" then
								CFrameSelectedZone = CFrame.new(-34054.6875, 30.2187767, -2560.12012)
							elseif _G.DangerSc == "Lv 5" then
								CFrameSelectedZone = CFrame.new(-38887.5547, 30.0004578, -2162.99023)
							elseif _G.DangerSc == "Lv 6" then
								CFrameSelectedZone = CFrame.new(-44541.7617, 30.0003204, -1244.8584)
							elseif _G.DangerSc == "Lv Infinite" then
								CFrameSelectedZone = CFrame.new(-10000000, 31, 37016.25)
							end

							while true do
								task.wait()

								if IsDoingSeaEvent() then
									Humanoid.Sit = false
									v230()

									break
								else
									if not _G.FishBoat and CheckEnemiesBoat() or not _G.PGB and CheckPirateGrandBrigade() or not _G.TerrorShark and CheckTerrorShark() then
										tween2(CFrameSelectedZone * CFrame.new(0, 150, 0))
									else
										tween2(CFrameSelectedZone)
									end

									if not _G.SailBoats or IsDoingSeaEvent() or Humanoid.Sit == false then
										break
									end
								end
							end
						end
					end
				end)
			end
		end
	end)
	spawn(function()
		while wait(Sec) do
			pcall(function()
				for _, child in pairs(workspace.Boats:GetChildren()) do
					for _, descendant in pairs(workspace.Boats[child.Name]:GetDescendants()) do
						if descendant:IsA("BasePart") then
							if _G.SailBoats or _G.Prehis_Find or _G.FindMirage or _G.SailBoat_Hydra or _G.kitsunefind then
								descendant.CanCollide = false
							else
								descendant.CanCollide = true
							end
						end
					end
				end
			end)
		end
	end)
	v489:AddToggle({
		Name = "Drive To Hydra",
		Default = false,
		Callback = function(p291)
			_G.SailBoat_Hydra = p291
		end
	})
	task.spawn(function()
		while task.wait(0.2) do
			if _G.SailBoat_Hydra then
				pcall(function()
					local Character2 = LocalPlayer8.Character
					local Humanoid = Character2 and Character2:FindFirstChild("Humanoid")
					local HumanoidRootPart2 = Character2 and Character2:FindFirstChild("HumanoidRootPart")

					if not Humanoid or not HumanoidRootPart2 then
						return
					end

					local v1069 = CheckBoat()

					if not v1069 then
						local cFrame = CFrame.new(-16927, 9, 433)

						if (cFrame.Position - HumanoidRootPart2.Position).Magnitude > 10 then
							tween2(cFrame)
						else
							ReplicatedStorage6.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
						end

						return
					end

					if not Humanoid.Sit then
						tween2(v1069.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
					elseif CheckEnemiesBoat() or CheckPirateGrandBrigade() then
						tween2(CFrame.new(5433, 150, 290))

						return
					elseif CheckTerrorShark() then
						tween2(CFrame.new(5433, 150, 290))
					else
						tween2(CFrame.new(5433, 35, 290))
					end
				end)
			end
		end
	end)
	v489:AddToggle({
		Name = "Auto Escape Rough Sea",
		Description = "Tự động thoát khỏi Rough Sea",
		Default = false,
		Flag = "AutoEscapeRoughSea",
		Callback = function(p292)
			_G.AutoEscapeRoughSea = p292
		end
	})
	task.spawn(function()
		local t34 = {
			["Lv 1"] = Vector3.new(-21998, 30, -682),
			["Lv 2"] = Vector3.new(-26779, 30, -822),
			["Lv 3"] = Vector3.new(-31171, 30, -2256),
			["Lv 4"] = Vector3.new(-34054, 30, -2560),
			["Lv 5"] = Vector3.new(-38887, 30, -2162),
			["Lv 6"] = Vector3.new(-44541, 30, -1244)
		}

		local function v1072(p293)
			local s1 = "Lv 1"
			local huge = math.huge

			for k, v in pairs(t34) do
				local Magnitude = (p293 - v).Magnitude

				if Magnitude < huge then
					huge = Magnitude
					s1 = k
				end
			end

			return s1
		end

		while task.wait(0.5) do
			if _G.AutoEscapeRoughSea and _G.DangerSc ~= "Lv Infinite" then
				pcall(function()
					local v1078 = false
					local LocalPlayer9 = game.Players.LocalPlayer
					local PlayerGui2 = LocalPlayer9:FindFirstChild("PlayerGui")
					local Character2 = LocalPlayer9.Character
					local HumanoidRootPart2 = Character2 and Character2:FindFirstChild("HumanoidRootPart")

					if not HumanoidRootPart2 then
						return
					end

					if PlayerGui2 then
						for _, descendant in pairs(PlayerGui2:GetDescendants()) do
							if (descendant:IsA("TextLabel") or descendant:IsA("TextButton")) and descendant.Visible then
								local ContentText = descendant.ContentText or descendant.Text

								if ContentText ~= "" then
									if string.find(string.lower(ContentText):gsub("[%s<>%[%]]", ""), "roughsea") then
										v1078 = true

										break
									end
								end
							end
						end
					end

					if v1078 then
						local v1086 = v1072(HumanoidRootPart2.Position)
						local dangerSc = v1086

						if v1086 == "Lv 1" then
							dangerSc = "Lv 2"
						elseif v1086 == "Lv 2" then
							dangerSc = "Lv 3"
						elseif v1086 == "Lv 3" then
							dangerSc = "Lv 4"
						elseif v1086 == "Lv 4" then
							dangerSc = "Lv 5"
						elseif v1086 == "Lv 5" then
							dangerSc = "Lv 6"
						elseif v1086 == "Lv 6" then
							dangerSc = "Lv 5"
						end

						if _G.DangerSc ~= dangerSc then
							_G.DangerSc = dangerSc
							v230()
							Window:Notify({
								Title = "Đang thoát khỏi Rough Sea",
								Content = "Vị trí: " .. v1086 .. " → Đang đến " .. dangerSc,
								Image = "rbxassetid://96220014754961",
								Duration = 5
							})
						end
					end
				end)
			end
		end
	end)
	v489:AddToggle({
		Name = "Dodge Skill",
		Default = false,
		Callback = function(p294)
			_G.DodgeSkill = p294
		end
	})
	spawn(function()
		while task.wait() do
			if _G.DodgeSkill then
				pcall(function()
					for _, child in pairs(workspace.Enemies:GetChildren()) do
						local HumanoidRootPart2 = child:FindFirstChild("HumanoidRootPart")
						local Humanoid = child:FindFirstChild("Humanoid")
						local Animator = Humanoid and Humanoid:FindFirstChild("Animator")

						if HumanoidRootPart2 and Animator then
							for _, v in ipairs(Animator:GetPlayingAnimationTracks()) do
								local AnimationId = v.Animation.AnimationId

								if (AnimationId == "rbxassetid://14977820392" or AnimationId == "rbxassetid://8708222556" or AnimationId == "rbxassetid://8708225668") and LocalPlayer8.Character then
									if LocalPlayer8.Character:FindFirstChild("HumanoidRootPart") then
										LocalPlayer8.Character.HumanoidRootPart.CFrame = HumanoidRootPart2.CFrame * CFrame.new(0, 100, 0)
									end
								end
							end
						end
					end
				end)
			end
		end
	end)
	v489:AddButton({
		Name = "Buy Levi Spy",
		Callback = function()
			ReplicatedStorage6:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("InfoLeviathan", "2")
		end
	})

	local v1096 = v489:AddParagraph("Frozen Dimension", "")

	spawn(function()
		pcall(function()
			while wait(0.2) do
				if workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
					v1096:Set(" True")
				else
					v1096:Set(" False")
				end
			end
		end)
	end)
	v489:AddToggle({
		Name = "Tween To Frozen Dimension",
		Default = false,
		Callback = function(p295)
			_G.FrozenTP = p295
		end
	})
	spawn(function()
		while wait(0.1) do
			if _G.FrozenTP then
				pcall(function()
					if workspace.Map:FindFirstChild("LeviathanGate") then
						KurriTween(workspace.Map.LeviathanGate.CFrame)
						ReplicatedStorage6:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("OpenLeviathanGate")
					end
				end)
			end
		end
	end)

	local n15 = 0
	local n16 = 0
	local n17 = 1

	GetWeaponList = function()
		local t35 = {}

		if _G.UseMelee then
			t35[#t35 + 1] = "Melee"
		end

		if _G.UseSword then
			t35[#t35 + 1] = "Sword"
		end

		if _G.UseGun then
			t35[#t35 + 1] = "Gun"
		end

		if _G.UseFruit then
			t35[#t35 + 1] = "Blox Fruit"
		end

		return t35
	end
	SwitchWeapon = function()
		if tick() - n16 < NoSkid then
			return
		end

		n16 = tick()

		local v1101 = GetWeaponList()

		if #v1101 == 0 then
			return
		end

		n17 = n17 % #v1101 + 1
		weaponSc(v1101[n17])
	end
	SpamSkill = function()
		if tick() - n15 < HNCU then
			return
		end

		n15 = tick()

		local v1102 = GetWeaponList()

		if #v1102 == 0 then
			return
		end

		local v1103 = v1102[n17]

		weaponSc(v1103)
		task.wait()

		if v1103 == "Melee" then
			if _G.MeleeZ then
				_S(v1103, "Z")
			end

			if _G.MeleeX then
				_S(v1103, "X")
			end

			if _G.MeleeC then
				_S(v1103, "C")
			end
		elseif v1103 == "Sword" then
			if _G.SwordZ then
				_S(v1103, "Z")
			end

			if _G.SwordX then
				_S(v1103, "X")
			end
		elseif v1103 == "Blox Fruit" then
			if _G.BloxFruitZ then
				_S(v1103, "Z")
			end

			if _G.BloxFruitX then
				_S(v1103, "X")
			end

			if _G.BloxFruitC then
				_S(v1103, "C")
			end

			if _G.BloxFruitV then
				_S(v1103, "V")
			end

			if _G.BloxFruitF then
				_S(v1103, "F")
			end
		elseif v1103 == "Gun" then
			if _G.GunZ then
				_S(v1103, "Z")
			end

			if _G.GunX then
				_S(v1103, "X")
			end
		end
	end
	spawn(function()
		while wait() do
			pcall(function()
				if _G.Shark and CheckShark() then
					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if child.Name == "Shark" and t8.Alive(child) then
							while true do
								task.wait()
								KurriTween(CFrame.new(child.HumanoidRootPart.Position.X, workspace.Map["WaterBase-Plane"].Position.Y + 200, child.HumanoidRootPart.Position.Z))
								KillSea(child, _G.Shark)

								if not _G.Shark then
									break
								elseif not child.Parent or child.Humanoid.Health <= 0 then
									break
								end
							end
						end
					end
				end

				if _G.TerrorShark and CheckTerrorShark() then
					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if child.Name == "Terrorshark" and t8.Alive(child) then
							while true do
								task.wait()
								KurriTween(CFrame.new(child.HumanoidRootPart.Position.X, workspace.Map["WaterBase-Plane"].Position.Y + 200, child.HumanoidRootPart.Position.Z))
								KillSea(child, _G.TerrorShark)

								if not _G.TerrorShark then
									break
								elseif not child.Parent or child.Humanoid.Health <= 0 then
									break
								end
							end
						end
					end
				end

				if _G.Piranha then
					if CheckPiranha() then
						for _, child in pairs(workspace.Enemies:GetChildren()) do
							if child.Name == "Piranha" and t8.Alive(child) then
								while true do
									task.wait()
									KurriTween(CFrame.new(child.HumanoidRootPart.Position.X, workspace.Map["WaterBase-Plane"].Position.Y + 200, child.HumanoidRootPart.Position.Z))
									KillSea(child, _G.Piranha)

									if not _G.Piranha then
										break
									elseif not child.Parent or child.Humanoid.Health <= 0 then
										break
									end
								end
							end
						end
					end
				end

				if _G.MobCrew and CheckFishCrew() then
					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if child.Name == "Fish Crew Member" and t8.Alive(child) then
							while true do
								task.wait()
								KurriTween(CFrame.new(child.HumanoidRootPart.Position.X, workspace.Map["WaterBase-Plane"].Position.Y + 200, child.HumanoidRootPart.Position.Z))
								KillSea(child, _G.MobCrew)

								if not _G.MobCrew then
									break
								elseif not child.Parent or child.Humanoid.Health <= 0 then
									break
								end
							end
						end
					end
				end

				if _G.HCM and CheckHauntedCrew() then
					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if child.Name == "Haunted Crew Member" and t8.Alive(child) then
							while true do
								task.wait()
								KurriTween(CFrame.new(child.HumanoidRootPart.Position.X, workspace.Map["WaterBase-Plane"].Position.Y + 200, child.HumanoidRootPart.Position.Z))
								KillSea(child, _G.HCM)

								if not _G.HCM then
									break
								elseif not child.Parent or child.Humanoid.Health <= 0 then
									break
								end
							end
						end
					end
				end

				if _G.seabeatfarm then
					for _, child in pairs(workspace.SeaBeasts:GetChildren()) do
						if child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Health") and child.Health.Value > 0 then
							repeat
								task.wait()
								KurriTween(CFrame.new(child.HumanoidRootPart.Position.X, workspace.Map["WaterBase-Plane"].Position.Y + 200, child.HumanoidRootPart.Position.Z))

								if LocalPlayer8:DistanceFromCharacter(child.HumanoidRootPart.Position) <= 500 then
									MousePos = child.HumanoidRootPart.Position
									SpamSkill()
								end
							until not _G.seabeatfarm or not child.Parent or child.Health.Value <= 0
						end
					end
				end

				if _G.FishBoat then
					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if child:FindFirstChild("VehicleSeat") and child:FindFirstChild("Health") and child.Health.Value > 0 then
							repeat
								task.wait()
								KurriTween(child.Engine.CFrame * CFrame.new(0, -50, -25))

								if LocalPlayer8:DistanceFromCharacter(child.Engine.Position) <= 150 then
									MousePos = child.Engine.Position
									SpamSkill()
								end
							until not _G.FishBoat or child.Health.Value <= 0
						end
					end
				end

				if _G.PGB then
					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if child:FindFirstChild("VehicleSeat") and child:FindFirstChild("Health") and child.Health.Value > 0 then
							repeat
								task.wait()

								if child.Name == "PirateBrigade" then
									KurriTween(child.Engine.CFrame * CFrame.new(0, -30, -10))
								else
									KurriTween(child.Engine.CFrame * CFrame.new(0, -50, -50))
								end

								if LocalPlayer8:DistanceFromCharacter(child.Engine.Position) <= 150 then
									MousePos = child.Engine.Position
									SpamSkill()
								end
							until not _G.PGB or child.Health.Value <= 0
						end
					end
				end
			end)
		end
	end)
end
local _okSea, _errSea = pcall(_SeaKurri)
if not _okSea then warn('[Sea Kurri] '..tostring(_errSea)) end
-- ===== HET SEA KURRI =====

_ = v490:AddSection({" Race Upgrade V2 / V3 "})
v490:AddToggle({
    Name = "Auto Upgrade Race V2 / V3",
    Description = "Automates Flower quest (V2) and Arrow NPC quest (V3)",
    Default = false,
    Callback = function(Value)
        _G.AutoUpgradeRace = Value
        StopTween(_G.AutoUpgradeRace)
    end
})
spawn(function()
    while task.wait(1) do
        if _G.AutoUpgradeRace then
            pcall(function()
                local race = game:GetService("Players").LocalPlayer.Data.Race.Value
                local alchemistState = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1")
                
                if alchemistState == 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "2")
                elseif alchemistState == 1 then
                    local backpack = game.Players.LocalPlayer:FindFirstChild("Backpack")
                    local character = game.Players.LocalPlayer.Character
                    local hasFlower1 = backpack:FindFirstChild("Flower 1") or character:FindFirstChild("Flower 1")
                    local hasFlower2 = backpack:FindFirstChild("Flower 2") or character:FindFirstChild("Flower 2")
                    local hasFlower3 = backpack:FindFirstChild("Flower 3") or character:FindFirstChild("Flower 3")
                    
                    if not hasFlower1 then
                        local f1 = workspace:FindFirstChild("Flower1")
                        if f1 then
                            topos(f1.CFrame)
                        else
                            topos(CFrame.new(28960.158203125, 14919.6240234375, 235.03948974609375))
                        end
                    elseif not hasFlower2 then
                        local f2 = workspace:FindFirstChild("Flower2")
                        if f2 then
                            topos(f2.CFrame)
                        else
                            topos(CFrame.new(-2967.59521, -4.91089821, 5328.70703))
                        end
                    elseif not hasFlower3 then
                        local enemyName = "Swan Pirate"
                        if game:GetService("Workspace").Enemies:FindFirstChild(enemyName) then
                            for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if enemy.Name == enemyName and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        AutoHaki()
                                        EquipWeapon(_G.SelectWeapon)
                                        enemy.HumanoidRootPart.CanCollide = false
                                        StartBring = true
                                        enemy.Humanoid.WalkSpeed = 0
                                        topos(enemy.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                        game:GetService("VirtualUser"):CaptureController()
                                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
                                    until not _G.AutoUpgradeRace or not enemy.Parent or enemy.Humanoid.Health <= 0
                                    break
                                end
                            end
                        else
                            topos(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))
                        end
                    end
                elseif alchemistState == 2 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "3")
                else
                    local wenlockState = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
                    if wenlockState == 0 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
                    elseif wenlockState == 1 then
                        if race == "Mink" then
                            local chestFound = false
                            for _, chest in pairs(game:GetService("Workspace"):GetChildren()) do
                                if chest.Name:find("Chest") and chest:IsA("Part") then
                                    topos(chest.CFrame)
                                    chestFound = true
                                    task.wait(0.5)
                                    break
                                end
                            end
                            if not chestFound then
                                topos(CFrame.new(-2967.59521, -4.91089821, 5328.70703))
                            end
                        elseif race == "Human" then
                            local humanTarget = nil
                            for _, bossName in ipairs({"Fajita", "Diamond", "Jeremy"}) do
                                local boss = game:GetService("Workspace").Enemies:FindFirstChild(bossName)
                                if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                                    humanTarget = boss
                                    break
                                end
                            end
                            if humanTarget then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    humanTarget.HumanoidRootPart.CanCollide = false
                                    StartBring = true
                                    humanTarget.Humanoid.WalkSpeed = 0
                                    topos(humanTarget.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                    game:GetService("VirtualUser"):CaptureController()
                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
                                until not _G.AutoUpgradeRace or not humanTarget.Parent or humanTarget.Humanoid.Health <= 0
                            else
                                topos(CFrame.new(2006.92615, 448.956665, 853.98285))
                            end
                        elseif race == "Skypiea" or race == "Angel" then
                            local skyTarget = nil
                            for _, player in pairs(game.Players:GetChildren()) do
                                if player ~= game.Players.LocalPlayer and tostring(player.Data.Race.Value):find("Sky") then
                                    local char = player.Character
                                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                                    local hum = char and char:FindFirstChild("Humanoid")
                                    if hrp and hum and hum.Health > 0 then
                                        skyTarget = player
                                        break
                                    end
                                end
                            end
                            if skyTarget then
                                local char = skyTarget.Character
                                repeat
                                    task.wait()
                                    topos(char.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0))
                                    game:GetService("VirtualUser"):CaptureController()
                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
                                until not _G.AutoUpgradeRace or not char.Parent or char.Humanoid.Health <= 0
                            else
                                topos(CFrame.new(-2967.59521, -4.91089821, 5328.70703))
                            end
                        elseif race == "Fishman" or race == "Fish" then
                            local seabeasts = game:GetService("Workspace"):FindFirstChild("SeaBeasts")
                            local sbTarget = nil
                            if seabeasts then
                                for _, sb in pairs(seabeasts:GetChildren()) do
                                    local hum = sb:FindFirstChild("Humanoid")
                                    local hrp = sb:FindFirstChild("HumanoidRootPart")
                                    if hum and hrp and hum.Health > 0 then
                                        sbTarget = sb
                                        break
                                    end
                                end
                            end
                            if sbTarget then
                                local hum = sbTarget.Humanoid
                                local hrp = sbTarget.HumanoidRootPart
                                repeat
                                    task.wait()
                                    topos(hrp.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                    game:GetService("VirtualUser"):CaptureController()
                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
                                until not _G.AutoUpgradeRace or not sbTarget.Parent or hum.Health <= 0
                            else
                                topos(CFrame.new(-2967.59521, -4.91089821, 5328.70703))
                            end
                        end
                    elseif wenlockState == 2 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "3")
                    end
                end
            end)
        end
    end
end)

_ = v490:AddSection({" Teleport V4 "})
v490:AddButton({
    Title = "Teleport To Top GreatTree",
    Value = false,
    Callback = function()
        _G.AutoFarm = false
        _G.AutoFarmLevelNew = false
        _G.AutoFarmMastery = false
        _G.AutoFarmChest = false
        _G.FarmBone = false
        _G.AutoUpgradeRace = false
        StopTween(false)
        
        local character = game.Players.LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local targetPos = CFrame.new(3030.39453125, 2280.6171875, -7320.18359375)
            task.spawn(function()
                -- Teleport to Top of Great Tree (loop to override rubberband)
                for i = 1, 15 do
                    if not hrp or not hrp.Parent then break end
                    hrp.CFrame = targetPos
                    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    task.wait(0.05)
                end
            end)
        end
    end
})
v490:AddButton({
    Title = "Teleport Temple Of Time",
    Value = false,
    Callback = function()
        _G.AutoFarm = false
        _G.AutoFarmLevelNew = false
        _G.AutoFarmMastery = false
        _G.AutoFarmChest = false
        _G.FarmBone = false
        _G.AutoUpgradeRace = false
        StopTween(false)
        
        local character = game.Players.LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local targetPos = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
            task.spawn(function()
                for i = 1, 15 do
                    if not hrp or not hrp.Parent then break end
                    hrp.CFrame = targetPos
                    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    task.wait(0.05)
                end
            end)
        end
    end
})
v490:AddButton({
    Title = "Teleport Lever Pull",
    Value = false,
    Callback = function()
        _G.AutoFarm = false
        _G.AutoFarmLevelNew = false
        _G.AutoFarmMastery = false
        _G.AutoFarmChest = false
        _G.FarmBone = false
        _G.AutoUpgradeRace = false
        StopTween(false)
        
        local character = game.Players.LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local targetPos = CFrame.new(28575.181640625, 14936.6279296875, 72.31636810302734)
            task.spawn(function()
                for i = 1, 15 do
                    if not hrp or not hrp.Parent then break end
                    hrp.CFrame = targetPos
                    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    task.wait(0.05)
                end
            end)
        end
    end
})
v490:AddButton({
    Title = "Teleport To The Clock",
    Value = false,
    Callback = function()
        _G.AutoFarm = false
        _G.AutoFarmLevelNew = false
        _G.AutoFarmMastery = false
        _G.AutoFarmChest = false
        _G.FarmBone = false
        _G.AutoUpgradeRace = false
        StopTween(false)
        
        local character = game.Players.LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local targetPos = CFrame.new(29553.7812, 15066.6133, -88.2750015, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            task.spawn(function()
                for i = 1, 15 do
                    if not hrp or not hrp.Parent then break end
                    hrp.CFrame = targetPos
                    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    task.wait(0.05)
                end
            end)
        end
    end
})
_ = v490:AddSection({" Trial V4 "})
v490:AddButton({
    Title = "Auto Race Door",
    Value = false,
    Callback = function()
        task.spawn(function()
            local character = game.Players.LocalPlayer.Character
            local hrp = character and character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local targetPos = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
                for i = 1, 15 do
                    if not hrp or not hrp.Parent then break end
                    hrp.CFrame = targetPos
                    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    task.wait(0.05)
                end
            end
            
            task.wait(0.2)
            
            if game:GetService("Players").LocalPlayer.Data.Race.Value == "Human" then
                topos(CFrame.new(29221.822265625, 14890.9755859375, -205.99114990234375))
            elseif game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Skypiea" then
                if game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman" then
                    topos(CFrame.new(28231.17578125, 14890.9755859375, -211.64173889160156))
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg" then
                    topos(CFrame.new(28502.681640625, 14895.9755859375, -423.7279357910156))
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Ghoul" then
                    if game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" then
                        topos(CFrame.new(29012.341796875, 14890.9755859375, -380.1492614746094))
                    end
                else
                    topos(CFrame.new(28674.244140625, 14890.6767578125, 445.4310607910156))
                end
            else
                topos(CFrame.new(28960.158203125, 14919.6240234375, 235.03948974609375))
            end
        end)
    end
})
v490:AddButton({
    Title = "Buy Acient One Quest",
    Value = false,
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("UpgradeRace", "Buy")
    end
})
v490:AddToggle({
    Name = "Auto Trial Human Ghost",
    Description = "",
    Default = false,
    Callback = function(v998)
        _G.Kill_Aura = v998
        StopTween(_G.Kill_Aura)
    end
})
v490:AddToggle({
    Name = "Auto Trial All Race",
    Description = "",
    Default = false,
    Callback = function(v999)
        _G.AutoQuestRace = v999
        StopTween(_G.AutoQuestRace)
    end
})
spawn(function()
    while wait() do
        if _G.AutoQuestRace then
            pcall(function()
                if game:GetService("Players").LocalPlayer.Data.Race.Value == "Human" then
                    for _, v1001 in pairs(game.Workspace.Enemies:GetDescendants()) do
                        local l_v1001_0 = v1001
                        if l_v1001_0:FindFirstChild("Humanoid") and l_v1001_0:FindFirstChild("HumanoidRootPart") and l_v1001_0.Humanoid.Health > 0 then
                            pcall(function()
                                repeat
                                    wait(0.1)
                                    l_v1001_0.Humanoid.Health = 0
                                    l_v1001_0.HumanoidRootPart.CanCollide = false
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.AutoQuestRace or not l_v1001_0.Parent or l_v1001_0.Humanoid.Health <= 0
                            end)
                        end
                    end
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Skypiea" then
                    local map = game:GetService("Workspace"):FindFirstChild("Map")
                    local skyTrial = map and map:FindFirstChild("SkyTrial")
                    local model = skyTrial and skyTrial:FindFirstChild("Model")
                    if model then
                        for _, v1004 in pairs(model:GetDescendants()) do
                            if v1004.Name == "snowisland_Cylinder.081" then
                                topos(v1004.CFrame * CFrame.new(0, 0, 0))
                            end
                        end
                    end
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Fishman" then
                    if game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg" then
                        topos(CFrame.new(28654, 14898.7832, -30, 1, 0, 0, 0, 1, 0, 0, 0, 1))
                    elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Ghoul" then
                        for _, v1006 in pairs(game.Workspace.Enemies:GetDescendants()) do
                            local l_v1006_0 = v1006
                            if l_v1006_0:FindFirstChild("Humanoid") and l_v1006_0:FindFirstChild("HumanoidRootPart") and l_v1006_0.Humanoid.Health > 0 then
                                pcall(function()
                                    repeat
                                        wait(0.1)
                                        l_v1006_0.Humanoid.Health = 0
                                        l_v1006_0.HumanoidRootPart.CanCollide = false
                                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                    until not _G.AutoQuestRace or not l_v1006_0.Parent or l_v1006_0.Humanoid.Health <= 0
                                end)
                            end
                        end
                    elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" then
                        for _, v1009 in pairs(game:GetService("Workspace"):GetDescendants()) do
                            if v1009.Name == "StartPoint" then
                                topos(v1009.CFrame * CFrame.new(0, 3, 0))
                                _G.AutoQuestRace = false
                                StopTween(_G.AutoQuestRace)
                            end
                        end
                    end
                else
                    local seaBeasts = game:GetService("Workspace"):FindFirstChild("SeaBeasts")
                    local seaBeast1 = seaBeasts and seaBeasts:FindFirstChild("SeaBeast1")
                    if seaBeast1 then
                        for _, v1011 in pairs(seaBeast1:GetDescendants()) do
                            if v1011.Name == "HumanoidRootPart" then
                                topos(v1011.CFrame * (Pos or CFrame.new(0, 0, 0)))
                                for _, v1013 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                    if v1013:IsA("Tool") and v1013.ToolTip == "Melee" then
                                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1013)
                                    end
                                end
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                wait(0.2)
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                wait(0.2)
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                for _, v1015 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                    if v1015:IsA("Tool") and v1015.ToolTip == "Blox Fruit" then
                                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1015)
                                    end
                                end
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                wait(0.2)
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                wait(0.2)
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                wait(0.5)
                                for _, v1017 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                    if v1017:IsA("Tool") and v1017.ToolTip == "Sword" then
                                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1017)
                                    end
                                end
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                wait(0.2)
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                wait(0.2)
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                wait(0.5)
                                for _, v1019 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                    if v1019:IsA("Tool") and v1019.ToolTip == "Gun" then
                                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1019)
                                    end
                                end
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                wait(0.2)
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                wait(0.2)
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                            end
                        end
                    end
                end
            end)
        end
    end
end)
v490:AddToggle({
    Name = "Auto Kill Player after Trial  V4",
    Description = "",
    Default = false,
    Callback = function(v1020)
        _G.AutoKillV4 = v1020
        StopTween(_G.AutoKillV4)
    end
})
spawn(function()
    while task.wait() do
        if _G.AutoKillV4 then
            pcall(function()
                local characters = game.Workspace:FindFirstChild("Characters")
                if characters then
                    for _, v1022 in pairs(characters:GetChildren()) do
                        if v1022.Name ~= game.Players.LocalPlayer.Name and v1022:FindFirstChild("Humanoid") and v1022:FindFirstChild("HumanoidRootPart") and v1022.Humanoid.Health > 0 and v1022.Parent and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v1022.HumanoidRootPart.Position).Magnitude <= 230 then
                            _G.AttackRange = 120
                            repeat
                                task.wait()
                                AutoHaki()
                                EquipWeapon(_G.SelectWeapon)
                                topos(v1022.HumanoidRootPart.CFrame * CFrame.new(1, 1, 2))
                                v1022.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v1022.HumanoidRootPart.CanCollide = false
                                v1022.Head.CanCollide = false
                                v1022.Humanoid.WalkSpeed = 0
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
                                if _G.XaiSkillZ then Skill("Z") end
                                if _G.XaiSkillX then Skill("X") end
                                if _G.XaiSkillC then Skill("C") end
                            until not _G.AutoKillV4 or v1022.Humanoid.Health <= 0 or not v1022.Parent or not v1022:FindFirstChild("HumanoidRootPart") or not v1022:FindFirstChild("Humanoid")
                            _G.AttackRange = nil
                        end
                    end
                end
            end)
        end
    end
end)
_ = v490:AddSection({" Auto Skill "})
v490:AddToggle({
    Name = "Auto Skill Z",
    Description = "",
    Default = false,
    Callback = function(v1024)
        _G.XaiSkillZ = v1024
        StopTween(_G.XaiSkillZ)
    end
})
v490:AddToggle({
    Name = "Auto Skill X",
    Description = "",
    Default = false,
    Callback = function(v1025)
        _G.XaiSkillX = v1025
        StopTween(_G.XaiSkillX)
    end
})
v490:AddToggle({
    Name = "Auto Skill C",
    Description = "",
    Default = false,
    Callback = function(v1026)
        _G.XaiSkillC = v1026
        StopTween(_G.XaiSkillC)
    end
})

if not World3 then
    v498:AddParagraph({
        Title = "Only Sea 3",
        Content = "Only Sea 3"
    })
else
end
_ = v498:AddSection({" Leviathan Island "})

-- 1st: Status Leviathan Island
vLiviStatus = v498:AddParagraph({Title = "Status Leviathan Island", Content = "Loading..."})
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
                vLiviStatus:Set("Spawning    ")
            else
                vLiviStatus:Set("Not Spawn    ")
            end
        end)
    end
end)

-- 2nd: Find Leviathan Island
v498:AddToggle({
    Name = "Find Leviathan Island",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoFindFrozen = Value
        _G.SailBoat = Value
        StopTween(_G.AutoFindFrozen)
        if not Value then
            stopBoatTween()
            stopTeleport()
            pcall(function()
                if tween then
                    tween:Cancel()
                end
            end)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", false, game)
        end
    end
})
frozenSeats = {}

game:GetService("RunService").RenderStepped:Connect(function()
    if _G.AutoFindFrozen then
        local character = game:GetService("Players").LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            local humanoid = character.Humanoid
            local onSeat = false
            local activeSeat = nil
            for _, boat in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                local seat = boat:FindFirstChild("VehicleSeat")
                if seat and seat.Occupant == humanoid then
                    onSeat = true
                    activeSeat = seat
                    frozenSeats[boat.Name] = seat
                end
            end
            if onSeat then
                activeSeat.MaxSpeed = 350
                activeSeat.CFrame = CFrame.new(Vector3.new(activeSeat.Position.X, activeSeat.Position.Y, activeSeat.Position.Z)) * activeSeat.CFrame.Rotation
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
                for _, part in pairs(game:GetService("Workspace").Boats:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                for _, island in ipairs({
                    "ShipwreckIsland",
                    "SandIsland",
                    "TreeIsland",
                    "TinyIsland",
                    "MysticIsland",
                    "KitsuneIsland",
                    "PrehistoricIsland"
                }) do
                    local model = game:GetService("Workspace").Map:FindFirstChild(island)
                    if model and model:IsA("Model") then
                        model:Destroy()
                    end
                end
                if workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", false, game)
                    _G.AutoFindFrozen = false
                    _G.SailBoat = false
                    stopBoatTween()
                end
            end
        end
    end
end)

-- 3rd: Tween Leviathan Island
v498:AddToggle({
    Name = "Tween Leviathan Island",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.TweenToFrozenDimension = Value
        StopTween(_G.TweenToFrozenDimension)
    end
})
spawn(function()
    while wait() do
        if _G.TweenToFrozenDimension and not v391 then
            pcall(function()
                local character = game.Players.LocalPlayer.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local marker = workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension")
                    if marker then
                        local cf = marker:GetPivot()
                        local distance = (cf.Position - hrp.Position).Magnitude
                        if distance > 10 then
                            topos(cf)
                        else
                            _G.TweenToFrozenDimension = false
                        end
                    end
                end
            end)
        end
    end
end)

-- 4th: Leviathan Chip Status
vChipStatus = v498:AddParagraph({Title = "Leviathan Chip Status", Content = "Loading..."})
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local v1103 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "1")
            local spycheck = string.match(tostring(v1103), "%d+")
            if spycheck then
                local num = tonumber(spycheck)
                if num == 5 then
                    vChipStatus:Set("Leviathan Is Out There    ")
                elseif num == 0 then
                    vChipStatus:Set("I Don't Know / Reset    ")
                else
                    vChipStatus:Set("Cooldown: " .. tostring(num) .. "s    ")
                end
            else
                vChipStatus:Set("I Don't Know / Reset    ")
            end
        end)
    end
end)

-- 5th: Buy Leviathan Chip
v498:AddButton({
    Title = "Buy Leviathan Chip",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "2")
    end
})

_ = v498:AddSection({" Volcanic Island "})
v498:AddButton({
    Title = "Craft Volcanic Magnet",
    Value = false,
    Callback = function()
        local v849 = {[1] = "CraftItem", [2] = "Craft", [3] = "Volcanic Magnet"}
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v849))
    end
})
v850 = v498:AddParagraph({Title = "Check Prehistoric Island", Content = "Loading..."})
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
                v850:Set("Prehistoric Island Spawning    ")
            else
                v850:Set("Prehistoric Island Not Spawn    ")
            end
        end)
    end
end)
v498:AddToggle({
    Name = "Auto Find Prehistoric",
    Description = "",
    Default = false,
    Callback = function(v851)
        _G.AutoFindPrehistoric = v851
        _G.SailBoat = v851
        StopTween(_G.AutoFindPrehistoric)
        if not v851 then
            stopBoatTween()
            stopTeleport()
            pcall(function()
                if tween then
                    tween:Cancel()
                end
            end)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", false, game)
        end
    end
})
v852 = {}
l_Players_0 = game:GetService("Players")
l_RunService_0 = game:GetService("RunService")
l_VirtualInputManager_3 = game:GetService("VirtualInputManager")
l_Workspace_1 = game:GetService("Workspace")
v857 = 350
l_RunService_0.RenderStepped:Connect(function()
    for v858, v859 in pairs(v852) do
        if v859 and v859.Parent and v859.Name == "VehicleSeat" and not v859.Occupant then
            v852[v858] = v859
        end
    end
end)
_ = function()
    for _, v861 in pairs(v852) do
        if v861 and v861.Parent and v861.Name == "VehicleSeat" and not v861.Occupant then
            topos(v861.CFrame)
        end
    end
end
v863 = false
v864 = false

l_RunService_0.RenderStepped:Connect(function()
    if _G.AutoFindPrehistoric then
        local l_Character_8 = l_Players_0.LocalPlayer.Character
        if l_Character_8 and l_Character_8:FindFirstChild("Humanoid") then
            local l_Humanoid_1 = l_Character_8.Humanoid
            local v870 = false
            local v871 = nil
            for _, v873 in pairs(l_Workspace_1.Boats:GetChildren()) do
                local l_VehicleSeat_0 = v873:FindFirstChild("VehicleSeat")
                if l_VehicleSeat_0 and l_VehicleSeat_0.Occupant == l_Humanoid_1 then
                    v870 = true
                    v871 = l_VehicleSeat_0
                    v852[v873.Name] = l_VehicleSeat_0
                end
            end
            if v870 then
                v871.MaxSpeed = v857
                v871.CFrame = CFrame.new(Vector3.new(v871.Position.X, v871.Position.Y, v871.Position.Z)) * v871.CFrame.Rotation
                l_VirtualInputManager_3:SendKeyEvent(true, "W", false, game)
                for _, v876 in pairs(l_Workspace_1.Boats:GetDescendants()) do
                    if v876:IsA("BasePart") then
                        v876.CanCollide = false
                    end
                end
                for _, v878 in pairs(l_Character_8:GetDescendants()) do
                    if v878:IsA("BasePart") then
                        v878.CanCollide = false
                    end
                end
                for _, v880 in ipairs({
                    "ShipwreckIsland",
                    "SandIsland",
                    "TreeIsland",
                    "TinyIsland",
                    "MysticIsland",
                    "KitsuneIsland",
                    "FrozenDimension"
                }) do
                    local l_FirstChild_6 = l_Workspace_1.Map:FindFirstChild(v880)
                    if l_FirstChild_6 and l_FirstChild_6:IsA("Model") then
                        l_FirstChild_6:Destroy()
                    end
                end
                if l_Workspace_1.Map:FindFirstChild("PrehistoricIsland") then
                    l_VirtualInputManager_3:SendKeyEvent(false, "W", false, game)
                    _G.AutoFindPrehistoric = false
                    _G.SailBoat = false
                    stopBoatTween()
                end
            end
        end
    end
end)
v498:AddToggle({
    Name = "Auto Tween Prehistoric Island",
    Description = "",
    Default = false,
    Callback = function(v882)
        _G.TweenVolcano = v882
        StopTween(_G.TweenVolcano)
    end
})
spawn(function()
    local v883 = nil
    while not v883 do
        v883 = game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
        wait()
    end
    while wait() do
        if _G.TweenVolcano then
            local l_PrehistoricIsland_0 = game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
            if l_PrehistoricIsland_0 then
                local v885 = l_PrehistoricIsland_0:FindFirstChild("Core") and l_PrehistoricIsland_0.Core:FindFirstChild("PrehistoricRelic")
                local v886 = v885 and v885:FindFirstChild("Skull")
                if v886 then
                    TP1(CFrame.new(v886.Position))
                    _G.TweenVolcano = false
                end
            end
        end
    end
end)
v498:AddDropdown({
    Name = "Select Skills to Use",
    Description = "Select weapons to use during defend",
    Options = {"Melee", "Sword", "Gun"},
    Default = {["Melee"] = true, ["Sword"] = true, ["Gun"] = true},
    MultiSelect = true,
    Callback = function(Table)
        local selected = {}
        for k, v in pairs(Table) do
            if type(k) == "string" then
                if v == true then selected[k] = true end
            elseif type(v) == "string" then
                selected[v] = true
            end
        end
        _G.UseMelee = not not selected["Melee"]
        _G.UseSword = not not selected["Sword"]
        _G.UseGun = not not selected["Gun"]
    end
})
v498:AddToggle({
    Name = "Auto Defend Prehistoric",
    Description = "",
    Default = false,
    Callback = function(v887)
        _G.DefendVolcano = v887
        StopTween(_G.DefendVolcano)
    end
})
local function v889(v888)
    game:GetService("VirtualInputManager"):SendKeyEvent(true, v888, false, game)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, v888, false, game)
end
local function v898()
    local l_InteriorLava_0 = game.Workspace.Map.PrehistoricIsland.Core:FindFirstChild("InteriorLava")
    if l_InteriorLava_0 and l_InteriorLava_0:IsA("Model") then
        l_InteriorLava_0:Destroy()
    end
    local l_PrehistoricIsland_1 = game.Workspace.Map:FindFirstChild("PrehistoricIsland")
    if l_PrehistoricIsland_1 then
        for _, v893 in pairs(l_PrehistoricIsland_1:GetDescendants()) do
            if v893:IsA("Part") and v893.Name:lower():find("lava") then
                v893:Destroy()
            end
        end
    end
    if l_PrehistoricIsland_1 then
        for _, v895 in pairs(l_PrehistoricIsland_1:GetDescendants()) do
            if v895:IsA("Model") then
                for _, v897 in pairs(v895:GetDescendants()) do
                    if v897:IsA("MeshPart") and v897.Name:lower():find("lava") then
                        v897:Destroy()
                    end
                end
            end
        end
    end
end
local function v904()
    local l_VolcanoRocks_0 = game.Workspace.Map.PrehistoricIsland.Core.VolcanoRocks
    for _, v901 in pairs(l_VolcanoRocks_0:GetChildren()) do
        if v901:IsA("Model") then
            local l_volcanorock_0 = v901:FindFirstChild("volcanorock")
            if l_volcanorock_0 and l_volcanorock_0:IsA("MeshPart") then
                local l_Color_0 = l_volcanorock_0.Color
                if l_Color_0 == Color3.fromRGB(185, 53, 56) or l_Color_0 == Color3.fromRGB(185, 53, 57) then
                    return l_volcanorock_0
                end
            end
        end
    end
    return nil
end
local function v913(v905)
    local l_LocalPlayer_13 = game.Players.LocalPlayer
    local l_Backpack_2 = l_LocalPlayer_13.Backpack
    for _, v909 in pairs(l_Backpack_2:GetChildren()) do
        if v909:IsA("Tool") and v909.ToolTip == v905 then
            v909.Parent = l_LocalPlayer_13.Character
            for _, v911 in ipairs({"Z", "X", "C", "V", "F"}) do
                wait()
                do
                    local l_v911_0 = v911
                    pcall(function()
                        v889(l_v911_0)
                    end)
                end
            end
            v909.Parent = l_Backpack_2
            break
        end
    end
end
spawn(function()
    while wait() do
        if _G.DefendVolcano then
            AutoHaki()
            pcall(v898)
            local v914 = v904()
            if not v914 then
                _G.TpPrehistoric = true
            else
                local v915 = CFrame.new(v914.Position)
                TP1(v915)
                local l_Color_1 = v914.Color
                if l_Color_1 == Color3.fromRGB(185, 53, 56) or l_Color_1 == Color3.fromRGB(185, 53, 57) then
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v914.Position).Magnitude <= 1 then
                        if _G.UseMelee then
                            v913("Melee")
                        end
                        if _G.UseSword then
                            v913("Sword")
                        end
                        if _G.UseGun then
                            v913("Gun")
                        end
                    end
                    _G.TpPrehistoric = false
                else
                    v914 = v904()
                end
            end
        end
    end
end)

_ = v498:AddSection({" Auto Kill Golem "})
v498:AddToggle({
    Name = "Auto Kill Golem",
    Description = "",
    Default = false,
    Callback = function(v922)
        _G.KillGolem = v922
        StopTween(_G.KillGolem)
    end
})
spawn(function()
    while wait() do
        if _G.KillGolem and World3 then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("Lava Golem") then
                    for _, v924 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v924.Name == "Lava Golem" and v924:FindFirstChild("Humanoid") and v924:FindFirstChild("HumanoidRootPart") and v924.Humanoid.Health > 0 then
                            repeat
                                task.wait()
                                AutoHaki()
                                EquipWeapon(_G.SelectWeapon)
                                v924.HumanoidRootPart.CanCollide = false
                                v924.Humanoid.WalkSpeed = 0
                                v924.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                topos(v924.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            until not _G.KillGolem or not v924.Parent or v924.Humanoid.Health <= 0
                        end
                    end
                else
                    UnEquipWeapon(_G.SelectWeapon)
                    if game:GetService("ReplicatedStorage"):FindFirstChild("Lava Golem") then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild("Lava Golem").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                    end
                end
            end)
        end
    end
end)
v498:AddToggle({
    Name = "Auto Kill Aura Golem",
    Description = "",
    Default = false,
    Callback = function(v925)
        _G.Kill_Aura = v925
        StopTween(_G.Kill_Aura)
    end
})
spawn(function()
    pcall(function()
        while wait() do
            if _G.Kill_Aura then
                local l_LocalPlayer_14 = game:GetService("Players").LocalPlayer
                local l_Children_0 = game:GetService("Workspace").Enemies:GetChildren()
                local v928 = l_LocalPlayer_14.Character and l_LocalPlayer_14.Character:FindFirstChild("HumanoidRootPart") and l_LocalPlayer_14.Character.HumanoidRootPart.Position
                do
                    local l_l_LocalPlayer_14_0 = l_LocalPlayer_14
                    if v928 then
                        for _, v931 in pairs(l_Children_0) do
                            do
                                local l_v931_0 = v931
                                if l_v931_0:FindFirstChild("Humanoid") and l_v931_0:FindFirstChild("HumanoidRootPart") and l_v931_0.Humanoid.Health > 0 and (l_v931_0.HumanoidRootPart.Position - v928).Magnitude <= 1000 then
                                    pcall(function()
                                        repeat
                                            wait()
                                            sethiddenproperty(l_l_LocalPlayer_14_0, "SimulationRadius", math.huge)
                                            l_v931_0.Humanoid.Health = 0
                                            l_v931_0.HumanoidRootPart.CanCollide = false
                                        until not _G.Kill_Aura or not l_v931_0.Parent or l_v931_0.Humanoid.Health <= 0
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end)
_ = v498:AddSection({" Auto Collect Bone,Egg "})
v498:AddToggle({
    Name = "Auto Collect Bone",
    Description = "",
    Default = false,
    Callback = function(v934)
        _G.AutoCollectBone = v934
        StopTween(_G.AutoCollectBone)
    end
})
spawn(function()
    while wait() do
        if _G.AutoCollectBone then
            for _, v936 in pairs(workspace:GetDescendants()) do
                if v936:IsA("BasePart") and v936.Name == "DinoBone" then
                    topos(CFrame.new(v936.Position))
                end
            end
        end
    end
end)
v498:AddToggle({
    Name = "Auto Collect Egg",
    Description = "",
    Default = false,
    Callback = function(v937)
        _G.CollectEgg = v937
        StopTween(_G.CollectEgg)
    end
})
spawn(function()
    while wait() do
        if _G.CollectEgg then
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/CollectedDragonEgg"):FireServer()
            end)
        end
    end
end)
_ = v498:AddSection({" Kitsune Island "})
v939 = v498:AddParagraph({Title = "Check Kitsune Island", Content = "Loading..."})
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") then
                v939:Set("Kitsune Island Spawning    ")
            else
                v939:Set("Kitsune Island Not Spawn    ")
            end
        end)
    end
end)
v498:AddToggle({
    Title = "Esp Kitsune Island",
    Value = false,
    Callback = function(v945)
        if getgenv().KitsuneManager then
            getgenv().KitsuneManager.Enabled = v945
        end
    end
})
v498:AddToggle({
    Name = "Fly To Kitsune Island",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.TweenToKitsune = Value
        StopTween(_G.TweenToKitsune)
    end
})
spawn(function()
    while wait() do
        if _G.TweenToKitsune and not v391 then
            pcall(function()
                local character = game.Players.LocalPlayer.Character
                if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                
                local kitsuneIsland = game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland")
                if kitsuneIsland then
                    local shrineActive = kitsuneIsland:FindFirstChild("ShrineActive")
                    if shrineActive then
                        for _, neonPart in pairs(shrineActive:GetDescendants()) do
                            if neonPart:IsA("BasePart") and neonPart.Name:find("NeonShrinePart") then
                                local distance = (neonPart.Position - character.HumanoidRootPart.Position).Magnitude
                                if distance > 10 then
                                    topos(neonPart.CFrame)
                                end
                                break
                            end
                        end
                    end
                end
            end)
        end
    end
end)
v498:AddToggle({
    Name = "Auto Azuer Ember",
    Description = "",
    Default = false,
    Callback = function(v946)
        _G.AutoAzuerEmber = v946
        StopTween(_G.AutoAzuerEmber)
    end
})
spawn(function()
    while wait() do
        if _G.AutoAzuerEmber then
            pcall(function()
                for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if v.Name == "AttachedAzureEmber" or v.Name == "AzureEmber" then
                        local part = v:IsA("BasePart") and v or v:FindFirstChildWhichIsA("BasePart")
                        if part then
                            topos(part.CFrame)
                            break
                        end
                    end
                end
            end)
        end
    end
end)
_ = v498:AddSection({" Mirage Island "})
v984 = v498:AddParagraph({Title = "Check Mirage Island", Content = "Loading..."})
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if not game.Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
                v984:Set("Mirage Island Not Spawn    ")
            else
                v984:Set("Mirage Island Spawning    ")
            end
        end)
    end
end)
v498:AddToggle({
    Name = "Tween Mirage Island",
    Description = "",
    Default = false,
    Callback = function(v985)
        _G.AutoMysticIsland = v985
        StopTween(_G.AutoMysticIsland)
    end
})
spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if _G.AutoMysticIsland then
                for _, v987 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
                    if v987.Name == "Mirage Island" then
                        topos(v987.CFrame * CFrame.new(0, 333, 0))
                    end
                end
            end
        end)
    end
end)
v498:AddToggle({
    Title = "Esp Mirage Island",
    Description = "",
    Value = false,
    Callback = function(v988)
        if getgenv().MirageManager then
            getgenv().MirageManager.Enabled = v988
        end
    end
})
v498:AddToggle({
    Name = "Look Moon + Auto V3",
    Description = "",
    Default = false,
    Callback = function(v989)
        _G.AutoDooHee = v989
        StopTween(_G.AutoDooHee)
    end
})
l_VirtualInputManager_4 = game:GetService("VirtualInputManager")
spawn(function()
    while wait() do
        pcall(function()
            if getgenv()._G.AutoDooHee then
                local l_MoonDirection_0 = game.Lighting:GetMoonDirection()
                local v992 = game.Workspace.CurrentCamera.CFrame.p + l_MoonDirection_0 * 100
                game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.p, v992)
                wait(2)
                l_VirtualInputManager_4:SendKeyEvent(true, "T", false, game)
                wait(0.1)
                l_VirtualInputManager_4:SendKeyEvent(false, "T", false, game)
            end
        end)
    end
end)
v498:AddToggle({
    Name = "Auto Tween To Gear",
    Description = "",
    Default = false,
    Callback = function(v993)
        _G.TweenMGear = v993
        StopTween(_G.TweenMGear)
    end
})
spawn(function()
    pcall(function()
        while wait() do
            if _G.TweenMGear and game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
                for _, v995 in pairs(game:GetService("Workspace").Map.MysticIsland:GetDescendants()) do
                    if v995:IsA("MeshPart") and v995.Material == Enum.Material.Neon then
                        topos(v995.CFrame)
                    end
                end
            end
        end
    end)
end)

_ = v491:AddSection({" Fruits "})
v491:AddToggle({
    Name = "Auto Random Fruits",
    Description = "",
    Default = false,
    Callback = function(v1074)
        _G.RandomAuto = v1074
    end
})
spawn(function()
    _G.LastGachaCheck = 0
    while task.wait(5) do
        if _G.RandomAuto then
            pcall(function()
                if os.time() - _G.LastGachaCheck > 60 then -- Don't spam remote
                    local res = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "GetPrice")
                    if type(res) == "number" or res == 1 or type(res) == "table" or game:GetService("ReplicatedStorage"):FindFirstChild("RF/GachaNetworkRF", true) then
                        local gachaCFrame
                        if game.PlaceId == 2753915549 then
                            gachaCFrame = CFrame.new(-1005.4, 8.4, 1725.7) -- Middletown Gacha Dealer (Update 30)
                        elseif game.PlaceId == 4442272183 then
                            gachaCFrame = CFrame.new(-380.479, 77.22, 255.826) -- Cafe
                        else
                            gachaCFrame = CFrame.new(-5036, 315, -3179) -- Castle on the Sea
                        end
                        
                        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp and (hrp.Position - gachaCFrame.Position).Magnitude > 25 then
                            local oldAutoFarm = _G.AutoFarm
                            _G.AutoFarm = false -- Smart Pause
                            topos(gachaCFrame)
                            task.wait(1.5)
                            local rf = game:GetService("ReplicatedStorage"):FindFirstChild("RF/GachaNetworkRF", true)
                            if rf then rf:InvokeServer({["Context"]="Purchase", ["BoxName"]="ZiolesGacha"}) else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy") end
                            task.wait(0.5)
                            _G.AutoFarm = oldAutoFarm -- Resume
                            _G.LastGachaCheck = os.time() + 7200 -- 2 Hour Cooldown
                        else
                            local rf = game:GetService("ReplicatedStorage"):FindFirstChild("RF/GachaNetworkRF", true)
                            if rf then rf:InvokeServer({["Context"]="Purchase", ["BoxName"]="ZiolesGacha"}) else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy") end
                            _G.LastGachaCheck = os.time() + 7200
                        end
                    end
                end
            end)
        end
    end
end)
v491:AddToggle({
    Name = "Auto Store Fruits",
    Description = "",
    Default = false,
    Callback = function(v1075)
        getgenv().AutoStoreFruit = v1075
    end
})
spawn(function()
    while task.wait(0.2) do
        if getgenv().AutoStoreFruit then
            pcall(function()
                local l_LocalPlayer_16 = game:GetService("Players").LocalPlayer
                local v1077 = l_LocalPlayer_16.Character or l_LocalPlayer_16.CharacterAdded:Wait()
                local l_Backpack_3 = l_LocalPlayer_16:WaitForChild("Backpack")
                for _, v1080 in ipairs({
                    {"Rocket Fruit", "Rocket-Rocket"},
                    {"Spin Fruit", "Spin-Spin"},
                    {"Blade Fruit", "Blade-Blade"},
                    {"Spring Fruit", "Spring-Spring"},
                    {"Bomb Fruit", "Bomb-Bomb"},
                    {"Smoke Fruit", "Smoke-Smoke"},
                    {"Spike Fruit", "Spike-Spike"},
                    {"Flame Fruit", "Flame-Flame"},
                    {"Eagle Fruit", "Eagle-Eagle"},
                    {"Ice Fruit", "Ice-Ice"},
                    {"Sand Fruit", "Sand-Sand"},
                    {"Dark Fruit", "Dark-Dark"},
                    {"Diamond Fruit", "Diamond-Diamond"},
                    {"Light Fruit", "Light-Light"},
                    {"Rubber Fruit", "Rubber-Rubber"},
                    {"Creation Fruit", "Creation-Creation"},
                    {"Ghost Fruit", "Ghost-Ghost"},
                    {"Magma Fruit", "Magma-Magma"},
                    {"Quake Fruit", "Quake-Quake"},
                    {"Buddha Fruit", "Buddha-Buddha"},
                    {"Love Fruit", "Love-Love"},
                    {"Spider Fruit", "Spider-Spider"},
                    {"Sound Fruit", "Sound-Sound"},
                    {"Phoenix Fruit", "Phoenix-Phoenix"},
                    {"Portal Fruit", "Portal-Portal"},
                    {"Lightning Fruit", "Lightning-Lightning"},
                    {"Pain Fruit", "Pain-Pain"},
                    {"Blizzard Fruit", "Blizzard-Blizzard"},
                    {"Gravity Fruit", "Gravity-Gravity"},
                    {"Mammoth Fruit", "Mammoth-Mammoth"},
                    {"T-Rex Fruit", "T-Rex-T-Rex"},
                    {"Dough Fruit", "Dough-Dough"},
                    {"Shadow Fruit", "Shadow-Shadow"},
                    {"Venom Fruit", "Venom-Venom"},
                    {"Gas Fruit", "Gas-Gas"},
                    {"Control Fruit", "Control-Control"},
                    {"Spirit Fruit", "Spirit-Spirit"},
                    {"Leopard Fruit", "Leopard-Leopard"},
                    {"Yeti Fruit", "Yeti-Yeti"},
                    {"Kitsune Fruit", "Kitsune-Kitsune"},
                    {"Dragon Fruit", "Dragon-Dragon"}
                }) do
                    local v1081 = v1080[1]
                    local v1082 = v1080[2]
                    local v1083 = l_Backpack_3:FindFirstChild(v1081) or v1077:FindFirstChild(v1081)
                    if v1083 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", v1082, v1083)
                        break
                    end
                end
            end)
        end
    end
end)
v491:AddToggle({
    Name = "Auto Drop Fruits",
    Description = "",
    Default = false,
    Callback = function(state)
        getgenv().AutoDropFruit = state
    end
})
spawn(function()
    while task.wait(0.5) do
        if getgenv().AutoDropFruit then
            pcall(function()
                local l_LocalPlayer = game:GetService("Players").LocalPlayer
                local char = l_LocalPlayer.Character
                if char then
                    for _, tool in pairs(char:GetChildren()) do
                        if tool:IsA("Tool") and string.find(tool.Name, "Fruit") then
                            game:GetService("ReplicatedStorage"):FindFirstChild("EatRemote", true):InvokeServer("Drop")
                        end
                    end
                end
                
                local backpack = l_LocalPlayer:FindFirstChild("Backpack")
                if backpack then
                    for _, tool in pairs(backpack:GetChildren()) do
                        if tool:IsA("Tool") and string.find(tool.Name, "Fruit") then
                            char.Humanoid:EquipTool(tool)
                            task.wait(0.1)
                            game:GetService("ReplicatedStorage"):FindFirstChild("EatRemote", true):InvokeServer("Drop")
                        end
                    end
                end
            end)
        end
    end
end)
v491:AddToggle({
    Name = "Teleport To Fruit Spawn",
    Description = "",
    Default = false,
    Callback = function(v1084)
        _G.Tweenfruit = v1084
        if v1084 then
            _G.Grabfruit = false
        end
    end
})
spawn(function()
    while wait(0.5) do
        if _G.Tweenfruit and not _G.AutoFarm and not _G.AutoFarmMastery and not _G.FarmBone and not _G.AutoNear and not _G.AutoBoss and not _G.AutoFarmMaterial and not _G.FarmCake and not _G.AutoFarmLevelNew and not _G.FarmBlazeEM and not _G.AutoElitehunter and not _G.KillGolem and not _G.DefendVolcano and not _G.FarmSummer and not _G.BossPain and not _G.RipIndraKill and not _G.Fullykatakuri and not _G.FarmChocola and not _G.AutoDooHee then
            pcall(function()
                for _, v1086 in pairs(game.Workspace:GetChildren()) do
                    if _G.Tweenfruit and not _G.AutoFarm and not _G.AutoFarmMastery and not _G.FarmBone and not _G.AutoNear and not _G.AutoBoss and not _G.AutoFarmMaterial and not _G.FarmCake and not _G.AutoFarmLevelNew and not _G.FarmBlazeEM and not _G.AutoElitehunter and not _G.KillGolem and not _G.DefendVolcano and not _G.FarmSummer and not _G.BossPain and not _G.RipIndraKill and not _G.Fullykatakuri and not _G.FarmChocola and not _G.AutoDooHee and v1086:FindFirstChild("Handle") and string.find(v1086.Name, "Fruit") then
                        _G.GrabbedFruits = _G.GrabbedFruits or setmetatable({}, {__mode = "k"})
                        local attempts = _G.GrabbedFruits[v1086] or 0
                        if attempts < 3 then
                            _G.GrabbedFruits[v1086] = attempts + 1
                            topos(v1086.Handle.CFrame * CFrame.new(0, -2, 0))
                            task.wait(1)
                            if v1086 and v1086.Parent and v1086:FindFirstChild("Handle") then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v1086.Handle.CFrame * CFrame.new(0, -2, 0)
                                task.wait(0.5)
                                pcall(function()
                                    if firetouchinterest then
                                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v1086.Handle, 0)
                                        task.wait(0.1)
                                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v1086.Handle, 1)
                                    end
                                end)
                            end
                        end
                    end
                end
            end)
        end
    end
end)
v491:AddToggle({
    Name = "Auto Teleport Fruits",
    Description = "",
    Default = false,
    Callback = function(v1087)
        _G.Grabfruit = v1087
        if v1087 then
            _G.Tweenfruit = false
        end
    end
})
spawn(function()
    while wait(0.5) do
        if _G.Grabfruit and not _G.AutoFarm and not _G.AutoFarmMastery and not _G.FarmBone and not _G.AutoNear and not _G.AutoBoss and not _G.AutoFarmMaterial and not _G.FarmCake and not _G.AutoFarmLevelNew and not _G.FarmBlazeEM and not _G.AutoElitehunter and not _G.KillGolem and not _G.DefendVolcano and not _G.FarmSummer and not _G.BossPain and not _G.RipIndraKill and not _G.Fullykatakuri and not _G.FarmChocola and not _G.AutoDooHee then
            pcall(function()
                for _, v1089 in pairs(game.Workspace:GetChildren()) do
                    if _G.Grabfruit and not _G.AutoFarm and not _G.AutoFarmMastery and not _G.FarmBone and not _G.AutoNear and not _G.AutoBoss and not _G.AutoFarmMaterial and not _G.FarmCake and not _G.AutoFarmLevelNew and not _G.FarmBlazeEM and not _G.AutoElitehunter and not _G.KillGolem and not _G.DefendVolcano and not _G.FarmSummer and not _G.BossPain and not _G.RipIndraKill and not _G.Fullykatakuri and not _G.FarmChocola and not _G.AutoDooHee and v1089:FindFirstChild("Handle") and string.find(v1089.Name, "Fruit") then
                        _G.GrabbedFruits = _G.GrabbedFruits or setmetatable({}, {__mode = "k"})
                        local attempts = _G.GrabbedFruits[v1089] or 0
                        if attempts < 3 then
                            _G.GrabbedFruits[v1089] = attempts + 1
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v1089.Handle.CFrame * CFrame.new(0, -2, 0)
                            task.wait(0.5)
                            pcall(function()
                                if firetouchinterest then
                                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v1089.Handle, 0)
                                    task.wait(0.1)
                                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v1089.Handle, 1)
                                end
                            end)
                        end
                    end
                end
            end)
        end
    end
end)
        v491:AddButton({
            Name = "Open Fruit Shop",
            Callback = function()
                pcall(function()
                    require(game:GetService("Players").LocalPlayer.PlayerGui.Main.UIController.FruitShop):Open("FruitDealer")
                end)
            end
        })
        v491:AddButton({
            Name = "Open Mirage Shop",
            Callback = function()
                pcall(function()
                    require(game:GetService("Players").LocalPlayer.PlayerGui.Main.UIController.FruitShop):Open("AdvancedFruitDealer")
                end)
            end
        })
        local _ = v491:AddSection({" Check Stock Fruits "})
local function v1096(v1091)
    local v1092 = tostring(v1091)
    repeat
        local v1093 = nil
        local v1094, v1095 = v1092.gsub(v1092, "^(-?%d+)(%d%d%d)", "%1,%2")
        v1093 = v1095
        v1092 = v1094
    until v1093 == 0
    return v1092
end
l_CommF__1 = game:GetService("ReplicatedStorage").Remotes.CommF_
local function v1111()
    local v1098 = "Advance Fruit Stock\n"
    local l_status_2, l_result_2 = pcall(function()
        return l_CommF__1:InvokeServer("GetFruits", true)
    end)
    if not l_status_2 or not l_result_2 then
        v1098 = v1098 .. "-       khi   d    li   u.\n"
    else
        local v1101 = false
        for _, v1103 in pairs(l_result_2) do
            if v1103.OnSale then
                v1101 = true
                local v1104 = v1096(v1103.Price)
                v1098 = v1098 .. v1103.Name .. " - $" .. v1104 .. "\n"
            end
        end
        if not v1101 then
            v1098 = v1098 .. "- Kh  ng c   tr  i  .\n"
        end
    end
    v1098 = v1098 .. "\nNormal Fruit Stock\n"
    local l_status_3, l_result_3 = pcall(function()
        return l_CommF__1:InvokeServer("GetFruits")
    end)
    if l_status_3 and l_result_3 then
        local v1107 = false
        for _, v1109 in pairs(l_result_3) do
            if v1109.OnSale then
                v1107 = true
                local v1110 = v1096(v1109.Price)
                v1098 = v1098 .. v1109.Name .. " - $" .. v1110 .. "\n"
            end
        end
        if not v1107 then
            v1098 = v1098 .. "- Kh  ng c   tr  i  .\n"
        end
    else
        v1098 = v1098 .. "-       khi   d    li   u.\n"
    end
    return v1098
end
v1112 = v491:AddParagraph({
    Title = "Stock",
    Content = "  ang   d    li   u..."
})
task.spawn(function()
    while task.wait(60) do
        pcall(function()
            v1112:Set(v1111())
        end)
    end
end)
pcall(function()
    v1112:Set(v1111())
end)

if World1 then
    v491:AddParagraph({
        Title = "Raids only works in Sea 2 and 3",
        Content = "This only works in Sea 2 and 3"
    })
else

_ = v491:AddSection({" Raid Fruits "})

-- =========================
-- SELECT CHIP
-- =========================
_G.SelectChip = "Flame"
_G.AutoBuyChip = false
_G.StartRaid = false
_G.Dungeon = false

v491:AddDropdown({
    Name = "Select Chip",
    Options = {
        "Flame","Ice","Sand","Dark","Light","Magma",
        "Quake","Buddha","Spider","Phoenix","Lightning","Dough"
    },
    Default = "Flame",
    Callback = function(v)
        _G.SelectChip = v
    end
})

-- =========================
-- AUTO BUY CHIP
-- =========================
v491:AddToggle({
    Name = "Auto Buy Chip",
    Default = false,
    Callback = function(v)
        _G.AutoBuyChip = v
    end
})

task.spawn(function()
    while task.wait(1) do
        if _G.AutoBuyChip and _G.SelectChip then
            local lp = game.Players.LocalPlayer
            local hasChip = lp.Backpack:FindFirstChild("Special Microchip") or lp.Character:FindFirstChild("Special Microchip")
            if not hasChip then
                pcall(function()
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer(
                        "RaidsNpc",
                        "Select",
                        _G.SelectChip
                    )
                end)
            end
        end
    end
end)

-- =========================
-- AUTO START RAID
-- =========================
v491:AddToggle({
    Name = "Auto Start Raid",
    Default = false,
    Callback = function(v)
        _G.StartRaid = v
    end
})

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if not _G.StartRaid then return end

            local lp = game.Players.LocalPlayer
            local gui = lp.PlayerGui:FindFirstChild("Main")
            if not gui then return end

            if gui.Timer.Visible then return end
            if workspace._WorldOrigin.Locations:FindFirstChild("Island 1") then return end
            if not (lp.Backpack:FindFirstChild("Special Microchip") or lp.Character:FindFirstChild("Special Microchip")) then return end

            if World2 then
                topos(CFrame.new(-6438.73, 250.64, -4501.5))
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                fireclickdetector(workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
            elseif World3 then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer(
                    "requestEntrance",
                    Vector3.new(-5075.5, 314.51, -3150.02)
                )
                topos(CFrame.new(-5017.4, 314.84, -2823.01))
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                fireclickdetector(workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
            end
        end)
    end
end)

-- =========================
-- AUTO FARM RAID NEXT ISLAND
-- =========================
v491:AddToggle({
    Name = "Auto Farm Raid Next Island",
    Default = false,
    Callback = function(v)
        _G.Dungeon = v
    end
})

local function GetIsland(num)
    local closest, dist = nil, math.huge
    for _,v in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
        if v.Name == "Island "..num then
            local mag = (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if mag < dist then
                dist = mag
                closest = v
            end
        end
    end
    return closest
end

local function GetNextIsland()
    for _,i in ipairs({5,4,3,2,1}) do
        local isl = GetIsland(i)
        if isl and (isl.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4500 then
            return isl
        end
    end
end

local function FarmRaidEnemies()
    for _,mob in pairs(workspace.Enemies:GetChildren()) do
        if mob:FindFirstChild("HumanoidRootPart")
        and mob:FindFirstChild("Humanoid")
        and mob.Humanoid.Health > 0
        and (mob.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
            repeat
                task.wait(0.1)
                if mob.Humanoid.Health > 0 then
                    EquipWeapon(_G.SelectWeapon)
                    topos(mob.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                end
            until mob.Humanoid.Health <= 0 or not _G.Dungeon
        end
    end
end

task.spawn(function()
    while task.wait() do
        if _G.Dungeon then
            FarmRaidEnemies()
            local isl = GetNextIsland()
            if isl then
                topos(isl.CFrame * CFrame.new(0,60,0))
            end
        end
    end
end)

_ = v491:AddSection({" Fruit Awakening "})
v491:AddToggle({
    Name = "Auto Awakening",
    Default = false,
    Callback = function(v)
        _G.Auto_Awakener = v
        StopTween(_G.Auto_Awakener)
    end
})

task.spawn(function()
    while task.wait(1) do
        if _G.Auto_Awakener then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener", "Check")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener", "Awaken")
            end)
        end
    end
end)

end

if not World2 then
    v491:AddParagraph({
        Title = "Raid Law Only Sea 2",
        Content = ""
    })
else

_ = v491:AddSection({" Raid Law Sea 2 "})
v491:AddButton({
    Name = "Auto Buy Chip Law",
    Callback = function()
        local lp = game.Players.LocalPlayer
        local hasChip = lp.Backpack:FindFirstChild("Microchip") or lp.Character:FindFirstChild("Microchip") or lp.Backpack:FindFirstChild("Special Microchip") or lp.Character:FindFirstChild("Special Microchip")
        if not hasChip then
            local v1069 = {[1] = "BlackbeardReward", [2] = "Microchip", [3] = "2"}
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1069))
        end
    end
})
v491:AddButton({
    Name = "Auto Start Raid Law",
    Callback = function()
        fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
    end
})
v491:AddToggle({
    Name = "Auto Farm Law Raid",
    Description = "",
    Default = false,
    Callback = function(v1070)
        _G.AutoLawRaid = v1070
    end
})
spawn(function()
    while wait() do
        if _G.AutoLawRaid then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("Order") then
                    for _, v1072 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v1072.Name == "Order" and v1072:FindFirstChild("Humanoid") and v1072:FindFirstChild("HumanoidRootPart") and v1072.Humanoid.Health > 0 then
                            repeat
                                task.wait()
                                AutoHaki()
                                EquipWeapon(_G.SelectWeapon)
                                v1072.HumanoidRootPart.CanCollide = false
                                v1072.Humanoid.WalkSpeed = 0
                                topos(v1072.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmHeight or 10, 0))
                                sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                            until not _G.AutoLawRaid or not v1072.Parent or v1072.Humanoid.Health <= 0
                        end
                    end
                else
                    NeedAttacking = true
                    if game:GetService("ReplicatedStorage"):FindFirstChild("Order") then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild("Order").HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
                    end
                end
            end)
        end
    end
end)
end
_ = v493:AddSection({" Teleport Island "})
local function v1116(v1114)
    pcall(function()
        if type(topos) == "function" then
            topos(v1114)
        else
            local l_LocalPlayer_17 = game:GetService("Players").LocalPlayer
            if l_LocalPlayer_17 and l_LocalPlayer_17.Character and l_LocalPlayer_17.Character:FindFirstChild("HumanoidRootPart") then
                l_LocalPlayer_17.Character.HumanoidRootPart.CFrame = v1114
            end
        end
    end)
end
v1117 = nil
if not World1 then
    if World2 then
        v1117 = {
            "The Cafe",
            "Frist Spot",
            "Dark Area",
            "Flamingo Mansion",
            "Flamingo Room",
            "Green Zone",
            "Factory",
            "Colossuim",
            "Zombie Island",
            "Two Snow Mountain",
            "Punk Hazard",
            "Cursed Ship",
            "Ice Castle",
            "Forgotten Island",
            "Ussop Island",
            "Mini Sky Island"
        }
    elseif World3 then
        v1117 = {
            "Mansion",
            "Port Town",
            "Great Tree",
            "Castle On The Sea",
            "MiniSky",
            "Hydra Island",
            "Floating Turtle",
            "Haunted Castle",
            "Ice Cream Island",
            "Peanut Island",
            "Cake Island",
            "Cocoa Island",
            "Candy Island",
            "Tiki Outpost"
        }
    else
        v1117 = {"Spawn"}
    end
else
    v1117 = {
        "WindMill",
        "Marine",
        "Middle Town",
        "Jungle",
        "Pirate Village",
        "Desert",
        "Snow Island",
        "MarineFord",
        "Colosseum",
        "Sky Island 1",
        "Sky Island 2",
        "Sky Island 3",
        "Prison",
        "Magma Village",
        "Under Water Island",
        "Fountain City",
        "Shank Room",
        "Mob Island"
    }
end
v493:AddDropdown({
    Name = "Select Island",
    Description = "",
    Options = v1117,
    Default = v1117[1],
    Callback = function(v1118)
        _G.SelectIsland = v1118
    end
})
local TeleportIslandToggle
TeleportIslandToggle = v493:AddToggle({
    Name = "Auto Tween To Island",
    Description = "",
    Default = false,
    Callback = function(v)
        _G.TeleportIsland = v
        StopTween(_G.TeleportIsland)
    end
})

MansionCFrame = CFrame.new(-12471.17, 374.94, -7551.678)

Islands = {
    ["WindMill"] = CFrame.new(979.799, 16.516, 1429.047),
    ["Marine"] = CFrame.new(-2566.43, 6.856, 2045.256),
    ["Middle Town"] = CFrame.new(-690.331, 15.094, 1582.238),
    ["Jungle"] = CFrame.new(-1612.796, 36.852, 149.128),
    ["Pirate Village"] = CFrame.new(-1181.309, 4.751, 3803.546),
    ["Desert"] = CFrame.new(944.158, 20.92, 4373.3),
    ["Snow Island"] = CFrame.new(1347.807, 104.668, -1319.737),
    ["MarineFord"] = CFrame.new(-4914.821, 50.964, 4281.028),
    ["Magma Village"] = CFrame.new(-5247.716, 12.884, 8504.969),
    ["Fountain City"] = CFrame.new(5127.128, 59.501, 4105.446),
    ["Sky Island 1"] = CFrame.new(-483.734, 332.038, 595.327),
    ["Sky Island 2"] = CFrame.new(2284.414, 15.152, 875.725),
    ["Sky Island 3"] = CFrame.new(-2448.53, 73.016, -3210.631),
    ["Prison"] = CFrame.new(4875.33, 5.652, 734.85),
    ["Colosseum"] = CFrame.new(-11.311, 29.277, 2771.522),
    ["Under Water Island"] = CFrame.new(-2850.201, 7.392, 5354.993),
    ["Shank Room"] = CFrame.new(-1442.166, 29.879, -28.355),
    ["Mob Island"] = CFrame.new(-2850.201, 7.392, 5354.993),
    ["The Cafe"] = CFrame.new(-380.479, 77.22, 255.826),
    ["Dark Area"] = CFrame.new(3780.03, 22.652, -3498.586),
    ["Factory"] = CFrame.new(424.127, 211.162, -427.54),
    ["Colossuim"] = CFrame.new(-1503.622, 219.796, 1369.31),
    ["Two Snow Mountain"] = CFrame.new(753.143, 408.236, -5274.615),
    ["Punk Hazard"] = CFrame.new(-6127.654, 15.952, -5040.286),
    ["Ussop Island"] = CFrame.new(4816.862, 8.46, 2863.82),
    ["Mini Sky Island"] = CFrame.new(-288.741, 49326.316, -35248.594),
    ["Great Tree"] = CFrame.new(2681.274, 1682.809, -7190.985),
    ["Port Town"] = CFrame.new(-226.751, 20.603, 5538.34),
    ["Hydra Island"] = CFrame.new(5291.249, 1005.443, 393.762),
    ["Floating Turtle"] = CFrame.new(-13274.528, 531.821, -7579.223),
    ["Mansion"] = MansionCFrame,
    ["Castle On The Sea"] = CFrame.new(-5083.26, 314.606, -3175.673),
    ["Haunted Castle"] = CFrame.new(-9515.372, 164.006, 5786.061),
    ["Ice Cream Island"] = CFrame.new(-902.568, 79.932, -10988.848),
    ["Peanut Island"] = CFrame.new(-2062.748, 50.474, -10232.568),
    ["Cake Island"] = CFrame.new(-1884.775, 19.328, -11666.897),
    ["Cocoa Island"] = CFrame.new(87.943, 73.555, -12319.465),
    ["Candy Island"] = CFrame.new(-1014.424, 149.111, -14555.963),
    ["Tiki Outpost"] = CFrame.new(-16218.683, 9.086, 445.618),
}

local function TryPortal(position)
    local success = pcall(function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", position)
    end)
    return success
end

local function TeleportToIsland()
    if not _G.SelectIsland or not _G.TeleportIsland then return end

    local cf = Islands[_G.SelectIsland]
    if not cf then return end

    local character = game.Players.LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    local myPos = character.HumanoidRootPart.Position
    local targetPos = cf.Position
    local castlePos = Vector3.new(-5083.26, 314.606, -3175.673)
    local mansionPos = Vector3.new(-12471.17, 374.94, -7551.678)

    local directDist = (targetPos - myPos).Magnitude
    local distViaCastle = (targetPos - castlePos).Magnitude
    local distViaMansion = (targetPos - mansionPos).Magnitude

    -- Check if we are in Third Sea (where portals exist)
    local isThirdSea = (targetPos.X < -1000 or targetPos.Z < -1000) and (myPos.X < -1000 or myPos.Z < -1000)

    if isThirdSea and directDist > 3000 then
        -- Choose the best portal to bypass distance
        if distViaMansion < directDist - 1000 and distViaMansion < distViaCastle then
            local oldPos = character.HumanoidRootPart.Position
            TryPortal(mansionPos)
            task.wait(0.5)
            character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local newPos = character.HumanoidRootPart.Position
                if (newPos - oldPos).Magnitude > 100 then
                    myPos = newPos
                    directDist = (targetPos - myPos).Magnitude
                end
            end
        elseif distViaCastle < directDist - 1000 then
            local oldPos = character.HumanoidRootPart.Position
            TryPortal(castlePos)
            task.wait(0.5)
            character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local newPos = character.HumanoidRootPart.Position
                if (newPos - oldPos).Magnitude > 100 then
                    myPos = newPos
                    directDist = (targetPos - myPos).Magnitude
                end
            end
        end
    end

    if _G.SelectIsland == "Mansion" then
        local oldPos = character.HumanoidRootPart.Position
        TryPortal(Vector3.new(cf.X, cf.Y, cf.Z))
        task.wait(0.5)
        character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local newPos = character.HumanoidRootPart.Position
            if (newPos - oldPos).Magnitude < 10 then
                -- Portal failed, fall back to tweening
                v1116(cf)
            end
        end
        return
    end

    if _G.SelectIsland == "Castle On The Sea" then
        local oldPos = character.HumanoidRootPart.Position
        TryPortal(Vector3.new(-5083.26, 314.606, -3175.673))
        task.wait(0.5)
        character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local newPos = character.HumanoidRootPart.Position
            if (newPos - oldPos).Magnitude < 10 then
                -- Portal failed, fall back to tweening
                v1116(cf)
            end
        end
        return
    end

    v1116(cf)
end

task.spawn(function()
    while task.wait(0.5) do
        if _G.TeleportIsland then
            TeleportToIsland()
            local cf = Islands[_G.SelectIsland]
            if cf then
                local character = game.Players.LocalPlayer.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local dist = (character.HumanoidRootPart.Position - cf.Position).Magnitude
                    local distMansion = (character.HumanoidRootPart.Position - MansionCFrame.Position).Magnitude
                    if dist <= 50 or distMansion <= 50 then
                        _G.TeleportIsland = false
                        if TeleportIslandToggle then
                            TeleportIslandToggle:Set(false)
                        end
                    end
                end
            end
        end
    end
end)
_ = v493:AddSection({" Teleport Sea "})
v493:AddButton({
    Name = "Sea 1",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
    end
})
v493:AddButton({
    Name = "Sea 2",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
    end
})
v493:AddButton({
    Name = "Sea 3",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
    end
})

v484:AddSection({"Status"})

ServerUptime = v484:AddParagraph({
    Title = "Server Uptime",
    Desc = "Loading..."
})
task.spawn(function()
    while task.wait(1) do
        local timeInSeconds = math.floor(workspace.DistributedGameTime)
        local hours = math.floor(timeInSeconds / 3600)
        local minutes = math.floor((timeInSeconds % 3600) / 60)
        local seconds = timeInSeconds % 60
        ServerUptime:SetDesc(string.format("Uptime: %02d:%02d:%02d", hours, minutes, seconds))
    end
end)

LeviathanStatus = v484:AddParagraph({
    Title = "Leviathan",
    Desc = "Status: Loading..."
})
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
                LeviathanStatus:SetDesc("Status : ✅️ Spawning")
            else
                LeviathanStatus:SetDesc("Status : ❌️ Not Spawned")
            end
        end)
    end
end)

TyrantStatus = v484:AddParagraph({
    Title = "Tyrant of the Skies",
    Desc = "Status: "
})
spawn(function()
    pcall(function()
        while wait() do
            if game:GetService("Workspace").Enemies:FindFirstChild("Tyrant of the Skies") then
                TyrantStatus:SetDesc("Status : ✅️")
            else
                TyrantStatus:SetDesc("Status : ❌️")
            end
        end
    end)
end)
CheckRip = v484:AddParagraph({
    Title = "Rip_Indra",
    Desc = "Status: "
})
spawn(function()
    while wait() do
        pcall(function()
            if game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form") 
            or game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") then
                CheckRip:SetDesc("Status : ✅️")
            else
                CheckRip:SetDesc("Status : ❌️")
            end
        end)
    end
end)
CheckDoughKing = v484:AddParagraph({
    Title = "Dough King",
    Desc = "Status: "
})
spawn(function()
    while wait() do
        pcall(function()
            if game:GetService("ReplicatedStorage"):FindFirstChild("Dough King") 
            or game:GetService("Workspace").Enemies:FindFirstChild("Dough King") then
                CheckDoughKing:SetDesc("Status : ✅️")
            else
                CheckDoughKing:SetDesc("Status : ❌️")
            end
        end)
    end
end)
EliteHunter = v484:AddParagraph({
    Title = "Elite Hunter",
    Desc = "Status: "
})
spawn(function()
    while wait() do
        pcall(function()
            local rs = game:GetService("ReplicatedStorage")
            local ws = game:GetService("Workspace").Enemies
            local progress = rs.Remotes.CommF_:InvokeServer("EliteHunter", "Progress")
            if rs:FindFirstChild("Diablo") or rs:FindFirstChild("Deandre") or rs:FindFirstChild("Urban")
            or ws:FindFirstChild("Diablo") or ws:FindFirstChild("Deandre") or ws:FindFirstChild("Urban") then
                EliteHunter:SetDesc("Status : ✅️ | Killed: " .. progress)
            else
                EliteHunter:SetDesc("Status : ❌️ | Killed: " .. progress)
            end
        end)
    end
end)
Pullever = v484:AddParagraph({
    Title = "Pull Lever",
    Desc = "Status: "
})
spawn(function()
    while wait() do
        pcall(function()
            if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CheckTempleDoor") then
                Pullever:SetDesc("✅")
            else
                Pullever:SetDesc("❌")
            end
        end)
    end
end)
FM = v484:AddParagraph({
    Title = "Full Moon",
    Desc = ""
})
spawn(function()
    while wait() do
        pcall(function()
            local moonId = game:GetService("Lighting").Sky.MoonTextureId
            if moonId == "http://www.roblox.com/asset/?id=9709149431" then
                FM:SetDesc("Moon: 5/5")
            elseif moonId == "http://www.roblox.com/asset/?id=9709149052" then
                FM:SetDesc("Moon: 4/5")
            elseif moonId == "http://www.roblox.com/asset/?id=9709143733" then
                FM:SetDesc("Moon: 3/5")
            elseif moonId == "http://www.roblox.com/asset/?id=9709150401" then
                FM:SetDesc("Moon: 2/5")
            elseif moonId == "http://www.roblox.com/asset/?id=9709149680" then
                FM:SetDesc("Moon: 1/5")
            else
                FM:SetDesc("Moon: 0/5")
            end
        end)
    end
end)
LegendarySword = v484:AddParagraph({
    Title = "Legendary Sword",
    Desc = "Status: "
})
spawn(function()
    pcall(function()
        while wait() do
            local rs = game:GetService("ReplicatedStorage").Remotes.CommF_   
            if rs:InvokeServer("LegendarySwordDealer", "1") then
                LegendarySword:SetDesc("Shisui")
            elseif rs:InvokeServer("LegendarySwordDealer", "2") then
                LegendarySword:SetDesc("Wando")
            elseif rs:InvokeServer("LegendarySwordDealer", "3") then
                LegendarySword:SetDesc("Saddi")
            else
                LegendarySword:SetDesc("Not Found Legend Swords")
            end
        end
    end)
end)
Bone = v484:AddParagraph({
    Title = "Bone",
    Desc = ""
})
spawn(function()
    pcall(function()
        while wait() do
            local bones = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check")
            Bone:SetDesc("You Have : " .. tostring(bones) .. " Bones")
        end
    end)
end)


-- // AUTO STATS SYSTEM
Replicated = game:GetService("ReplicatedStorage")
CommF = Replicated:WaitForChild("Remotes"):WaitForChild("CommF_")

AutoStats = false
PointsPerTick = 1

StatsSelect = {
    Melee = false,
    Defense = false,
    Sword = false,
    Gun = false,
    BloxFruit = false,
}

local function AddPoint(Stat, Amount)
    pcall(function()
        CommF:InvokeServer("AddPoint", Stat, Amount, false)
    end)
end

local function DistributePoints()
    while AutoStats do
        task.wait(0.4)

        local player = game.Players.LocalPlayer
        local statsFolder = player:FindFirstChild("Data")
        if statsFolder then
            local points = statsFolder:FindFirstChild("Points")
            if points and points.Value > 0 then
                -- Ver quantos Stats estÃ£o ativos
                local EnabledStats = {}
                for stat, enabled in pairs(StatsSelect) do
                    if enabled then
                        table.insert(EnabledStats, stat)
                    end
                end
                
                if #EnabledStats > 0 then
                    local amountEach = math.floor(PointsPerTick / #EnabledStats)
                    if amountEach < 1 then amountEach = 1 end
                    
                    for _, stat in ipairs(EnabledStats) do
                        AddPoint(stat, amountEach)
                    end
                end
            end
        end
    end
end

-- UI
v497:AddSlider({
    Name = "Points Amount",
    Min = 1,
    Max = 500,
    Increase = 1,
    Default = 1,
    Callback = function(v)
        PointsPerTick = v
    end
})

v497:AddToggle({
    Name = "Auto Status",
    Default = false,
    Callback = function(v)
        AutoStats = v
        if v then
            task.spawn(DistributePoints)
        end
    end
})

Section = v497:AddSection({" Select Status "})

v497:AddToggle({
    Name = "Melee",
    Default = false,
    Callback = function(v)
        StatsSelect.Melee = v
    end
})

v497:AddToggle({
    Name = "Defense",
    Default = false,
    Callback = function(v)
        StatsSelect.Defense = v
    end
})

v497:AddToggle({
    Name = "Sword",
    Default = false,
    Callback = function(v)
        StatsSelect.Sword = v
    end
})

v497:AddToggle({
    Name = "Gun",
    Default = false,
    Callback = function(v)
        StatsSelect.Gun = v
    end
})

v497:AddToggle({
    Name = "Fruit",
    Default = false,
    Callback = function(v)
        StatsSelect.BloxFruit = v
    end
})

     local Managers = {}
     Managers.EspManager = (function()
     local EspManager = {}
          EspManager.__index = EspManager
          EspManager.__newindex = function(self, index, value)
if index == "Enabled" then
task.spawn(self.ToggleEsp, self, value)
else
rawset(self, index, value)
end
end
local CoreGui
pcall(function()
    if gethui then
        CoreGui = gethui()
    else
        CoreGui = game:GetService("CoreGui")
    end
end)
if not CoreGui then
    CoreGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

local CoreGuiEspFolder = Instance.new("Folder", CoreGui) do  
		CoreGuiEspFolder.Name = "redzHub-EspFolder"  
		  
		local _EspFolder = CoreGui:FindFirstChild(CoreGuiEspFolder.Name)  
		  
		if _EspFolder and _EspFolder ~= CoreGuiEspFolder then  
			_EspFolder:Destroy()  
		end  
	end  
	  
	local EspTemplate = Instance.new("BoxHandleAdornment") do  
		local BoxHandleAdornment = EspTemplate  
		BoxHandleAdornment.Size = Vector3.new(1, 0, 1, 0)  
		BoxHandleAdornment.AlwaysOnTop = true  
		BoxHandleAdornment.ZIndex = 10  
		BoxHandleAdornment.Transparency = 0  
		  
		local BillboardGui = Instance.new("BillboardGui", BoxHandleAdornment)  
		BillboardGui.Size = UDim2.new(0, 100, 0, 150)  
		BillboardGui.StudsOffset = Vector3.new(0, 2, 0)  
		BillboardGui.AlwaysOnTop = true  
		  
		local TextLabel = Instance.new("TextLabel", BillboardGui)  
		TextLabel.BackgroundTransparency = 1  
		TextLabel.Position = UDim2.new(0, 0, 0, -50)  
		TextLabel.Size = UDim2.new(0, 100, 0, 100)  
		TextLabel.TextSize = 10  
		TextLabel.TextStrokeTransparency = 0  
		TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom  
		TextLabel.Text = "..."  
		TextLabel.ZIndex = 15  
		TextLabel.RichText = true  
	end  
	  
	local DefaultEspColor = Color3.fromRGB(255, 255, 255)  
	local HumHealth = "%s<font color='rgb(160, 160, 160)'> [ %im ]</font>\n<font color='rgb(25, 240, 25)'>[%i/%i]</font>"  
	local CreatedEsps = {}  
    EspManager.CreatedEsps = CreatedEsps  
	local function GetBasePart(Instance)  
		if Instance:IsA("BasePart") then  
			return Instance  
		elseif Instance:IsA("Model") then  
			return Instance.PrimaryPart or Instance:GetPivot()  
		elseif Instance.Parent:IsA("Model") then  
			return Instance.Parent.PrimaryPart or Instance.Parent:GetPivot()  
		end  
	end  
	  
	function EspManager:SetCustomEspDisplay(Action)  
		self.CustomEspDisplay = Action  
		return self  
	end  
	  
	function EspManager:SetObjects(Objects)  
		self.GetObjectsAction = Objects  
		return self  
	end  
	  
	function EspManager:GetInstance(Action)  
		self.OnlyOneInstanceAction = Action  
		return self  
	end  
	  
	function EspManager:SetInstanceName(Instance, Name)  
		self.EspsNames[Instance] = Name  
		return self  
	end  
	  
	function EspManager:SetAllInstancesName(Name)  
		self.CustomInstanceName = Name  
		return self  
	end  
	  
	function EspManager:WaitChildsAdded()  
		self._WaitChildsAdded = true  
		return self  
	end  
	  
	function EspManager:SetEspColor(Action)  
		self.EspColor = Action  
		return self  
	end  
	  
	function EspManager:SetAlwaysValidate()  
		self.AlwaysValidateInstance = true  
		return self  
	end  
	  
	function EspManager:Validator(Action)  
		self.ValidateInstance = Action  
		return self  
	end  
	  
	function EspManager:ChangeEspSize(Size)  
		self.EspSize = Size  
		  
		for i = 1, #CreatedEsps do  
			for _, Esp in pairs(CreatedEsps[i].EspObjects) do  
				Esp.BoxHandleAdornment.BillboardGui.TextLabel.TextSize = Size  
			end  
		end  
		  
		return self  
	end  
	  
	function EspManager:StartRunningEsp(Esp)  
		local Instance = Esp.Instance  
		local BoxHandleAdornment = Esp.BoxHandleAdornment  
		local TextLabel = BoxHandleAdornment.BillboardGui.TextLabel  
		local Folder = self.EspFolder  
		local IsModel = Instance:IsA("Model")  
		local CachedBasePart = nil  
		  
		while task.wait(Settings.SmoothMode and 0.25 or 0) do  
			if not BoxHandleAdornment or not BoxHandleAdornment.Parent then  
				return self:Clear(Esp)  
			elseif self.AlwaysValidateInstance and not self.ValidateInstance(Instance) then  
				return self:Clear(Esp)  
			elseif not Instance:IsDescendantOf(workspace) and not Instance:IsDescendantOf(ReplicatedStorage) then  
				return self:Clear(Esp)  
			end  
			  
			CachedBasePart = CachedBasePart or GetBasePart(Instance)  
			  
			if not CachedBasePart then  
				return self:Clear(Esp)  
			end  
			  
			local Distance = math.floor((DistanceFromMyCharacter(CachedBasePart)) / 5)  
			local Humanoid = IsModel and Instance:FindFirstChildOfClass("Humanoid")  
			  
			if Humanoid then  
				TextLabel.Text = HumHealth:format(Instance.Name, Distance, math.floor(Humanoid.Health), math.floor(Humanoid.MaxHealth))  
			elseif self.CustomEspDisplay then  
				TextLabel.Text = self.CustomEspDisplay(Instance, Distance)  
			else  
				local Name = self.CustomInstanceName or self.EspsNames[Instance] or Instance.Name  
				TextLabel.Text = ("%s < %i >"):format(Name, Distance)  
			end  
		end  
	end  
	  
	function EspManager:Create(Instance)  
		if self.EspObjects[Instance] then return end  
		  
		local Esp = {  
			Instance = Instance,  
			BoxHandleAdornment = nil  
		}  
		  
		local BoxHandleAdornment = EspTemplate:Clone()  
		local BillboardGui = BoxHandleAdornment.BillboardGui  
		local TextLabel = BillboardGui.TextLabel  
		  
		BillboardGui.Adornee = (Instance:IsA("BasePart") or Instance:IsA("Model")) and Instance or Instance.Parent  
		TextLabel.TextColor3 = type(self.EspColor) == "function" and self.EspColor(Instance) or self.EspColor or DefaultEspColor  
		TextLabel.Text = self.CustomInstanceName or "..."  
		TextLabel.TextSize = self.EspSize or TextLabel.TextSize  
		BoxHandleAdornment.Parent = self.EspFolder  
		  
		self.EspObjects[Instance] = Esp  
		Esp.BoxHandleAdornment = BoxHandleAdornment  
		  
		task.spawn(self.StartRunningEsp, self, Esp)  
		  
		return Esp  
	end  
	  
	function EspManager:Clear(Esp)  
		if Esp then  
			self.EspObjects[Esp.Instance] = nil  
			if Esp.BoxHandleAdornment then Esp.BoxHandleAdornment:Destroy() end  
		else  
			table.clear(self.EspObjects)  
			self.EspFolder:ClearAllChildren()  
		end  
	end  
	  
	function EspManager:ToggleEsp(Value)  
		local Environment = "redzHub_Esp_" .. self.SpecialTag  
		_G[Environment] = Value  
  
		if not Value then  
			return self:Clear()  
		end  
  
		while _G[Environment] do  
			local ObjectsAction = self.GetObjectsAction  
	  
			if self.OnlyOneInstanceAction then  
				local Instance = self.OnlyOneInstanceAction()  
		  
				if Instance then  
					self:Create(Instance)  
				end  
		  
			elseif ObjectsAction then  
				local Instances  
		  
				if typeof(ObjectsAction) == "function" then
					Instances = ObjectsAction()
				elseif typeof(ObjectsAction) == "Instance" then
					Instances = ObjectsAction:GetChildren()
				else
					Instances = ObjectsAction
					end

				if type(Instances) ~= "table" then
					Instances = {}
				end
		  
				local Validate = self.ValidateInstance  
				local CreatedEsps = self.EspObjects  
				local CreatedNew = false  
		  
				for i = 1, #Instances do  
					local Instance = Instances[i]  
			  
					if not CreatedEsps[Instance] and (not Validate or Validate(Instance)) then  
						CreatedNew = true  
						self:Create(Instance)  
					end  
				end  
		  
				if not CreatedNew and self._WaitChildsAdded and typeof(ObjectsAction) == "Instance" then  
					ObjectsAction.ChildAdded:Wait()  
				end  
			end  
	  
			task.wait(0.25)  
		end  
	end  
	  
	function EspManager.new(Tag)  
		local EspFolder = Instance.new("Folder", CoreGuiEspFolder)  
		EspFolder.Name = Tag  
		  
		local self = setmetatable({  
			SpecialTag = Tag,  
			EspObjects = {},  
			EspsNames = {},  
			EspFolder = EspFolder  
		}, EspManager)  
		  
		table.insert(CreatedEsps, self)  
		  
		return self  
	end  
	  
	return EspManager  
end)()
local PlayerESP = Managers.EspManager.new("Players")

PlayerESP:SetObjects(function()
local PlayersTable = {}

for _,v in pairs(game:GetService("Players"):GetPlayers()) do  
	if v ~= Player and v.Character then  
		table.insert(PlayersTable, v.Character)  
	end  
end  

return PlayersTable

end)

PlayerESP:Validator(function(Character)
return Character
and Character:FindFirstChild("HumanoidRootPart")
and Character:FindFirstChildOfClass("Humanoid")
end)
local FruitESP = Managers.EspManager.new("Fruits")

local CachedFruits = {}

local function IsHeld(tool)
	local parent = tool.Parent
	return parent and parent:FindFirstChildOfClass("Humanoid") ~= nil
end

local function GetHandle(tool)
	local handle = tool:FindFirstChild("Handle")
	if handle and handle:IsA("BasePart") then
		return handle
	end

	if tool:IsA("Model") then
		return tool.PrimaryPart or tool:FindFirstChildWhichIsA("BasePart")
	end

	return nil
end

local function UpdateFruits()
	table.clear(CachedFruits)

	for _, v in pairs(workspace:GetChildren()) do
		if v:IsA("Tool") and v.Name:find("Fruit") then
			if not Players:GetPlayerFromCharacter(v.Parent) and not IsHeld(v) then
				local handle = GetHandle(v)
				if handle then
					table.insert(CachedFruits, v)
				end
			end
		end
	end
end

UpdateFruits()

workspace.ChildAdded:Connect(function(v)
	if v:IsA("Tool") and v.Name:find("Fruit") then
		task.wait(0.1)
		UpdateFruits()
	end
end)

workspace.ChildRemoved:Connect(function(v)
	if v:IsA("Tool") and v.Name:find("Fruit") then
		UpdateFruits()
	end
end)

FruitESP:SetObjects(function()
	return CachedFruits
end)

FruitESP:Validator(function(Fruit)
	if not Fruit or not Fruit.Parent then return false end
	if Players:GetPlayerFromCharacter(Fruit.Parent) then return false end
	if IsHeld(Fruit) then return false end

	return GetHandle(Fruit) ~= nil
end)

FruitESP:SetEspColor(Color3.fromRGB(200, 0, 0))

FruitESP:SetCustomEspDisplay(function(Fruit, Distance)
	local handle = GetHandle(Fruit)
	if not handle then return end

	local char = Players.LocalPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")

	if not hrp then
		return ("Fruit [ %s ] < ?m >"):format(Fruit.Name:gsub(" Fruit", ""))
	end

	local dist = (hrp.Position - handle.Position).Magnitude
	dist = math.floor(dist / 5)

	return ("Fruit [ %s ] < %im >"):format(Fruit.Name:gsub(" Fruit", ""), dist)
end)

local BerryESP = Managers.EspManager.new("Berries")

BerryESP:SetObjects(function()
	return CollectionService:GetTagged("BerryBush")
end)

BerryESP:SetAlwaysValidate()

BerryESP:Validator(function(Bush)
	if not Bush or not Bush.Parent then
		return false
	end

	local BerryName

	for _, Value in pairs(Bush:GetAttributes()) do
		if typeof(Value) == "string" and Value ~= "" then
			BerryName = Value
			break
		end
	end

	if not BerryName then
		return false
	end

	local Parent = Bush.Parent

	if not Parent then
		return false
	end

	for _, Child in ipairs(Parent:GetChildren()) do
		if Child:IsA("BasePart") then
			return true
		end
	end

	return false
end)

BerryESP:SetEspColor(function()
	return Color3.fromRGB(255,255,0)
end)

BerryESP:SetCustomEspDisplay(function(Bush, Distance)
	local BerryName = "Unknown"

	for _, Value in pairs(Bush:GetAttributes()) do
		if typeof(Value) == "string" and Value ~= "" then
			BerryName = Value
			break
		end
	end

	return string.format(
		"%s < %im >",
		BerryName,
		math.floor(Distance)
	)
end)

local ChestESP = Managers.EspManager.new("ChestESP")

ChestESP:SetObjects(function()
    return game:GetService("CollectionService"):GetTagged("_ChestTagged")
end)

ChestESP:Validator(function(Chest)
    return Chest and Chest.Parent and not Chest:GetAttribute("IsDisabled")
end)

ChestESP:SetEspColor(function(Chest)
    local Name = string.lower(Chest.Name)

    if Name:find("chest3") then
        return Color3.fromRGB(0, 255, 255)
    elseif Name:find("chest2") then
        return Color3.fromRGB(255, 255, 0)
    else
        return Color3.fromRGB(150, 150, 150)
    end
end)

ChestESP:SetCustomEspDisplay(function(Chest, Distance)
    local Name = Chest.Name

    if Name:find("Chest3") then
        Name = "Chest 3"
    elseif Name:find("Chest2") then
        Name = "Chest 2"
    else
        Name = "Chest 1"
    end

    return string.format("%s\n%d M", Name, Distance)
end)

local IslandsESP = Managers.EspManager.new("IslandsESP")

IslandsESP:SetObjects(function()
    return workspace._WorldOrigin.Locations:GetChildren()
end)

IslandsESP:SetEspColor(function()
    return Color3.fromRGB(0, 255, 255)
end)

IslandsESP:SetCustomEspDisplay(function(Island, Distance)
    return string.format("%s < %d >", Island.Name, Distance)
end)

local MyBoatESP = Managers.EspManager.new("MyBoatESP")

MyBoatESP:GetInstance(function()
    local Character = vu14.Character

    if Character and Character:FindFirstChild("Humanoid") then
        local SeatPart = Character.Humanoid.SeatPart

        if SeatPart and SeatPart.Name == "VehicleSeat" then
            return SeatPart.Parent
        end
    end

    for _, Boat in ipairs(vu23:GetChildren()) do
        local Owner = Boat:FindFirstChild("Owner")

        if Owner and Owner.Value and Owner.Value.Name == vu14.Name then
            return Boat
        end
    end
end)

MyBoatESP:Validator(function(Boat)
    return Boat
        and Boat.Parent
        and Boat:IsDescendantOf(vu23)
end)

MyBoatESP:SetEspColor(function()
    return Color3.fromRGB(160,160,0)
end)

MyBoatESP:SetCustomEspDisplay(function(Boat, Distance)
    local Health = Boat:FindFirstChild("Health")

    if not Health then
        for _, v in ipairs(Boat:GetDescendants()) do
            if v.Name == "Health" then
                Health = v
                break
            end
        end
    end

    if Health then
        return string.format(
            "<font color='rgb(160,160,0)'>My Boat [ %im ]</font>\n<font color='rgb(25,240,25)'>[%i/%i]</font>",
            Distance,
            math.floor(Health.Value),
            math.floor(Health:GetAttribute('MaxHealth') or Health.Value)
        )
    end

    return string.format(
        "<font color='rgb(160,160,0)'>My Boat [ %im ]</font>",
        Distance
    )
end)

local LSDESP = Managers.EspManager.new("LegendarySwordDealerESP")

LSDESP:SetObjects(function()
    return workspace.NPCs:GetChildren()
end)

LSDESP:Validator(function(NPC)
    return NPC
        and NPC.Parent
        and NPC.Name == "Legendary Sword Dealer"
end)

LSDESP:SetEspColor(function()
    return Color3.fromRGB(80, 245, 245)
end)

LSDESP:SetCustomEspDisplay(function(NPC, Distance)
    return string.format(
        "%s\n%d M",
        NPC.Name,
        Distance
    )
end)


getgenv().KitsuneManager = Managers.EspManager.new("KitsuneIslandESP")
getgenv().KitsuneManager:SetObjects(function()
    return game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()
end)
getgenv().KitsuneManager:Validator(function(Island)
    return Island.Name == "Kitsune Island"
end)
getgenv().KitsuneManager:SetEspColor(Color3.fromRGB(80, 245, 245))
getgenv().KitsuneManager:SetCustomEspDisplay(function(Island, Distance)
    return Island.Name .. "   \n" .. Distance .. " M"
end)

getgenv().MirageManager = Managers.EspManager.new("MirageIslandESP")
getgenv().MirageManager:SetObjects(function()
    return game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()
end)
getgenv().MirageManager:Validator(function(Island)
    return Island.Name == "Mirage Island"
end)
getgenv().MirageManager:SetEspColor(Color3.fromRGB(80, 245, 245))
getgenv().MirageManager:SetCustomEspDisplay(function(Island, Distance)
    return Island.Name .. "   \n" .. Distance .. " M"
end)
local FlowerESPManager = Managers.EspManager.new("FlowerESP")

FlowerESPManager:SetObjects(function()
    local Flowers = {}

    for _, v in pairs(workspace:GetChildren()) do
        if v.Name == "Flower1" or v.Name == "Flower2" then
            table.insert(Flowers, v)
        end
    end

    return Flowers
end)

FlowerESPManager:SetEspColor(function(Flower)
    if Flower.Name == "Flower1" then
        return Color3.fromRGB(0, 0, 255)
    elseif Flower.Name == "Flower2" then
        return Color3.fromRGB(255, 0, 0)
    end
    return Color3.fromRGB(255, 255, 255)
end)


v494:AddSection({"ESP"})
v494:AddSlider({
	Name = "ESP Size",
	Flag = "S-EspSize",
	Min = 7,
	Max = 15,
	Default = 10,
	Increment = 1,
	Callback = function(v)
		for i = 1, #Managers.EspManager.CreatedEsps do
			Managers.EspManager.CreatedEsps[i]:ChangeEspSize(v)
		end
	end
})
if World2 then
v494:AddToggle({

    Description = "Display Flowers",
    Flag = "S-ESPFlowers",
    Default = false,
    Callback = function(v)
        FlowerESPManager.Enabled = v
    end
})

v494:AddToggle({
    Name = "ESP Legendary Sword Dealer",
    Description = "Display Legendary Sword Dealer",
    Flag = "S-ESPLSD",
    Default = false,
    Callback = function(v)
        LSDESP.Enabled = v
    end
})
end

v494:AddToggle({
    Name = "ESP My Boat",
    Description = "Display my boat on the Map",
    Flag = "M-EspMyBoat",
    Default = false,
    Callback = function(v)
        MyBoatESP.Enabled = v
    end
})

v494:AddToggle({
  Name = "ESP Players",
  Description = "Display Players on the Map",
  Flag = "B-EspPlayers",
  Default = false,
  Callback = function(v)
      PlayerESP.Enabled = v
  end
})

v494:AddToggle({
	Name = "ESP Fruits",
    Description = "Display Fruits on the Map",
	Flag = "S-ESPfruits",
	Default = false,
	Callback = function(v)
		FruitESP.Enabled = v
	end
})

v494:AddToggle({
	Name = "ESP Berry",
	Description = "Display Berries Ready to Collect",
	Flag = "Flag3",
	Default = false,
	Callback = function(v)
		BerryESP.Enabled = v
	end
})

v494:AddToggle({
    Name = "ESP Chests",
    Description = "Display Chests on the Map",
    Flag = "S-ESPChest",
    Default = false,
    Callback = function(v)
        ChestESP.Enabled = v
    end
})

v494:AddToggle({
    Name = "ESP Islands",
    Description = "Display Islands on the Map",
    Flag = "S-ESPislands",
    Default = false,
    Callback = function(v)
        IslandsESP.Enabled = v
    end
})

v494:AddSection({"Aim"})

v494:AddToggle({
    Name = "Aim Gun",
    Default = false,
    Callback = function(v)
        _ENV.AimBot_Gun = v
    end
})

v494:AddToggle({
    Name = "Aim Tap",
    Default = false,
    Callback = function(v)
        _ENV.AimBot_Tap = v
    end
})

v494:AddToggle({
    Name = "Aim Skills",
    Default = false,
    Callback = function(v)
        _ENV.AimBot_Skills = v
    end
})

v494:AddToggle({
    Name = "Ignore Mobs",
    Default = true,
    Callback = function(v)
        Settings.NoAimMobs = v
    end
})

    v494:AddSection({"Visual"})
v494:AddButton({
	Name = "FPS Boost",
	Callback = function()
		-- Optimize Lighting & Post-Processing
		local lighting = game:GetService("Lighting")
		lighting.GlobalShadows = false
		lighting.FogEnd = 1e10
		lighting.Brightness = 0
		
		for _, effect in ipairs(lighting:GetChildren()) do
			if effect:IsA("PostEffect") or effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("DepthOfFieldEffect") then
				pcall(function() effect.Enabled = false end)
			end
		end

		-- Optimize Terrain Water
		local terrain = game:GetService("Workspace"):FindFirstChildWhichIsA("Terrain")
		if terrain then
			terrain.WaterWaveSize = 0
			terrain.WaterWaveSpeed = 0
			terrain.WaterReflectance = 0
			terrain.WaterTransparency = 0
		end

		-- Optimize Workspace Descendants
		local function optimizeInstance(v)
			pcall(function()
				if v:IsA("BasePart") then
					v.Material = Enum.Material.SmoothPlastic
					v.Reflectance = 0
				elseif v:IsA("Decal") or v:IsA("Texture") then
					v:Destroy()
				elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Sparkles") or v:IsA("Fire") or v:IsA("Smoke") then
					v.Enabled = false
				end
			end)
		end

		for _, v in ipairs(game:GetService("Workspace"):GetDescendants()) do
			optimizeInstance(v)
		end

		-- Hook listener for newly streamed/added parts to prevent future lag
		game:GetService("Workspace").DescendantAdded:Connect(optimizeInstance)

		setfpscap(60)
	end
})
v494:AddToggle({
	Name = "White Screen",
	Default = false,
	Callback = function(Value)

		_G.WhiteScreen = Value
		RunService:Set3dRenderingEnabled(not Value)

	end
})

vu14 = game.Players.LocalPlayer

v494:AddButton({
    Name = "Meteor Rain",
    Callback =
    function()
        if vu14.Character and vu14.Character.PrimaryPart then
            require(game:GetService("ReplicatedStorage").Effect.Container.UzothSpec)({
                Position = vu14.Character.PrimaryPart.Position
            })
        end
    end
})
v494:AddButton({
    Name = "Devil Fruit Rain",
    Callback =
    function()
        pcall(function()
            for _, v in pairs(game:GetObjects("rbxassetid://14759368201")[1]:GetChildren()) do
                v.Parent = game.Workspace.Map
                v:MoveTo(vu14.Character.PrimaryPart.Position + Vector3.new(math.random(-50, 50), 100, math.random(-50, 50)))
                if v.Fruit:FindFirstChild("AnimationController") then
                    v.Fruit:FindFirstChild("AnimationController"):LoadAnimation(v.Fruit:FindFirstChild("Idle")):Play()
                end
                v.Handle.Touched:Connect(function(otherPart)
                    if otherPart.Parent == vu14.Character then
                        v.Parent = vu14.Backpack
                        vu14.Character.Humanoid:EquipTool(v)
                    end
                end)
            end
        end)
    end
})
v494:AddButton({
    Name = "Kamui",
    Callback =
    function()
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local hrp = char.HumanoidRootPart
            
            -- Create Kamui center part
            local kamuiPart = Instance.new("Part")
            kamuiPart.Name = "KamuiPortal"
            kamuiPart.Size = Vector3.new(1, 1, 1)
            kamuiPart.Position = hrp.Position
            kamuiPart.Anchored = true
            kamuiPart.CanCollide = false
            kamuiPart.Material = Enum.Material.Neon
            kamuiPart.Color = Color3.fromRGB(0, 0, 0)
            kamuiPart.Shape = Enum.PartType.Ball
            kamuiPart.Parent = workspace
            
            -- Add glowing outer aura ring
            local ring = Instance.new("Part")
            ring.Size = Vector3.new(1.2, 0.1, 1.2)
            ring.Position = hrp.Position
            ring.Anchored = true
            ring.CanCollide = false
            ring.Material = Enum.Material.Neon
            ring.Color = Color3.fromRGB(138, 43, 226) -- Blue Violet
            ring.Parent = workspace
            
            local mesh = Instance.new("SpecialMesh", ring)
            mesh.MeshId = "rbxassetid://3270017"
            mesh.Scale = Vector3.new(0.5, 0.5, 0.5)
            
            -- Add Particle Emitters for swirling dark energy
            local attachment = Instance.new("Attachment", kamuiPart)
            local emitter = Instance.new("ParticleEmitter", attachment)
            emitter.Texture = "rbxassetid://258129705" -- Swirl aura texture
            emitter.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(75, 0, 130))
            emitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 5), NumberSequenceKeypoint.new(1, 0)})
            emitter.Lifetime = NumberRange.new(0.8, 1.2)
            emitter.Rate = 120
            emitter.Speed = NumberRange.new(2, 5)
            emitter.RotSpeed = NumberRange.new(100, 300)
            emitter.SpreadAngle = Vector2.new(180, 180)
            
            -- Camera / Lighting distortion effects
            local cc = Instance.new("ColorCorrectionEffect", game.Lighting)
            cc.Contrast = 0.5
            cc.Saturation = -0.5
            
            local blur = Instance.new("BlurEffect", game.Lighting)
            blur.Size = 0
            
            -- Tween effects (opening the portal)
            local tweenService = game:GetService("TweenService")
            local openInfo = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            local closeInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            
            local openTween = tweenService:Create(kamuiPart, openInfo, {Size = Vector3.new(8, 8, 8)})
            local openRing = tweenService:Create(mesh, openInfo, {Scale = Vector3.new(40, 40, 5)})
            local openBlur = tweenService:Create(blur, openInfo, {Size = 24})
            
            openTween:Play()
            openRing:Play()
            openBlur:Play()
            
            -- Spin the ring
            task.spawn(function()
                local angle = 0
                for time = 1, 60 do
                    if not ring or not ring.Parent then break end
                    angle = (angle + 15) % 360
                    ring.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, math.rad(angle), 0)
                    task.wait(0.02)
                end
                
                -- Close the portal
                if kamuiPart and kamuiPart.Parent then
                    local closeTween = tweenService:Create(kamuiPart, closeInfo, {Size = Vector3.new(0.1, 0.1, 0.1)})
                    local closeRing = tweenService:Create(mesh, closeInfo, {Scale = Vector3.new(0.1, 0.1, 0.1)})
                    local closeCC = tweenService:Create(cc, closeInfo, {Contrast = 0, Saturation = 0})
                    local closeBlur = tweenService:Create(blur, closeInfo, {Size = 0})
                    
                    closeTween:Play()
                    closeRing:Play()
                    closeCC:Play()
                    closeBlur:Play()
                    
                    closeTween.Completed:Wait()
                    
                    -- Clean up everything
                    kamuiPart:Destroy()
                    ring:Destroy()
                    cc:Destroy()
                    blur:Destroy()
                end
            end)
        end)
    end
})
v494:AddButton({
    Name = "Give Divine Art",
    Callback =
    function()
        pcall(function()
            local player = game.Players.LocalPlayer
            local backpack = player:FindFirstChild("Backpack")
            local char = player.Character
            if backpack and char then
                local oldTool = backpack:FindFirstChild("Divine Art") or char:FindFirstChild("Divine Art")
                if oldTool then oldTool:Destroy() end
                
                -- Find any existing fighting style to copy animations from (e.g. Combat, Dark Step, etc.)
                local baseStyle = nil
                for _, t in pairs(backpack:GetChildren()) do
                    if t:IsA("Tool") and t.ToolTip == "Martial Art" then
                        baseStyle = t
                        break
                    end
                end
                if not baseStyle then
                    for _, t in pairs(char:GetChildren()) do
                        if t:IsA("Tool") and t.ToolTip == "Martial Art" then
                            baseStyle = t
                            break
                        end
                    end
                end
                
                -- Clone and spoof style into "Divine Art"
                local divineStyle = (baseStyle and baseStyle:Clone()) or Instance.new("Tool")
                divineStyle.Name = "Divine Art"
                divineStyle.ToolTip = "Martial Art"
                divineStyle.Parent = backpack
                
                -- 1. Hook the click (M1 attack) to spawn golden slashes
                divineStyle.Activated:Connect(function()
                    pcall(function()
                        local c = player.Character
                        if not c or not c:FindFirstChild("HumanoidRootPart") then return end
                        local hrp = c.HumanoidRootPart
                        
                        -- Spawn a beautiful curved neon gold slash
                        local slash = Instance.new("Part")
                        slash.Size = Vector3.new(4, 0.1, 4)
                        slash.CFrame = hrp.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(math.rad(math.random(-20, 20)), math.rad(math.random(-20, 20)), math.rad(math.random(-180, 180)))
                        slash.Anchored = true
                        slash.CanCollide = false
                        slash.Material = Enum.Material.Neon
                        slash.Color = Color3.fromRGB(255, 215, 0)
                        slash.Parent = workspace
                        
                        local mesh = Instance.new("SpecialMesh", slash)
                        mesh.MeshId = "rbxassetid://3270017"
                        mesh.Scale = Vector3.new(2, 2, 0.1)
                        
                        local emitter = Instance.new("ParticleEmitter", slash)
                        emitter.Texture = "rbxassetid://258129705"
                        emitter.Color = ColorSequence.new(Color3.fromRGB(255, 223, 0), Color3.fromRGB(255, 255, 255))
                        emitter.Size = NumberSequence.new(1, 0)
                        emitter.Rate = 50
                        emitter.Speed = NumberRange.new(5, 10)
                        emitter.Lifetime = NumberRange.new(0.3, 0.5)
                        
                        local tweenService = game:GetService("TweenService")
                        local info = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        local t1 = tweenService:Create(mesh, info, {Scale = Vector3.new(4, 4, 0.1)})
                        local t2 = tweenService:Create(slash, info, {Transparency = 1})
                        
                        t1:Play()
                        t2:Play()
                        task.spawn(function()
                            task.wait(0.3)
                            slash:Destroy()
                        end)
                    end)
                end)
                
                -- Notify success
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Divine Art",
                    Text = "Divine Art style added! Hold the tool and use Z, X, C keys for skills!",
                    Duration = 6
                })
            end
            
            -- 2. Hook Keyboard keys for visual skills (Z, X, C)
            if not _G.DivineArtKeysHooked then
                _G.DivineArtKeysHooked = true
                game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
                    if processed then return end
                    local c = player.Character
                    if not c or not c:FindFirstChild("Divine Art") then return end
                    local hrp = c:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    
                    local key = input.KeyCode
                    local tweenService = game:GetService("TweenService")
                    
                    if key == Enum.KeyCode.Z then
                        -- [Z] Bloodbane Devour / Holy Grasp
                        pcall(function()
                            local sphere = Instance.new("Part")
                            sphere.Shape = Enum.PartType.Ball
                            sphere.Size = Vector3.new(1, 1, 1)
                            sphere.Position = hrp.Position + hrp.CFrame.LookVector * 5
                            sphere.Anchored = true
                            sphere.CanCollide = false
                            sphere.Material = Enum.Material.Neon
                            sphere.Color = Color3.fromRGB(255, 255, 255)
                            sphere.Parent = workspace
                            
                            local emitter = Instance.new("ParticleEmitter", sphere)
                            emitter.Texture = "rbxassetid://258129705"
                            emitter.Color = ColorSequence.new(Color3.fromRGB(255, 215, 0), Color3.fromRGB(255, 255, 255))
                            emitter.Size = NumberSequence.new(2, 0)
                            emitter.Rate = 100
                            
                            local info = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                            local t = tweenService:Create(sphere, info, {Size = Vector3.new(6, 6, 6)})
                            t:Play()
                            
                            task.wait(0.5)
                            local tClose = tweenService:Create(sphere, TweenInfo.new(0.3), {Size = Vector3.new(0.1, 0.1, 0.1), Transparency = 1})
                            tClose:Play()
                            tClose.Completed:Wait()
                            sphere:Destroy()
                        end)
                        
                    elseif key == Enum.KeyCode.X then
                        -- [X] Scarlet Tear / Divine Barrage
                        pcall(function()
                            for i = 1, 5 do
                                task.spawn(function()
                                    local slash = Instance.new("Part")
                                    slash.Size = Vector3.new(5, 0.1, 5)
                                    slash.CFrame = hrp.CFrame * CFrame.new(math.random(-3, 3), math.random(-2, 2), -3) * CFrame.Angles(0, 0, math.rad(math.random(-180, 180)))
                                    slash.Anchored = false
                                    slash.CanCollide = false
                                    slash.Material = Enum.Material.Neon
                                    slash.Color = Color3.fromRGB(255, 215, 0)
                                    slash.Parent = workspace
                                    
                                    local mesh = Instance.new("SpecialMesh", slash)
                                    mesh.MeshId = "rbxassetid://3270017"
                                    mesh.Scale = Vector3.new(3, 3, 0.1)
                                    
                                    local bodyVel = Instance.new("BodyVelocity", slash)
                                    bodyVel.Velocity = hrp.CFrame.LookVector * 100
                                    bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                                    
                                    local info = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                                    local t1 = tweenService:Create(mesh, info, {Scale = Vector3.new(6, 6, 0.1)})
                                    local t2 = tweenService:Create(slash, info, {Transparency = 1})
                                    
                                    t1:Play()
                                    t2:Play()
                                    task.wait(0.4)
                                    slash:Destroy()
                                end)
                                task.wait(0.1)
                            end
                        end)
                        
                    elseif key == Enum.KeyCode.C then
                        -- [C] Devourer of Worlds / Judgment Beam
                        pcall(function()
                            local beam = Instance.new("Part")
                            beam.Shape = Enum.PartType.Cylinder
                            beam.Size = Vector3.new(200, 1, 1)
                            beam.CFrame = (hrp.CFrame * CFrame.new(0, 0, -8)) * CFrame.Angles(0, 0, math.rad(90))
                            beam.Anchored = true
                            beam.CanCollide = false
                            beam.Material = Enum.Material.Neon
                            beam.Color = Color3.fromRGB(255, 223, 0)
                            beam.Parent = workspace
                            
                            local emitter = Instance.new("ParticleEmitter", beam)
                            emitter.Texture = "rbxassetid://258129705"
                            emitter.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 215, 0))
                            emitter.Size = NumberSequence.new(5, 0)
                            emitter.Rate = 200
                            emitter.Speed = NumberRange.new(10, 30)
                            
                            local info = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                            local t = tweenService:Create(beam, info, {Size = Vector3.new(200, 15, 15)})
                            t:Play()
                            
                            task.wait(0.8)
                            local tClose = tweenService:Create(beam, TweenInfo.new(0.4), {Size = Vector3.new(200, 0.1, 0.1), Transparency = 1})
                            tClose:Play()
                            tClose.Completed:Wait()
                            beam:Destroy()
                        end)
                    end
                end)
            end
            
            -- 3. Also activate Sanguine Art visual color repaint skin hook
            _G.DivineArtVisuals = true
            task.spawn(function()
                local function repaint(v)
                    if not _G.DivineArtVisuals then return end
                    local name = string.lower(v.Name)
                    local parentName = v.Parent and string.lower(v.Parent.Name) or ""
                    if string.find(name, "sanguine") or string.find(name, "blood") or string.find(name, "bat") or string.find(name, "shafi") or
                       string.find(parentName, "sanguine") or string.find(parentName, "blood") or string.find(parentName, "bat") then
                        if v:IsA("ParticleEmitter") then
                            v.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)),
                                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 223, 0))
                            })
                            v.LightEmission = 0.8
                            v.LightInfluence = 0
                        elseif v:IsA("Trail") then
                            v.Color = ColorSequence.new(Color3.fromRGB(255, 215, 0), Color3.fromRGB(255, 255, 255))
                            v.LightEmission = 0.8
                        elseif v:IsA("BasePart") or v:IsA("MeshPart") then
                            v.Color = Color3.fromRGB(255, 215, 0)
                            v.Material = Enum.Material.Neon
                        end
                    end
                end
                for _, desc in pairs(workspace:GetDescendants()) do
                    pcall(repaint, desc)
                end
                workspace.DescendantAdded:Connect(function(desc)
                    pcall(repaint, desc)
                end)
            end)
        end)
    end
})
vu14 = game.Players.LocalPlayer

v494:AddButton({
    Name = "Remove Portal Dash Cooldown",
    Callback =
    function()
        local portal = vu14.Backpack:FindFirstChild("Portal-Portal") or (vu14.Character and vu14.Character:FindFirstChild("Portal-Portal"))
        if portal then
            local connections = getconnections(portal.Activated)
            for i = 1, #connections do
                local conn = connections[i]
                local func = conn.Function
                if func and #debug.getupvalues(func) == 9 then
                    task.spawn(function()
                        while portal and portal:IsDescendantOf(game) do
                            debug.setupvalue(func, 2, 0)
                            task.wait(0.1) 
                        end
                    end)
                end
            end
        end
    end
})

_ = v495:AddSection({" Fighting Style "})
Players = game:GetService("Players")
RunService = game:GetService("RunService")
ReplicatedStorage = game:GetService("ReplicatedStorage")
LP = Players.LocalPlayer

local SEA
if game.PlaceId == 2753915549 or game.PlaceId == 85211729168715 then
	SEA = 1
elseif game.PlaceId == 4442272183 or game.PlaceId == 79091703265657 then
	SEA = 2
elseif game.PlaceId == 7449423635 or game.PlaceId == 100117331123089 then
	SEA = 3
else
	return
end

_G.BuyFly = false
local BV, BG
TargetPos = nil

NPCS = {
	BlackLeg={[1]={Vector3.new(-988,13,3996)},[2]={Vector3.new(-4750.61, 35.08, -4846.33)},[3]={Vector3.new(-5043.64,371.35,-3183.40)}},
	Electro={[1]={Vector3.new(-5382.27,14.15,-2150.34)},[2]={Vector3.new(-4863.81, 35.08, -4767.54)},[3]={Vector3.new(-4993.20,314.56,-3198.06)}},
	FishmanKarate={[1]={Vector3.new(61584.35,18.85,988.89)},[2]={Vector3.new(-4960.04, 35.08, -4662.67)},[3]={Vector3.new(-5017.39,371.35,-3187.53)}},
	Superhuman={[2]={Vector3.new(1378.05, 247.43, -5189.37)},[3]={Vector3.new(-4997.53,371.35,-3197.46)}},
	DeathStep={[2]={Vector3.new(6360.04, 296.67, -6763.93)},[3]={Vector3.new(-4997.64,314.56,-3220.37)}},
	SharkmanKarate={[2]={Vector3.new(-2602.40, 239.22, -10314.75)},[3]={Vector3.new(-4970.48,314.56,-3225.04)}},
	ElectricClaw={[3]={Vector3.new(-10369.83,331.69,-10126.49)}},
	DragonTalon={[3]={Vector3.new(5662.03,1211.32,858.60)}},
	GodHuman={[3]={Vector3.new(-13775.56,334.66,-9877.67)}},
	SanguineArt={[3]={Vector3.new(-16514.86,23.18,-190.84)}}
}

local function HRP()
	return LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
end

local LV, AO
local TargetPos

local function EnsureFly()
	local hrp = HRP()
	if not hrp then return end

	if not LV or LV.Parent ~= hrp then
		if LV then LV:Destroy() end
		LV = Instance.new("LinearVelocity")
		LV.Attachment0 = hrp:FindFirstChildOfClass("Attachment") or Instance.new("Attachment", hrp)
		LV.MaxForce = math.huge
		LV.VectorVelocity = Vector3.zero
		LV.Parent = hrp
	end

	if not AO or AO.Parent ~= hrp then
		if AO then AO:Destroy() end
		AO = Instance.new("AlignOrientation")
		AO.Attachment0 = hrp:FindFirstChildOfClass("Attachment")
		AO.MaxTorque = math.huge
		AO.Responsiveness = 200
		AO.Parent = hrp
	end
end

local function StopFly()
	RunService:UnbindFromRenderStep("BuyFly")
	if LV then LV:Destroy() LV=nil end
	if AO then AO:Destroy() AO=nil end
	TargetPos = nil
end

local function FlyTo(pos)
	TargetPos = pos

	RunService:BindToRenderStep("BuyFly", Enum.RenderPriority.Character.Value + 1, function()
		if not _G.BuyFly then StopFly() return end

		local hrp = HRP()
		if not hrp then return end

		EnsureFly()

		for _,v in ipairs(LP.Character:GetDescendants()) do
			if v:IsA("BasePart") then v.CanCollide = false end
		end

		local delta = TargetPos - hrp.Position
		local dist = delta.Magnitude

		if dist <= 3 then
			LV.VectorVelocity = Vector3.zero
			hrp.AssemblyLinearVelocity = Vector3.zero
			hrp.CFrame = CFrame.new(TargetPos)
			return
		end

		local dir = delta.Unit
		LV.VectorVelocity = dir * math.clamp(dist * 6, 120, 330)
		AO.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + dir)
	end)
end

local function Buy(style, remote)
	task.spawn(function()
		local pos = NPCS[style] and NPCS[style][SEA]
		if not pos then return end

		FlyTo(pos[1])

		repeat task.wait()
		until (HRP() and (HRP().Position - pos[1]).Magnitude <= 4) or not _G.BuyFly

		if _G.BuyFly then
			ReplicatedStorage.Remotes.CommF_:InvokeServer(remote)
		end
	end)
end

LP.CharacterAdded:Connect(function()
	task.wait(0.4)
	if _G.BuyFly and TargetPos then
		FlyTo(TargetPos)
	end
end)
local function StopAllBuy()
	_G.BuyFly = false
	StopFly()
end

v495:AddButton({
	Title = "Stop Tween",
	Callback = function()
		StopAllBuy()
	end
})

v495:AddButton({
	Title = "Buy Black Leg",
	Callback = function()
		StopAllBuy()
		_G.BuyFly = true
		Buy("BlackLeg","BuyBlackLeg")
	end
})

v495:AddButton({
	Title = "Buy Electro",
	Callback = function()
		StopAllBuy()
		_G.BuyFly = true
		Buy("Electro","BuyElectro")
	end
})

v495:AddButton({
	Title = "Buy Fishman Karate",
	Callback = function()
		StopAllBuy()
		_G.BuyFly = true
		Buy("FishmanKarate","BuyFishmanKarate")
	end
})

v495:AddButton({
	Title = "Buy Superhuman",
	Callback = function()
		StopAllBuy()
		_G.BuyFly = true
		Buy("Superhuman","BuySuperhuman")
	end
})

v495:AddButton({
	Title = "Buy Death Step",
	Callback = function()
		StopAllBuy()
		_G.BuyFly = true
		Buy("DeathStep","BuyDeathStep")
	end
})

v495:AddButton({
	Title = "Buy Sharkman Karate",
	Callback = function()
		StopAllBuy()
		_G.BuyFly = true
		Buy("SharkmanKarate","BuySharkmanKarate")
	end
})

v495:AddButton({
	Title = "Buy Electric Claw",
	Callback = function()
		StopAllBuy()
		_G.BuyFly = true
		Buy("ElectricClaw","BuyElectricClaw")
	end
})

v495:AddButton({
	Title = "Buy Dragon Talon",
	Callback = function()
		StopAllBuy()
		_G.BuyFly = true
		Buy("DragonTalon","BuyDragonTalon")
	end
})

v495:AddButton({
	Title = "Buy God Human",
	Callback = function()
		StopAllBuy()
		_G.BuyFly = true
		Buy("GodHuman","BuyGodhuman")
	end
})

v495:AddButton({
	Title = "Buy Sanguine Art",
	Callback = function()
		StopAllBuy()
		_G.BuyFly = true
		Buy("SanguineArt","BuySanguineArt")
	end
})
 
_ = v495:AddSection({" Buy Sea Event Crafting "})
v495:AddButton({
    Title = "Craft Dragonheart",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Dragonheart")
    end
})
v495:AddButton({
    Title = "Craft Dragonstorm",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Dragonstorm")
    end
})
v495:AddButton({
    Title = "Craft DinoHood",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "DinoHood")
    end
})
v495:AddButton({
    Title = "Craft SharkTooth",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "SharkTooth")
    end
})
v495:AddButton({
    Title = "Craft TerrorJaw",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "TerrorJaw")
    end
})
v495:AddButton({
    Title = "Craft SharkAnchor",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "SharkAnchor")
    end
})
v495:AddButton({
    Title = "Craft LeviathanCrown",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanCrown")
    end
})
v495:AddButton({
    Title = "Craft LeviathanShield",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanShield")
    end
})
v495:AddButton({
    Title = "Craft LeviathanBoat",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanBoat")
    end
})
v495:AddButton({
    Title = "Craft LegendaryScroll",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LegendaryScroll")
    end
})
v495:AddButton({
    Title = "Craft MythicalScroll",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "MythicalScroll")
    end
})
_ = v495:AddSection({" Buy Haki,Soru... "})
v495:AddButton({
    Title = "Buy Geppo $10,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
    end
})
v495:AddButton({
    Title = "Buy Buso Haki $25,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
    end
})
v495:AddButton({
    Title = "Buy Soru $25,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
    end
})
v495:AddButton({
    Title = "Buy Observation Haki $750,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk", "Buy")
    end
})
_ = v495:AddSection({" Buy Sword,Gun "})
v495:AddButton({
    Title = "Buy Cutlass $1,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Cutlass")
    end
})
v495:AddButton({
    Title = "Buy Katana $1,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Katana")
    end
})
v495:AddButton({
    Title = "Buy Iron Mace $25,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Iron Mace")
    end
})
v495:AddButton({
    Title = "Buy Dual Katana $12,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Duel Katana")
    end
})
v495:AddButton({
    Title = "Buy Triple Katana $60,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Triple Katana")
    end
})
v495:AddButton({
    Title = "Buy Pipe $100,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Pipe")
    end
})
v495:AddButton({
    Title = "Buy Dual-Headed Blade $400,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Dual-Headed Blade")
    end
})
v495:AddButton({
    Title = "Buy Bisento $1,200,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Bisento")
    end
})
v495:AddButton({
    Title = "Buy Soul Cane $750,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Soul Cane")
    end
})
v495:AddButton({
    Title = "Buy Pole V2 5,000F",
    Callback = function()
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ThunderGodTalk")
    end
})
v495:AddButton({
    Title = "Buy Slingshot $5,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Slingshot")
    end
})
v495:AddButton({
    Title = "Buy Musket $8,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Musket")
    end
})
v495:AddButton({
    Title = "Buy Flintlock $10,500",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Flintlock")
    end
})
v495:AddButton({
    Title = "Refined Slingshot $30,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Refined Flintlock")
    end
})
v495:AddButton({
    Title = "Buy Refined Flintlock $65,000",
    Callback = function()
        local v1157 = {[1] = "BuyItem", [2] = "Refined Flintlock"}
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1157))
    end
})
v495:AddButton({
    Title = "Buy Cannon $100,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Cannon")
    end
})
v495:AddButton({
    Title = "Buy Kabucha 1,500F",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "2")
    end
})
v495:AddButton({
    Title = "Buy Bizarre Rifle 250 Ectoplasm",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 1)
    end
})
v495:AddButton({
    Title = "Buy Black Cape $50,000",
    Callback = function()
        local v1158 = {[1] = "BuyItem", [2] = "Black Cape"}
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1158))
    end
})
v495:AddButton({
    Title = "Swordsman Hat $150,000",
    Callback = function()
        local v1159 = {[1] = "BuyItem", [2] = "Swordsman Hat"}
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1159))
    end
})
v495:AddButton({
    Title = "Buy Tomoe Ring $500,000",
    Callback = function()
        local v1160 = {[1] = "BuyItem", [2] = "Tomoe Ring"}
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1160))
    end
})
_ = v495:AddSection({" Reset Stats , Random Race "})
v495:AddButton({
    Title = "buy Ghoul",
    Description = "",
    Callback = function()
        local v1162 = {[1] = "Ectoplasm", [2] = "Change", [3] = 4}
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1162))
    end
})
v495:AddButton({
    Title = "buy Cyborg",
    Description = "",
    Callback = function()
        local v1163 = {[1] = "CyborgTrainer", [2] = "Buy"}
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1163))
    end
})
v495:AddButton({
    Title = "Reset Stats 2,500F",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")
    end
})
v495:AddButton({
    Title = "Random Race 3,000F",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2")
    end
})


-- ========== KURRI COMPAT SHIM + MODULE (lien ket Misc + Sea) ==========
-- Cac bien Kurri dung nhung Hu999 khong co - dinh nghia o day de khong loi nil
if not _G.SaveData then _G.SaveData = {} end
if not GetSetting then
    GetSetting = function(k, d) if _G.SaveData[k] == nil then return d end return _G.SaveData[k] end
end
if not SaveSettings then
    SaveSettings = function()
        pcall(function()
            if writefile then
                if makefolder and not isfolder("Redz Hub - OK Hub") then makefolder("Redz Hub - OK Hub") end
                writefile("Redz Hub - OK Hub/Configs.json", game:GetService("HttpService"):JSONEncode(_G.SaveData))
            end
        end)
    end
end
if not FolderName then FolderName = "Redz Hub - OK Hub" end
if not Player then Player = game.Players.LocalPlayer end
if not LocalPlayer3 then LocalPlayer3 = game.Players.LocalPlayer end
if not ReplicatedStorage6 then ReplicatedStorage6 = game:GetService("ReplicatedStorage") end
if not RunService6 then RunService6 = game:GetService("RunService") end
if not KurriRS then KurriRS = game:GetService("ReplicatedStorage") end
if not Sec then Sec = 0.1 end
if not rejoinConnection then rejoinConnection = nil end
if not AutoRejoinKick then AutoRejoinKick = true end
-- KurriTween: tween nhan vat toi CFrame (Kurri dung tween(CFrame), Hu999 khong co ham nay)
if not KurriTween then
    KurriTween = function(target)
        if getgenv().TweenPaused then return end
        if typeof(target) ~= "CFrame" then return end
        local c = game.Players.LocalPlayer.Character
        if not c then return end
        local hrp = c:FindFirstChild("HumanoidRootPart")
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end
        pcall(function()
            local dist = (hrp.Position - target.Position).Magnitude
            local speed = _G.TweenSpeed or getgenv().TweenSpeed or 300
            local dur = math.max(0.1, dist / math.max(1, speed))
            local tw = game:GetService("TweenService"):Create(hrp, TweenInfo.new(dur, Enum.EasingStyle.Linear), {CFrame = target})
            tw:Play()
            -- Cho toi khi toi noi hoac bi tat
            local t0 = tick()
            while tick() - t0 < dur + 2 do
                task.wait(0.1)
                if getgenv().TweenPaused then tw:Cancel() break end
                if (hrp.Position - target.Position).Magnitude < 15 then break end
            end
        end)
    end
end
-- SeaModule + MiscModule: de chuc nang chay that, lien ket voi _G
local SeaModule = {}
_G.SeaModule = SeaModule; getgenv().SeaModule = SeaModule
SeaModule.IsSeaEvent = function()
    local ok, r = pcall(function() return IsDoingSeaEvent and IsDoingSeaEvent() or false end)
    return ok and r or false
end
local MiscModule = {}
_G.MiscModule = MiscModule; getgenv().MiscModule = MiscModule
MiscModule.Hop = function()
    pcall(function()
        local HS = game:GetService("HttpService"); local TS = game:GetService("TeleportService")
        local servers = HS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for _, s in pairs(servers.data) do if s.playing < s.maxPlayers and s.id ~= game.JobId then TS:TeleportToPlaceInstance(game.PlaceId, s.id) break end end
    end)
end
MiscModule.Rejoin = function() pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer) end) end
-- Loop lien ket: Misc + Sea doc _G/getgenv, ap dung NoClip / Speed / WalkWater / AntiBan
if not _G._KurriLinkLoop then
    _G._KurriLinkLoop = true
    task.spawn(function()
        while task.wait(0.25) do
            pcall(function()
                if getgenv().NoClip or _G.NoClip then
                    local c = game.Players.LocalPlayer.Character
                    if c then for _, v in pairs(c:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
                end
                if _G.AntiBand then
                    for _, pl in pairs(game:GetService("Players"):GetPlayers()) do
                        if table.find({17884881,120173604,912348}, pl.UserId) then MiscModule.Hop() break end
                    end
                end
            end)
        end
    end)
end
-- ========== HET SHIM - BAT DAU CODE KURRI ==========

-- ===== MISC CUA KURRI (thay toan bo Misc Hu999) =====
local function _MiscKurri()
v496:AddSection({"Settings"})
v496:AddToggle({
	Name = "Auto Translate",
	Description = "Tu dong dich UI sang ngon ngu cua ban.",
	Default = _G.AutoTranslate,
	Callback = function(p137)
		_G.AutoTranslate = p137

		local FolderName_ = FolderName

		FolderName_ = FolderName_ or "Redz Hub - OK Hub"

		if writefile then
			if makefolder and not isfolder(FolderName_) then
				makefolder(FolderName_)
			end

			writefile(FolderName_ .. "/AutoTranslate.txt", p137 and "true" or "false")
		end
	end
})
v496:AddDropdown({
	Name = "Farm Mode",
	Default = GetSetting("Mode", "Up"),
	Options = {
		"Up",
		"Orbit",
		"Star"
	},
	MultiSelect = false,
	Callback = function(p138)
		-- FIX Farm Mode: dong bo _G.FarmMode / _G.Mode / getgenv + FarmModule
		if _G.FarmModule and _G.FarmModule.SetMode then _G.FarmModule.SetMode(p138) else _G.FarmMode = p138; _G.Mode = p138; getgenv().FarmMode = p138 end
		_G.SaveData.Mode = p138; _G.SaveData.FarmMode = p138
		SaveSettings()
	end
})
v496:AddSlider({
	Name = "Farm Distance",
	Min = -30,
	Max = 30,
	Default = GetSetting("FarmDistance", 15),
	Increase = 1,
	Callback = function(p139)
		_G.FarmDistance = p139
		_G.SaveData.FarmDistance = p139
		SaveSettings()
	end
})
v496:AddSlider({
	Name = "Tween Speed",
	Min = 50,
	Max = 500,
	Default = GetSetting("TweenSpeed", 191),
	Increase = 1,
	Callback = function(p140)
		_G.TweenSpeed = p140; getgenv().TweenSpeed = p140; _G.FlySpeed = p140; getgenv().FlySpeed = p140; TweenSpeed = p140
		_G.SaveData.TweenSpeed = p140
		SaveSettings()
	end
})

local t19 = {}

local function v618(p141, p142, p143)
	local Position = p141.Position
	local Position2 = p142.Position

	p141.CFrame = CFrame.new(Position + (Position2 - Position) * p143, Position2)
end
local function v621(p144, p145)
	p144.CFrame = CFrame.new(p145)
end
local function v622(p146, p147)
	local n11 = 0

	for _, child in pairs(workspace.Enemies:GetChildren()) do
		if child:FindFirstChild("Humanoid") and child:FindFirstChild("HumanoidRootPart") then
			if child.Humanoid.Health > 0 then
				if (child.HumanoidRootPart.Position - p146.Position).Magnitude <= (p147 or 250) then
					n11 += 1
				end
			end
		end
	end

	return n11
end
local function v626(p148, p149)
	local Character2 = LocalPlayer3.Character

	if Character2 then
		if Character2:FindFirstChild("HumanoidRootPart") then
			return (Character2.HumanoidRootPart.Position - p148.Position).Magnitude <= (p149 or 290)
		end
	end

	return false
end

if not isnetworkowner then
	isnetworkowner = function()
		return true
	end
end

local function v628(p150)
	for k, v in pairs(t19) do
		local v631 = not k or not k.Parent or not k:FindFirstChild("Humanoid") or not k:FindFirstChild("HumanoidRootPart")

		if v631 or k.Humanoid.Health <= 0 or tick() - v.LastUpdate > 2 then
			t19[k] = nil
		end
	end

	if p150 and v622(p150) == 0 then
		t19 = {}
	end
end

spawn(function()
	game:GetService("RunService").RenderStepped:Connect(function()
		pcall(function()
			for k, v in pairs(t19) do
				if k and k.Parent then
					if k:FindFirstChild("HumanoidRootPart") and k.Humanoid.Health > 0 then
						local now = tick()

						v621(k.HumanoidRootPart, v.Position + Vector3.new(math.sin(now * v.RockSpeedX + v.FloatPhase) * 0.5, 0, math.cos(now * v.RockSpeedZ + v.FloatPhase) * 0.5))
						v.LastUpdate = now

						continue
					end
				end

				t19[k] = nil
			end
		end)
	end)
end)
bringmob = function()
	if not CfMon then
		return
	end

	pcall(function()
		local Character2 = LocalPlayer3.Character

		if not Character2 then
			return
		end

		if not Character2:FindFirstChild("HumanoidRootPart") then
			return
		end

		if not (typeof(CfMon) == "Vector3" and CfMon) then
		end

		local t20 = {
			Position = typeof(CfMon) == "Vector3" and CfMon or Vector3.new(CfMon.X, CfMon.Y, CfMon.Z)
		}

		v628(t20)

		local n12 = 0
		local MaxMobBring = _G.MaxMobBring or 4

		for _, child in pairs(workspace.Enemies:GetChildren()) do
			if MaxMobBring <= n12 then
				break
			end

			local HumanoidRootPart2 = child:FindFirstChild("HumanoidRootPart")
			local Humanoid = child:FindFirstChild("Humanoid")
			local Head = child:FindFirstChild("Head")

			if HumanoidRootPart2 and Humanoid and Head and not (Humanoid.Health <= 0) and not HumanoidRootPart2.Anchored and (not BossList or not table.find(BossList, child.Name)) then
				if not ((_G.BringDistance or 450) < (HumanoidRootPart2.Position - t20.Position).Magnitude) and v626(t20) and isnetworkowner(HumanoidRootPart2) then
					n12 += 1
					HumanoidRootPart2.CanCollide = false
					Head.CanCollide = false
					HumanoidRootPart2.Size = Vector3.new(1, 1, 1)
					Humanoid.WalkSpeed = 0
					Humanoid.JumpPower = 0
					Humanoid:ChangeState(11)
					Humanoid.PlatformStand = true

					local Magnitude = (HumanoidRootPart2.Position - t20.Position).Magnitude
					local cFrame = CFrame.new(t20.Position)

					if t19[child] then
						v621(HumanoidRootPart2, t20.Position)
					else
						v618(HumanoidRootPart2, cFrame, 0.4)

						if Magnitude < 2 then
							v621(HumanoidRootPart2, t20.Position)
							t19[child] = {
								Position = t20.Position,
								LastUpdate = tick(),
								RockSpeedX = math.random(1, 3) * 0.05,
								RockSpeedZ = math.random(1, 3) * 0.05,
								FloatPhase = math.random(0, math.floor(6.2831853071795862))
							}
						end
					end
				end
			end
		end

		sethiddenproperty(LocalPlayer3, "SimulationRadius", math.huge)
	end)
end
v496:AddSlider({
	Name = "Bring Distance",
	Min = 50,
	Max = 1000,
	Default = GetSetting("BringDistance", 450),
	Increase = 1,
	Callback = function(p151)
		_G.BringDistance = p151
		_G.SaveData.BringDistance = p151
		if Settings then Settings["Bring Mob Distance"] = p151 end -- Quantum Bring doc truc tiep _G.BringDistance
		SaveSettings()
	end
})
v496:AddSlider({
	Name = "Max Mob Bring",
	Min = 2,
	Max = 8,
	Default = GetSetting("MaxMobBring", 4),
	Increase = 1,
	Callback = function(p152)
		_G.MaxMobBring = p152
		_G.SaveData.MaxMobBring = p152
		if Settings then Settings["Bring Mob Count"] = math.clamp(tonumber(p152) or 6, 2, 10) end -- Quantum Bring doc truc tiep _G.MaxMobBring
		SaveSettings()
	end
})
_G.BringY = 0
v496:AddToggle({
	Name = "Bring Mobs",
	Default = GetSetting("B", true),
	Callback = function(p153)
		Bringgay = p153
		_G.SaveData.B = p153
		if Settings then Settings["Bring Mob"] = p153 end
		SaveSettings()
	end
})
v496:AddToggle({
	Name = "Bypass TP",
	Description = "",
	Default = GetSetting("BypassCF", false),
	Callback = function(p154)
		_G.BypassCF = p154
		_G.SaveData.BypassCF = p154
		SaveSettings()
	end
})
v496:AddToggle({
	Name = "Auto Attack",
	Description = "",
	Default = GetSetting("FastAttack", true),
	Callback = function(p155)
		_G.FastV2 = p155
		_G.SaveData.FastAttack = p155
		SaveSettings()
	end
})
v496:AddToggle({
	Name = "Auto M1 Fruit",
	Description = "",
	Default = GetSetting("M1BF", true),
	Callback = function(p156)
		_G.M1BF = p156
		_G.SaveData.M1BF = p156
		SaveSettings()
	end
})
v496:AddToggle({
	Name = "x2 Speed If Have M1 - Not Eqiup Tool",
	Description = "",
	Default = GetSetting("Aura", true),
	Callback = function(p157)
		_G.Aura = p157
		_G.SaveData.Aura = p157
		SaveSettings()
	end
})
v496:AddToggle({
	Name = "Auto Shoot [ BETA ]",
	Description = "",
	Default = GetSetting("Shoot", true),
	Callback = function(p158)
		_G.Shoot = p158
		_G.SaveData.Shoot = p158
		SaveSettings()
	end
})
v496:AddToggle({
	Name = "Auto Haki",
	Default = GetSetting("_G.TurnOnBuso", true),
	Callback = function(p159)
		_G.TurnOnBuso = p159
		_G.SaveData["_G.TurnOnBuso"] = p159
		SaveSettings()
	end
})

if World3 then
	v496:AddToggle({
		Name = "Auto Accept Quests",
		Description = "Bone and cake",
		Default = GetSetting("AcceptQuestC", false),
		Callback = function(p160)
			_G.AcceptQuestC = p160
			_G.SaveData.AcceptQuestC = p160
			SaveSettings()
		end
	})
end

v496:AddToggle({
	Name = "Bypass Quest",
	Default = GetSetting("RemoteQuest", false),
	Callback = function(p161)
		_G.RemoteQuest = p161
		_G.SaveData.RemoteQuest = p161
		SaveSettings()
	end
})
v496:AddToggle({
	Name = "Take Quest Debounce",
	Description = "Wait 5 seconds to take the next mission",
	Default = GetSetting("DelayQuest", false),
	Callback = function(p162)
		_G.DelayQuest = p162
		_G.SaveData.DelayQuest = p162
		SaveSettings()
	end
})
v496:AddSection({"Codes"})
v496:AddButton({
	Name = "Redeem all Codes",
	Callback = function()
		local Redeem = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem")

		task.wait(1)

		for _, v in ipairs({
			"LIGHTNINGABUSE",
			"fudd10",
			"fudd10_V2",
			"Chandler",
			"BIGNEWS",
			"KITT_RESET",
			"Sub2UncleKizaru",
			"SUB2GAMERROBOT_RESET1",
			"Sub2Fer999",
			"Enyu_is_Pro",
			"JCWK",
			"StarcodeHEO",
			"MagicBUS",
			"KittGaming",
			"Sub2CaptainMaui",
			"Sub2OfficialNoobie",
			"TheGreatAce",
			"Sub2NoobMaster123",
			"Sub2Daigrock",
			"Axiore",
			"StrawHatMaine",
			"TantaiGaming",
			"Bluxxy",
			"SUB2GAMERROBOT_EXP1",
			"NOMOREHACK",
			"BANEXPLOIT",
			"WildDares",
			"BossBuild",
			"GetPranked",
			"EARN_FRUITS",
			"FIGHT4FRUIT",
			"NOEXPLOITER",
			"NOOB2ADMIN",
			"CODESLIDE",
			"ADMINHACKED",
			"ADMINDARES",
			"fruitconcepts",
			"krazydares",
			"TRIPLEABUSE",
			"SEATROLLING",
			"24NOADMIN",
			"REWARDFUN",
			"NEWTROLL",
			"SECRET_ADMIN"
		}) do
			pcall(function()
				Redeem:InvokeServer(v)
			end)
			task.wait(0.2)
		end
	end
})
v496:AddSection({"Team"})
v496:AddButton({
	Name = "Join Pirate Team",
	Callback = function()
		Pirates()
	end
})
v496:AddButton({
	Name = "Join Marine Team",
	Callback = function()
		Marines()
	end
})
v496:AddSection({"Race"})
v496:AddToggle({
	Name = "Auto Active Race V3",
	Default = GetSetting("RaceClickAutov3", false),
	Callback = function(p163)
		_G.RaceClickAutov3 = p163
		_G.SaveData.RaceClickAutov3 = p163
		SaveSettings()
	end
})
spawn(function()
	while wait(0.2) do
		pcall(function()
			if _G.RaceClickAutov3 then
				repeat
					KurriRS.Remotes.CommE:FireServer("ActivateAbility")
					wait(30)
				until not _G.RaceClickAutov3
			end
		end)
	end
end)
v496:AddToggle({
	Name = "Auto Active Race V4",
	Default = GetSetting("RaceClickAutov4", false),
	Callback = function(p164)
		_G.RaceClickAutov4 = p164
		_G.SaveData.RaceClickAutov4 = p164
		SaveSettings()
		spawn(function()
			while _G.RaceClickAutov4 and task.wait(0.5) do
				pcall(function()
					local Character2 = game.Players.LocalPlayer.Character

					if Character2 and Character2:FindFirstChild("RaceEnergy") and Character2.RaceEnergy.Value >= 1 then
						local Awakening = game.Players.LocalPlayer.Backpack:FindFirstChild("Awakening") or Character2:FindFirstChild("Awakening")

						if Awakening and Awakening:FindFirstChild("RemoteFunction") then
							Awakening.RemoteFunction:InvokeServer(true)
						end
					end
				end)
			end
		end)
	end
})
v496:AddSection({"Select Skill"})
v496:AddDropdown({
	Name = "Melee",
	Default = GetSetting("MeleeSkills", {}),
	Options = {
		"Z",
		"X",
		"C"
	},
	MultiSelect = true,
	Callback = function(p165)
		_G.MeleeZ = p165.Z
		_G.MeleeX = p165.X
		_G.MeleeC = p165.C
		_G.SaveData.MeleeSkills = p165
		SaveSettings()
	end
})
v496:AddDropdown({
	Name = "Sword",
	Default = GetSetting("SwordSkills", {}),
	Options = {
		"Z",
		"X"
	},
	MultiSelect = true,
	Callback = function(p166)
		_G.SwordZ = p166.Z
		_G.SwordX = p166.X
		_G.SaveData.SwordSkills = p166
		SaveSettings()
	end
})
v496:AddDropdown({
	Name = "Blox Fruit",
	Default = GetSetting("BloxFruitSkills", {}),
	Options = {
		"Z",
		"X",
		"C",
		"V",
		"F"
	},
	MultiSelect = true,
	Callback = function(p167)
		_G.BloxFruitZ = p167.Z
		_G.BloxFruitX = p167.X
		_G.BloxFruitC = p167.C
		_G.BloxFruitV = p167.V
		_G.BloxFruitF = p167.F
		_G.SaveData.BloxFruitSkills = p167
		SaveSettings()
	end
})
v496:AddDropdown({
	Name = "Gun",
	Default = GetSetting("GunSkills", {}),
	Options = {
		"Z",
		"X"
	},
	MultiSelect = true,
	Callback = function(p168)
		_G.GunZ = p168.Z
		_G.GunX = p168.X
		_G.SaveData.GunSkills = p168
		SaveSettings()
	end
})
v496:AddSection({"Menu"})
v496:AddButton({
	Name = "Awakenings Expert",
	Callback = function()
		LocalPlayer3.PlayerGui.Main.AwakeningToggler.Visible = true
	end
})
v496:AddButton({
	Name = "Devil Fruit Shop",
	Callback = function()
		require(LocalPlayer3.PlayerGui.Main.UIController.FruitShop):Open("FruitDealer")
	end
})
v496:AddButton({
	Name = "Advanced Fruit Dealer",
	Callback = function()
		require(LocalPlayer3.PlayerGui.Main.UIController.FruitShop):Open("AdvancedFruitDealer")
	end
})
v496:AddButton({
	Name = "Titles",
	Callback = function()
		KurriRS.Remotes.CommF_:InvokeServer("getTitles", true)
		LocalPlayer3.PlayerGui.Main.Titles.Visible = true
	end
})
v496:AddSection({"Local-Player"})
getgenv().WalkSpeedValue = GetSetting("WalkSpeedValue", 30)
getgenv().JumpValue = GetSetting("JumpValue", 50)
_G.WalkSpeedEnabled = GetSetting("WalkSpeedEnabled", false)
_G.JumpEnabled = GetSetting("JumpEnabled", false)
_G.SmoothFarmEnabled = GetSetting("SmoothFarmEnabled", false)

local t21 = {}
local t22 = {}

ApplyWalkSpeed = function(p169)
	if p169 then
		p169.WalkSpeed = getgenv().WalkSpeedValue
		p169:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
			if _G.WalkSpeedEnabled and p169.WalkSpeed ~= getgenv().WalkSpeedValue then
				p169.WalkSpeed = getgenv().WalkSpeedValue
			end
		end)
	end
end
ApplySmoothFarm = function(p170)
	local Terrain = game.Workspace.Terrain

	if p170 then
		t21.WaterWaveSize = Terrain.WaterWaveSize
		t21.WaterWaveSpeed = Terrain.WaterWaveSpeed
		t21.WaterReflectance = Terrain.WaterReflectance
		t21.WaterTransparency = Terrain.WaterTransparency
		t21.GlobalShadows = game.Lighting.GlobalShadows
		t21.FogEnd = game.Lighting.FogEnd
		t21.Brightness = game.Lighting.Brightness
		t21.QualityLevel = settings().Rendering.QualityLevel
		Terrain.WaterWaveSize = 0
		Terrain.WaterWaveSpeed = 0
		Terrain.WaterReflectance = 0
		Terrain.WaterTransparency = 0
		game.Lighting.GlobalShadows = false
		game.Lighting.FogEnd = 9e9
		game.Lighting.Brightness = 0
		settings().Rendering.QualityLevel = "Level01"

		for _, descendant in pairs(game:GetDescendants()) do
			if descendant:IsA("Part") or descendant:IsA("Union") or descendant:IsA("CornerWedgePart") or descendant:IsA("TrussPart") then
				if not t22[descendant] then
					t22[descendant] = {
						Material = descendant.Material,
						Reflectance = descendant.Reflectance
					}
				end

				descendant.Material = "Plastic"
				descendant.Reflectance = 0
			elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
				if not t22[descendant] then
					t22[descendant] = {
						Transparency = descendant.Transparency
					}
				end

				descendant.Transparency = 1
			elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
				if not t22[descendant] then
					t22[descendant] = {
						Lifetime = descendant.Lifetime
					}
				end

				descendant.Lifetime = NumberRange.new(0)
			elseif descendant:IsA("Explosion") then
				if not t22[descendant] then
					t22[descendant] = {
						BlastPressure = descendant.BlastPressure,
						BlastRadius = descendant.BlastRadius
					}
				end

				descendant.BlastPressure = 1
				descendant.BlastRadius = 1
			elseif descendant:IsA("Fire") or descendant:IsA("SpotLight") or descendant:IsA("Smoke") or descendant:IsA("Sparkles") then
				if not t22[descendant] then
					t22[descendant] = {
						Enabled = descendant.Enabled
					}
				end

				descendant.Enabled = false
			elseif descendant:IsA("MeshPart") then
				if not t22[descendant] then
					t22[descendant] = {
						Material = descendant.Material,
						Reflectance = descendant.Reflectance,
						TextureID = descendant.TextureID
					}
				end

				descendant.Material = "Plastic"
				descendant.Reflectance = 0
				descendant.TextureID = 10385902758728956
			end
		end

		for _, child in pairs(game.Lighting:GetChildren()) do
			if not child:IsA("BlurEffect") and not child:IsA("SunRaysEffect") and not child:IsA("ColorCorrectionEffect") then
				if not child:IsA("BloomEffect") and not child:IsA("DepthOfFieldEffect") then
					continue
				end
			end

			if not t22[child] then
				t22[child] = {
					Enabled = child.Enabled
				}
			end

			child.Enabled = false
		end
	else
		if t21.WaterWaveSize then
			Terrain.WaterWaveSize = t21.WaterWaveSize
		end

		if t21.WaterWaveSpeed then
			Terrain.WaterWaveSpeed = t21.WaterWaveSpeed
		end

		if t21.WaterReflectance then
			Terrain.WaterReflectance = t21.WaterReflectance
		end

		if t21.WaterTransparency then
			Terrain.WaterTransparency = t21.WaterTransparency
		end

		if t21.GlobalShadows ~= nil then
			game.Lighting.GlobalShadows = t21.GlobalShadows
		end

		if t21.FogEnd then
			game.Lighting.FogEnd = t21.FogEnd
		end

		if t21.Brightness then
			game.Lighting.Brightness = t21.Brightness
		end

		if t21.QualityLevel then
			settings().Rendering.QualityLevel = t21.QualityLevel
		end

		for k, v in pairs(t22) do
			if k and k.Parent then
				for k2, v2 in pairs(v) do
					pcall(function()
						k[k2] = v2
					end)
				end
			end
		end

		t22 = {}
	end
end
v496:AddToggle({
	Name = "Walk Speed",
	Default = _G.WalkSpeedEnabled,
	Callback = function(p171)
		_G.WalkSpeedEnabled = p171
		_G.SaveData.WalkSpeedEnabled = p171
		SaveSettings()

		local Humanoid = LocalPlayer3.Character and LocalPlayer3.Character:FindFirstChild("Humanoid")

		if p171 and Humanoid then
			ApplyWalkSpeed(Humanoid)
		end
	end
})
v496:AddSlider({
	Name = "Speed Hack",
	Min = 50,
	Max = 300,
	Default = getgenv().WalkSpeedValue,
	Callback = function(p172)
		getgenv().WalkSpeedValue = p172
		_G.SaveData.WalkSpeedValue = p172
		SaveSettings()

		local Humanoid = LocalPlayer3.Character and LocalPlayer3.Character:FindFirstChild("Humanoid")

		if _G.WalkSpeedEnabled and Humanoid then
			Humanoid.WalkSpeed = p172
		end
	end
})
LocalPlayer3.CharacterAdded:Connect(function(character)
	local Humanoid = character:WaitForChild("Humanoid", 5)

	if _G.WalkSpeedEnabled then
		ApplyWalkSpeed(Humanoid)
	end

	if _G.JumpEnabled then
		Humanoid.JumpPower = getgenv().JumpValue
	end
end)

if LocalPlayer3.Character then
	local Humanoid = LocalPlayer3.Character:FindFirstChild("Humanoid")

	if _G.WalkSpeedEnabled then
		ApplyWalkSpeed(Humanoid)
	end

	if _G.JumpEnabled and Humanoid then
		Humanoid.JumpPower = getgenv().JumpValue
	end
end

v496:AddToggle({
	Name = "High Jump",
	Default = _G.JumpEnabled,
	Callback = function(p173)
		_G.JumpEnabled = p173
		_G.SaveData.JumpEnabled = p173
		SaveSettings()

		if p173 and LocalPlayer3.Character then
			local Humanoid = LocalPlayer3.Character:FindFirstChild("Humanoid")

			if Humanoid then
				Humanoid.JumpPower = getgenv().JumpValue
			end
		end
	end
})
v496:AddSlider({
	Name = "Jump Hack",
	Min = 50,
	Max = 500,
	Default = getgenv().JumpValue,
	Callback = function(p174)
		getgenv().JumpValue = p174
		_G.SaveData.JumpValue = p174
		SaveSettings()

		if _G.JumpEnabled and LocalPlayer3.Character then
			local Humanoid = LocalPlayer3.Character:FindFirstChild("Humanoid")

			if Humanoid then
				Humanoid.JumpPower = p174
			end
		end
	end
})
v496:AddSection({"More FPS"})
_G.FastModeEnabled = _G.FastModeEnabled or false
_G.SaveData.FastModeEnabled = _G.FastModeEnabled

local t23 = {}

ApplyFastMode = function(p175)
	for _, descendant in ipairs(workspace:GetDescendants()) do
		if not descendant:IsA("Part") then
			if not descendant:IsA("MeshPart") and not descendant:IsA("UnionOperation") then
				continue
			end
		end

		if p175 then
			if not t23[descendant] then
				t23[descendant] = descendant.Material
			end

			descendant.Material = Enum.Material.Plastic
		elseif t23[descendant] then
			descendant.Material = t23[descendant]
		end
	end

	if not p175 then
		table.clear(t23)
	end
end
v496:AddToggle({
	Name = "Fast Mode",
	Default = _G.FastModeEnabled,
	Callback = function(p176)
		_G.FastModeEnabled = p176
		_G.SaveData.FastModeEnabled = p176
		SaveSettings()
		ApplyFastMode(p176)
	end
})

if _G.FastModeEnabled then
	ApplyFastMode(true)
end

v496:AddToggle({
	Name = "Smooth Farm Mode",
	Default = _G.SmoothFarmEnabled,
	Callback = function(p177)
		_G.SmoothFarmEnabled = p177
		_G.SaveData.SmoothFarmEnabled = p177
		SaveSettings()
		ApplySmoothFarm(p177)
	end
})

if _G.SmoothFarmEnabled then
	ApplySmoothFarm(true)
end

v496:AddSection({"Others"})
v496:AddToggle({
	Name = "Walk on Water",
	Default = GetSetting("WalkWater_Part", true),
	Callback = function(p178)
		_G.WalkWater_Part = p178
		_G.SaveData.WalkWater_Part = p178
		SaveSettings()

		if _G.WalkWater_Part then
			game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
		else
			game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
		end
	end
})
v496:AddToggle({
	Name = "Anti AFK",
	Default = GetSetting("AntiAFK", true),
	Callback = function(p179)
		_G.AntiAFK = p179
		_G.SaveData.AntiAFK = p179
		SaveSettings()
	end
})
LocalPlayer3.Idled:connect(function()
	vim2:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	wait(1)
	vim2:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
v496:AddToggle({
	Name = "Auto Set Spawn Point",
	Default = GetSetting("AutoSetSpawnPoint", false),
	Callback = function(p180)
		AutoSetSpawnPoint = p180
		_G.SaveData.AutoSetSpawnPoint = p180
		SaveSettings()
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if AutoSetSpawnPoint then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
			end
		end)
	end
end)
v496:AddToggle({
	Name = "Safe Mode",
	Default = GetSetting("Safemode", true),
	Callback = function(p181)
		_G.Safemode = p181
		_G.SaveData.Safemode = p181
		SaveSettings()
	end
})
spawn(function()
	while task.wait(0.1) do
		if _G.Safemode then
			pcall(function()
				local Character2 = LocalPlayer3.Character

				if not Character2 then
					return
				end

				local Humanoid = Character2:FindFirstChild("Humanoid")
				local HumanoidRootPart2 = Character2:FindFirstChild("HumanoidRootPart")

				if Humanoid and HumanoidRootPart2 then
					local v674 = Humanoid.Health / Humanoid.MaxHealth

					if v674 <= 0.5 then
						if not IsUp then
							SafePos = HumanoidRootPart2.CFrame
							UpPos = HumanoidRootPart2.CFrame * CFrame.new(0, 500, 0)
							IsUp = true
						end

						if UpPos then
							HumanoidRootPart2.CFrame = UpPos
						end
					elseif v674 >= 0.65 and IsUp and SafePos then
						HumanoidRootPart2.CFrame = SafePos
						IsUp = false
						SafePos = nil
						UpPos = nil
					end
				end
			end)
		end
	end
end)
v496:AddToggle({
	Name = "Remove Damage",
	Default = GetSetting("RemoveDamage", true),
	Callback = function(p182)
		_G.RemoveDamage = p182
		_G.SaveData.RemoveDamage = p182
		game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = not p182
		SaveSettings()
	end
})
v496:AddToggle({
	Name = "Remove Notifications",
	Default = GetSetting("RemoveNotifications", false),
	Callback = function(p183)
		_G.RemoveNotifications = p183
		_G.SaveData.RemoveNotifications = p183
		Player.PlayerGui.Notifications.Enabled = not p183
		SaveSettings()
	end
})

v496:AddSection({"Anti Ban"})
v496:AddToggle({
	Name = "Hop if admin join",
	Default = true,
	Callback = function(p334)
		_G.AntiBand = p334
	end
})

local t42 = {
	17884881,
	120173604,
	912348
}

spawn(function()
	while task.wait(1) do
		if _G.AntiBand then
			local pairs_ = pairs
			local Players5 = game:GetService("Players")
			local exitTo

			for _, player in pairs_(Players5:GetPlayers()) do
				if table.find(t42, player.UserId) then
					exitTo = 1

					break
				end
			end

			if exitTo == 1 then
				repeat
					task.wait(2)
				until game:IsLoaded()

				local PlaceId = game.PlaceId
				local JobId = game.JobId
				local HttpService = game:GetService("HttpService")
				local __ServerBrowser = game:GetService("ReplicatedStorage"):WaitForChild("__ServerBrowser")
				local s3 = ""

				HopServer = function()
					while task.wait(1) do
						local ok, result = pcall(function()
							return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100" .. (s3 ~= "" and "&cursor=" .. s3 or "")))
						end)

						if ok and result then
							s3 = result.nextPageCursor or ""

							for _, v in pairs(result.data) do
								if v.id ~= JobId then
									__ServerBrowser:InvokeServer("teleport", v.id)

									break
								end
							end
						end
					end
				end
				task.delay(1, function()
					HopServer()
				end)
			end
		end
	end
end)
v496:AddToggle({
	Name = "Auto Hop (30 min)",
	Default = false,
	Callback = function(p335)
		_G.AutoHop30 = p335
	end
})
spawn(function()
	while task.wait(1800) do
		if _G.AutoHop30 then
			repeat
				task.wait(2)
			until game:IsLoaded()

			local PlaceId = game.PlaceId
			local JobId = game.JobId
			local HttpService = game:GetService("HttpService")
			local __ServerBrowser = game:GetService("ReplicatedStorage"):WaitForChild("__ServerBrowser")
			local s4 = ""

			HopServer = function()
				while task.wait(1) do
					local ok, result = pcall(function()
						return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100" .. (s4 ~= "" and "&cursor=" .. s4 or "")))
					end)

					if ok and result then
						s4 = result.nextPageCursor or ""

						for _, v in pairs(result.data) do
							if v.id ~= JobId then
								__ServerBrowser:InvokeServer("teleport", v.id)

								break
							end
						end
					end
				end
			end
			task.delay(1, function()
				HopServer()
			end)
		end
	end
end)
v496:AddToggle({
	Name = "Rejoin If Kick",
	Default = true,
	Callback = function(p336)
		AutoRejoinKick = p336
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if not AutoRejoinKick then
				if rejoinConnection then
					rejoinConnection:Disconnect()
					rejoinConnection = nil
				end
			elseif not rejoinConnection then
				rejoinConnection = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
					if child.Name == "ErrorPrompt" and child:FindFirstChild("MessageArea") then
						if child.MessageArea:FindFirstChild("ErrorFrame") then
							game:GetService("TeleportService"):Teleport(game.PlaceId)
						end
					end
				end)
			end
		end)
	end
end)
end
local _okMisc, _errMisc = pcall(_MiscKurri)
if not _okMisc then warn('[Misc Kurri] '..tostring(_errMisc)) end
-- ===== HET MISC KURRI =====
RunService = game:GetService("RunService")


Players = game:GetService("Players")
TweenService = game:GetService("TweenService")
RunService = game:GetService("RunService")

local CoreGui
pcall(function()
    if gethui then
        CoreGui = gethui()
    else
        CoreGui = game:GetService("CoreGui")
    end
end)
if not CoreGui then
    CoreGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

gui = Instance.new("ScreenGui")
gui.Name = "RedzNotification"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999999
gui.Parent = CoreGui

frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 75) -- menor
frame.Position = UDim2.new(1, 400, 1, -30)
frame.AnchorPoint = Vector2.new(1, 1)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
frame.BorderSizePixel = 0
frame.Parent = gui

corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(60, 60, 60)
stroke.Thickness = 1
stroke.Parent = frame

iconBg = Instance.new("Frame")
iconBg.Size = UDim2.new(0, 50, 0, 50)
iconBg.Position = UDim2.new(0, 12, 0.5, -25)
iconBg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
iconBg.BorderSizePixel = 0
iconBg.Parent = frame

iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(0, 8)
iconCorner.Parent = iconBg

icon = Instance.new("ImageLabel")
icon.Size = UDim2.new(1, -8, 1, -8)
icon.Position = UDim2.new(0.5, 0, 0.5, 0)
icon.AnchorPoint = Vector2.new(0.5, 0.5)
icon.BackgroundTransparency = 1
icon.Image = "rbxthumb://type=Asset&id=93070017822513&w=150&h=150"
icon.Parent = iconBg

title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -115, 0, 25)
title.Position = UDim2.new(0, 75, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Script Loaded"
title.Font = Enum.Font.GothamBold
title.TextSize = 17
title.TextColor3 = Color3.new(1, 1, 1)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

description = Instance.new("TextLabel")
description.Size = UDim2.new(1, -115, 0, 30)
description.Position = UDim2.new(0, 75, 0, 35)
description.BackgroundTransparency = 1
description.TextWrapped = true
description.Text = 'redz Hub loaded successfully! Press "LeftControl" to minimize.'
description.Font = Enum.Font.Gotham
description.TextSize = 12
description.TextColor3 = Color3.fromRGB(200, 200, 200)
description.TextXAlignment = Enum.TextXAlignment.Left
description.TextYAlignment = Enum.TextYAlignment.Top
description.Parent = frame

-- Timer branco
duration = 5
timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.new(0, 45, 0, 20)
timerLabel.Position = UDim2.new(1, -50, 0, 8)
timerLabel.BackgroundTransparency = 1
timerLabel.Font = Enum.Font.GothamBold
timerLabel.TextSize = 14
timerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
timerLabel.TextXAlignment = Enum.TextXAlignment.Right
timerLabel.Parent = frame

-- Entrando
tweenIn = TweenService:Create(
	frame,
	TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	{Position = UDim2.new(1, -20, 1, -30)}
)

tweenIn:Play()
tweenIn.Completed:Wait()

-- Contagem regressiva suave
startTime = tick()
local connection

connection = RunService.RenderStepped:Connect(function()
	local elapsed = tick() - startTime
	local remaining = math.clamp(duration - elapsed, 0, duration)
	timerLabel.Text = string.format("%.1f", remaining)

	if remaining <= 0 then
		connection:Disconnect()
	end
end)

task.wait(duration)

-- Saindo
tweenOut = TweenService:Create(
	frame,
	TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
	{Position = UDim2.new(1, 400, 1, -30)}
)

tweenOut:Play()
tweenOut.Completed:Wait()

gui:Destroy()

spawn(function()
    while task.wait() do
        pcall(function()
            local l_Character_3 = game:GetService("Players").LocalPlayer.Character
            local l_HumanoidRootPart_1 = l_Character_3:FindFirstChild("HumanoidRootPart")
            if (l_Character_3.Humanoid.Health <= 0 or not l_HumanoidRootPart_1) and l_Character_3:FindFirstChild("Block") then
                l_Character_3.Block:Destroy()
            end
        end)
    end
end)
spawn(function()
    while task.wait() do
        pcall(function()
            local l_Character_4 = game:GetService("Players").LocalPlayer.Character
            local l_HumanoidRootPart_2 = l_Character_4:FindFirstChild("HumanoidRootPart")
            if l_Character_4:FindFirstChild("Block") and (l_HumanoidRootPart_2.Position - l_Character_4.Block.Position).Magnitude >= 100 then
                l_Character_4.Block:Destroy()
            end
        end)
    end
end)
function enableNoclip()
    if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
        local l_BodyVelocity_1 = Instance.new("BodyVelocity")
        l_BodyVelocity_1.Name = "BodyClip"
        l_BodyVelocity_1.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
        l_BodyVelocity_1.MaxForce = Vector3.new(100000, 100000, 100000)
        l_BodyVelocity_1.Velocity = Vector3.new(0, 0, 0)
    end
end
function disableNoclip()
    local l_BodyClip_0 = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip")
    if l_BodyClip_0 then
        l_BodyClip_0:Destroy()
    end
end
function disableCollisions()
    for _, v385 in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
        if v385:IsA("BasePart") then
            v385.CanCollide = false
        end
    end
end
_, _ = pcall(function()
    return getgenv().Module
end)
spawn(function()
    pcall(function()
        while task.wait(0.1) do
            if getgenv().Module or _G.DefendVolcano or getgenv().AutoFarm or v391 then
                enableNoclip()
                disableCollisions()
            else
                disableNoclip()
            end
        end
    end)
end)


spawn(function()
    while task.wait() do
        pcall(function()
            if type(CheckQuest) == "function" then CheckQuest() end
            for _, mob in ipairs(SortedFarmTargets()) do
                if StartBring
                and (mob.Name == MonFarm or mob.Name == Mon)
                and mob:FindFirstChild("Humanoid")
                and mob:FindFirstChild("HumanoidRootPart")
                and mob.Humanoid.Health > 0 then
                    local hrp = mob.HumanoidRootPart
                    local hum = mob.Humanoid
                    if _G.BringDistance and PosMon and (hrp.Position - PosMon.Position).Magnitude <= _G.BringDistance then
                        hrp.CFrame = PosMon
                        hrp.Anchored = false
                        if hrp.Size.X ~= 60 then
                            hrp.Size = Vector3.new(60,60,60)
                            hrp.Transparency = 1
                            hrp.CanCollide = false
                            if mob:FindFirstChild("Head") then mob.Head.CanCollide = false end
                            hum.JumpPower = 0
                            hum.WalkSpeed = 0
                            hum:ChangeState(11)
                            hum:ChangeState(14)
                        end
                        local anim = hum:FindFirstChild("Animator")
                        if anim then
                            anim:Destroy()
                        end
                    end
                end
            end
            if sethiddenproperty and StartBring and PosMon then
                sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
            end
        end)
    end
end)

return redzlib