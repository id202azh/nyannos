loadstring(game:HttpGet("https://raw.githubusercontent.com/nyannos/Ui-Script/refs/heads/main/fps"))()
print("[nyann os] boot midnight...")
do
  ply = game.Players
  plr = ply.LocalPlayer or ply.PlayerAdded:Wait()
  -- chờ character (timeout) — tránh crash không hiện menu
  do
    local t0 = tick()
    while (not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart")) and tick() - t0 < 20 do
      task.wait(0.1)
    end
  end
  Root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
  replicated = game:GetService("ReplicatedStorage")
  pcall(function()
    plr:WaitForChild("Data", 10)
    if plr:FindFirstChild("Data") then plr.Data:WaitForChild("Level", 5) end
  end)
  Lv = (plr:FindFirstChild("Data") and plr.Data:FindFirstChild("Level") and plr.Data.Level.Value) or 1
  TeleportService = game:GetService("TeleportService")
  TW = game:GetService("TweenService")
  Lighting = game:GetService("Lighting")
  Enemies = workspace:FindFirstChild("Enemies") or workspace
  pcall(function() vim1 = game:GetService("VirtualInputManager") end)
  pcall(function() vim2 = game:GetService("VirtualUser") end)
  TeamSelf = plr.Team
  RunSer = game:GetService("RunService")
  Stats = game:GetService("Stats")
  Energy = 0
  pcall(function()
    if plr.Character and plr.Character:FindFirstChild("Energy") then
      Energy = plr.Character.Energy.Value
    end
  end)
  BringConnections = {}
  BossList = {}
  MaterialList = {}
  NPCList = {}
  shouldTween = false
  SoulGuitar = false
  KenTest = true
  debug = false
  Brazier1 = false
  Brazier2 = false
  Brazier3 = false
  Sec = 0.1
  ClickState = 0
  Num_self = 25
  pcall(function()
    plr.CharacterAdded:Connect(function(char)
      local hrp = char:WaitForChild("HumanoidRootPart", 10)
      if hrp then Root = hrp end
    end)
  end)
end

-- Loading timeout 20s
do
  local t0 = tick()
  repeat
    local loading = plr.PlayerGui and plr.PlayerGui:FindFirstChild("Main")
    loading = loading and loading:FindFirstChild("Loading")
    task.wait(0.1)
  until (game:IsLoaded() and not (loading and loading.Visible)) or (tick() - t0 > 20)
end
print("[nyann os] game ready")
World1 = game.PlaceId == 2753915549 or game.PlaceId == 85211729168715
World2 = game.PlaceId == 4442272183 or game.PlaceId == 79091703265657
World3 = game.PlaceId == 7449423635 or game.PlaceId == 100117331123089
Marines = function() replicated.Remotes.CommF_:InvokeServer("SetTeam","Marines") end
Pirates = function() replicated.Remotes.CommF_:InvokeServer("SetTeam","Pirates") end
if World1 then BossList = {"The Gorilla King","Bobby","The Saw","Yeti","Mob Leader","Vice Admiral","Saber Expert","Warden","Chief Warden","Swan","Magma Admiral","Fishman Lord","Wysper","Thunder God","Cyborg","Ice Admiral","Greybeard"}
elseif World2 then BossList = {"Diamond","Jeremy","Orbitus","Don Swan","Smoke Admiral","Awakened Ice Admiral","Tide Keeper","Darkbeard","Cursed Captain","Order"}
elseif World3 then BossList = {"Stone","Hydra Leader","Kilo Admiral","Captain Elephant","Beautiful Pirate","Cake Queen","Dough King","Longma","Soul Reaper","rip_indra True Form","Tyrant of the Skies"}
end
if World1 then MaterialList = {"Leather + Scrap Metal", "Angel Wings", "Magma Ore", "Fish Tail"}
elseif World2 then MaterialList = {"Leather + Scrap Metal", "Radioactive Material", "Ectoplasm", "Mystic Droplet", "Magma Ore", "Vampire Fang"}
elseif World3 then MaterialList = {"Scrap Metal", "Demonic Wisp", "Conjured Cocoa", "Dragon Scale", "Gunpowder", "Fish Tail", "Mini Tusk"}
end
local DungeonTables = {"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human: Buddha","Sand","Bird: Phoenix","Dough"}
local RenMon = {"Snow Lurker","Arctic Warrior","Hidden Key","Awakened Ice Admiral"}
local CursedTables = {["Mob"] = "Mythological Pirate",["Mob2"] = "Cursed Skeleton","Hell's Messenger",["Mob3"] = "Cursed Skeleton","Heaven's Guardian"}
local Past = {"Part","SpawnLocation","Terrain","WedgePart","MeshPart"}
local BartMon = {"Swan Pirate","Jeremy"}
local CitizenTable = {"Forest Pirate","Captain Elephant"}
local Human_v3_Mob = {"Fajita","Jeremy","Diamond"}
local AllBoats = {"Beast Hunter","Lantern","Guardian","Grand Brigade","Dinghy","Sloop","The Sentinel"}
local mastery1 = {"Cookie Crafter"}
local mastery2 = {"Reborn Skeleton"}
local PosMsList = {["Pirate Millionaire"] = CFrame.new(-712.8272705078125, 98.5770492553711, 5711.9541015625),["Pistol Billionaire"] = CFrame.new(-723.4331665039062, 147.42906188964844, 5931.9931640625),["Dragon Crew Warrior"] = CFrame.new(7021.50439453125, 55.76270294189453, -730.1290893554688),["Dragon Crew Archer"] = CFrame.new(6625, 378, 244),["Female Islander"] = CFrame.new(4692.7939453125, 797.9766845703125, 858.8480224609375),["Venomous Assailant"] = CFrame.new(4902, 670, 39), ["Marine Commodore"] = CFrame.new(2401, 123, -7589),["Marine Rear Admiral"] = CFrame.new(3588, 229, -7085),["Fishman Raider"] = CFrame.new(-10941, 332, -8760),["Fishman Captain"] = CFrame.new(-11035, 332, -9087),["Forest Pirate"] = CFrame.new(-13446, 413, -7760),["Mythological Pirate"] = CFrame.new(-13510, 584, -6987),["Jungle Pirate"] = CFrame.new(-11778, 426, -10592),["Musketeer Pirate"] = CFrame.new(-13282, 496, -9565),["Reborn Skeleton"] = CFrame.new(-8764, 142, 5963),["Living Zombie"] = CFrame.new(-10227, 421, 6161),["Demonic Soul"] = CFrame.new(-9579, 6, 6194),["Posessed Mummy"] = CFrame.new(-9579, 6, 6194),["Peanut Scout"] = CFrame.new(-1993, 187, -10103),["Peanut President"] = CFrame.new(-2215, 159, -10474),["Ice Cream Chef"] = CFrame.new(-877, 118, -11032),["Ice Cream Commander"] = CFrame.new(-877, 118, -11032),["Cookie Crafter"] = CFrame.new(-2021, 38, -12028),["Cake Guard"] = CFrame.new(-2024, 38, -12026),["Baking Staff"] = CFrame.new(-1932, 38, -12848),["Head Baker"] = CFrame.new(-1932, 38, -12848),["Cocoa Warrior"] = CFrame.new(95, 73, -12309),["Chocolate Bar Battler"] = CFrame.new(647, 42, -12401),["Sweet Thief"] = CFrame.new(116, 36, -12478),["Candy Rebel"] = CFrame.new(47, 61, -12889),["Ghost"] = CFrame.new(5251, 5, 1111)}
local Remotes = { RFJobsRemoteFunction = nil, RFCraft = nil }
pcall(function()
  local mods = replicated:WaitForChild("Modules", 8)
  local net = mods and mods:WaitForChild("Net", 5)
  if net then
    Remotes.RFJobsRemoteFunction = net:FindFirstChild("RF/JobsRemoteFunction")
    Remotes.RFCraft = net:FindFirstChild("RF/Craft") or net:WaitForChild("RF/Craft", 3)
  end
end)
EquipWeapon = function(text)
  if not text then return end
  if plr.Backpack:FindFirstChild(text) then
	plr.Character.Humanoid:EquipTool(plr.Backpack:FindFirstChild(text))
  end
end
weaponSc = function(weapon)
  for __in, v in pairs(plr.Backpack:GetChildren()) do
    if v:IsA("Tool") then
      if v.ToolTip == weapon then EquipWeapon(v.Name) end
    end
  end
end
local Attack = {}
Attack.__index = Attack
Attack.Alive = function(model) if not model then return end local Humanoid = model:FindFirstChild("Humanoid") return Humanoid and Humanoid.Health > 0 end
Attack.Pos = function(model,dist) return (Root.Position - mode.Position).Magnitude <= dist end
Attack.Dist = function(model,dist) return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude <= dist end
Attack.DistH = function(model,dist) return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude > dist end
Attack.Kill = function(model,Succes)
  if model and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
  EquipWeapon(_G.SelectWeapon)
  local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
  local ToolTip = Equipped.ToolTip
  if ToolTip == "Blox Fruit" then _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,10,0) * CFrame.Angles(0,math.rad(90),0)) else _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0) * CFrame.Angles(0,math.rad(180),0))end
  if RandomCFrame then wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30 ,0)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))end
  end
end
Attack.Kill2 = function(model,Succes)
  if model and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
  EquipWeapon(_G.SelectWeapon)
  local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
  local ToolTip = Equipped.ToolTip
  if ToolTip == "Blox Fruit" then _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,10,0) * CFrame.Angles(0,math.rad(90),0)) else _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,8) * CFrame.Angles(0,math.rad(180),0))end
  if RandomCFrame then wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30 ,0)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))end
  end
end
Attack.KillSea = function(model,Succes)
  if model and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
  EquipWeapon(_G.SelectWeapon)
  local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
  local ToolTip = Equipped.ToolTip
  if ToolTip == "Blox Fruit" then _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,10,0) * CFrame.Angles(0,math.rad(90),0)) else notween(model.HumanoidRootPart.CFrame * CFrame.new(0,50,8)) wait(.85)notween(model.HumanoidRootPart.CFrame * CFrame.new(0,400,0)) wait(1)end
  end
end
Attack.Sword = function(model,Succes)
  if model and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
  weaponSc("Sword")
  _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
  if RandomCFrame then wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30 ,0)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))end
  end
end
Attack.Mas = function(model,Succes)
  if model and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
    if model.Humanoid.Health <= HealthM then
      _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
      Useskills("Blox Fruit","Z")
      Useskills("Blox Fruit","X")
      Useskills("Blox Fruit","C")
    else
      weaponSc("Melee")
      _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
    end
  end
end
Attack.Masgun = function(model,Succes)
  if model and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
    if model.Humanoid.Health <= HealthM then
      _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,35,8))
      Useskills("Gun","Z")
      Useskills("Gun","X")
    else
      weaponSc("Melee")
      _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
    end
  end
end
statsSetings = function(Num, value)
  if Num == "Melee" then
    if plr.Data.Points.Value ~= 0 then
      replicated.Remotes.CommF_:InvokeServer("AddPoint","Melee",value)
    end
  elseif Num == "Defense" then
    if plr.Data.Points.Value ~= 0 then
      replicated.Remotes.CommF_:InvokeServer("AddPoint","Defense",value)
    end
  elseif Num == "Sword" then
    if plr.Data.Points.Value ~= 0 then
      replicated.Remotes.CommF_:InvokeServer("AddPoint","Sword",value)
    end
  elseif Num == "Gun" then
    if plr.Data.Points.Value ~= 0 then
      replicated.Remotes.CommF_:InvokeServer("AddPoint","Gun",value)
    end
  elseif Num == "Devil" then
    if plr.Data.Points.Value ~= 0 then
      replicated.Remotes.CommF_:InvokeServer("AddPoint","Demon Fruit",value)
    end
  end
end
BringEnemy = function(Mon)
    if not _B then return end
    if not Mon then 
        -- Tự động tìm mob nếu không có Mon
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local closestDist = math.huge
        for _, enemy in ipairs(workspace.Enemies:GetChildren()) do
            local hum = enemy:FindFirstChildOfClass("Humanoid")
            local root = enemy:FindFirstChild("HumanoidRootPart")
            if hum and root and hum.Health > 0 then
                local dist = (root.Position - hrp.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    Mon = enemy
                end
            end
        end
        if not Mon then return end
    end
    
    local AreaMob = false
    
    local function Mobs(enemy)
        local hum = enemy:FindFirstChildOfClass("Humanoid")
        local root = enemy:FindFirstChild("HumanoidRootPart")
        return hum and root and hum.Health > 0, root, hum
    end

    local function Network(part)
        if isnetworkowner then
            return isnetworkowner(part)
        end
        return part.ReceiveAge == 0 and not part.Anchored and part.Velocity.Magnitude > 0
    end
    
    pcall(function()
        -- Tăng simulation radius
        if sethiddenproperty then 
            sethiddenproperty(plr, "SimulationRadius", math.huge)
        end
        
        local targetPos = Mon.HumanoidRootPart.Position
        
        for _, v in ipairs(workspace.Enemies:GetChildren()) do
            if v ~= Mon then
                local alive, root, hum = Mobs(v)
                if alive and v.Name == Mon.Name then
                    local distance = (root.Position - targetPos).Magnitude
                    if distance <= 3000 then
                        -- Tạo BodyVelocity để giữ mob
                        local bv = root:FindFirstChild("BodyVelocity")
                        if not bv then
                            bv = Instance.new("BodyVelocity")
                            bv.Name = "BodyVelocity"
                            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                            bv.Velocity = Vector3.zero
                            bv.Parent = root
                        end
                        
                        if distance <= 10 then
                            AreaMob = true
                        end
                        
                        -- Kéo mob lại nếu là network owner và chưa ở gần
                        if not AreaMob and Network(root) then
                            root.CFrame = CFrame.new(targetPos)
                        end
                        
                        -- Tắt va chạm và ngăn di chuyển
                        root.CanCollide = false
                        hum.WalkSpeed = 0
                        hum.JumpPower = 0
                    end
                end
            end
        end
        
        -- Xử lý mob chính
        if Mon and Mon:FindFirstChild("HumanoidRootPart") then
            Mon.HumanoidRootPart.CanCollide = false
            Mon.Humanoid.WalkSpeed = 0
            Mon.Humanoid.JumpPower = 0
        end
    end)
end
Useskills = function(weapon, skill)
  if weapon == "Melee" then
    weaponSc("Melee")
    if skill == "Z" then
      vim1:SendKeyEvent(true, "Z", false, game);
      vim1:SendKeyEvent(false, "Z", false, game);
    elseif skill == "X" then
      vim1:SendKeyEvent(true, "X", false, game);
      vim1:SendKeyEvent(false, "X", false, game);
    elseif skill == "C" then
      vim1:SendKeyEvent(true, "C", false, game);
      vim1:SendKeyEvent(false, "C", false, game);
    end
  elseif weapon == "Sword" then
    weaponSc("Sword")
    if skill == "Z" then
      vim1:SendKeyEvent(true, "Z", false, game);
      vim1:SendKeyEvent(false, "Z", false, game);
    elseif skill == "X" then
      vim1:SendKeyEvent(true, "X", false, game);
      vim1:SendKeyEvent(false, "X", false, game);
    end
  elseif weapon == "Blox Fruit" then
    weaponSc("Blox Fruit")
    if skill == "Z" then
      vim1:SendKeyEvent(true, "Z", false, game);
      vim1:SendKeyEvent(false, "Z", false, game);
    elseif skill == "X" then
      vim1:SendKeyEvent(true, "X", false, game);
      vim1:SendKeyEvent(false, "X", false, game);
    elseif skill == "C" then
      vim1:SendKeyEvent(true, "C", false, game);
      vim1:SendKeyEvent(false, "C", false, game);        
    elseif skill == "V" then
      vim1:SendKeyEvent(true, "V", false, game);
      vim1:SendKeyEvent(false, "V", false, game);
    end
  elseif weapon == "Gun" then
    weaponSc("Gun")
    if skill == "Z" then
      vim1:SendKeyEvent(true, "Z", false, game);
      vim1:SendKeyEvent(false, "Z", false, game);
    elseif skill == "X" then
      vim1:SendKeyEvent(true, "X", false, game);
      vim1:SendKeyEvent(false, "X", false, game);
    end
  end
  if weapon == "nil" and skill == "Y" then
    vim1:SendKeyEvent(true, "Y", false, game);
    vim1:SendKeyEvent(false, "Y", false, game);
  end
end
local gg = getrawmetatable(game)
local old = gg.__namecall
setreadonly(gg, false)
gg.__namecall = newcclosure(function(...)
  local method = getnamecallmethod()
  local args = {...}    
    if tostring(method) == "FireServer" then
      if tostring(args[1]) == "RemoteEvent" then
        if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
          if (_G.FarmMastery_G and not SoulGuitar) or (_G.FarmMastery_Dev) or (_G.FarmBlazeEM) or (_G.Prehis_Skills) or (_G.SeaBeast1 or _G.FishBoat or _G.PGB or _G.Leviathan1 or _G.Complete_Trials) or (_G.AimMethod and ABmethod == "Aim Player") or (_G.AimMethod and ABmethod == "Nearest Aim") then
            args[2] = MousePos
            return old(unpack(args))
          end
        end
      end
    end
  return old(...)
end)
GetConnectionEnemies = function(a)
  for i,v in pairs(replicated:GetChildren()) do
    if v:IsA("Model") and  ((typeof(a) == "table" and table.find(a, v.Name)) or v.Name == a) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
      return v
    end
  end
  for i,v in next,game.Workspace.Enemies:GetChildren() do
    if v:IsA("Model") and ((typeof(a) == "table" and table.find(a, v.Name)) or v.Name == a)  and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
      return v
    end
  end
end
LowCpu = function()
  local decalsyeeted = true
  local g = game
  local w = g.Workspace
  local l = g.Lighting
  local t = w.Terrain
  t.WaterWaveSize = 0
  t.WaterWaveSpeed = 0
  t.WaterReflectance = 0
  t.WaterTransparency = 0
  l.GlobalShadows = false
  l.FogEnd = 9e9
  l.Brightness = 0
  settings().Rendering.QualityLevel = "Level01"
  for i, v in pairs(g:GetDescendants()) do
    if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
      v.Material = "Plastic"
      v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
      v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
      v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
      v.BlastPressure = 1
      v.BlastRadius = 1
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
      v.Enabled = false
    elseif v:IsA("MeshPart") then
      v.Material = "Plastic"
      v.Reflectance = 0
      v.TextureID = 10385902758728957
    end
  end
  for i, e in pairs(l:GetChildren()) do
    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
      e.Enabled = false
    end
  end
end
CheckF = function()
  if GetBP("Dragon-Dragon") or GetBP("Gas-Gas") or GetBP("Yeti-Yeti") or GetBP("Kitsune-Kitsune") or GetBP("T-Rex-T-Rex") then return true end
end
CheckBoat = function()
  for i, v in pairs(workspace.Boats:GetChildren()) do
    if tostring(v.Owner.Value) == tostring(plr.Name) then
      return v    
end;
  end;
  return false
end;
CheckEnemiesBoat = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if (v.Name == "FishBoat") and v:FindFirstChild("Health").Value > 0 then
      return true    
end;
  end;
  return false
end;
CheckPirateGrandBrigade = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if (v.Name == "PirateGrandBrigade" or v.Name == "PirateBrigade") and v:FindFirstChild("Health").Value > 0 then
      return true
    end
  end
  return false
end
CheckShark = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if v.Name == "Shark" and Attack.Alive(v) then
      return true    
end;
  end;
  return false
end;
CheckTerrorShark = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if v.Name == "Terrorshark" and Attack.Alive(v) then
      return true    
end;
  end;
  return false
end;
CheckPiranha = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if v.Name == "Piranha" and Attack.Alive(v) then
      return true    
end;
  end;
  return false
end;
CheckFishCrew = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if (v.Name == "Fish Crew Member" or v.Name == "Haunted Crew Member") and Attack.Alive(v) then
      return true    
end;
  end;
  return false
end;
CheckHauntedCrew = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if (v.Name == "Haunted Crew Member") and Attack.Alive(v) then
      return true    
end;
  end;
  return false
end;
CheckSeaBeast = function()
  if workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
    return true  
end;
  return false
end;
CheckLeviathan = function()
  if workspace.SeaBeasts:FindFirstChild("Leviathan") then
    return true  
end;
  return false
end;
UpdStFruit = function()
  for z,x in next, plr.Backpack:GetChildren() do
  StoreFruit = x:FindFirstChild("EatRemote", true)
    if StoreFruit then
      replicated.Remotes.CommF_:InvokeServer("StoreFruit",StoreFruit.Parent:GetAttribute("OriginalName"),
      plr.Backpack:FindFirstChild(x.Name))
    end
  end
end
collectFruits = function(Succes)
  if Succes then
    local Character = plr.Character
    for _,v1 in pairs(workspace:GetChildren()) do
    if string.find(v1.Name, "Fruit") then v1.Handle.CFrame = Character.HumanoidRootPart.CFrame end
    end
  end
end
Getmoon = function()
  if World1 then
    return Lighting.FantasySky.MoonTextureId
  elseif World2 then
    return Lighting.FantasySky.MoonTextureId
  elseif World3 then
    return Lighting.Sky.MoonTextureId
  end
end
DropFruits = function()
  for _,v3 in next, plr.Backpack:GetChildren() do
    if string.find(v3.Name, "Fruit") then
      EquipWeapon(v3.Name) wait(.1)
      if plr.PlayerGui.Main.Dialogue.Visible == true then plr.PlayerGui.Main.Dialogue.Visible = false end EquipWeapon(v3.Name) plr.Character:FindFirstChild(v3.Name).EatRemote:InvokeServer("Drop")
    end
  end
  for a,b2 in pairs(plr.Character:GetChildren()) do
    if string.find(b2.Name, "Fruit") then EquipWeapon(b2.Name) wait(.1)
    if plr.PlayerGui.Main.Dialogue.Visible == true then plr.PlayerGui.Main.Dialogue.Visible = false end EquipWeapon(b2.Name) plr.Character:FindFirstChild(b2.Name).EatRemote:InvokeServer("Drop")
    end
  end
end
GetBP = function(v)
  return plr.Backpack:FindFirstChild(v) or plr.Character:FindFirstChild(v)
end
GetIn = function(Name)
  for _ ,v1 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
    if type(v1) == "table" then
      if v1.Name == Name or plr.Character:FindFirstChild(Name) or plr.Backpack:FindFirstChild(Name) then
        return true
	 end
    end
  end
  return false
end
GetM = function(Name)
  for _,tab in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
    if type(tab) == "table" then
	  if tab.Type == "Material" then
	    if tab.Name == Name then
		  return tab.Count
	    end
	  end
    end
  end
return 0
end
GetWP = function(nametool)
  for _,v4 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
    if type(v4) == "table" then
      if v4.Type == "Sword" then
        if v4.Name == nametool or plr.Character:FindFirstChild(nametool) or plr.Backpack:FindFirstChild(nametool) then
	     return true
	     end
	   end
      end
    end
  return false
end 
getInfinity_Ability = function(Method, Var)
  if not Root then return end
  if Method == "Soru" and Var then
    for _,gc in next, getgc() do
      if plr.Character.Soru then
        if ((typeof(gc) == "function") and (getfenv(gc).script == plr.Character.Soru)) then
          for _, v in next, getupvalues(gc) do
            if (typeof(v) == "table") then
              repeat wait(Sec) v.LastUse = 0 until not Var or (plr.Character.Humanoid.Health <= 0)
            end
          end
        end
      end
    end    
  elseif Method == "Energy" and Var then
    plr.Character.Energy.Changed:connect(function()
      if Var then plr.Character.Energy.Value = Energy end 
    end)
  elseif Method == "Observation" and Var then
    local VisionRadius = plr.VisionRadius
    VisionRadius.Value = math.huge
  end
end
Hop = function()
  pcall(function()
    for count = math.random(1, math.random(40, 75)), 100 do
      local remote = replicated.__ServerBrowser:InvokeServer(count)
	  for _, v in next, remote do
	  if tonumber(v['Count']) < 12 then TeleportService:TeleportToPlaceInstance(game.PlaceId, _) end
	  end    
    end
  end)
end
local block = Instance.new("Part", workspace)
block.Size = Vector3.new(1, 1, 1)
block.Name = "Rip_Indra"
block.Anchored = true
block.CanCollide = false
block.CanTouch = false
block.Transparency = 1
local blockfind = workspace:FindFirstChild(block.Name)
if blockfind and blockfind ~= block then blockfind:Destroy() end
task.spawn(function()while task.wait()do if block and block.Parent==workspace then if shouldTween then getgenv().OnFarm=true else getgenv().OnFarm=false end else getgenv().OnFarm=false end end end)
task.spawn(function()local a=game.Players.LocalPlayer;repeat task.wait()until a.Character and a.Character.PrimaryPart;block.CFrame=a.Character.PrimaryPart.CFrame;while task.wait()do pcall(function()if getgenv().OnFarm then if block and block.Parent==workspace then local b=a.Character and a.Character.PrimaryPart;if b and(b.Position-block.Position).Magnitude<=200 then b.CFrame=block.CFrame else block.CFrame=b.CFrame end end;local c=a.Character;if c then for d,e in pairs(c:GetChildren())do if e:IsA("BasePart")then e.CanCollide=false end end end else local c=a.Character;if c then for d,e in pairs(c:GetChildren())do if e:IsA("BasePart")then e.CanCollide=true end end end end end)end end)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

sea1 = (game.PlaceId == 2753915549 or game.PlaceId == 85211729168715)
sea2 = (game.PlaceId == 4442272183 or game.PlaceId == 79091703265657)
sea3 = (game.PlaceId == 7449423635 or game.PlaceId == 100117331123089)

local Settings = {
    ["Tween Speed"] = 1.5, -- bay (duration = distance/(100*speed))
    ["Bypass Teleport"] = false,
    ["Up Y"] = false,
    ["Up Y When Low Health"] = false,
    ["Same Y"] = false
}

local newdao = CFrame.new(10641.0918, -1953.92981, 9825.07031, -0.652825892, -9.2805891e-08, -0.757508039, -2.73638356e-08, 1, -9.89323823e-08, 0.757508039, -4.38572947e-08, -0.652825892)
local cframenpc = CFrame.new(-16271.126, 25.5847301, 1371.98755, 0.999396622, -5.78875188e-08, -0.0347310975, 5.52972779e-08, 1, -8.7544322e-08, 0.034731105, 8.28877091e-08, 0.999396741)

function Convert_CFrame(x)
    if not x then return end
    if typeof(x) == "Vector3" then
        return CFrame.new(x)
    elseif typeof(x) == "CFrame" then
        return x
    elseif typeof(x) == "Model" then
        return x:GetPivot()
    elseif x.CFrame then
        return x.CFrame
    end
    return nil
end

function GetDistance(POS_1, POS_2, NO_Y)
    if POS_1 == nil then return 9e9 end
    
    local Character = LocalPlayer.Character
    if not Character then return 9e9 end
    
    local Humanoid = Character:FindFirstChild("Humanoid")
    if not Humanoid or Humanoid.Health <= 0 then
        return 9e9
    end
    
    if POS_2 == nil then
        POS_2 = Character:FindFirstChild("HumanoidRootPart")
        if not POS_2 then return 9e9 end
    end
    
    local pos1 = Convert_CFrame(POS_1)
    local pos2 = Convert_CFrame(POS_2)
    
    if NO_Y then
        return (Vector3.new(pos1.X, 0, pos1.Z) - Vector3.new(pos2.X, 0, pos2.Z)).Magnitude
    else
        return (pos1.Position - pos2.Position).Magnitude
    end
end

function InArea(POS)
    local WorldOrigin = workspace:FindFirstChild("_WorldOrigin")
    if not WorldOrigin then return {Name = ""} end
    
    local pos = Convert_CFrame(POS)
    for i,v in next, WorldOrigin.Locations:GetChildren() do
        if v:FindFirstChild("Mesh") and (pos.Position - v.Position).Magnitude <= v.Mesh.Scale.X then
            return v
        end
    end
    return {Name = ""}
end

function GetSpawnPoint(x)
    local Spawns = workspace:FindFirstChild("_WorldOrigin") 
        and workspace._WorldOrigin:FindFirstChild("PlayerSpawns") 
        and workspace._WorldOrigin.PlayerSpawns:FindFirstChild("Pirates")
    if not Spawns then return end
    
    for i,v in next, Spawns:GetChildren() do
        if v:FindFirstChild("Part") and (v.Part.Position - x.Position).Magnitude <= 2500 then
            return v
        end
    end
end

function CheckLegendaryItems()
    local function CheckItem(ITEM_NAME)
        for i,v in next, LocalPlayer.Backpack:GetChildren() do
            if v:IsA('Tool') and (v.Name == ITEM_NAME or string.find(v.Name, ITEM_NAME)) then 
                return v 
            end
        end
        for i,v in next, LocalPlayer.Character:GetChildren() do
            if v:IsA('Tool') and (v.Name == ITEM_NAME or string.find(v.Name, ITEM_NAME)) then 
                return v 
            end
        end
    end
    
    if CheckItem("God's Chalice") or CheckItem("Fist of Darkness") or CheckItem("Sweet Chalice") or CheckItem("Hallow Essence") or CheckItem("Flower1") then
        return true
    end
    return false
end

function WaitForHumanoid()
    local Character = LocalPlayer.Character
    if not Character then return nil end
    
    local Humanoid = Character:FindFirstChild("Humanoid")
    if Humanoid then return Humanoid end
    
    local timeout = tick() + 5
    while tick() < timeout do
        Humanoid = Character:FindFirstChild("Humanoid")
        if Humanoid then return Humanoid end
        task.wait(0.1)
    end
    return nil
end

function checkinventory(v)
    if v then
        for i, vl in pairs(ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")) do
            if vl.Name == v then
                return true
            end
        end
    end
    return false
end

function getdis(a,b)
    b = b or LocalPlayer.Character.HumanoidRootPart.CFrame
    local _a = CFrame.new(a.X, b.Y, a.Z)
    local _b = CFrame.new(b.X,b.Y,b.Z)
    return (_a.Position - _b.Position).Magnitude
end

function CanBypassTeleport(x)
    local AreaName = InArea(x).Name
    if AreaName == "" then return false end
    
    if not Settings["Bypass Teleport"] 
        or AreaName:find("Dimension") 
        or AreaName:find("Submerged") 
        or AreaName == "Sealed Cavern" 
        or AreaName:lower():find("under") 
        or CheckLegendaryItems() then
        return false
    end
    
    if LocalPlayer.Data and LocalPlayer.Data.LastSpawnPoint and LocalPlayer.Data.LastSpawnPoint.Value == "SubmergedIsland" then 
        return false 
    end
    
    if GetDistance(x.Position) <= 3500 then
        return false
    end
    
    return true
end

function GetBypassCFrame(x)
    local Max = math.huge
    local Pos
    local Spawns = workspace._WorldOrigin.PlayerSpawns.Pirates:GetChildren()
    local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not HRP then return nil end
    
    for i,v in next, Spawns do
        if v:FindFirstChild("Part") then
            if (x.Position - HRP.Position).Magnitude >= 3000 
            and GetSpawnPoint(v.Part) ~= GetSpawnPoint(HRP) 
            and (v.Part.Position - HRP.Position).Magnitude <= 10000 
            and (v.Part.Position - x.Position).Magnitude <= Max then
                Max = (v.Part.Position - x.Position).Magnitude
                Pos = v
            end
        end
    end
    return Pos
end

function BypassTP(Target)
    local Character = LocalPlayer.Character
    if not Character then return end
    
    local Humanoid = WaitForHumanoid()
    if not Humanoid or Humanoid.Health <= 0 then return end
    
    if CanBypassTeleport(Target) and GetBypassCFrame(Target) then
        local TargetTP = GetBypassCFrame(Target)
        if TargetTP and TargetTP:FindFirstChild("Part") then
            Character.LastSpawnPoint.Disabled = true
            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetLastSpawnPoint", TargetTP.Name)
            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
            Character:PivotTo(TargetTP.Part.CFrame)
            Humanoid:ChangeState(15)
            
            repeat 
                task.wait() 
            until LocalPlayer.Character and WaitForHumanoid() and WaitForHumanoid().Health > 0
        end
    end
end

function totopofgreattree()
    if getdis(CFrame.new(28310.0234, 14895.1123, 109.456741)) > 1500 then
        ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28310.0234, 14895.1123, 109.456741))
        wait(0.3)
    end
    
    local targetCF = CFrame.new(28607.5352, 14896.5449, 106.011726)
    _tp(targetCF)
    
    repeat
        wait()
    until getdis(targetCF) <= 5
    
    wait(0.5)
    for i = 1, 4 do
        ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "TeleportBack")
    end
end

function requestentrance(pos)
    local tb = {}
    local targetPos = pos
    
    if typeof(pos) == "CFrame" then
        targetPos = pos.Position
    end
    
    if sea1 then
        tb = {
            ["Sky3"] = Vector3.new(-7894, 5547, -380),
            ["Sky3Exit"] = Vector3.new(-4607, 874, -1667),
            ["UnderWater"] = Vector3.new(61163, 11, 1819),
            ["Underwater City"] = Vector3.new(61165.19140625, 0.18704631924629211, 1897.379150390625),
            ["Pirate Village"] = Vector3.new(-1242.4625244140625, 4.787059783935547, 3901.282958984375),
            ["UnderwaterExit"] = Vector3.new(4050, -1, -1814)
        }
    elseif sea2 then
        tb = {
            ["Swan Mansion"] = Vector3.new(-390, 332, 673),
            ["Swan Room"] = Vector3.new(2285, 15, 905),
            ["Cursed Ship"] = Vector3.new(923, 126, 32852),
            ["Zombie Island"] = Vector3.new(-6509, 83, -133)
        }
    else
        tb = {
            ["Hydra Island"] = Vector3.new(5657.88623046875, 1013.0790405273438, -335.4996337890625),
            ["Mansion"] = Vector3.new(-12462, 375, -7552),
            ["Castle"] = Vector3.new(-5036, 315, -3179),
            ["Temple of Time"] = Vector3.new(28286, 14897, 103),
            ["Greate Tree"] = Vector3.new(3024.1709, 2280.69434, -7325.12793)
        }
        if not checkinventory("Valkyrie Helm") then
            return
        end
    end
    
    local x, y = nil, math.huge
    for i, v in pairs(tb) do
        local distance = (typeof(v) == "Vector3" and (v - targetPos).Magnitude) or (v.Position - targetPos).Magnitude
        if distance < y then
            y = distance
            x = v
        end
    end
    
    if x and y and y < getdis(pos) then
        pcall(function ()
            if _G.TweenCache then
                _G.TweenCache:Cancel()
            end
        end)
        
        if typeof(x) == "Vector3" 
            and x.X == 3024.1709 and x.Y == 2280.69434 and x.Z == -7325.12793
            and ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Check") >= 2 then
            totopofgreattree()
            wait(1)
        elseif y < getdis(pos) then
            local requestPos = typeof(x) == "Vector3" and x or x.Position
            ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", requestPos)
            wait(1)
        end
    end
end

_tp = function(target)
    local gg
    if typeof(target) == "Vector3" then
        gg = CFrame.new(target)
    elseif typeof(target) == "CFrame" then
        gg = target
    else
        gg = target and target.CFrame
    end
    
    if not gg then return end
    
    local character = plr.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = character.HumanoidRootPart
    
    pcall(function()
        if CanBypassTeleport(gg) then
            BypassTP(gg)
            task.wait(0.5)
        end
    end)
    
    pcall(function()
        requestentrance(target)
    end)
    
    if sea3 and getdis(gg.Position, newdao.Position) < 2000 then
        local hrp = plr.Character.HumanoidRootPart
        if math.abs(newdao.Position.Y - hrp.CFrame.Y) > 1000 then
            repeat
                task.wait()
                old_tp(cframenpc)
                if getdis(cframenpc) < 10 then
                    local net = ReplicatedStorage.Modules.Net
                    net["RF/SubmarineWorkerSpeak"]:InvokeServer("AskKilledTikiBoss")
                    task.wait(0.5)
                    net["RF/SubmarineWorkerSpeak"]:InvokeServer("TravelToSubmergedIsland")
                end
            until getdis(gg.Position) < 2000
            task.wait(0.6)
            pcall(function()
                if hrp:FindFirstChild("BodyClip") then
                    hrp.BodyClip:Destroy()
                end
            end)
        end
    end
    
    local distance = (gg.Position - rootPart.Position).Magnitude
    local tweenInfo = TweenInfo.new(distance / math.max(50, (Settings["Tween Speed"] or 1.5) * 100), Enum.EasingStyle.Linear)
    local tween = game:GetService("TweenService"):Create(block, tweenInfo, {CFrame = gg})    
    
    if plr.Character.Humanoid.Sit == true then
        block.CFrame = CFrame.new(block.Position.X, gg.Y, block.Position.Z)
    end  
    
    tween:Play()    
    
    task.spawn(function() 
        while tween.PlaybackState == Enum.PlaybackState.Playing do 
            if not shouldTween then 
                tween:Cancel() 
                break 
            end 
            task.wait(0.1) 
        end 
    end)
    
    return tween
end

old_tp = function(p) 
    local char = plr.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = p 
    end
end

TeleportToTarget = function(targetCFrame) if (targetCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude > 1000 then _tp(targetCFrame)else _tp(targetCFrame)end end
notween = function(p) plr.Character.HumanoidRootPart.CFrame = p end
function BTP(p)
    local player = game.Players.LocalPlayer
    local humanoidRootPart = player.Character.HumanoidRootPart
    local humanoid = player.Character.Humanoid
    local playerGui = player.PlayerGui.Main
    local targetPosition = p.Position
    local lastPosition = humanoidRootPart.Position
    repeat
        humanoid.Health = 0
        humanoidRootPart.CFrame = p
        playerGui.Quest.Visible = false
        if (humanoidRootPart.Position - lastPosition).Magnitude > 1 then
            lastPosition = humanoidRootPart.Position
            humanoidRootPart.CFrame = p
        end
        task.wait(0.5)
    until (p.Position - humanoidRootPart.Position).Magnitude <= 2000
end
spawn(function()
  while task.wait() do
    pcall(function()
      if _G.SailBoat_Hydra or _G.WardenBoss or _G.AutoFactory or _G.HighestMirage or _G.HCM or _G.PGB or _G.Leviathan1 or _G.UPGDrago or _G.Complete_Trials or _G.TpDrago_Prehis or _G.BuyDrago or _G.AutoFireFlowers or _G.DT_Uzoth or _G.AutoBerry or _G.Prefully or _G.Prehis_Find or _G.Prehis_Skills or _G.Prehis_DB or _G.Prehis_DE or _G.FarmBlazeEM or _G.Dojoo or _G.CollectPresent or _G.AutoLawKak or _G.TpLab or _G.AutoPhoenixF or _G.AutoFarmChest or _G.AutoHytHallow or _G.LongsWord or _G.BlackSpikey or _G.AutoHolyTorch or _G.TrainDrago  or _G.AutoSaber or _G.FarmMastery_Dev or _G.CitizenQuest or _G.AutoEctoplasm or _G.KeysRen or _G.Auto_Rainbow_Haki or _G.obsFarm or _G.AutoBigmom or _G.Doughv2 or _G.AuraBoss or _G.Raiding or _G.Auto_Cavender or _G.TpPly or _G.Bartilo_Quest or _G.Level or _G.FarmEliteHunt or _G.AutoZou or _G.AutoFarm_Bone or getgenv().AutoMaterial or _G.CraftVM or _G.FrozenTP or _G.TPDoor or _G.AcientOne or _G.AutoFarmNear or _G.AutoRaidCastle or _G.DarkBladev3 or _G.AutoFarmRaid or _G.Auto_Cake_Prince or _G.Addealer or _G.TPNpc or _G.TwinHook or _G.FindMirage or _G.FarmChestM or _G.Shark or _G.TerrorShark or _G.Piranha or _G.MobCrew or _G.SeaBeast1 or _G.FishBoat or _G.AutoPole or _G.AutoPoleV2 or _G.Auto_SuperHuman or _G.AutoDeathStep or _G.Auto_SharkMan_Karate or _G.Auto_Electric_Claw or _G.AutoDragonTalon or _G.Auto_Def_DarkCoat or _G.Auto_God_Human or _G.Auto_Tushita or _G.AutoMatSoul or _G.AutoKenVTWO or _G.AutoSerpentBow or _G.AutoFMon or _G.Auto_Soul_Guitar or _G.TPGEAR or _G.AutoSaw or _G.AutoTridentW2 or _G.AutoEvoRace or _G.AutoGetQuestBounty or _G.MarinesCoat or _G.TravelDres or _G.Defeating or _G.DummyMan or _G.Auto_Yama or _G.Auto_SwanGG or _G.SwanCoat or _G.AutoEcBoss or _G.Auto_Mink or _G.Auto_Human or _G.Auto_Skypiea or _G.Auto_Fish or _G.CDK_TS or _G.CDK_YM or _G.CDK or _G.AutoFarmGodChalice or _G.AutoFistDarkness or _G.AutoMiror or _G.Teleport or _G.AutoKilo or _G.AutoGetUsoap or _G.Praying or _G.TryLucky or _G.AutoColShad or _G.AutoUnHaki or _G.Auto_DonAcces or _G.AutoRipIngay or _G.DragoV3 or _G.DragoV1 or _G.SailBoats or NextIs or _G.FarmGodChalice or _G.IceBossRen or senth or senth2 or _G.Lvthan or _G.beasthunter or _G.DangerLV or _G.Relic123 or _G.tweenKitsune or _G.Collect_Ember or _G.AutofindKitIs or _G.snaguine or _G.TwFruits or _G.tweenKitShrine or _G.Tp_LgS or _G.Tp_MasterA or _G.tweenShrine or _G.FarmMastery_G or _G.FarmMastery_S or _G.FarmBoss or _G.AutoFarmAllBoss or _G.AutoFishSlap or _G.FarmTyrant or _G.FarmPhaBinh or _G.AutoSpawnCP or _G.AutoBerryH or _G.AutoChestBP or _G.FarmEliteHop or _G.AutoHop_Dough or _G.AutoDoughKing or _G.AutoAttackDoughKing or _G.AutoChipFruit or _G.AutoChipBeli or _G.StartEvent or _G.AutoMysticIsland or _G.AutoPlayerHunter or _G.SafeMode or _G.AutoKillMob or _G.AutoStartPrehistoric or _G.AutoUnHaki or _G.AutoAttackRipIndra or _G.AutoFarmIsland or _G.AutoFarmDungeon or _G.AutoFarmCandy or _G.AutoTP_Gift or _G.AutoTPGift or _G.AutoTPAndCollect or _G.MasterAutoLevel or _G.MasterAutoCandy or _G.TPFloor1 or _G.TPFloor2 or _G.TPFloor3 or _G.TPFloor4 then
        shouldTween = true
        if not plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
          local Noclip = Instance.new("BodyVelocity")
          Noclip.Name = "BodyClip"
          Noclip.Parent = plr.Character.HumanoidRootPart
          Noclip.MaxForce = Vector3.new(100000,100000,100000)
          Noclip.Velocity = Vector3.new(0,0,0)
        end        
      if not plr.Character:FindFirstChild("highlight") then
    local Test = Instance.new("Highlight")
    Test.Name = "highlight"
    Test.Enabled = true
    Test.FillColor = Color3.fromRGB(255,255,255)
    Test.OutlineColor = Color3.fromRGB(255,255,255)
    Test.FillTransparency = 0.5
    Test.OutlineTransparency = 0.2
    Test.Parent = plr.Character
end
        for _, no in pairs(plr.Character:GetDescendants()) do if no:IsA("BasePart") then no.CanCollide = false end end
      else
        shouldTween = false
        if plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then plr.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy() end
        if plr.Character:FindFirstChild('highlight') then plr.Character:FindFirstChild('highlight'):Destroy() end	        
      end
    end)
  end
end)
QuestB = function()
				if World1 then
					if _G.FindBoss == "The Gorilla King" then
						bMon = "The Gorilla King"
						Qname = "JungleQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
						PosB = CFrame.new(-1088.75977, 8.13463783, -488.559906, -0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, -0.707134247)
					elseif _G.FindBoss == "Bobby" then
						bMon = "Bobby"
						Qname = "BuggyQuest1"
						Qdata = 3;
						PosQBoss = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
						PosB = CFrame.new(-1087.3760986328, 46.949409484863, 4040.1462402344)
					elseif _G.FindBoss == "The Saw" then
						bMon = "The Saw"
						PosB = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906)
					elseif _G.FindBoss == "Yeti" then
						bMon = "Yeti"
						Qname = "SnowQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
						PosB = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
					elseif _G.FindBoss == "Mob Leader" then
						bMon = "Mob Leader"
						PosB = CFrame.new(-2844.7307128906, 7.4180502891541, 5356.6723632813)
					elseif _G.FindBoss == "Vice Admiral" then
						bMon = "Vice Admiral"
						Qname = "MarineQuest2"
						Qdata = 2;
						PosQBoss = CFrame.new(-5036.2465820313, 28.677835464478, 4324.56640625)
						PosB = CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375)
					elseif _G.FindBoss == "Saber Expert" then
						bMon = "Saber Expert"
						PosB = CFrame.new(-1458.89502, 29.8870335, -50.633564)
					elseif _G.FindBoss == "Warden" then
						bMon = "Warden"
						Qname = "ImpelQuest"
						Qdata = 1;
						PosB = CFrame.new(5278.04932, 2.15167475, 944.101929, 0.220546961, -4.49946401e-06, 0.975376427, -1.95412576e-05, 1, 9.03162072e-06, -0.975376427, -2.10519756e-05, 0.220546961)
						PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
					elseif _G.FindBoss == "Chief Warden" then
						bMon = "Chief Warden"
						Qname = "ImpelQuest"
						Qdata = 2;
						PosB = CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, -0.00062915677, 0.939684749, 0.00191645394, 0.999998152, -2.80422337e-05, -0.939682961, 0.00181045406, 0.342041939)
						PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
					elseif _G.FindBoss == "Swan" then
						bMon = "Swan"
						Qname = "ImpelQuest"
						Qdata = 3;
						PosB = CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, 0.951042235, 0, 1, 0, -0.951042235, 0, -0.309060812)
						PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
					elseif _G.FindBoss == "Magma Admiral" then
						bMon = "Magma Admiral"
						Qname = "MagmaQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(-5314.6220703125, 12.262420654297, 8517.279296875)
						PosB = CFrame.new(-5765.8969726563, 82.92064666748, 8718.3046875)
					elseif _G.FindBoss == "Fishman Lord" then
						bMon = "Fishman Lord"
						Qname = "FishmanQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
						PosB = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984)
					elseif _G.FindBoss == "Wysper" then
						bMon = "Wysper"
						Qname = "SkyExp1Quest"
						Qdata = 3;
						PosQBoss = CFrame.new(-7861.947265625, 5545.517578125, -379.85974121094)
						PosB = CFrame.new(-7866.1333007813, 5576.4311523438, -546.74816894531)
					elseif _G.FindBoss == "Thunder God" then
						bMon = "Thunder God"
						Qname = "SkyExp2Quest"
						Qdata = 3;
						PosQBoss = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
						PosB = CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188)
					elseif _G.FindBoss == "Cyborg" then
						bMon = "Cyborg"
						Qname = "FountainQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
						PosB = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813)
					elseif _G.FindBoss == "Ice Admiral" then
						bMon = "Ice Admiral"
						Qdata = nil;
						PosQBoss = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
						PosB = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
					elseif _G.FindBoss == "Greybeard" then
						bMon = "Greybeard"
						Qdata = nil;
						PosQBoss = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
						PosB = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
					end
				end;
				if World2 then
					if _G.FindBoss == "Diamond" then
						bMon = "Diamond"
						Qname = "Area1Quest"
						Qdata = 3;
						PosQBoss = CFrame.new(-427.5666809082, 73.313781738281, 1835.4208984375)
						PosB = CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407)
					elseif _G.FindBoss == "Jeremy" then
						bMon = "Jeremy"
						Qname = "Area2Quest"
						Qdata = 3;
						PosQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063)
						PosB = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109)
					elseif _G.FindBoss == "Orbitus" then
						bMon = "Orbitus"
						Qname = "MarineQuest3"
						Qdata = 3;
						PosQBoss = CFrame.new(-2441.986328125, 73.359344482422, -3217.5324707031)
						PosB = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625)
					elseif _G.FindBoss == "Don Swan" then
						bMon = "Don Swan"
						PosB = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875)
					elseif _G.FindBoss == "Smoke Admiral" then
						bMon = "Smoke Admiral"
						Qname = "IceSideQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
						PosB = CFrame.new(-5275.1987304688, 20.757257461548, -5260.6669921875)
					elseif _G.FindBoss == "Awakened Ice Admiral" then
						bMon = "Awakened Ice Admiral"
						Qname = "FrostQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813)
						PosB = CFrame.new(6403.5439453125, 340.29766845703, -6894.5595703125)
					elseif _G.FindBoss == "Tide Keeper" then
						bMon = "Tide Keeper"
						Qname = "ForgottenQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625)
						PosB = CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188)
					elseif _G.FindBoss == "Darkbeard" then
						bMon = "Darkbeard"
						Qdata = nil;
						PosQBoss = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
						PosB = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
					elseif _G.FindBoss == "Cursed Captaim" then
						bMon = "Cursed Captain"
						Qdata = nil;
						PosQBoss = CFrame.new(916.928589, 181.092773, 33422)
						PosB = CFrame.new(916.928589, 181.092773, 33422)
					elseif _G.FindBoss == "Order" then
						bMon = "Order"
						Qdata = nil;
						PosQBoss = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
						PosB = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
					end
				end;
				if World3 then
					if _G.FindBoss == "Stone" then
						bMon = "Stone"
						Qname = "PiratePortQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(-289.76705932617, 43.819011688232, 5579.9384765625)
						PosB = CFrame.new(-1027.6512451172, 92.404174804688, 6578.8530273438)
					elseif _G.FindBoss == "Hydra Leader" then
						bMon = "Hydra Leader"
						Qname = "VenomCrewQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(5211.021484375, 1004.35778859375, 758.1847534179688)
						PosB = CFrame.new(5821.89794921875, 1019.0950927734375, -73.71923065185547)
					elseif _G.FindBoss == "Kilo Admiral" then
						bMon = "Kilo Admiral"
						Qname = "MarineTreeIsland"
						Qdata = 3;
						PosQBoss = CFrame.new(2179.3010253906, 28.731239318848, -6739.9741210938)
						PosB = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125)
					elseif _G.FindBoss == "Captain Elephant" then
						bMon = "Captain Elephant"
						Qname = "DeepForestIsland"
						Qdata = 3;
						PosQBoss = CFrame.new(-13232.682617188, 332.40396118164, -7626.01171875)
						PosB = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)
					elseif _G.FindBoss == "Beautiful Pirate" then
						bMon = "Beautiful Pirate"
						Qname = "DeepForestIsland2"
						Qdata = 3;
						PosQBoss = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
						PosB = CFrame.new(5283.609375, 22.56223487854, -110.78285217285)
					elseif _G.FindBoss == "Cake Queen" then
						bMon = "Cake Queen"
						Qname = "IceCreamIslandQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
						PosB = CFrame.new(-678.648804, 381.353943, -11114.2012, -0.908641815, 0.00149294338, 0.41757378, 0.00837114919, 0.999857843, 0.0146408929, -0.417492568, 0.0167988986, -0.90852499)
					elseif _G.FindBoss == "Longma" then
						bMon = "Longma"
						Qdata = nil;
						PosQBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
						PosB = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
					elseif _G.FindBoss == "Soul Reaper" then
						bMon = "Soul Reaper"
						Qdata = nil;
						PosQBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
						PosB = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
					end
				end
			end
			QuestBeta = function()
				local Neta = QuestB()
				return {
					[0] = _G.FindBoss,
					[1] = bMon,
					[2] = Qdata,
					[3] = Qname,
					[4] = PosB,
					[5] = PosQBoss,
				}  
			end

local Quests = require(game:GetService("ReplicatedStorage"):WaitForChild("Quests"))
local GuideModule = require(game:GetService("ReplicatedStorage"):WaitForChild("GuideModule"))

local blacklistquest = {
    "MarineQuest",
    "BartiloQuest",
    "CitizenQuest",
    "Trainees"
}

CheckSea = function(b)
    if (game.PlaceId == 2753915549 or game.PlaceId == 85211729168715) and b == 1 then
        return true
    elseif (game.PlaceId == 4442272183 or game.PlaceId == 79091703265657) and b == 2 then
        return true
    elseif (game.PlaceId == 7449423635 or game.PlaceId == 100117331123089) and b == 3 then
        return true
    end
    return false
end

GetQuestPointFromNPC = function(npcName)
    for _, npc in pairs(workspace.NPCs:GetChildren()) do
        if npc.Name == npcName and npc:FindFirstChild("HumanoidRootPart") then
            return npc.HumanoidRootPart.CFrame
        end
    end
    for _, npc in pairs(replicated.NPCs:GetChildren()) do
        if npc.Name == npcName and npc:FindFirstChild("HumanoidRootPart") then
            return npc.HumanoidRootPart.CFrame
        end
    end
    return nil
end

GetQuests = function()
    local lvl = plr.Data.Level.Value
    local LevelReq = 0
    local mmb = {}
    
    if lvl >= 700 and CheckSea(1) then
        mmb["Mob"] = "Galley Captain"
        mmb["NameQuest"] = "FountainQuest"
        mmb["ID"] = 2
        mmb["LevelReq"] = 700
    elseif lvl >= 1500 and CheckSea(2) then
        mmb["Mob"] = "Water Fighter"
        mmb["NameQuest"] = "ForgottenQuest"
        mmb["ID"] = 2
        mmb["LevelReq"] = 1450
    else
        for r, v in pairs(Quests) do
            for id, v1 in pairs(v) do
                local LvReq = v1.LevelReq
                for nguoi, tinh in pairs(v1.Task) do
                    if lvl >= LvReq and LevelReq <= LvReq and v1.Task[nguoi] > 1 and not table.find(blacklistquest, r) then
                        LevelReq = LvReq
                        mmb["Mob"] = nguoi
                        mmb["NameQuest"] = r
                        mmb["ID"] = id
                        mmb["LevelReq"] = LvReq
                    end
                end
            end
        end
    end
    
    return mmb
end

GetQuestPoint = function()
    if GuideModule and GuideModule.Data and GuideModule.Data.LastClosestNPC then
        return GetQuestPointFromNPC(GuideModule.Data.LastClosestNPC)
    end
    return nil
end

MaterialMon=function()local a=game.Players.LocalPlayer;local b=a.Character and a.Character:FindFirstChild("HumanoidRootPart")if not b then return end;shouldRequestEntrance=function(c,d)local e=(b.Position-c).Magnitude;if e>=d then replicated.Remotes.CommF_:InvokeServer("requestEntrance",c)end end;if World1 then if SelectMaterial=="Angel Wings"then MMon={"Shanda","Royal Squad","Royal Soldier","Wysper","Thunder God"}MPos=CFrame.new(-4698,845,-1912)SP="Default"local c=Vector3.new(-4607.82275,872.54248,-1667.55688)shouldRequestEntrance(c,10000)elseif SelectMaterial=="Leather + Scrap Metal"then MMon={"Brute","Pirate"}MPos=CFrame.new(-1145,15,4350)SP="Default"elseif SelectMaterial=="Magma Ore"then MMon={"Military Soldier","Military Spy","Magma Admiral"}MPos=CFrame.new(-5815,84,8820)SP="Default"elseif SelectMaterial=="Fish Tail"then MMon={"Fishman Warrior","Fishman Commando","Fishman Lord"}MPos=CFrame.new(61123,19,1569)SP="Default"local c=Vector3.new(61163.8515625,5.342342376708984,1819.7841796875)shouldRequestEntrance(c,17000)end elseif World2 then if SelectMaterial=="Leather + Scrap Metal"then MMon={"Marine Captain"}MPos=CFrame.new(-2010.5059814453125,73.00115966796875,-3326.620849609375)SP="Default"elseif SelectMaterial=="Magma Ore"then MMon={"Magma Ninja","Lava Pirate"}MPos=CFrame.new(-5428,78,-5959)SP="Default"elseif SelectMaterial=="Ectoplasm"then MMon={"Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer"}MPos=CFrame.new(911.35827636719,125.95812988281,33159.5390625)SP="Default"local c=Vector3.new(61163.8515625,5.342342376708984,1819.7841796875)shouldRequestEntrance(c,18000)elseif SelectMaterial=="Mystic Droplet"then MMon={"Water Fighter"}MPos=CFrame.new(-3385,239,-10542)SP="Default"elseif SelectMaterial=="Radioactive Material"then MMon={"Factory Staff"}MPos=CFrame.new(295,73,-56)SP="Default"elseif SelectMaterial=="Vampire Fang"then MMon={"Vampire"}MPos=CFrame.new(-6033,7,-1317)SP="Default"end elseif World3 then if SelectMaterial=="Scrap Metal"then MMon={"Jungle Pirate","Forest Pirate"}MPos=CFrame.new(-11975.78515625,331.7734069824219,-10620.0302734375)SP="Default"elseif SelectMaterial=="Fish Tail"then MMon={"Fishman Raider","Fishman Captain"}MPos=CFrame.new(-10993,332,-8940)SP="Default"elseif SelectMaterial=="Conjured Cocoa"then MMon={"Chocolate Bar Battler","Cocoa Warrior"}MPos=CFrame.new(620.6344604492188,78.93644714355469,-12581.369140625)SP="Default"elseif SelectMaterial=="Dragon Scale"then MMon={"Dragon Crew Archer","Dragon Crew Warrior"}MPos=CFrame.new(6594,383,139)SP="Default"elseif SelectMaterial=="Gunpowder"then MMon={"Pistol Billionaire"}MPos=CFrame.new(-84.8556900024414, 85.62061309814453, 6132.0087890625)SP="Default"elseif SelectMaterial=="Mini Tusk"then MMon={"Mythological Pirate"}MPos=CFrame.new(-13545,470,-6917)SP="Default"elseif SelectMaterial=="Demonic Wisp"then MMon={"Demonic Soul"}MPos=CFrame.new(-9495.6806640625,453.58624267578125,5977.3486328125)SP="Default"end end end
QuestNeta = function()
    local questData = GetQuests()
    return {
        [1] = questData.Mob,           
        [2] = questData.ID,             
        [3] = questData.NameQuest,      
        [4] = questData.LevelReq,       
        [5] = questData.Mob,             
        [6] = GetQuestPoint()            
    }
end

-- ========================================
-- ========================================
-- UiRedzV5 DemoUi (daucobonhi) + AddMinimizeButton
-- Không đổi kích thước menu (giữ default lib)
-- ========================================

-- ============================================================
-- REDZ LIBRARY V5 DemoUi (daucobonhi)
-- ============================================================
local redzlib = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/daucobonhi/UiRedzV5/refs/heads/main/DemoUi.lua"
))()

local RealWindow = redzlib:MakeWindow({
	Title = "nyann os",
	SubTitle = "by real_@nyannnokonoko",
	SaveFolder = "NyannOS_BF.lua",
})

-- Minimize (DemoUi AddMinimizeButton)
do
	local added = false
	pcall(function()
		if RealWindow.AddMinimizeButton then
			RealWindow:AddMinimizeButton({
				Button = {
					Image = "rbxassetid://94678517792779",
					BackgroundTransparency = 0,
				},
				Corner = {
					CornerRadius = UDim.new(0, 6),
				},
			})
			added = true
		end
	end)

	pcall(function()
		if not added and RealWindow.NewMinimizer then
			local Minimizer = RealWindow:NewMinimizer({
				KeyCode = Enum.KeyCode.LeftControl,
			})
			if Minimizer and Minimizer.CreateMobileMinimizer then
				Minimizer:CreateMobileMinimizer({
					Image = "rbxassetid://94678517792779",
					BackgroundTransparency = 0,
					BackgroundColor3 = Color3.fromRGB(20, 20, 20),
					Size = UDim2.fromOffset(48, 48),
				})
				added = true
			end
		end
	end)

	if not added then
		pcall(function()
			local CoreGui = game:GetService("CoreGui")
			local UIS = game:GetService("UserInputService")
			local gethui = gethui or function() return CoreGui end
			local sg = Instance.new("ScreenGui")
			sg.Name = "NyannMinimize"
			sg.ResetOnSpawn = false
			sg.DisplayOrder = 999999
			sg.IgnoreGuiInset = true
			pcall(function() sg.Parent = gethui() end)

			local btn = Instance.new("ImageButton")
			btn.Size = UDim2.fromOffset(48, 48)
			btn.Position = UDim2.fromScale(0.15, 0.25)
			btn.AnchorPoint = Vector2.new(0.5, 0.5)
			btn.Image = "rbxassetid://94678517792779"
			btn.BackgroundTransparency = 0
			btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			btn.AutoButtonColor = false
			btn.Parent = sg

			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, 6)
			corner.Parent = btn

			btn.MouseButton1Click:Connect(function()
				pcall(function()
					if RealWindow.Minimize then RealWindow:Minimize()
					elseif RealWindow.MinimizeBtn then RealWindow:MinimizeBtn()
					end
				end)
			end)

			local dragging, dragStart, startPos
			btn.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					dragStart = input.Position
					startPos = btn.Position
				end
			end)
			btn.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = false
				end
			end)
			UIS.InputChanged:Connect(function(input)
				if not dragging then return end
				if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
				local d = input.Position - dragStart
				btn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
			end)
		end)
	end
end

-- ============================================================
-- Shim (tuong thich code cu)
-- ============================================================
local Window = {}

local function MakeTabShim(page)
	local tab = {}

	function tab:AddSection(name)
		pcall(function()
			page:AddSection(tostring(name or "Section"))
		end)
	end

	function tab:AddToggle(cfg)
		cfg = type(cfg) == "table" and cfg or { Name = tostring(cfg) }
		local obj
		pcall(function()
			obj = page:AddToggle({
				Name = cfg.Name or cfg.Title or "Toggle",
				Description = cfg.Description,
				Default = cfg.Default or false,
				Callback = cfg.Callback or function() end,
			})
		end)
		return {
			Set = function(_, v)
				pcall(function()
					if obj and obj.Set then obj:Set(v)
					elseif obj and obj.SetValue then obj:SetValue(v)
					elseif obj and obj.SetStage then obj:SetStage(v)
					end
				end)
			end,
			SetValue = function(self, v) self:Set(v) end,
			SetStage = function(self, v) self:Set(v) end,
		}
	end

	function tab:AddDropdown(cfg)
		cfg = type(cfg) == "table" and cfg or {}
		local def = cfg.Default
		if def == "nil" then def = nil end
		pcall(function()
			page:AddDropdown({
				Name = cfg.Name or cfg.Title or "Dropdown",
				Options = cfg.Options or cfg.List or {},
				Default = def,
				MultiSelect = cfg.MultiSelect,
				Callback = cfg.Callback or function() end,
			})
		end)
		return {}
	end

	function tab:AddSlider(cfg)
		cfg = type(cfg) == "table" and cfg or {}
		pcall(function()
			page:AddSlider({
				Name = cfg.Name or cfg.Title or "Slider",
				Min = cfg.Min or 0,
				Max = cfg.Max or 100,
				Default = cfg.Default or cfg.Min or 0,
				Increment = cfg.Increment or 1,
				Callback = cfg.Callback or function() end,
			})
		end)
		return {}
	end

	function tab:AddButton(cfg)
		cfg = type(cfg) == "table" and cfg or { Name = tostring(cfg) }
		pcall(function()
			page:AddButton({
				Name = cfg.Name or cfg.Title or "Button",
				Callback = cfg.Callback or function() end,
			})
		end)
		return {}
	end

	function tab:AddParagraph(title, desc)
		local para
		pcall(function()
			para = page:AddParagraph(tostring(title or ""), tostring(desc or ""))
		end)
		local proxy = { _para = para }
		function proxy:SetDesc(value)
			pcall(function()
				if para and para.SetDesc then para:SetDesc(tostring(value or ""))
				elseif para and para.SetDescription then para:SetDescription(tostring(value or ""))
				elseif para and para.Set then para:Set(tostring(value or ""))
				end
			end)
		end
		function proxy:SetDescription(v) self:SetDesc(v) end
		function proxy:Set(v)
			pcall(function()
				if para and para.SetTitle then para:SetTitle(tostring(v or ""))
				elseif para and para.Set then para:Set(tostring(v or ""))
				end
			end)
		end
		return proxy
	end

	function tab:AddTextBox(cfg)
		cfg = type(cfg) == "table" and cfg or {}
		local name = cfg.Name or cfg.Title or "TextBox"
		local placeholder = cfg.Placeholder or cfg.Default or ""
		local cb = cfg.Callback or function() end
		pcall(function()
			if page.AddTextBox then
				page:AddTextBox({ Name = name, Default = placeholder, Placeholder = placeholder, Callback = cb })
			elseif page.AddTextbox then
				page:AddTextbox({ Name = name, Default = placeholder, Callback = cb })
			end
		end)
		return {}
	end

	function tab:AddDiscordInvite(cfg)
		cfg = cfg or {}
		pcall(function()
			if page.AddDiscordInvite then
				page:AddDiscordInvite(cfg)
			else
				page:AddButton({
					Name = cfg.Title or "Discord",
					Callback = function()
						if cfg.Invite and setclipboard then
							pcall(setclipboard, tostring(cfg.Invite))
						end
					end,
				})
			end
		end)
		return {}
	end

	return tab
end

function Window:MakeTab(cfg)
	cfg = cfg or {}
	local title = tostring(cfg.Title or cfg.Name or "Tab")
	local icon = cfg.Icon
	local page
	pcall(function()
		page = RealWindow:MakeTab({ title, icon or "Info" })
	end)
	if not page then
		pcall(function()
			page = RealWindow:MakeTab({ Name = title, Title = title, Icon = icon })
		end)
	end
	return MakeTabShim(page)
end

function Window:Notify(opts)
	opts = opts or {}
	pcall(function()
		if RealWindow.Notify then
			RealWindow:Notify({
				Title = opts.Title or "nyann os",
				Content = opts.Content or opts.Message or opts.Description or "",
				Duration = opts.Duration or 3,
			})
		end
	end)
end

function Window:NewMinimizer(cfg)
	return RealWindow:NewMinimizer(cfg)
end

function Window:Minimize()
	pcall(function()
		if RealWindow.Minimize then RealWindow:Minimize()
		elseif RealWindow.MinimizeButton then RealWindow:MinimizeButton()
		end
	end)
end

print("[nyann os] Redz V5 (id202azh) ready")



local Tabs = {
	Info = Window:MakeTab({ Title = "Information", Icon = "info" }),
	Main = Window:MakeTab({ Title = "Main", Icon = "home" }),
	Settings = Window:MakeTab({ Title = "Setting", Icon = "settings" }),
	Fish = Window:MakeTab({ Title = "Fishing", Icon = "fish" }),
	Race = Window:MakeTab({ Title = "Race V4", Icon = "moon" }),
	SeaEvent = Window:MakeTab({ Title = "Sea Event", Icon = "waves" }),
	Raids = Window:MakeTab({ Title = "Fruit And Raid", Icon = "cherry" }),
	Misc = Window:MakeTab({ Title = "Miscellaneous", Icon = "box" }),
}

local function _dummyTab()
	return {
		AddSection = function() end,
		AddToggle = function() return { Set = function() end } end,
		AddDropdown = function() return {} end,
		AddSlider = function() return {} end,
		AddParagraph = function() return { SetDesc = function() end } end,
		AddButton = function() return {} end,
		AddDiscordInvite = function() end,
		AddTextBox = function() return {} end,
	}
end
Tabs.Font = _dummyTab()
Tabs.Quests = _dummyTab()
Tabs.Prehistoric = _dummyTab()
Tabs.Esp = _dummyTab()
Tabs.Combat = _dummyTab()
Tabs.Travel = _dummyTab()
Tabs.Shop = _dummyTab()

print("[nyann os] Menu: Info + Main + Fish + RaceV4 + SeaEvent + Fruit/Raid + Misc")

-- ========== INFORMATION ==========
Tabs.Info:AddSection("Information")

Tabs.Info:AddParagraph("Hub", "nyann os  |  by real_@nyannnokonoko")

Tabs.Info:AddDiscordInvite({
	Title = "Nyann | Community",
	Description = "Discord server",
	Invite = "https://discord.gg/k6MRH4KxTv",
})

Tabs.Info:AddButton({
	Name = "Copy Discord Invite",
	Callback = function()
		pcall(function()
			if setclipboard then
				setclipboard("https://discord.gg/k6MRH4KxTv")
			end
		end)
		pcall(function()
			Window:Notify({ Title = "Discord", Content = "Copied!", Duration = 2 })
		end)
	end,
})

Tabs.Info:AddSection("Status")

local TimeZone = Tabs.Info:AddParagraph("Time Zone", "...")
local GameTime = Tabs.Info:AddParagraph("Game Time", "...")
local PlayerInfo = Tabs.Info:AddParagraph("Player", "...")
local CakePrinceStatus = Tabs.Info:AddParagraph("Cake Prince", "...")
local BoneStatus = Tabs.Info:AddParagraph("Bones", "...")

task.spawn(function()
	while task.wait(1) do
		pcall(function()
			local date = os.date("*t")
			local hour = date.hour % 24
			local ampm = hour < 12 and "AM" or "PM"
			local h12 = ((hour - 1) % 12) + 1
			local timezone = string.format("%02i:%02i:%02i %s", h12, date.min, date.sec, ampm)
			local datetime = string.format("%02d/%02d/%04d", date.day, date.month, date.year)
			local code = getgenv().countryRegionCode or "?"
			if not getgenv().countryRegionCode then
				pcall(function()
					getgenv().countryRegionCode = game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(game.Players.LocalPlayer)
					code = getgenv().countryRegionCode
				end)
			end
			TimeZone:SetDesc(datetime .. " - " .. timezone .. " [ " .. tostring(code) .. " ]")
		end)

		pcall(function()
			local t = math.floor(workspace.DistributedGameTime + 0.5)
			local h = math.floor(t / 3600) % 24
			local m = math.floor(t / 60) % 60
			local sec = t % 60
			GameTime:SetDesc(h .. "h " .. m .. "m " .. sec .. "s")
		end)

		pcall(function()
			local plr = game.Players.LocalPlayer
			local lv = plr.Data and plr.Data.Level and plr.Data.Level.Value or "?"
			PlayerInfo:SetDesc(plr.Name .. "  |  Lv " .. tostring(lv))
		end)

		pcall(function()
			local cakePrince = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
			local killStatus = "Cake Prince: ready"
			if type(cakePrince) == "string" and #cakePrince >= 86 then
				local killCount = string.sub(cakePrince, 39, 41)
				killStatus = "Killed: " .. tostring(killCount)
			end
			CakePrinceStatus:SetDesc(killStatus)
		end)

		pcall(function()
			local bones = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check")
			BoneStatus:SetDesc("You have: " .. tostring(bones) .. " Bones")
		end)
	end
end)

WeaponDropdown = Tabs.Main:AddDropdown({
    Name = "Select Weapon",
    Options = {"Melee","Sword","Blox Fruit","Gun"},
    Default = "nil",
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
Tabs.Main:AddSection("Farming")

FarmLevel = Tabs.Main:AddToggle({
    Name = "Auto Farm Level",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.Level = Value
        if not Value then
            alreadyTeleported = false
            teleporting = false
        end
    end
})

local alreadyTeleported = false
local teleporting = false

local function IsInSubmergedIsland()
    local char = plr.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    local islandXZ = Vector3.new(11520.8017578125, 0, 9829.513671875)
    local playerXZ = Vector3.new(hrp.Position.X, 0, hrp.Position.Z)
    return (playerXZ - islandXZ).Magnitude < 2000
end

task.spawn(function()
    while task.wait(Sec) do
        if _G.Level then
            pcall(function()
                local char = plr.Character or plr.CharacterAdded:Wait()
                local Root = char:WaitForChild("HumanoidRootPart")
                if not Root then return end

                local level = plr.Data.Level.Value
                local inSub = IsInSubmergedIsland()
                local questUI = plr.PlayerGui.Main.Quest
                local QuestTitle = questUI.Visible and questUI.Container.QuestTitle.Title.Text or ""

                if level >= 2600 and not inSub and not teleporting and not alreadyTeleported then
                    teleporting = true
                    
                    local npcPos = CFrame.new(-16269.7041, 25.2288494, 1373.65955)
                    local teleportAttempts = 0
                    
                    repeat 
                        task.wait(Sec)
                        _tp(npcPos)
                        teleportAttempts = teleportAttempts + 1
                    until not _G.Level or (Root.Position - npcPos.Position).Magnitude <= 8 or teleportAttempts > 20

                    if not _G.Level then 
                        teleporting = false
                        return 
                    end

                    task.wait(1)
                    
                    pcall(function()
                        local args = {"TravelToSubmergedIsland"} 
                        game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer(unpack(args))
                    end)

                    local timeout = tick()
                    repeat 
                        task.wait(0.5)
                        local currentInSub = IsInSubmergedIsland()
                        local farFromNPC = (Root.Position - npcPos.Position).Magnitude > 50
                        
                        if currentInSub or farFromNPC then
                            break
                        end
                    until not _G.Level or tick() - timeout > 15

                    task.wait(2)
                    alreadyTeleported = true
                    teleporting = false
                    
                elseif inSub or level < 2600 then
                    alreadyTeleported = true
                    teleporting = false

                    local questData = QuestNeta()
                    
                    if not questData or not questData[1] then
                        task.wait(1)
                        return
                    end
                    
                    if questUI.Visible and not string.find(QuestTitle, questData[1]) then
                        replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
                        task.wait(0.2)
                        return
                    end

                    if not questUI.Visible then
                        local questPos = questData[6]
                        if questPos then
                            _tp(questPos)
                            task.wait(2)
                            
                            if (Root.Position - questPos.Position).Magnitude <= 10 then
                                pcall(function()
                                    replicated.Remotes.CommF_:InvokeServer("StartQuest", questData[3], questData[2])
                                end)
                                task.wait(1)
                            end
                        else
                            pcall(function()
                                replicated.Remotes.CommF_:InvokeServer("StartQuest", questData[3], questData[2])
                            end)
                            task.wait(1)
                        end
                        return
                    end

                    local enemyName = questData[1]
                    
                    local foundMob = false
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if v.Name == enemyName and Attack.Alive(v) then
                            foundMob = true
                            repeat
                                task.wait(Sec)
                                _tp(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                                Attack.Kill(v, _G.Level)
                                
                                if not questUI.Visible then
                                    break
                                end
                            until not _G.Level or not v.Parent or v.Humanoid.Health <= 0
                            break
                        end
                    end
                    
                    if not foundMob then
                        for _, v in pairs(replicated:GetChildren()) do
                            if v.Name == enemyName and Attack.Alive(v) then
                                foundMob = true
                                _tp(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                                break
                            end
                        end
                    end
                    
                    if not foundMob then
                        for _, spawnPoint in pairs(workspace["_WorldOrigin"].EnemySpawns:GetChildren()) do
                            if string.find(spawnPoint.Name, enemyName) then
                                _tp(spawnPoint.CFrame * CFrame.new(0, 20, 0))
                                break
                            end
                        end
                    end
                end
            end)
        else
            teleporting = false
            alreadyTeleported = false
        end
    end
end)


-- === FARM CAKE ===
Tabs.Main:AddSection("Farming Cake")
local MobKilled = Tabs.Main:AddParagraph("Cake Princes", "")
spawn(function()
    while wait(0.2) do
        pcall(function()
            local Killed = string.match(replicated.Remotes.CommF_:InvokeServer("CakePrinceSpawner"), "%d+")
            if Killed then
                MobKilled:SetDesc("Killed : " .. (500 - tonumber(Killed) or 0))
            end
        end)
    end
end)

Cake = Tabs.Main:AddToggle({
    Name = "Auto Farm Cake Prince",
    Description = "",
    Default = false,
    Callback = function(Value)
    _G.Auto_Cake_Prince = Value
end
})

spawn(function()
    while task.wait() do
        if _G.Auto_Cake_Prince and not _G.AutoRaidCastle then
            pcall(function()
                local player = game.Players.LocalPlayer
                local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                local questUI = player.PlayerGui.Main.Quest
                local enemies = workspace.Enemies
                local cakeMap = workspace.Map:FindFirstChild("CakeLoaf")
                local bigMirror = cakeMap and cakeMap:FindFirstChild("BigMirror")
                if not root then return end

                if _G.AcceptQuestC and questUI and not questUI.Visible then
                    local questPos = CFrame.new(-1927.92, 37.8, -12842.54)
                    _tp(questPos)
                    while (questPos.Position - root.Position).Magnitude > 50 do
                        task.wait(0.2)
                    end
                    local randomQuest = math.random(1, 4)
                    local questData = {
                        [1] = {"StartQuest", "CakeQuest2", 2},
                        [2] = {"StartQuest", "CakeQuest2", 1},
                        [3] = {"StartQuest", "CakeQuest1", 1},
                        [4] = {"StartQuest", "CakeQuest1", 2}
                    }
                    pcall(function()
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(questData[randomQuest]))
                    end)
                end

                if not cakeMap then
                    _tp(CFrame.new(-2077, 252, -12373))
                    task.wait(2)
                    return
                end

                if bigMirror and (bigMirror.Other.Transparency == 0 or enemies:FindFirstChild("Cake Prince")) then
                    local boss = GetConnectionEnemies("Cake Prince")
                    if boss then
                        repeat task.wait()
                            Attack.Kill2(boss, _G.Auto_Cake_Prince)
                        until not _G.Auto_Cake_Prince or not boss.Parent or boss.Humanoid.Health <= 0
                    else
                        _tp(CFrame.new(-2151.82, 149.32, -12404.91))
                    end
                else

                    local CakeMobs = {"Cookie Crafter","Cake Guard","Baking Staff","Head Baker"}
                    local mob = GetConnectionEnemies(CakeMobs)
                    if mob then
                        repeat task.wait()
                            Attack.Kill(mob, _G.Auto_Cake_Prince)
                        until not _G.Auto_Cake_Prince or not mob.Parent or mob.Humanoid.Health <= 0 or (bigMirror and bigMirror.Other.Transparency == 0)
                    else
                        _tp(CFrame.new(-2077, 252, -12373))
                    end
                end
            end)
        end
    end
end)

CakeQ = Tabs.Main:AddToggle({
Name = "Accept Quests", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.AcceptQuestC = Value
end
})


CakeSM = Tabs.Main:AddToggle({
    Name = "Auto Summon Cake Prince",
    Description = "",
    Default = false,
    Callback = function(Value)
    _G.AutoSpawnCP = Value
end})

spawn(function()
    while task.wait(2) do
        if _G.AutoSpawnCP then
            pcall(function()
                local CommF = game.ReplicatedStorage.Remotes.CommF_
                local enemies = workspace.Enemies
                local bigMirror = workspace.Map.CakeLoaf:FindFirstChild("BigMirror")
                if not bigMirror then return end
                if enemies:FindFirstChild("Cake Prince") then return end
                if bigMirror.Other.Transparency == 0 then return end

                CommF:InvokeServer("CakePrinceSpawner", true)
            end)
        end
    end
end)



-- === FARM BONE ===
Tabs.Main:AddSection("Farming Bone")

local CheckingBone = Tabs.Main:AddParagraph("Bones", "")
spawn(function()
    while wait(0.2) do
        pcall(function()
            CheckingBone:SetDesc("Bones : " .. GetM("Bones"))
        end)
    end
end)

Tabs.Main:AddToggle({
    Name = "Auto Farm Bone",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm_Bone = Value
    end
})

spawn(function()
    local player = game.Players.LocalPlayer
    local BonesTable = {
        "Reborn Skeleton",
        "Living Zombie",
        "Demonic Soul",
        "Possessed Mummy"
    }

    while wait(0.5) do
        if not _G.AutoFarm_Bone then continue end

        pcall(function()
            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not root then return end

           
            local questUI =
                player.PlayerGui:FindFirstChild("Main")
                and player.PlayerGui.Main:FindFirstChild("Quest")

            local bone = GetConnectionEnemies(BonesTable)

            
            if _G.AcceptQuestB and questUI and not questUI.Visible then
                local questPos = CFrame.new(-9516.99316,172.01718,6078.46533)
                _tp(questPos)

                repeat wait(2)
                until not _G.AutoFarm_Bone
                   or (questPos.Position - root.Position).Magnitude <= 50

                if not _G.AutoFarm_Bone then return end

                local questData = {
                    {"StartQuest","HauntedQuest2",2},
                    {"StartQuest","HauntedQuest2",1},
                    {"StartQuest","HauntedQuest1",1},
                    {"StartQuest","HauntedQuest1",2}
                }

                game.ReplicatedStorage.Remotes.CommF_:InvokeServer(
                    unpack(questData[math.random(1,#questData)])
                )
            end

           
            if bone then
                repeat
                    wait()
                    Attack.Kill(bone, true)
                until not _G.AutoFarm_Bone
                   or not bone.Parent
                   or bone.Humanoid.Health <= 0
            else
            
                _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
            end
        end)
    end
end)

BoneQ = Tabs.Main:AddToggle({
Name = "Accept Quests", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.AcceptQuestB = Value
end
})


-- === FISHING ===
Tabs.Fish:AddSection("Fishing")

Tabs.Fish:AddDropdown({
    Name = "Select Fishing Rod",
    Description = "",
    Options = {"Fishing Rod", "Gold Rod", "Shark Rod", "Shell Rod", "Treasure Rod"},
    Default = "Fishing Rod",
    Callback = function(Value)
        _G.SelectedRod = Value
    end
})

BaitDropdown = Tabs.Fish:AddDropdown({
    Name = "Select Bait",
    Description = "",
    Options = {"Basic Bait", "Kelp Bait", "Good Bait", "Abyssal Bait", "Frozen Bait", "Epic Bait", "Carnivore Bait"},
    Default = "Basic Bait",
    Callback = function(Value)
        _G.SelectedBait = Value
        if _G.AutoBuyBait then
            pcall(function()
                Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
            end)
        end
    end
})

BuyBaitToggle = Tabs.Fish:AddToggle({
    Name = "Auto Buy Bait",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoBuyBait = Value
        if Value then
            pcall(function()
                Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
            end)
        end
    end
})


task.spawn(function()
    while task.wait(2) do
        if _G.AutoBuyBait and _G.SelectedBait then
            pcall(function()
                Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
            end)
        end
    end
end)




FishingToggle = Tabs.Fish:AddToggle({
    Name = "Auto Fishing",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoFishing = Value
    end
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FishReplicated = ReplicatedStorage:WaitForChild("FishReplicated")
local FishingRequest = FishReplicated:WaitForChild("FishingRequest")
local Config = require(FishReplicated.FishingClient.Config)
local GetWaterHeight = require(ReplicatedStorage.Util.GetWaterHeightAtLocation)
local MaxDistance = Config.Rod.MaxLaunchDistance

task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoFishing then
            pcall(function()
                local Char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                local HRP = Char:FindFirstChild("HumanoidRootPart")
                if not HRP then return end

                local Tool = Char:FindFirstChildOfClass("Tool")

                
                if _G.SelectedRod and (not Tool or Tool.Name ~= _G.SelectedRod) then
                    local backpackTool = LocalPlayer.Backpack:FindFirstChild(_G.SelectedRod)
                    if backpackTool then
                        Char.Humanoid:EquipTool(backpackTool)
                        Tool = backpackTool
                    end
                end

                if Tool then
                    local waterHeight = GetWaterHeight(HRP.Position)
                    local _, hitPos = Workspace:FindPartOnRayWithIgnoreList(
                        Ray.new(Char.Head.Position, HRP.CFrame.LookVector * MaxDistance),
                        {Char, Workspace.Characters, Workspace.Enemies}
                    )
                    local TargetPos = hitPos and Vector3.new(hitPos.X, math.max(hitPos.Y, waterHeight), hitPos.Z)
                    local State = Tool:GetAttribute("State")
                    local ServerState = Tool:GetAttribute("ServerState")

                    if TargetPos and (State == "ReeledIn" or ServerState == "ReeledIn") then
                        FishingRequest:InvokeServer("StartCasting")
                        task.wait()
                        FishingRequest:InvokeServer("CastLineAtLocation", TargetPos, 100, true)
                    elseif ServerState == "Biting" then
                        FishingRequest:InvokeServer("Catching", true)
                        task.wait(0.1)
                        FishingRequest:InvokeServer("Catch", 1)
                    end
                end
            end)
        end
    end
end)


FishingQ = Tabs.Fish:AddToggle({
Name = "Auto Quest Fishing", 
Description = "",
Default = false,
Callback = function(Value)
    _G.AutoFishingQuest = Value
end})


local Players3 = game:GetService("Players")
local LocalPlayer3 = Players3.LocalPlayer
local ReplicatedStorage3 = game:GetService("ReplicatedStorage")
local RFJobsRemoteFunction3 = ReplicatedStorage3.Modules.Net:WaitForChild("RF/JobsRemoteFunction")

local function HasQuest3()
    local questGui = LocalPlayer3.PlayerGui:FindFirstChild("Quest") or LocalPlayer3.PlayerGui:FindFirstChild("QuestGui")
    if questGui and questGui:FindFirstChild("Container") and questGui.Container:FindFirstChild("QuestTitle") then
        return true
    end
    return false
end

task.spawn(function()
    while task.wait(1) do
        if _G.AutoFishingQuest then
            pcall(function()
                if not HasQuest3() then
                    RFJobsRemoteFunction3:InvokeServer("FishingNPC", "Angler", "AskQuest")
                end
            end)
        end
    end
end)


QuestToggle = Tabs.Fish:AddToggle({
    Name = "Auto Complete Quest",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoQuestComplete = Value

        if Value then
            pcall(function()
                Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC", "FinishQuest")
            end)
        end
    end
})


task.spawn(function()
    while task.wait(5) do 
        if _G.AutoQuestComplete then
            pcall(function()
                Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC", "FinishQuest")
            end)
        end
    end
end)


SellFishToggle = Tabs.Fish:AddToggle({
    Name = "Auto Sell Fish",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoSellFish = Value

        if Value then
            pcall(function()
                Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC", "SellFish")
            end)
        end
    end
})


task.spawn(function()
    while task.wait(5) do 
        if _G.AutoSellFish then
            pcall(function()
                Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC", "SellFish")
            end)
        end
    end
end)


SpamSkillZ = Tabs.Fish:AddToggle({
Name = "Auto Spam Skill Z", 
Description = "",
Default = false,
Callback = function(Value)
    _G.AutoSkillZ = Value
end})


local ReplicatedStorage4 = game:GetService("ReplicatedStorage")
local RFJobToolAbilities4 = ReplicatedStorage4.Modules.Net:WaitForChild("RF/JobToolAbilities")

task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoSkillZ then
            pcall(function()
                RFJobToolAbilities4:InvokeServer("Z", true)
            end)
        end
    end
end)

TravelDress = Tabs.Quests:AddToggle({
Name = "Auto Quest Sea 2", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.TravelDres = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.TravelDres then
        if plr.Data.Level.Value >= 700 then
          if workspace.Map.Ice.Door.CanCollide == true and workspace.Map.Ice.Door.Transparency == 0 then
            replicated.Remotes.CommF_:InvokeServer("DressrosaQuestProgress","Detective")
		    EquipWeapon("Key")
		    repeat wait() _tp(CFrame.new(1347.7124, 37.3751602, -1325.6488)) until not _G.TravelDres or (Root.Position == CFrame.new(1347.7124, 37.3751602, -1325.6488).Position)
	      elseif workspace.Map.Ice.Door.CanCollide == false and workspace.Map.Ice.Door.Transparency == 1 then
            if Enemies:FindFirstChild("Ice Admiral") then
              for _,xz in pairs(Enemies:GetChildren()) do
                if xz.Name == "Ice Admiral" and Attack.Alive(xz) then
              	  repeat task.wait() Attack.Kill(xz,_G.TravelDres) until _G.TravelDres == false or xz.Humanoid.Health <= 0
                  replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
                end
              end
            else
              _tp(CFrame.new(1347.7124, 37.3751602, -1325.6488))
            end
	      else
		    replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
	      end
        end
      end
    end)
  end
end)
Zou = Tabs.Quests:AddToggle({
Name = "Auto Quest Sea 3", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoZou = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.AutoZou then
   	    if plr.Data.Level.Value >= 1500 then
          if replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 3 then
            if replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess ~= nil then
              replicated.Remotes.CommF_:InvokeServer("F_","TravelZou")
              if replicated.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 0 then
                local v = GetConnectionEnemies("rip_indra")
                if v then
                  repeat wait() Attack.Kill(v,_G.AutoZou) until not _G.AutoZou or not v.Parent or v.Humanoid.Health <= 0
                  Check = 2
                  repeat wait()replicated.Remotes.CommF_:InvokeServer("F_","TravelZou")until Check == 1                   
                else
                  replicated.Remotes.CommF_:InvokeServer("F_","ZQuestProgress","Check") wait(.1)
                  replicated.Remotes.CommF_:InvokeServer("F_","ZQuestProgress","Begin")
                end
              elseif replicated.Remotes["CommF_"]:InvokeServer("ZQuestProgress", "Check") == 1 then
                replicated.Remotes.CommF_:InvokeServer("F_","TravelZou")
              else
                local v = GetConnectionEnemies("Don Swan")
                if v then
                  repeat wait() Attack.Kill(v,_G.AutoZou)until not _G.AutoZou or not v.Parent or v.Humanoid.Health<=0                  
                else
                  repeat wait() _tp(CFrame.new(2288.802, 15.1870775, 863.034607)) until not _G.AutoZou or (Root.Position == CFrame.new(2288.802, 15.1870775, 863.034607).Position)
                  if (Root.CFrame == CFrame.new(2288.802, 15.1870775, 863.034607)) then notween(CFrame.new(2288.802, 15.1870775, 863.034607)) end
                end
              end
            else
            if replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
              TabelDevilFruitStore = {}
              TabelDevilFruitOpen = {}
              for i,v in pairs(replicated.Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
                for i1,v1 in pairs(v) do
                  if i1 == "Name" then table.insert(TabelDevilFruitStore,v1)end
                end
              end
              for i,v in next, game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits") do
                if v.Price >= 1000000 then table.insert(TabelDevilFruitOpen,v.Name) end
              end
              for i,DevilFruitOpenDoor in pairs(TabelDevilFruitOpen) do
                for i1,DevilFruitStore in pairs(TabelDevilFruitStore) do
                  if DevilFruitOpenDoor == DevilFruitStore and replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
                    if not plr.Backpack:FindFirstChild(DevilFruitStore) then
                      replicated.Remotes.CommF_:InvokeServer("F_","LoadFruit",DevilFruitStore)
                    else
                      replicated.Remotes.CommF_:InvokeServer("F_","TalkTrevor","1")
                      replicated.Remotes.CommF_:InvokeServer("F_","TalkTrevor","2")
                      replicated.Remotes.CommF_:InvokeServer("F_","TalkTrevor","3")
                    end
                  end
                end
              end
                replicated.Remotes.CommF_:InvokeServer("F_","TalkTrevor","1")
                replicated.Remotes.CommF_:InvokeServer("F_","TalkTrevor","2")
                replicated.Remotes.CommF_:InvokeServer("F_","TalkTrevor","3")
              end
            end
          else
            if replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
              if string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and plr.PlayerGui.Main.Quest.Visible == true then                
                local v = GetConnectionEnemies("Swan Pirate")
                if v then
                  pcall(function() repeat wait() Attack.Kill(v,_G.AutoZou) until not v.Parent or v.Humanoid.Health <= 0 or _G.AutoZou == false or plr.PlayerGui.Main.Quest.Visible == false end)                    
                else
                  _tp(CFrame.new(1057.92761, 137.614319, 1242.08069))
                end
              else
                _tp(CFrame.new(-456.28952, 73.0200958, 299.895966))
              end
            elseif replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
              local v = GetConnectionEnemies("Jeremy")
              if v then
                repeat wait() Attack.Kill(v,_G.AutoZou) until not v.Parent or v.Humanoid.Health <= 0 or _G.AutoZou == false
              else
                _tp(CFrame.new(2099.88159, 448.931, 648.997375))
              end
            elseif replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
              repeat wait() _tp(CFrame.new(-1836, 11, 1714)) until not _G.AutoZou or (Root.Position == CFrame.new(-1836, 11, 1714).Position)
              if (Root.CFrame == CFrame.new(-1836, 11, 1714)) then notween(CFrame.new(-1836, 11, 1714))end
              notween(CFrame.new(-1850.49329, 13.1789551, 1750.89685))
              wait(.1)
              notween(CFrame.new(-1858.87305, 19.3777466, 1712.01807))
              wait(.1)
              notween(CFrame.new(-1803.94324, 16.5789185, 1750.89685))
              wait(.1)
              notween(CFrame.new(-1858.55835, 16.8604317, 1724.79541))
              wait(.1)
              notween(CFrame.new(-1869.54224, 15.987854, 1681.00659))
              wait(.1)
              notween(CFrame.new(-1800.0979, 16.4978027, 1684.52368))
              wait(.1)
              notween(CFrame.new(-1819.26343, 14.795166, 1717.90625))
              wait(.1)
              notween(CFrame.new(-1813.51843, 14.8604736, 1724.79541))
            end
          end
        end
      end
    end)
  end
end)





-- === RACE V4 ===
Tabs.Race:AddSection("Trials Quest V4")
local CheckTier = Tabs.Race:AddParagraph("Tiers V4 Status", "")
spawn(function()
    pcall(function()
        while wait(0.2) do
            CheckTier:SetDesc("Tiers - V4 : " .. " " .. plr.Data.Race.C.Value)
        end
    end)
end)
PullLv = Tabs.Race:AddToggle({
Name = "Auto Pull Lever", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.Lver = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.Lver then
      pcall(function()
        for x,c in pairs(workspace.Map["Temple of Time"]:GetDescendants()) do
        if c.Name == "ProximityPrompt" then fireproximityprompt(c,math.huge)end
        end
      end)
    end
  end
end)
Train = Tabs.Race:AddToggle({
Name = "Auto Train V4", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.AcientOne = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.AcientOne then
        local BonesTable = {"Reborn Skeleton","Living Zombie","Demonic Soul","Posessed Mummy"}
	    for i=1,#BonesTable do
          if plr.Character:FindFirstChild("RaceEnergy").Value == 1 then
            vim1:SendKeyEvent(true, "Y", false, game)
            replicated.Remotes.CommF_:InvokeServer("UpgradeRace","Buy")
            _tp(CFrame.new(-8987.041015625, 215.862060546875, 5886.71044921875))
	      elseif plr.Character:FindFirstChild("RaceTransformed").Value == false then
	        local v = GetConnectionEnemies(BonesTable)
	        if v then repeat wait() Attack.Kill(v, _G.AcientOne) until _G.AcientOne == false or v.Humanoid.Health <= 0 or not v.Parent
		    else _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)) 
		    end
	      end
        end
      end
    end)
  end
end)

Tabs.Race:AddButton({
    Name = "Teleport to Temple of Time",
    Description = "",
    Callback = function()
        local plr = game:GetService("Players").LocalPlayer
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
        end

        if not game:GetService("Workspace").Map:FindFirstChild("Temple of Time") and World3 then
            local stash = game:GetService("ReplicatedStorage"):FindFirstChild("MapStash")
            if stash and stash:FindFirstChild("Temple of Time") then
                stash["Temple of Time"].Parent = workspace.Map
            end
        end
    end
})
Tabs.Race:AddButton({
Name = "Teleport to Ancient One", 
Description = "",
Callback = function()
        local plr = game:GetService("Players").LocalPlayer
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

        if hrp then
            hrp.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
        end

        if not game:GetService("Workspace").Map:FindFirstChild("Temple of Time") and World3 then
            local stash = game:GetService("ReplicatedStorage"):FindFirstChild("MapStash")
            if stash and stash:FindFirstChild("Temple of Time") then
                stash["Temple of Time"].Parent = workspace.Map
            end
        end
        
        task.wait(2)

        tween(CFrame.new(28981.552734375, 14888.4267578125, - 120.245849609375))
    end
})
Tabs.Race:AddButton({
Name = "Teleport to Ancient Clock", 
Description = "",
Callback = function()
        local plr = game:GetService("Players").LocalPlayer
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

        local pos1 = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)

        local pos2 = CFrame.new(29549, 15069, -88)

        if hrp then
            hrp.CFrame = pos1
        end

        task.delay(2, function()
            _tp(pos2)
        end)

        if not workspace.Map:FindFirstChild("Temple of Time") and World3 then
            local stash = game:GetService("ReplicatedStorage"):FindFirstChild("MapStash")
            if stash and stash:FindFirstChild("Temple of Time") then
                stash["Temple of Time"].Parent = workspace.Map
            end
        end
    end
})
Doors = Tabs.Race:AddToggle({
Name = "Auto Teleport to Race Doors", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.TPDoor = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.TPDoor then
	    if tostring(plr.Data.Race.Value) == "Mink" then
          _tp(CFrame.new(29020.66015625, 14889.4267578125, -379.2682800292969))
	    elseif tostring(plr.Data.Race.Value) == "Fishman" then
          _tp(CFrame.new(28224.056640625, 14889.4267578125, -210.5872039794922))
	    elseif tostring(plr.Data.Race.Value) == "Cyborg" then
          _tp(CFrame.new(28492.4140625, 14894.4267578125, -422.1100158691406))
	    elseif tostring(plr.Data.Race.Value) == "Skypiea" then
          _tp(CFrame.new(28967.408203125, 14918.0751953125, 234.31198120117188))
	    elseif tostring(plr.Data.Race.Value) == "Ghoul" then
          _tp(CFrame.new(28672.720703125, 14889.1279296875, 454.5961608886719))
	    elseif tostring(plr.Data.Race.Value) == "Human" then
          _tp(CFrame.new(29237.294921875, 14889.4267578125, -206.94955444335938))
	    end
      end
    end)
  end
end)                   
Trials = Tabs.Race:AddToggle({
Name = "Auto Complete Trial Race", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.Complete_Trials = Value
end})
GetSeaBeastTrial = function()
  if not workspace.Map:FindFirstChild("FishmanTrial") then return nil end
  if workspace["_WorldOrigin"].Locations:FindFirstChild("Trial of Water") then FishmanTrial = workspace["_WorldOrigin"].Locations:FindFirstChild("Trial of Water") end
  if FishmanTrial then
    for _,v in next, workspace.SeaBeasts:GetChildren() do
      if v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - FishmanTrial.Position).Magnitude <= 1500 then
      if v.Health.Value > 0 then return v end
      end
    end
  end
end
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Complete_Trials then
        if tostring(plr.Data.Race.Value) == "Mink" then
          notween(workspace.Map.MinkTrial.Ceiling.CFrame * CFrame.new(0,-20,0))
	   end
      end
    end)
  end
end)
spawn(function()
  while wait(Sec) do
    pcall(function() 
      if _G.Complete_Trials then
	    if tostring(plr.Data.Race.Value) == "Fishman" then
	      if GetSeaBeastTrial() then            
            repeat task.wait()
              spawn(function()_tp(CFrame.new(GetSeaBeastTrial().HumanoidRootPart.Position.X,game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y + 300,GetSeaBeastTrial().HumanoidRootPart.Position.Z))end)
		      MousePos = GetSeaBeastTrial().HumanoidRootPart.Position
              Useskills("Melee","Z")
	          Useskills("Melee","X")
	          Useskills("Melee","C")
              wait(.1)
              Useskills("Sword","Z")
              Useskills("Sword","X")
              wait(.1)
              Useskills("Blox Fruit","Z")
              Useskills("Blox Fruit","X")
              Useskills("Blox Fruit","C")
              wait(.1)
              Useskills("Gun","Z")
              Useskills("Gun","X")
            until _G.Complete_Trials == false or not GetSeaBeastTrial()
          end          
	    end
      end
    end)
  end
end)
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Complete_Trials then
        if tostring(plr.Data.Race.Value) == "Cyborg" then
         _tp(workspace.Map.CyborgTrial.Floor.CFrame * CFrame.new(0,500,0))
   	   end
      end
    end)
  end
end)
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Complete_Trials then
        if tostring(plr.Data.Race.Value) == "Skypiea" then
          notween(workspace.Map.SkyTrial.Model.FinishPart.CFrame)
  	   end
      end
    end)
  end
end)
spawn(function()
  while wait(.1) do   
    pcall(function()
      if _G.Complete_Trials then
	    if tostring(plr.Data.Race.Value) == "Human" or tostring(plr.Data.Race.Value) == "Ghoul" then	      
	      local TrialsTables = {"Ancient Vampire","Ancient Zombie"}
	      local v = GetConnectionEnemies(TrialsTables)
          if v then repeat wait() Attack.Kill(v, _G.Complete_Trials)until _G.Complete_Trials == false or not v.Parent or v.Humanoid.Health <= 0 end		
        end
      end
    end)
  end
end)
AutoKill = Tabs.Race:AddToggle({
Name = "Auto Kill Player After Trial", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.Defeating = Value
end})
spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.Defeating then
	    for _, v in pairs(workspace.Characters:GetChildren()) do
          if v.Name ~= plr.Name then
            if v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and v.Parent and (Root.Position - v.HumanoidRootPart.Position).Magnitude <= 250 then
              repeat task.wait() EquipWeapon(_G.SelectWeapon) _tp(v.HumanoidRootPart.CFrame * CFrame.new(0,0,15)) sethiddenproperty(plr, "SimulationRadius", math.huge)until _G.Defeating == false or v.Humanoid.Health <= 0 or not v.Parent or not v:FindFirstChild("HumanoidRootPart") or not v:FindFirstChild("Humanoid")
            end
          end
        end
      end
    end)
  end
end)


-- === SEA EVENT ===
Tabs.SeaEvent:AddSection("Sea Event / Setting Sail")
local ListSeaBoat={"Guardian","PirateGrandBrigade","MarineGrandBrigade","PirateBrigade","MarineBrigade","PirateSloop","MarineSloop","Beast Hunter"}
local ListSeaZone={"Lv 1","Lv 2","Lv 3","Lv 4","Lv 5","Lv 6","Lv Infinite"}


Tabs.SeaEvent:AddButton({
    Name = "Remove Lighting Effect",
    Callback = function()
        game:GetService("Lighting").BaseAtmosphere:Destroy()
    end
})

Tabs.SeaEvent:AddToggle({
    Name = "Ship Speed Modifier",
    Default = false,
    Callback = function(Value)
        getgenv().SpeedBoat = Value
    end
})
game:GetService("RunService").RenderStepped:Connect(function()
    if getgenv().SpeedBoat then
        local plr = game:GetService("Players").LocalPlayer
        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
            if plr.Character.Humanoid.Sit then
                for _, boat in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                    local seat = boat:FindFirstChildWhichIsA("VehicleSeat")
                    if seat then
                        seat.MaxSpeed = SetSpeedBoat
                    end
                end
            end
        end
    end
end)
Tabs.SeaEvent:AddSlider({
    Name = "Ship Speed",
    Min = 0,
    Max = 1000,
    Increment = 1,
    Default = 300,
    Callback = function(Value)
        SetSpeedBoat = Value
    end
})
Tabs.SeaEvent:AddToggle({
    Name = "Auto Press W",
    Default = false,
    Callback = function(Value)
        getgenv().AutoPressW = Value
    end
})
spawn(function()
    while wait() do
        pcall(function()
            if getgenv().AutoPressW then
                local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
                if humanoid.Sit == true then
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
                end
            end
        end)
    end
end)
Tabs.SeaEvent:AddToggle({
    Name = "No Clip Ship",
    Default = false,
    Callback = function(Value)
        getgenv().NoClipShip = Value
    end
})
spawn(function()
    while wait() do
        pcall(function()
            for i, boat in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                for _, v in pairs(boat:GetDescendants()) do
                    if v:IsA("BasePart") then
                        if getgenv().NoClipShip or getgenv().FindPrehistoric then
                            v.CanCollide = false
                        else
                            v.CanCollide = true
                        end
                    end
                end
            end
        end)
    end
end)

Tabs.SeaEvent:AddSection("Crafting Items")


Tabs.SeaEvent:AddButton({
Name = "Craft SharkTooth", 
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "SharkTooth"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.SeaEvent:AddButton({
Name = "Craft TerrorJaw", 
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "TerrorJaw"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.SeaEvent:AddButton({
Name = "Craft SharkAnchor", 
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "SharkAnchor"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.SeaEvent:AddButton({
Name = "Craft LeviathanCrown", 
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "LeviathanCrown"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})
 
Tabs.SeaEvent:AddButton({
Name = "Craft LeviathanShield", 
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "LeviathanShield"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.SeaEvent:AddButton({
Name = "Craft LeviathanBoat", 
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "LeviathanBoat"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.SeaEvent:AddButton({
Name = "Craft LegendaryScroll", 
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "LegendaryScroll"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tabs.SeaEvent:AddButton({
Name = "Craft MythicalScroll", 
Description = "",
Callback = function()
        local args = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "MythicalScroll"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
})
Tabs.SeaEvent:AddSection("Choose Sea Event")

Q = Tabs.SeaEvent:AddDropdown({
    Name = "Select Boats",
	Options = ListSeaBoat,
	Callback = function(Value)
        _G.SelectedBoat = Value
    end
})
Tabs.SeaEvent:AddButton({
Name = "Buy Boats", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyBoat",_G.SelectedBoat)
end})
Q = Tabs.SeaEvent:AddDropdown({
Name = "Select Sea Level",
Options = ListSeaZone,
Callback = function(Value)
  _G.DangerSc = Value
end})
Q = Tabs.SeaEvent:AddToggle({
Name = "Auto Sail Boat", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.SailBoats = Value
end})
spawn(function()
  while wait() do
    if _G.SailBoats then 
      pcall(function()        
        local myBoat = CheckBoat()
        if not myBoat and not(CheckShark()and _G.Shark or CheckTerrorShark()and _G.TerrorShark or CheckFishCrew()and _G.MobCrew or CheckPiranha()and _G.Piranha)and not(CheckEnemiesBoat()and _G.FishBoat)and not(CheckSeaBeast()and _G.SeaBeast1)and not(_G.PGB and CheckPirateGrandBrigade())and not(_G.HCM and CheckHauntedCrew())and not(_G.Leviathan1 and CheckLeviathan())then
          local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
          TeleportToTarget(buyBoatCFrame)
          if (buyBoatCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat) end
        elseif myBoat and not(CheckShark()and _G.Shark or CheckTerrorShark()and _G.TerrorShark or CheckFishCrew()and _G.MobCrew or CheckPiranha()and _G.Piranha)and not(CheckEnemiesBoat()and _G.FishBoat)and not(CheckSeaBeast()and _G.SeaBeast1)and not(_G.PGB and CheckPirateGrandBrigade())and not(_G.HCM and CheckHauntedCrew())and not(_G.Leviathan1 and CheckLeviathan())then
          if plr.Character.Humanoid.Sit == false then
            local boatSeatCFrame = myBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
            _tp(boatSeatCFrame)
          else                         
            if _G.DangerSc == "Lv 1" then CFrameSelectedZone = CFrame.new(-21998.375, 30.0006084, -682.309143)
            elseif _G.DangerSc == "Lv 2" then CFrameSelectedZone = CFrame.new(-26779.5215, 30.0005474, -822.858032)
            elseif _G.DangerSc == "Lv 3" then CFrameSelectedZone = CFrame.new(-31171.957, 30.0001011, -2256.93774)
            elseif _G.DangerSc == "Lv 4" then CFrameSelectedZone = CFrame.new(-34054.6875, 30.2187767, -2560.12012)
            elseif _G.DangerSc == "Lv 5" then CFrameSelectedZone = CFrame.new(-38887.5547, 30.0004578, -2162.99023)
            elseif _G.DangerSc == "Lv 6" then CFrameSelectedZone = CFrame.new(-44541.7617, 30.0003204, -1244.8584)
            elseif _G.DangerSc == "Lv Infinite" then CFrameSelectedZone = CFrame.new(-10000000, 31, 37016.25)
            end           
            repeat wait() 
              if (not _G.FishBoat and CheckEnemiesBoat()) or (not _G.PGB and CheckPirateGrandBrigade()) or (not _G.TerrorShark and CheckTerrorShark()) then
                _tp(CFrameSelectedZone * CFrame.new(0,150,0))
              else
                _tp(CFrameSelectedZone)
              end           
            until _G.SailBoats==false or(CheckShark()and _G.Shark or CheckTerrorShark()and _G.TerrorShark or CheckFishCrew()and _G.MobCrew or CheckPiranha()and _G.Piranha)or CheckSeaBeast()and _G.SeaBeast1 or CheckEnemiesBoat()and _G.FishBoat or _G.Leviathan1 and CheckLeviathan() or _G.HCM and CheckHauntedCrew() or _G.PGB and CheckPirateGrandBrigade() or plr.Character:WaitForChild("Humanoid").Sit==false plr.Character.Humanoid.Sit = false
          end
        end
      end)
    end
  end
end)
spawn(function()while wait(Sec)do pcall(function()for a,b in pairs(workspace.Boats:GetChildren())do for c,d in pairs(workspace.Boats[b.Name]:GetDescendants())do if d:IsA("BasePart")then if _G.SailBoats or _G.Prehis_Find or _G.FindMirage or _G.SailBoat_Hydra or _G.AutofindKitIs then d.CanCollide=false else d.CanCollide=true end end end end end)end end)

Tabs.SeaEvent:AddSection("Entity Sea Event")

Tabs.SeaEvent:AddToggle({
Name = "Auto Shark", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.Shark = Value
end})

Tabs.SeaEvent:AddToggle({
Name = "Auto Piranha", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.Piranha = Value
end})

Tabs.SeaEvent:AddToggle({
Name = "Auto Terror Shark", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.TerrorShark = Value
end})

Tabs.SeaEvent:AddToggle({
Name = "Auto Fish Crew Member", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.MobCrew = Value
end})

Tabs.SeaEvent:AddToggle({
Name = "Auto Haunted Crew Member", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.HCM = Value
end})

Tabs.SeaEvent:AddToggle({
Name = "Auto Attack PirateGrandBrigade", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.PGB = Value
end})

Tabs.SeaEvent:AddToggle({
Name = "Auto Attack Fish Boat", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.FishBoat = Value
end})

Tabs.SeaEvent:AddToggle({
Name = "Auto Attack Sea Beast", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.SeaBeast1 = Value
end})

spawn(function()
  while wait() do
    pcall(function()	
      if _G.Shark then local a={"Shark"}if CheckShark()then for b,c in pairs(workspace.Enemies:GetChildren())do if table.find(a,c.Name)then if Attack.Alive(c)then repeat task.wait()Attack.Kill(c,_G.Shark)until _G.Shark==false or not c.Parent or c.Humanoid.Health<=0 end end end end end
      if _G.TerrorShark then local a={"Terrorshark"}if CheckTerrorShark()then for b,c in pairs(workspace.Enemies:GetChildren())do if table.find(a,c.Name)then if Attack.Alive(c)then repeat task.wait()Attack.KillSea(c,_G.TerrorShark)until _G.TerrorShark==false or not c.Parent or c.Humanoid.Health<=0 end end end end end
      if _G.Piranha then local a={"Piranha"}if CheckPiranha()then for b,c in pairs(workspace.Enemies:GetChildren())do if table.find(a,c.Name)then if Attack.Alive(c)then repeat task.wait()Attack.Kill(c,_G.Piranha)until _G.Piranha==false or not c.Parent or c.Humanoid.Health<=0 end end end end end
      if _G.MobCrew then local a={"Fish Crew Member"}if CheckFishCrew()then for b,c in pairs(workspace.Enemies:GetChildren())do if table.find(a,c.Name)then if Attack.Alive(c)then repeat task.wait()Attack.Kill(c,_G.MobCrew)until _G.MobCrew==false or not c.Parent or c.Humanoid.Health<=0 end end end end end                 
      if _G.HCM then local a={"Haunted Crew Member"}if CheckHauntedCrew()then for b,c in pairs(workspace.Enemies:GetChildren())do if table.find(a,c.Name)then if Attack.Alive(c)then repeat task.wait()Attack.Kill(c,_G.HCM)until _G.HCM==false or not c.Parent or c.Humanoid.Health<=0 end end end end end
      if _G.SeaBeast1 then if workspace.SeaBeasts:FindFirstChild("SeaBeast1")then for a,b in pairs(workspace.SeaBeasts:GetChildren())do if b:FindFirstChild("HumanoidRootPart")and b:FindFirstChild("Health")and b.Health.Value>0 then repeat task.wait()spawn(function()_tp(CFrame.new(b.HumanoidRootPart.Position.X,game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y+200,b.HumanoidRootPart.Position.Z))end)if plr:DistanceFromCharacter(b.HumanoidRootPart.CFrame.Position)<=500 then AitSeaSkill_Custom=b.HumanoidRootPart.CFrame;MousePos=AitSeaSkill_Custom.Position;if CheckF()then weaponSc("Blox Fruit")Useskills("Blox Fruit","Z")Useskills("Blox Fruit","X")Useskills("Blox Fruit","C")else Useskills("Melee","Z")Useskills("Melee","X")Useskills("Melee","C")wait(.1)Useskills("Sword","Z")Useskills("Sword","X")wait(.1)Useskills("Blox Fruit","Z")Useskills("Blox Fruit","X")Useskills("Blox Fruit","C")wait(.1)Useskills("Gun","Z")Useskills("Gun","X")end end until _G.SeaBeast1==false or not b:FindFirstChild("HumanoidRootPart")or not b.Parent or b.Health.Value<=0 end end end end
      if _G.Leviathan1 then if workspace.SeaBeasts:FindFirstChild("Leviathan")then for a,b in pairs(workspace.SeaBeasts:GetChildren())do if b:FindFirstChild("HumanoidRootPart")and b:FindFirstChild("Leviathan Segment")and b:FindFirstChild("Health")and b.Health.Value>0 then repeat task.wait()spawn(function()_tp(CFrame.new(b.HumanoidRootPart.Position.X,game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y+200,b.HumanoidRootPart.Position.Z))end)if plr:DistanceFromCharacter(b.HumanoidRootPart.CFrame.Position)<=500 then MousePos=b:FindFirstChild("Leviathan Segment").Position;if CheckF()then weaponSc("Blox Fruit")Useskills("Blox Fruit","Z")Useskills("Blox Fruit","X")Useskills("Blox Fruit","C")else Useskills("Melee","Z")Useskills("Melee","X")Useskills("Melee","C")wait(.1)Useskills("Sword","Z")Useskills("Sword","X")wait(.1)Useskills("Blox Fruit","Z")Useskills("Blox Fruit","X")Useskills("Blox Fruit","C")wait(.1)Useskills("Gun","Z")Useskills("Gun","X")end end until _G.Leviathan1==false or not b:FindFirstChild("HumanoidRootPart")or not b.Parent or b.Health.Value<=0 end end end end
      if _G.FishBoat then if CheckEnemiesBoat()then for a,b in pairs(workspace.Enemies:GetChildren())do if b:FindFirstChild("Health")and b.Health.Value>0 and b:FindFirstChild("VehicleSeat")then repeat task.wait()spawn(function()if b.Name=="FishBoat"then _tp(b.Engine.CFrame*CFrame.new(0,-50,-25))end end)if plr:DistanceFromCharacter(b.Engine.CFrame.Position)<=150 then AitSeaSkill_Custom=b.Engine.CFrame;MousePos=AitSeaSkill_Custom.Position;if CheckF()then weaponSc("Blox Fruit")Useskills("Blox Fruit","Z")Useskills("Blox Fruit","X")Useskills("Blox Fruit","C")else Useskills("Melee","Z")Useskills("Melee","X")Useskills("Melee","C")wait(.1)Useskills("Sword","Z")Useskills("Sword","X")wait(.1)Useskills("Blox Fruit","Z")Useskills("Blox Fruit","X")Useskills("Blox Fruit","C")wait(.1)Useskills("Gun","Z")Useskills("Gun","X")end end until _G.FishBoat==false or not b:FindFirstChild("VehicleSeat")or b.Health.Value<=0 end end end end
      if _G.PGB then if CheckPirateGrandBrigade()then for a,b in pairs(workspace.Enemies:GetChildren())do if b:FindFirstChild("Health")and b.Health.Value>0 and b:FindFirstChild("VehicleSeat")then repeat task.wait()spawn(function()if b.Name=="PirateBrigade"then _tp(b.Engine.CFrame*CFrame.new(0,-30,-10))elseif b.Name=="PirateGrandBrigade"then _tp(b.Engine.CFrame*CFrame.new(0,-50,-50))end end)if plr:DistanceFromCharacter(b.Engine.CFrame.Position)<=150 then AitSeaSkill_Custom=b.Engine.CFrame;MousePos=AitSeaSkill_Custom.Position;if CheckF()then weaponSc("Blox Fruit")Useskills("Blox Fruit","Z")Useskills("Blox Fruit","X")Useskills("Blox Fruit","C")else Useskills("Melee","Z")Useskills("Melee","X")Useskills("Melee","C")wait(.1)Useskills("Sword","Z")Useskills("Sword","X")wait(.1)Useskills("Blox Fruit","Z")Useskills("Blox Fruit","X")Useskills("Blox Fruit","C")wait(.1)Useskills("Gun","Z")Useskills("Gun","X")end end until _G.PGB==false or not b:FindFirstChild("VehicleSeat")or b.Health.Value<=0 end end end end
    end)
  end
end)

Tabs.SeaEvent:AddSection("Kitsune Island / Event")
local Check_Kitsu = Tabs.SeaEvent:AddParagraph("Kitsune Island Status", "")
spawn(function()
    while wait(0.2) do
        if workspace.Map:FindFirstChild("KitsuneIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
            Check_Kitsu:SetDesc("Kitsune Island : True")
        else
            Check_Kitsu:SetDesc("Kitsune Island : False")
        end
    end
end)

Tabs.SeaEvent:AddToggle({
Name = "Auto Find Kitsune Island", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutofindKitIs = Value
end})
spawn(function()
  while wait() do
    if _G.AutofindKitIs then 
      pcall(function()
        if not workspace["_WorldOrigin"].Locations:FindFirstChild("Kitsune Island", true) then                
          local myBoat = CheckBoat()
          if not myBoat then
            local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
            TeleportToTarget(buyBoatCFrame)
            if (buyBoatCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat) end
          else
            if plr.Character.Humanoid.Sit == false then
              local boatSeatCFrame = myBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
              _tp(boatSeatCFrame)
            else
              local targetDestination = CFrame.new(-10000000, 31, 37016.25)              
              repeat wait() 
                if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
                  _tp(CFrame.new(-10000000, 150, 37016.25))
                else
                  _tp(CFrame.new(-10000000, 31, 37016.25))
                end
              until not _G.AutofindKitIs or (targetDestination.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 or workspace["_WorldOrigin"].Locations:FindFirstChild("Kitsune Island") or plr.Character.Humanoid.Sit == false plr.Character.Humanoid.Sit = false
            end
          end
        else
          _tp(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame*CFrame.new(0,500,0))
        end
      end)
    end
  end
end)

Tabs.SeaEvent:AddToggle({
Name = "Auto Teleport to Shrine Actived", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.tweenShrine = Value
end})
spawn(function()
  while wait(.1) do
    if _G.tweenShrine then
      pcall(function()
      local kit_is = workspace.Map:FindFirstChild("KitsuneIsland") or game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island")
      local shrineActive = kit_is:FindFirstChild("ShrineActive")
        if shrineActive then
          for _, v in next, shrineActive:GetDescendants() do
            if v:IsA("BasePart") and v.Name:find("NeonShrinePart") then
              replicated.Modules.Net:FindFirstChild("RE/TouchKitsuneStatue"):FireServer()
              repeat wait() _tp(v.CFrame * CFrame.new(0,2,0)) until _G.tweenShrine == false or not kit_is
            end
          end
        else
          _tp(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame * CFrame.new(0,500,0))        
        end
      end)
    end
  end
end)

Tabs.SeaEvent:AddToggle({
Name = "Auto Collect Azure Ember", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.Collect_Ember = Value
end})
spawn(function()
  while wait(.1) do
    if _G.Collect_Ember then
      pcall(function()
        if workspace:WaitForChild("AttachedAzureEmber") or workspace:WaitForChild("EmberTemplate") then
        notween(workspace:WaitForChild("EmberTemplate"):FindFirstChild("Part").CFrame)
        else
          _tp(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame * CFrame.new(0,500,0))        
          replicated.Modules.Net["RF/KitsuneStatuePray"]:InvokeServer()
        end
      end)
    end
  end
end)

Tabs.SeaEvent:AddToggle({
Name = "Auto Trade Azure Ember", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.Trade_Ember = Value
end})
spawn(function()
  while wait(.1) do
    if _G.Trade_Ember then
      pcall(function()
        if workspace["_WorldOrigin"].Locations:FindFirstChild("Kitsune Island",true) then
          replicated.Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
        end
      end)
    end
  end
end)

Tabs.SeaEvent:AddButton({
Name = "Trade Items Azure", 
Description = "",
Callback = function()
  replicated.Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
end})

Tabs.SeaEvent:AddButton({
Name = "Talk with kitsune statue", 
Description = "",
Callback = function()
  replicated.Modules.Net:FindFirstChild("RE/TouchKitsuneStatue"):FireServer()
end})

Tabs.SeaEvent:AddSection("Frozen Dimension Event")

local FloD = Tabs.SeaEvent:AddParagraph("FrozenDimension Status", "")
spawn(function()
    pcall(function()
        while wait(0.2) do
            if workspace._WorldOrigin.Locations:FindFirstChild('Frozen Dimension') then
                FloD:SetDesc('Frozen Dimension : True')
            else
                FloD:SetDesc('Frozen Dimension : False')
            end
        end
    end)
end)

local SPYING = Tabs.SeaEvent:AddParagraph("Spy Status", "")
spawn(function()
    while wait(0.2) do
        pcall(function()
            local spycheck = string.match(replicated.Remotes.CommF_:InvokeServer("InfoLeviathan", "1"), "%d+")
            if spycheck then 
                SPYING:SetDesc("Spy Leviathan : " .. tostring(spycheck))
                if tonumber(spycheck) == 5 then
                    SPYING:SetDesc("Spy Leviathan : Already Done!!")
                end
            end
        end)
    end
end)

Tabs.SeaEvent:AddButton({
    Name = "Buy Spy",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "2")
    end
})


Tabs.SeaEvent:AddToggle({
Name = "Auto Teleport Frozen Dimension", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.FrozenTP = Value
end})
spawn(function()
  while wait(.1) do
    if _G.FrozenTP then
      pcall(function()
      if workspace.Map:FindFirstChild("LeviathanGate") then _tp(workspace.Map.LeviathanGate.CFrame) replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("OpenLeviathanGate") end
      end)
    end
  end
end)

Tabs.SeaEvent:AddToggle({
Name = "Auto Drive To Hydra Island", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.SailBoat_Hydra = Value
end})
spawn(function()
  while wait() do
    if _G.SailBoat_Hydra then 
      pcall(function()        
        local myBoat = CheckBoat()
        if not myBoat then
          local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
          TeleportToTarget(buyBoatCFrame)
          if (buyBoatCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat) end
        elseif myBoat then
          if plr.Character.Humanoid.Sit == false then
            local boatSeatCFrame = myBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
            _tp(boatSeatCFrame)
          else                         
            repeat wait() 
              if CheckEnemiesBoat() or CheckPirateGrandBrigade() or CheckTerrorShark() then
                _tp(CFrame.new(5433, 150, 290))
              else
                _tp(CFrame.new(5433, 35, 290))
              end           
            until _G.SailBoat_Hydra==false or plr.Character:WaitForChild("Humanoid").Sit==false plr.Character.Humanoid.Sit = false
          end
        end
      end)
    end
  end
end)

Tabs.SeaEvent:AddToggle({
Name = "Auto Attack Leviathan", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.Leviathan1 = Value
end})




-- === FRUIT AND RAID ===
Tabs.Raids:AddSection("Fruits Options")

local function formatNumber(number)
    local str = tostring(number)
    repeat
        local replaced, count = str:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
        str = replaced
    until count == 0
    return str
end

local function getFruitStock()
    local resultStr = "Advance Fruit Stock\n"
    local success, advanceFruits = pcall(function()
        return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", true)
    end)

    if not success or not advanceFruits then
        resultStr = resultStr .. "- Error while retrieving data.\n"
    else
        local hasFruit = false
        for _, fruit in pairs(advanceFruits) do
            if fruit.OnSale then
                hasFruit = true
                resultStr = resultStr .. fruit.Name .. " - $" .. formatNumber(fruit.Price) .. "\n"
            end
        end
        if not hasFruit then
            resultStr = resultStr .. "- No fruit.\n"
        end
    end

    resultStr = resultStr .. "\nNormal Fruit Stock\n"
    local success2, normalFruits = pcall(function()
        return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
    end)

    if success2 and normalFruits then
        local hasFruit = false
        for _, fruit in pairs(normalFruits) do
            if fruit.OnSale then
                hasFruit = true
                resultStr = resultStr .. fruit.Name .. " - $" .. formatNumber(fruit.Price) .. "\n"
            end
        end
        if not hasFruit then
            resultStr = resultStr .. "- No fruit.\n"
        end
    else
        resultStr = resultStr .. "- Error while retrieving data.\n"
    end

    return resultStr
end

local stockParagraph = Tabs.Raids:AddParagraph("Stock Fruit", "Loading...")

task.spawn(function()
    while task.wait(60) do
        pcall(function()
            stockParagraph:SetDesc(getFruitStock())
        end)
    end
end)

pcall(function()
    stockParagraph:SetDesc(getFruitStock())
end)


RandomFF = Tabs.Raids:AddToggle({
Name = "Auto Random Fruit", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.Random_Auto = Value
end})
spawn(function()
  while wait(Sec) do
   	pcall(function()
      if _G.Random_Auto then replicated.Remotes.CommF_:InvokeServer("Cousin","Buy") end 
    end)
  end
end)
DropF = Tabs.Raids:AddToggle({
Name = "Auto Drop Fruit", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.DropFruit = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.DropFruit then
      pcall(function() DropFruits() end)
    end
  end
end)
StoredF = Tabs.Raids:AddToggle({
Name = "Auto Store Fruit", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.StoreF = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.StoreF then
      pcall(function() UpdStFruit() end)
    end
  end
end)
TwF = Tabs.Raids:AddToggle({
Name = "Auto Tween to Fruit", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.TwFruits = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.TwFruits then
      pcall(function()
        for _,x1 in pairs(workspace:GetChildren()) do
	    if string.find(x1.Name, "Fruit") then _tp(x1.Handle.CFrame) end
	    end
      end)
    end
  end
end)
BringF = Tabs.Raids:AddToggle({
Name = "Auto Collect Fruit", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.InstanceF = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.InstanceF then
      pcall(function() collectFruits(_G.InstanceF) end)
    end
  end
end)

Tabs.Raids:AddDropdown({
    Name = "Select Fruit Shop",
    Options = {
        "Rocket-Rocket", "Spin-Spin", "Blade-Blade", "Spring-Spring",
        "Bomb-Bomb", "Smoke-Smoke", "Spike-Spike", "Flame-Flame",
        "Ice-Ice", "Sand-Sand", "Dark-Dark", "Eagle-Eagle",
        "Diamond-Diamond", "Light-Light", "Rubber-Rubber", "Ghost-Ghost",
        "Magma-Magma", "Quake-Quake", "Buddha-Buddha", "Love-Love",
        "Creation-Creation", "Spider-Spider", "Sound-Sound", "Phoenix-Phoenix",
        "Portal-Portal", "Lightning-Lightning", "Pain-Pain", "Blizzard-Blizzard",
        "Gravity-Gravity", "T-Rex-T-Rex", "Mammoth-Mammoth", "Dough-Dough",
        "Shadow-Shadow", "Venom-Venom", "Gas-Gas", "Control-Control",
        "Spirit-Spirit", "Leopard-Leopard", "Yeti-Yeti", "Kitsune-Kitsune",
        "Dragon-Dragon"
    },
    Callback = function(Value)
        getgenv().SelectFruit = Value
    end
})
Tabs.Raids:AddToggle({
    Name = "Auto Buy Fruit Shop",
    Default = false,
    Callback = function(Value)
        getgenv().AutoBuyFruitSniper = Value
    end
})
spawn(function()
    pcall(function()
        while wait() do
            if getgenv().AutoBuyFruitSniper then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseRawFruit", getgenv().SelectFruit)
            end
        end
    end)
end)

Tabs.Raids:AddSection("Dungeon Event / Raiding")
DungeonTables = {"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human: Buddha","Sand","Bird: Phoenix","Dough"}
Q = Tabs.Raids:AddDropdown({
Name = "Select Chip",
Description = "",
Options = DungeonTables,
Callback = function(Value)
  _G.SelectChip = Value
end})
Q = Tabs.Raids:AddToggle({
Name = "Auto Select Dungeon Chip", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoSelectDungeon = Value
end})
Tabs.Raids:AddToggle({
    Name = "Get Fruit In Inventory Below 1M",
    Default = false,
    Callback = function(Value)
        getgenv().AutoGetFruit = Value
    end
})
spawn(function()
    while wait() do
        pcall(function()
            if getgenv().AutoGetFruit then
                local fruits = {
                    "Rocket-Rocket", "Spin-Spin", "Chop-Chop", "Spring-Spring", "Bomb-Bomb", "Smoke-Smoke",
                    "Spike-Spike", "Flame-Flame", "Falcon-Falcon", "Ice-Ice", "Sand-Sand", "Dark-Dark",
                    "Ghost-Ghost", "Diamond-Diamond", "Light-Light", "Rubber-Rubber", "Barrier-Barrier"
                }
                for _, fruit in ipairs(fruits) do
                    local args = {
                        [1] = "LoadFruit",
                        [2] = fruit
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                end
            end
        end)
    end
end)
Tabs.Raids:AddButton({
Name = "Buy Dungeon Chips [Beli]", 
Description = "",
Callback = function()
  if not GetBP("Special Microchip") then replicated.Remotes.CommF_:InvokeServer("RaidsNpc","Select",_G.SelectChip) end
end})
Tabs.Raids:AddButton({
Name = "Buy Dungeon Chips [Devil Fruit]", 
Description = "",
Callback = function()
  if GetBP("Special Microchip") then return end
  local FruitPrice = {}
  local FruitStore = {}
  for i,v in next,replicated:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits") do
    if v.Price <= 490000 then table.insert(FruitPrice,v.Name) end 
  end    
  for _,y in pairs(FruitPrice) do    
    for i,v in pairs(DungeonTables) do 
      if not GetBP("Special Microchip") then     
        replicated.Remotes.CommF_:InvokeServer("LoadFruit",tostring(y))	      
	    replicated.Remotes.CommF_:InvokeServer("RaidsNpc","Select",_G.SelectChip)	
	  end            
    end    
  end
end})


AutoChipBeli = Tabs.Raids:AddToggle({
    Name = "Auto Buy Chip [Beli]",
    Description = "",
    Default = false,
    Callback = function(Value)
    _G.AutoChipBeli = Value
end
})

task.spawn(function()
    while task.wait(1) do
        if _G.AutoChipBeli then
            pcall(function()
                if not GetBP("Special Microchip") then
                    replicated.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
                end
            end)
        end
    end
end)


AutoChipFruit = Tabs.Raids:AddToggle({
    Name = "Auto Buy Chip [Devil Fruit]",
    Description = "",
    Default = false,
    Callback = function(Value)
    _G.AutoChipFruit = Value
end
})

task.spawn(function()
    while task.wait(1) do
        if _G.AutoChipFruit then
            pcall(function()
                if not GetBP("Special Microchip") then
                    local fruits = replicated.Remotes.CommF_:InvokeServer("GetFruits")
                    local cheapest = nil
                    for _, data in pairs(fruits) do
                        if data.Price <= 490000 then
                            cheapest = data.Name
                            break
                        end
                    end
                    if cheapest then
                        replicated.Remotes.CommF_:InvokeServer("LoadFruit", tostring(cheapest))
                        replicated.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
                    end
                end
            end)
        end
    end
end)


StartR = Tabs.Raids:AddToggle({
    Name = "Auto Start Raid",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.Auto_StartRaid = Value
    end
})

task.spawn(function()
    while task.wait(Sec) do
        if not _G.Auto_StartRaid then continue end

        pcall(function()
            local plr = game.Players.LocalPlayer
            local gui = plr:FindFirstChild("PlayerGui")
            local main = gui and gui:FindFirstChild("Main")
            local top = main and main:FindFirstChild("TopHUDList")

            if not top or top.RaidTimer.Visible then return end

            if not GetBP("Special Microchip") then return end

            if World2 then
                local btn = workspace.Map.CircleIsland.RaidSummon2.Button.Main
                if btn then
                    if btn:FindFirstChild("ProximityPrompt") then
                        fireproximityprompt(btn.ProximityPrompt)
                    elseif btn:FindFirstChild("ClickDetector") then
                        fireclickdetector(btn.ClickDetector)
                    end
                end
            end

            if World3 then
                local btn = workspace.Map["Boat Castle"].RaidSummon2.Button.Main
                if btn then
                    if btn:FindFirstChild("ProximityPrompt") then
                        fireproximityprompt(btn.ProximityPrompt)
                    elseif btn:FindFirstChild("ClickDetector") then
                        fireclickdetector(btn.ClickDetector)
                    end
                end
            end
        end)
    end
end)

Raiding = Tabs.Raids:AddToggle({
    Name = "Auto Raid + Next Island",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.Raiding = Value
    end
})

spawn(function()
    local locations = workspace["_WorldOrigin"].Locations
    local islands = {"Island 1","Island 2","Island 3","Island 4","Island 5"}
    local currentIsland = nil

    while task.wait(0.3) do
        if not _G.Raiding then continue end
         

        local gui = plr.PlayerGui.Main.TopHUDList.RaidTimer
        if not gui.Visible then continue end

        local char = plr.Character
        if not char then continue end

        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not root or not hum or hum.Health <= 0 then continue end
        if hum.Sit or hum.PlatformStand or root.Anchored then continue end


        local closestDist = 999999
        for _,name in ipairs(islands) do
            local loc = locations:FindFirstChild(name)
            if loc then
                local dist = (root.Position - loc.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    currentIsland = name
                end
            end
        end

        if not currentIsland then continue end
        local islandPos = locations:FindFirstChild(currentIsland)
        if not islandPos then continue end


        local foundEnemies = false
        for _,mob in ipairs(workspace.Enemies:GetChildren()) do
            local eh = mob:FindFirstChild("Humanoid")
            local ehrp = mob:FindFirstChild("HumanoidRootPart")
            if eh and ehrp and eh.Health > 0 then
                if (ehrp.Position - islandPos.Position).Magnitude < 450 then
                    foundEnemies = true
                    repeat
                        task.wait()
                        Attack.Kill(mob, _G.Raiding)
                    until not _G.Raiding or not mob.Parent or eh.Health <= 0
                end
            end
        end


        if not foundEnemies then
            local idx = table.find(islands, currentIsland)
            if idx and islands[idx+1] then
                local nxt = locations:FindFirstChild(islands[idx+1])
                if nxt then
              
                    local safePos = nxt.CFrame * CFrame.new(0, 45, 120)
                    _tp(safePos)
                end
                currentIsland = islands[idx+1]
                task.wait(1)
            end
        end
    end
end)

Tabs.Raids:AddToggle({
Name = "Auto Awakening", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_Awakener = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Auto_Awakener then
        replicated.Remotes.CommF_:InvokeServer("Awakener","Check")
        replicated.Remotes.CommF_:InvokeServer("Awakener","Awaken")
      end
    end)
  end
end)	

Tabs.Raids:AddToggle({
    Name = "Auto Teleport To Lab",
    Default = false,
    Callback = function(Value)
        _G.TpLab = Value
        StopTween(_G.TpLab)
        while _G.TpLab do
            wait()
            if _G.TpLab then
                if World2 and _G.TpLab then
                    topos(CFrame.new(-6438.73535, 250.645355, -4501.50684))
                elseif World3 and _G.TpLab then
                    topos(CFrame.new(-5017.40869, 314.844055, -2823.0127,-0.925743818, 4.48217499e-08, -0.378151238,4.55503146e-09, 1, 1.07377559e-07,0.378151238, 9.7681621e-08, -0.925743818))
                end
            end
        end
    end
})

Tabs.Raids:AddSection("Items Law/Order Sword")

Tabs.Raids:AddButton({
Name = "Buy Microchip Law", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Microchip","2")
end})
Tabs.Raids:AddButton({
Name = "Start Law Raids", 
Description = "",
Callback = function()
  fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
end})

Tabs.Raids:AddToggle({
    Name = "Auto Buy Microchip Law", 
    Description = "",
    Default = false,
    Callback = function(Value)
        getgenv().AutoBuyMicrochipLaw = Value
    end
})

spawn(function()
    while task.wait(1) do  
        if getgenv().AutoBuyMicrochipLaw then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Microchip","2")
            end)
        end
    end
end)

Tabs.Raids:AddToggle({
    Name = "Auto Start Law Raids", 
    Description = "",
    Default = false,
    Callback = function(Value)
        getgenv().AutoStartLawRaids = Value
    end
})

spawn(function()
    while task.wait(1) do  
        if getgenv().AutoStartLawRaids then
            pcall(function()
                fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
            end)
        end
    end
end)

Tabs.Raids:AddToggle({
Name = "Auto Kill Law", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoLawKak = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.AutoLawKak then
      pcall(function()
        local v = GetConnectionEnemies("Order")
        if v then repeat task.wait() Attack.Kill(v, _G.AutoLawKak) until _G.AutoLawKak == false or not v.Parent or v.Humanoid.Health <= 0
        else _tp(CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875))
        end
      end)
    end
  end
end)

Tabs.Raids:AddSection("Raids Dungeons")

local plr = game.Players.LocalPlayer

local function GetHRP()
    local char = plr.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

Tabs.Raids:AddToggle({
    Name = "Auto Farm Dungeon",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmDungeon = Value
    end
})

local FARM_RANGE = 5000

spawn(function()
    while task.wait(0.15) do
        if not _G.AutoFarmDungeon then continue end

        pcall(function()
            local plr = game.Players.LocalPlayer
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum or hum.Health <= 0 then return end

            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if not _G.AutoFarmDungeon then break end

                local mh = mob:FindFirstChild("Humanoid")
                local mhrp = mob:FindFirstChild("HumanoidRootPart")

                if mh and mhrp and mh.Health > 0 then
                    local dist = (mhrp.Position - hrp.Position).Magnitude
                    if dist <= FARM_RANGE then
                        repeat
                            task.wait()
                            Attack.Kill(mob, true)
                        until not _G.AutoFarmDungeon
                            or not mob.Parent
                            or mh.Health <= 0
                    end
                end
            end
        end)
    end
end)


Tabs.Raids:AddToggle({
    Name = "TP Exit (1)",
    Default = false,
    Callback = function(v)
        _G.TPFloor1 = v
    end
})


local tp1Done = false

local function GetCurrentFloor()
    local hrp = GetHRP()
    if not hrp then return end

    for _, floor in pairs(workspace.Map.Dungeon:GetChildren()) do
        local exit = floor:FindFirstChild("ExitTeleporter")
        if exit and exit:FindFirstChild("Root") then
            if (hrp.Position - exit.Root.Position).Magnitude < 200 then
                return exit.Root
            end
        end
    end
end

task.spawn(function()
    while task.wait(0.3) do
        if not _G.TPFloor1 then
            tp1Done = false
            continue
        end

        if not tp1Done then
            local root = GetCurrentFloor()
            if root then
                root = root.CFrame * CFrame.new(0,3,0)
                GetHRP().CFrame = root
                tp1Done = true
            end
        end
    end
end)

Tabs.Raids:AddToggle({
    Name = "TP Exit (2)",
    Default = false,
    Callback = function(v)
        _G.TPFloor2 = v
    end
})

local tp2Done = false

task.spawn(function()
    while task.wait(0.3) do
        if not _G.TPFloor2 then
            tp2Done = false
            continue
        end

        if tp2Done then continue end

        local hrp = GetHRP()
        if not hrp then continue end

        for _, floor in pairs(workspace.Map.Dungeon:GetChildren()) do
            local ent = floor:FindFirstChild("EntranceTeleporter")
            local ext = floor:FindFirstChild("ExitTeleporter")

            if ent and ext and ent:FindFirstChild("Root") and ext:FindFirstChild("Root") then
                if (hrp.Position - ent.Root.Position).Magnitude < 100 then
                    hrp.CFrame = ext.Root.CFrame * CFrame.new(0,3,0)
                    tp2Done = true
                    break
                end
            end
        end
    end
end)

Tabs.Raids:AddToggle({
    Name = "TP Exit (3)",
    Default = false,
    Callback = function(v)
        _G.TPFloor3 = v
    end
})

local tp3Done = false

local function GetHighestFloor()
    local max
    for _, floor in pairs(workspace.Map.Dungeon:GetChildren()) do
        local n = tonumber(floor.Name)
        if n and (not max or n > tonumber(max.Name)) then
            max = floor
        end
    end
    return max
end

task.spawn(function()
    while task.wait(0.3) do
        if not _G.TPFloor3 then
            tp3Done = false
            continue
        end

        if not tp3Done then
            local floor = GetHighestFloor()
            if floor and floor:FindFirstChild("ExitTeleporter")
            and floor.ExitTeleporter:FindFirstChild("Root") then

                GetHRP().CFrame =
                    floor.ExitTeleporter.Root.CFrame * CFrame.new(0,3,0)
                tp3Done = true
            end
        end
    end
end)

Tabs.Raids:AddToggle({
    Name = "TP Exit (4)",
    Default = false,
    Callback = function(v)
        _G.TPFloor4 = v
    end
})

local tp4Done = false

local function GetNearestExit()
    local hrp = GetHRP()
    if not hrp then return end

    local nearest, dist = nil, math.huge

    for _, floor in pairs(workspace.Map.Dungeon:GetChildren()) do
        local exit = floor:FindFirstChild("ExitTeleporter")
        if exit and exit:FindFirstChild("Root") then
            local d = (hrp.Position - exit.Root.Position).Magnitude
            if d < dist then
                dist = d
                nearest = exit.Root
            end
        end
    end
    return nearest
end

task.spawn(function()
    while task.wait(0.3) do
        if not _G.TPFloor4 then
            tp4Done = false
            continue
        end

        if not tp4Done then
            local root = GetNearestExit()
            if root then
                GetHRP().CFrame = root.CFrame * CFrame.new(0,3,0)
                tp4Done = true
            end
        end
    end
end)







-- === MISCELLANEOUS ===
Tabs.Misc:AddSection("Server - Function")
Tabs.Misc:AddButton({
    Name = "Redeem All Codes",
    Description = "",
    Callback = function()
        local codes = {
            "LIGHTNINGABUSE","1LOSTADMIN","ADMINFIGHT","GIFTING_HOURS","NOMOREHACK",
            "BANEXPLOIT","WildDares","BossBuild","GetPranked","EARN_FRUITS",
            "SUB2GAMERROBOT_RESET1","KITT_RESET","Bignews","CHANDLER","Fudd10",
            "fudd10_v2","Sub2UncleKizaru","FIGHT4FRUIT","kittgaming","TRIPLEABUSE",
            "Sub2CaptainMaui","Sub2Fer999","Enyu_is_Pro","Magicbus","JCWK",
            "Starcodeheo","Bluxxy","SUB2GAMERROBOT_EXP1","Sub2NoobMaster123",
            "Sub2Daigrock","Axiore","TantaiGaming","StrawHatMaine","Sub2OfficialNoobie",
            "TheGreatAce","JULYUPDATE_RESET","ADMINHACKED","SEATROLLING","24NOADMIN",
            "ADMIN_TROLL","NEWTROLL","SECRET_ADMIN","staffbattle","NOEXPLOIT",
            "NOOB2ADMIN","CODESLIDE","fruitconcepts","krazydares"
        }

        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local RemotesFolder = ReplicatedStorage:WaitForChild("Remotes")
        local RedeemRemote = RemotesFolder:FindFirstChild("Redeem")

        if not RedeemRemote then
            return
        end

        for _, code in ipairs(codes) do
            task.wait(0)
            pcall(function()
                if RedeemRemote.InvokeServer then
                    RedeemRemote:InvokeServer(code)
                else
                    RedeemRemote:FireServer(code)
                end
            end)
        end
    end
})
Tabs.Misc:AddButton({
Name = "Rejoin Server", 
Description = "",
Callback = function()
  game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end})
Tabs.Misc:AddButton({
    Name = "Hop Server",
    Description = "",
    Callback = function()
        task.spawn(function()
            local HttpService = game:GetService("HttpService")
            local TeleportService = game:GetService("TeleportService")
            local PlaceId = game.PlaceId
            local Players = game:GetService("Players")

            local success, servers = pcall(function()
                local url = "https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
                local response = game:HttpGet(url)
                return HttpService:JSONDecode(response).data
            end)

            if success and servers then
                local targetServer
                for _, s in pairs(servers) do
                    if s.playing < s.maxPlayers then
                        targetServer = s.id
                    end
                end

                if targetServer then
                    pcall(function()
                        TeleportService:TeleportToPlaceInstance(PlaceId, targetServer, Players.LocalPlayer)
                    end)
                end
            end
        end)
    end
})
Tabs.Misc:AddButton({
Name = "Hop to Lowest Players", 
Description = "",
Callback = function()
  local Http = game:GetService("HttpService")
  local TPS = game:GetService("TeleportService")
  local Api = "https://games.roblox.com/v1/games/"
  local _place = game.PlaceId
  local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
   function ListServers(cursor)
     local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
     return Http:JSONDecode(Raw)
   end
   local Server, Next; repeat
   local Servers = ListServers(Next)
   Server = Servers.data[1]
   Next = Servers.nextPageCursor
  until Server
  TPS:TeleportToPlaceInstance(_place,Server.id,plr)
end})

Tabs.Misc:AddButton({
Name = "Hop to Lowest Pings Server", 
Description = "",
Callback = function()
local HTTPService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local StatsService = game:GetService("Stats")
local function fetchServersData(placeId, limit)
    local url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?limit=%d", placeId, limit)
    local success, response = pcall(function()
        return HTTPService:JSONDecode(game:HttpGet(url))
    end)
  if success and response and response.data then
	return response.data
  end
    return nil
  end
  local placeId = game.PlaceId
  local serverLimit = 100
  local servers = fetchServersData(placeId, serverLimit)
  if not servers then return end
  local lowestPingServer = servers[1]
  for _, server in pairs(servers) do
    if server["ping"] < lowestPingServer["ping"] and server.maxPlayers > server.playing then
      lowestPingServer = server
    end
  end
  local commonLoadTime = 0.5
  task.wait(commonLoadTime)
  local pingThreshold = 100
  local serverStats = StatsService.Network.ServerStatsItem
  local dataPing = serverStats["Data Ping"]:GetValueString()
  local pingValue = tonumber(dataPing:match("(%d+)"))
  if pingValue >= pingThreshold then
    TeleportService:TeleportToPlaceInstance(placeId, lowestPingServer.id)
  else
  end
end})

local replicated = game:GetService("ReplicatedStorage")

Tabs.Misc:AddTextBox({
    Name = "Input Job Id",
    Placeholder = "Job ID",
    ClearOnFocus = true,
    Callback = function(Value)
        getgenv().Job = Value
    end
})

Tabs.Misc:AddButton({
    Name = "Teleport [Job ID]", 
    Callback = function()
        if getgenv().Job and getgenv().Job ~= "" then
            game:GetService("TeleportService")
                :TeleportToPlaceInstance(
                    game.PlaceId,
                    getgenv().Job,
                    game.Players.LocalPlayer
                )
        end
    end
})
Tabs.Misc:AddButton({
Name = "Copy JobID", 
Description = "",
Callback = function()
  setclipboard(tostring(game.JobId))
end})

Tabs.Misc:AddSection("Player Gui / Others")

Tabs.Misc:AddButton({
Name = "Open Awakenings Expert", 
Description = "",
Callback = function()
  plr.PlayerGui.Main.AwakeningToggler.Visible = true
end})
Tabs.Misc:AddButton({
Name = "Open Title Selection", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("getTitles",true)
  plr.PlayerGui.Main.Titles.Visible = true
end})
DisbleChat = Tabs.Misc:AddToggle({
Name = "Disable Chat GUI", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.Rechat = Value
  if  _G.Rechat == true then
    local StarterGui = game:GetService('StarterGui')
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)    
  elseif _G.chat == false then
    local StarterGui = game:GetService('StarterGui')
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)    
  end
end
})
DisbleLeaderB = Tabs.Misc:AddToggle({
Name = "Disable Leader Board GUI", 
Description = "", 
Default = false,
Callback = function(Value)
  ReLeader = Value
  if ReLeader == true then
    local StarterGui = game:GetService('StarterGui')
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)   
  elseif ReLeader == false then
    local StarterGui = game:GetService('StarterGui')
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)   
  end
end
})
Tabs.Misc:AddButton({
Name = "Set Pirate Team", 
Description = "",
Callback = function()
  Pirates()
end})  
Tabs.Misc:AddButton({
Name = "Set Marine Team", 
Description = "",
Callback = function()
  Marines()
end})
UnPortal = Tabs.Misc:AddToggle({
Name = "Unlock All Portals", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.PortalUnLock = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.PortalUnLock then        
         if Attack.Pos(CstlePos_Miti,8) then
           replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
         elseif Attack.Pos(Man3Pos_Miti,8) then
           replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-5072.08984375, 314.5412902832, -3151.1098632812))
         elseif Attack.Pos(HydraPos_Miti,8) then                    
           replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5748.7587890625, 610.44982910156, -267.81704711914))
         elseif Attack.Pos(HydratoCastle,8) then                   
           replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-5072.08984375, 314.5412902832, -3151.1098632812))
        end
      end
    end)
  end
end)

Tabs.Misc:AddSection("Graphics / Haki Stats")

HakiSt = {"State 0","State 1","State 2","State 3","State 4","State 5"}
HakiStat = Tabs.Misc:AddDropdown({
Name = "Select Haki States",
Options = HakiSt,
Callback = function(Value)
  _G.SelectStateHaki = Value
end})
Tabs.Misc:AddButton({
Name = "ChangeBusoStage", 
Description = "",
Callback = function()
  if _G.SelectStateHaki == "State 0" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",0)
  elseif _G.SelectStateHaki == "State 1" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",1)
  elseif _G.SelectStateHaki == "State 2" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",2)
  elseif _G.SelectStateHaki == "State 3" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",3)
  elseif _G.SelectStateHaki == "State 4" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",4)
  elseif _G.SelectStateHaki == "State 5" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",5)
  end
end})
rtxM = Tabs.Misc:AddToggle({
Name = "Turn on RTX Mode", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.RTXMode = Value
  local a = game.Lighting
  local c = Instance.new("ColorCorrectionEffect", a)
  local e = Instance.new("ColorCorrectionEffect", a)
  OldAmbient = a.Ambient
  OldBrightness = a.Brightness
  OldColorShift_Top = a.ColorShift_Top
  OldBrightnessc = c.Brightness
  OldContrastc = c.Contrast
  OldTintColorc = c.TintColor
  OldTintColore = e.TintColor    
  if not _G.RTXMode then return end
  while _G.RTXMode do wait()
    a.Ambient = Color3.fromRGB(33, 33, 33)
    a.Brightness = 0.3
    c.Brightness = 0.176
    c.Contrast = 0.39
    c.TintColor = Color3.fromRGB(217, 145, 57)
    game.Lighting.FogEnd = 999
    if not plr.Character.HumanoidRootPart:FindFirstChild("PointLight") then
      local a2 = Instance.new("PointLight")
      a2.Parent = plr.Character.HumanoidRootPart
      a2.Range = 15
      a2.Color = Color3.fromRGB(217, 145, 57)
    end
    if not _G.RTXMode then
      a.Ambient = OldAmbient
      a.Brightness = OldBrightness
      a.ColorShift_Top = OldColorShift_Top
      c.Contrast = OldContrastc
      c.Brightness = OldBrightnessc
      c.TintColor = OldTintColorc
      e.TintColor = OldTintColore
      game.Lighting.FogEnd = 2500
      plr.Character.HumanoidRootPart:FindFirstChild("PointLight"):Destroy()
    end
  end
end
})
Tabs.Misc:AddButton({
Name = "Turn on Fast Mode", 
Description = "",
Callback = function()
  for _,zx in next, workspace:GetDescendants() do
  if table.find(Past, zx.ClassName) then  zx.Material = "Plastic" end
  end
end})
Tabs.Misc:AddButton({
Name = "Turn on Low CPU", 
Description = "",
Callback = function()
  LowCpu()
end})
Tabs.Misc:AddButton({
Name = "Turn on increase Boats", 
Description = "",
Callback = function()
  for _, v in pairs(workspace.Boats:GetDescendants()) do
    if table.find(ListSeaBoat, v.Name) and tostring(v.Owner.Value) == tostring(plr.Name) then              
      v.VehicleSeat.MaxSpeed = 350
      v.VehicleSeat.Torque = 0.2
      v.VehicleSeat.TurnSpeed = 5
      v.VehicleSeat.HeadsUpDisplay = true
    end
  end
end})
Tabs.Misc:AddButton({
Name = "Remove Sky Fog", 
Description = "",
Callback = function()
  if Lighting:FindFirstChild("LightingLayers") then Lighting.LightingLayers:Destroy() end
  if Lighting:FindFirstChild("SeaTerrorCC") then Lighting.SeaTerrorCC:Destroy() end
  if Lighting:FindFirstChild("FantasySky") then Lighting.FantasySky:Destroy() end
end})

Tabs.Misc:AddSection("Configure - God")
Tabs.Misc:AddButton({
Name = "Rain Fruits (Client)", 
Description = "",
Callback = function()
  for i, v in pairs(game:GetObjects("rbxassetid://14759368201")[1]:GetChildren()) do
    v.Parent = game.Workspace.Map
    v:MoveTo(plr.Character.PrimaryPart.Position + Vector3.new(math.random(-50, 50), 100, math.random(-50, 50)))
    if v.Fruit:FindFirstChild("AnimationController") then
      v.Fruit:FindFirstChild("AnimationController"):LoadAnimation(v.Fruit:FindFirstChild("Idle")):Play()
    end
    v.Handle.Touched:Connect(function(otherPart)
      if otherPart.Parent == plr.Character then
        v.Parent = plr.Backpack
        plr.Character.Humanoid:EquipTool(v)
      end
    end)
  end
end})
briggt1 = Tabs.Misc:AddToggle({
Name = "Turn on Full Bright", 
Description = "", 
Default = false,
Callback = function(Value)
  bright = Value
  if Value == true then
    Lighting.Ambient = Color3.new(1, 1, 1)
    Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
    Lighting.ColorShift_Top = Color3.new(1, 1, 1)
  else
    Lighting.Ambient = Color3.new(0, 0, 0)
    Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
    Lighting.ColorShift_Top = Color3.new(0, 0, 0)
  end  
end
})


DayN = Tabs.Misc:AddDropdown({
Name = "Select Time",
Description = "",
Options = {"Day", "Night"},
Default = Day,
Callback = function(Value)
  _G.SelectDN = Value
end})
dayornight = Tabs.Misc:AddToggle({
Name = "Turn on Time", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.daylightN = Value
end})
task.spawn(function()
  while task.wait() do
    if _G.daylightN then
      if _G.SelectDN == "Day" then
        Lighting.ClockTime = 12
      elseif _G.SelectDN == "Night" then
        Lighting.ClockTime = 0
      end
    end
  end
end)
walkWater = Tabs.Misc:AddToggle({
Name = "Turn on Walk on Water", 
Description = "", 
Default = true,
Callback = function(Value)
  _G.WalkWater_Part = Value
  if _G.WalkWater_Part then
    game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
  else
    game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
  end
end
})
iceWalk = Tabs.Misc:AddToggle({
Name = "Turn on Ice Walk", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.WalkWater = Value
end})
spawn(function()
  while task.wait() do
    if _G.WalkWater then
      pcall(function()
	   if plr.Character and plr.Character:FindFirstChild("LeftFoot") then
	   local upval0 = replicated.Assets.Models.IceSpikes4:Clone()
        upval0.Parent = workspace
        upval0.Size = Vector3.new(3+math.random(10,12),1.7,3+math.random(10,12))
        upval0.Color = Color3.fromRGB(128,187,219)
        upval0.CFrame = CFrame.new(plr.Character.Head.Position.X,-3.8,plr.Character.Head.Position.Z)*CFrame.Angles((math.random()-0.5)*0.06, math.random()*7,(math.random()-0.5)*0.07)
        local var85={};
        var85.Size=Vector3.new(0,0.3,0)
        local var3=TW:Create(upval0,TweenInfo.new(2,Enum.EasingStyle.Quad,Enum.EasingDirection.In),var85)
        var3.Completed:Connect(function()
          upval0:Destroy()
        end)
          var3:Play()
	    end	
      end)
    end
  end
end)
local player = game.Players.LocalPlayer

-- === SETTINGS (essential) ===
Tabs.Settings:AddSection("Settings / Configure")

Initialize = Tabs.Settings:AddToggle({
Name = "Fast Attack", 
Description = "", 
Default = true,
Callback = function(Value)
  _G.Seriality = Value
end})
Bringmob = Tabs.Settings:AddToggle({
Name = "Bring Mobs", 
Description = "", 
Default = true,
Callback = function(Value)
  _B = Value
end})
Tabs.Settings:AddToggle({
    Name = "Auto Hop Server with time",
    Default = false,
    Callback = function(Value)
        _G.AutoHopServer = Value
        if not Value then
            _G.HopTimer = nil
        end
    end
})

Spawn(function()
    while Wait(1) do
        if _G.AutoHopServer then
            pcall(function()
                if not _G.HopTimer then
                    _G.HopTimer = tick()
                end

                if tick() - _G.HopTimer >= _G.HopDelay then
                    _G.HopTimer = tick()

                    if syn and syn.queue_on_teleport then
                        syn.queue_on_teleport(
                            "loadstring(game:HttpGet('https://pastefy.app/iiFOhcot/raw'))()"
                        )
                    end

                    game:GetService("TeleportService")
                        :Teleport(game.PlaceId, game.Players.LocalPlayer)
                end
            end)
        end
    end
end)
Tabs.Settings:AddSlider({
    Name = "Hop Delay (Minutes)",
    Min = 5,
    Max = 120,
    Default = 30,
    Increment = 1,
    Callback = function(Value)
        _G.HopDelay = Value * 60
    end
})
Tabs.Settings:AddToggle({
    Name = "Auto Set Spawn Point",
    Default = false,
    Callback = function(Value)
        getgenv().Set = Value
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
            end)
        end
    end
})
BusuAura = Tabs.Settings:AddToggle({
Name = "Auto Turn on Buso", 
Description = "", 
Default = true,
Callback = function(Value)
  Boud = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if Boud then
      local _HasBuso = {"HasBuso","Buso"}
  	  if not plr.Character:FindFirstChild(_HasBuso[1]) then replicated.Remotes.CommF_:InvokeServer(_HasBuso[2]) end
      end
    end)
  end
end)

-- Auto ON khi chạy script: Fast Attack + Bring + Buso + Spin XYZ + Stop Items + Anti AFK
task.defer(function()
  task.wait(0.35)
  _G.Seriality = true
  _B = true
  Boud = true
  RandomCFrame = true
  _G.StopWhenChalice = true
  -- Anti AFK
  pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
      vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
      task.wait(1)
      vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
  end)
  pcall(function() if Initialize and Initialize.Set then Initialize:Set(true) end end)
  pcall(function() if Bringmob and Bringmob.Set then Bringmob:Set(true) end end)
  pcall(function() if BusuAura and BusuAura.Set then BusuAura:Set(true) end end)
  pcall(function() if RandomAround and RandomAround.Set then RandomAround:Set(true) end end)
  pcall(function() if StopI and StopI.Set then StopI:Set(true) end end)
  print("[nyann os] Auto ON: Fast Attack / Bring / Buso / Spin XYZ / Stop Items / Anti AFK")
end)
-- Anti AFK toggle (optional UI)
Tabs.Settings:AddToggle({
    Name = "Anti AFK",
    Default = true,
    Callback = function(Value)
        _G.AntiAFK = Value
    end
})


-- ============================================================
-- OPTIMIZED FAST ATTACK (SIEU TOC) - from user paste
-- ============================================================
do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")
    local Player = Players.LocalPlayer

    local RegisterAttack, RegisterHit, ShootGunEvent
    pcall(function()
        local Modules = ReplicatedStorage:WaitForChild("Modules", 10)
        local Net = Modules and Modules:WaitForChild("Net", 5)
        if Net then
            RegisterAttack = Net:FindFirstChild("RE/RegisterAttack") or Net:WaitForChild("RE/RegisterAttack", 3)
            RegisterHit = Net:FindFirstChild("RE/RegisterHit") or Net:WaitForChild("RE/RegisterHit", 3)
            ShootGunEvent = Net:FindFirstChild("RE/ShootGunEvent") or Net:FindFirstChild("RE/ShootGunEvent")
        end
    end)

    getgenv().PMT_GunFast = true
    getgenv().PMT_GunFast_Delay = 0
    getgenv().PMT_GunFast_PrimeEvery = 0

    local Config = {
        AttackDistance = 100,
        AttackMobs = true,
        AttackPlayers = false,
        AttackDelay = 0,
        AutoClickEnabled = true,
    }

    local FA = {}
    FA.__index = FA

    function FA.new()
        local self = setmetatable({
            EnemyRootPart = nil,
            HitFunction = nil,
        }, FA)
        pcall(function()
            local ls = Player:WaitForChild("PlayerScripts", 5)
            ls = ls and ls:FindFirstChildOfClass("LocalScript")
            if ls and getsenv then
                self.HitFunction = getsenv(ls)._G.SendHitsToServer
            end
        end)
        return self
    end

    function FA:IsEntityAlive(e)
        local h = e and e:FindFirstChild("Humanoid")
        return h and h.Health > 0
    end

    function FA:GetBladeHits(c, dist)
        local pos = c:GetPivot().Position
        local bh = {}
        dist = dist or Config.AttackDistance
        local function proc(folder)
            if not folder then return end
            for _, e in ipairs(folder:GetChildren()) do
                if e ~= c and self:IsEntityAlive(e) then
                    local root = e:FindFirstChild("HumanoidRootPart")
                    if root and (pos - root.Position).Magnitude <= dist then
                        local hitPart = e:FindFirstChild("Head") or root
                        table.insert(bh, { e, hitPart })
                        self.EnemyRootPart = root
                    end
                end
            end
        end
        if Config.AttackMobs then proc(Workspace:FindFirstChild("Enemies")) end
        if Config.AttackPlayers then proc(Workspace:FindFirstChild("Characters")) end
        return bh
    end

    function FA:Attack()
        if not Config.AutoClickEnabled then return end
        if not (_G.Seriality or getgenv().FastAttackOn) then return end
        local char = Player.Character
        if not char or not self:IsEntityAlive(char) then return end
        local tool = char:FindFirstChildOfClass("Tool")
        if not tool then return end

        if tool.ToolTip == "Gun" and getgenv().PMT_GunFast and ShootGunEvent then
            pcall(function() tool:Activate() end)
            local targets = self:GetBladeHits(char, 120)
            local t = targets[1]
            if t then
                pcall(function()
                    ShootGunEvent:FireServer(t[2].Position, { t[2] })
                end)
            end
            return
        end

        if not RegisterAttack or not RegisterHit then return end
        local hits = self:GetBladeHits(char)
        if #hits > 0 then
            pcall(function() RegisterAttack:FireServer(0) end)
            if self.HitFunction then
                pcall(function() self.HitFunction(self.EnemyRootPart, hits) end)
            else
                local args = { hits[1][2], {} }
                for i, v in ipairs(hits) do
                    args[2][i] = v
                end
                pcall(function() RegisterHit:FireServer(unpack(args)) end)
            end
        end
    end

    local AttackInstance = FA.new()
    getgenv()._NyannFastAttack = AttackInstance
    getgenv()._NyannFastAttackConfig = Config

    RunService.Heartbeat:Connect(function()
        pcall(function()
            AttackInstance:Attack()
        end)
    end)

    pcall(function()
        local mt = getrawmetatable(game)
        local old = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "FireServer" and tostring(self.Name) == "RegisterAttack" then
                if Config.AutoClickEnabled and (_G.Seriality or getgenv().FastAttackOn) then
                    AttackInstance:Attack()
                    return
                end
            end
            return old(self, ...)
        end)
        setreadonly(mt, true)
    end)

    print("[nyann os] Ultra Fast Attack loaded")
end


print("[nyann os] Ready — Level/Bone/Cake + Fish/RaceV4/SeaEvent + FastAttack")

