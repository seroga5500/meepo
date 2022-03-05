local Meepo = {}
local KostyaUtils = require("KostyaUtils/Utils")
local font = Renderer.LoadFont("Tahoma", 20, Enum.FontWeight.EXTRABOLD)
local infoFont = Renderer.LoadFont("Tahoma", 14, Enum.FontWeight.BOLD)
local newFont = nil
----   PATH   ----
local comboPath = {".ZZZ","Meepo"}
local botPath = {".ZZZ","Meepo", "2.4 [Meepo bot]"}
local item_path = {".ZZZ","Meepo", "1.6 Combo Items"}
local pop_item_path = {".ZZZ","Meepo", "1.9 Pop Linken/Spell Shield items"}
local forest_path = {".ZZZ","Meepo", "2.4 [Meepo bot]", "2.0 Forest"}

Meepo.language1 = Menu.AddOption(comboPath, "2.5 Language", "", 0, 0, 1)
Menu.SetValueName(Meepo.language1, 0, "English")
Menu.SetValueName(Meepo.language1, 1, "Russian")

----   NAME   ----
Meepo.Name = 
{
    {
        ["mainOption"] =       "1.0 Enable",
        ["drawOption"] =       "1.1 Draw Info",
        ["altDrawing"] =       "1.2 Draw Info on Meepo",
        ["comboKey"] =         "1.3 Combo Key",
        ["targetIndicator"] =  "1.3.1 Target Indicator",
        ["targetIndicator1"] = "Tower aoe",
        ["targetIndicator2"] = "Hero name",
        ["optionBlink"] =      "1.4 Use Blink",
        ["BlinkDelay"] =       "1.4.1 Blink Delay",
        ["nearTarget"] =       "1.5 Closest to mouse range",
        ["ComboNoBlink"] =     "1.7 Poof to nearest to cursor Meepo",
        ["failSwitch"] =       "1.8 Interrupt poofs when no target",
        ["comboInLotus"] =     "2.0 Combo in Lotus Orb",
        ["healKey"] =          "2.1 Panic Key",
        ["MhealKey"] =         "2.2 Main panic",
        ["autoSave"] =         "2.3 Save then HP < % (not bot)",
        ["DangerHP"] =         "2.3.1 HP Treshold (%) for Escape to base",
        ["botOption"] =        "1.0 Enable Bot",
        ["botToggleKey"] =     "1.1 Toggle Key",
        ["useHero"] =          "1.3 Main Meepo",
        ["autoNet"] =          "1.4 Auto Earthbind",
        ["tresholdHP"] =       "1.5 HP Treshold (%) for 'HEAL'",
        ["sleepTime"] =        "1.6 Sleep duration after Player's order (sec)",
        ["enemyInRadius"] =    "1.7 If enemy hero in range",
        ["enemyInRadius1"] =   "Fight him",
        ["enemyInRadius2"] =   "Run to the base",
        ["afraidHP"] =         "1.8 Danger HP (%) for Afraid",
        ["afraidTime"] =       "1.9 Afraid duration (sec)",
        ["healAfterForest"] =  "1.0 'HEAL' after forest cleaning",
        ["manaThershold"] =    "1.1 Mana Theshold (%) for use Poof",
        ["forestMode"] =       "1.2 Forest Only",
        ["stackInTheForest"] = "1.3 Creep Stacking",
        ["stackAncient"] =     "1.4 Ancient Stacking",
        ["farmKey"] =          "1.5 Key on/off farm in spot",
        ["FarmWithAllies"] =   "1.6 Farm camps with allies",
        ["usePoofOnAncient"] = "1.7 Use poof on high-resist ancient camp"
    },
    {
        ["mainOption"] =       "1.0 Включить",
        ["drawOption"] =       "1.1 Инфопанель",
        ["altDrawing"] =       "1.2 Информация около клонов",
        ["comboKey"] =         "1.3 Прокаст",
        ["nearTarget"] =       "1.4 Радиус поиска цели вокруг курсора",
        ["BlinkDelay"] =       "1.6 Задержка перед блинком",
        ["failSwitch"] =       "1.8 Прерывать пуфы, когда нет противника",
        ["comboInLotus"] =     "1.9 Комбо в Lotus Orb",
        ["healKey"] =          "2.0 Бежать на базу",
        ["MhealKey"] =         "2.1 Главного тоже",
        ["botOption"] =        "1.0 Включить бота",
        ["botToggleKey"] =     "1.1 Вкл/Выкл",
        ["useHero"] =          "1.3 Главный Мипо",
        ["autoNet"] =          "1.4 Автосетка",
        ["tresholdHP"] =       "1.5 Порог HP (%) для статуса 'HEAL'",
        ["sleepTime"] =        "1.6 Длительность сна после команды игрока (sec)",
        ["enemyInRadius"] =    "1.7 Когда в радиусе герой противника",
        ["enemyInRadius1"] =   "Бить его",
        ["enemyInRadius2"] =   "Бежать",
        ["afraidHP"] =         "1.8 Опасный уровень здоровья (%)",
        ["afraidTime"] =       "1.9 Длительность 'испуга'",
        ["manaThershold"] =    "1.0 Порог маны (%) для пуфов при фарме леса",
        ["forestMode"] =       "1.1 Только лес",
        ["stackInTheForest"] = "1.2 Стакать крипов",
        ["stackAncient"] =     "1.3 Стакать Ancient-ов",
        ["ComboNoBlink"] =     "Пуфы к ближайшему Мипо",
        ["farmKey"] =          "Вкл/выкл фарм кемпа",
        ["optionBlink"] =      "Использовать блинк",
        ["FarmWithAllies"] =   "Фармить кемп с союзником",
        ["usePoofOnAncient"] = "Использовать пуф на эншентов с высоким маг. резистом"
    }
}

function Meepo.Language(path)
    lang = Menu.GetValue(Meepo.language1) + 1
    return Meepo.Name[lang][path]
end

local mainOption = Menu.AddOption(comboPath, Meepo.Language("mainOption"), "")
local drawOption = Menu.AddOption(comboPath, Meepo.Language("drawOption"), "")
local altDrawing = Menu.AddOption(comboPath, Meepo.Language("altDrawing"), "")
local DangerHP = Menu.AddOption(comboPath, Meepo.Language("DangerHP"), "", 10, 90, 5)
local botOption = Menu.AddOption(botPath, Meepo.Language("botOption"), "")
local botToggleKey = Menu.AddKeyOption(botPath, Meepo.Language("botToggleKey"), Enum.ButtonCode.KEY_NONE)
local useHero = Menu.AddOption(botPath, Meepo.Language("useHero"), "")
local autoNet = Menu.AddOption(botPath, Meepo.Language("autoNet"), "")
local tresholdHP = Menu.AddOption(botPath, Meepo.Language("tresholdHP"), "", 10, 70, 5)
local sleepTime = Menu.AddOption(botPath, Meepo.Language("sleepTime"), "", 0, 10, 1)
local enemyInRadius = Menu.AddOption(botPath, Meepo.Language("enemyInRadius"), "", 0, 1, 1)

Menu.SetValueName(enemyInRadius, 0, Meepo.Language("enemyInRadius1"))
Menu.SetValueName(enemyInRadius, 1, Meepo.Language("enemyInRadius2"))

local afraidHP = Menu.AddOption(botPath, Meepo.Language("afraidHP"), "", 10, 70, 5)
local afraidTime = Menu.AddOption(botPath, Meepo.Language("afraidTime"), "", 0, 10, 1)

local forestMode = Menu.AddOption(forest_path, Meepo.Language("forestMode"), "")
local FarmWithAllies = Menu.AddOption(forest_path, Meepo.Language("FarmWithAllies"), "")
local healAfterForest = Menu.AddOption(forest_path, Meepo.Language("healAfterForest"), "")
local manaThershold = Menu.AddOption(forest_path, Meepo.Language("manaThershold"), "",  0, 100, 5)
local usePoofOnAncient = Menu.AddOption(forest_path, Meepo.Language("usePoofOnAncient"), "")
local stackInTheForest = Menu.AddOption(forest_path, Meepo.Language("stackInTheForest"), "")
local stackAncient = Menu.AddOption(forest_path, Meepo.Language("stackAncient"), "")
local farmKey = Menu.AddKeyOption(forest_path, Meepo.Language("farmKey"), Enum.ButtonCode.KEY_NONE)


local comboKey =  Menu.AddKeyOption(comboPath, Meepo.Language("comboKey"), Enum.ButtonCode.KEY_NONE)
local targetIndicator = Menu.AddOption(comboPath, Meepo.Language("targetIndicator"), "", 0, 1, 1)

Menu.SetValueName(targetIndicator, 0, Meepo.Language("targetIndicator1"))
Menu.SetValueName(targetIndicator, 1, Meepo.Language("targetIndicator2"))

local nearTarget =  Menu.AddOption(comboPath, Meepo.Language("nearTarget"), "", 100, 1000, 100)
local optionBlink = Menu.AddOption(comboPath, Meepo.Language("optionBlink"), "")
local BlinkDelay = Menu.AddOption(comboPath, Meepo.Language("BlinkDelay"), "", 0, 4, 1)

Menu.SetValueName(BlinkDelay, 0, "1.4 sec (default)")
Menu.SetValueName(BlinkDelay, 1, "1.2 sec")
Menu.SetValueName(BlinkDelay, 2, "1.0 sec")
Menu.SetValueName(BlinkDelay, 3, "0.8 sec")
Menu.SetValueName(BlinkDelay, 4, " - ")

---- items ----
local itemsIndex = {"hex", "orchid", "null", "halberd", "diffusal"}
local items = {hex = "1. Scythe of Vyse", orchid =  "2. Orchid/Bloodthorn", null = "3. Nullifier", halberd = "4. Heaven's Halberd", diffusal = "5. Diffusal Blade"}
local itemsOptionID = {eblade, hex, orchid, null,halberd, diffusal}
itemsOptionID["eblade"] = Menu.AddOption(item_path, "6. Ethereal Blade", "", 0, 2, 1)

Menu.SetValueName(itemsOptionID["eblade"], 0, "Off")
Menu.SetValueName(itemsOptionID["eblade"], 1, "On")
Menu.SetValueName(itemsOptionID["eblade"], 2, "Steal Only")

for i,k in ipairs(itemsIndex) do
    itemsOptionID[k] = Menu.AddOption(item_path, items[k], "")
end
---- pop linken items ----
local popItemsIndex = {"diffusal", "forcestaff", "halberd", "eblade", "null", "orchid", "hex"} 
local popItems = {diffusal = "1. Pop with Diffusal Blade", forcestaff = "1. Pop with Force Staff/Hurricane Pike", halberd = "2. Pop with Heaven's Halberd", eblade = "3. Pop with Ethereal Blade", null = "4. Pop with Nullifier", orchid =  "5. Pop with Orchid/Bloodthorn", hex = "6. Pop with Scythe of Vyse"}
local popItemsOptionID = {diffusal, forcestaff, halberd, eblade, null, orchid, hex} 
for i,k in ipairs(popItemsIndex) do
    popItemsOptionID[k] = Menu.AddOption(pop_item_path, popItems[k], "")
end
---------------

local failSwitch = Menu.AddOption(comboPath,  Meepo.Language("failSwitch"), "")
local comboInLotus = Menu.AddOption(comboPath,  Meepo.Language("comboInLotus"), "")
local ComboNoBlink = Menu.AddKeyOption(comboPath,  Meepo.Language("ComboNoBlink"), Enum.ButtonCode.KEY_NONE)
local healKey = Menu.AddKeyOption(comboPath, Meepo.Language("healKey"), Enum.ButtonCode.KEY_NONE)
local MhealKey = Menu.AddOption(comboPath,  Meepo.Language("MhealKey"), "")
local autoSave =  Menu.AddOption(comboPath, Meepo.Language("autoSave"), "")


--local toogle =  Menu.AddKeyOption(comboPath, "test", Enum.ButtonCode.KEY_NONE)

Meepo.List = {}
Meepo.CampsClean = {}
Meepo.Runes = {}
Meepo.IconPoses = {true, true, true, true, true}
local indexes_of_npc = {}

Meepo.lastTick =    { -- Думаю не стоило этого делать roflanPominki
                            [0] = 0, -- blink комбо
                            [1] = 0, -- тайминги пуфов для комбо
                            [2] = 0, -- между сетками
                            [3] = 0, -- last poof time
                            [4] = 0, -- hex delay
                            [5] = 0, -- heal delay
                            [6] = 0, -- before attack order
                            [7] = 0, -- между запросами на сбитие линки
                            [8] = 0, -- между проверкой на стак
                            [9] = 0, -- runes
                    }
Meepo.TEAM = nil
Meepo.TEAM_CONTAIN = 'radiant'
Meepo.BASE = nil

Meepo.NPC = 0
Meepo.THINK = 1
Meepo.LAST_THINK = 2
Meepo.IDLE_CHECK = 3
Meepo.AFRAID_TIME = 4
Meepo.CAMP = 5

Meepo.THINK_IDLE = 0
Meepo.THINK_MOVE = 1
Meepo.THINK_ATTACK = 2
Meepo.THINK_HEAL = 3
Meepo.THINK_RUN = 4
Meepo.DELAY_BETWEEN_HEAL = 12

-- forest special
Meepo.THINK_FOREST = 5
Meepo.THINK_STACK = 6


-- attack special
Meepo.THINK_VISION_ATTACK = 7
Meepo.DELAY_BETWEEN_ATTACK = 8
Meepo.THINK_POOF_STRIKE = 9
Meepo.THINK_TEAMFIGHT = 10

Meepo.THINK_DELAY = 11
Meepo.THINK_RUNE = 12

Meepo.GAME_TIME = 0
Meepo.TOTAL_LATENCY = 0



local myHero = nil
local heroName = nil
local ultLvl = 0
local aghanim = 0
local someonePoofingStart = 0
local enemy = nil
local meepo_index = 1
local gameinfo_last_update = 0
local myPlayer = nil 
local current_time = os.clock
local ComboIsExecuting = false
local RealBlinkDelay = 0
local ebladeDMG = 0

local smallMax = 1
local midMax = 1
local largeMax = 1
local ancientMax = 2

local targetParticle = 0
local target_indicator = 1

function Meepo.Zeroing()
	myHero = nil
	ultLvl = 0
	aghanim = 0
	someonePoofingStart = 0
	enemy = nil
	meepo_index = 1
	gameinfo_last_update = 0
	myPlayer = nil 

	Meepo.TEAM = nil
	Meepo.TEAM_CONTAIN = 'radiant'
	Meepo.BASE = nil


	Meepo.List = {}
	Meepo.CampsClean = {}
	Meepo.Runes = {}
	Meepo.IconPoses = {true, true, true, true, true}
	indexes_of_npc = {}
	ComboIsExecuting = false
	RealBlinkDelay = 0
	targetParticle = 0
	target_indicator = 1

end

function Meepo.Init()
	if Engine.IsInGame() then
		myHero = Heroes.GetLocal()
		myPlayer = Players.GetLocal()
		heroName = NPC.GetUnitName(myHero)
		targetParticle = 0
        target_indicator = 1
	else 
		Meepo.Zeroing()
	end
end

Meepo.Init()



function Meepo.OnUpdate()
    if not Menu.IsEnabled(mainOption) or not Engine.IsInGame() or not Heroes.GetLocal() or GameRules.IsPaused() then return end
    if not myHero then 
        myHero = Heroes.GetLocal()
        heroName = NPC.GetUnitName(myHero)
    end
    if heroName ~= 'npc_dota_hero_meepo' then return end
    --
    --if Menu.IsKeyDownOnce(toogle) then
    --    Console.Print(tostring(Input.GetWorldCursorPos()))
    --end 
    --
    local time = current_time()
    
    for i = 1, Runes.Count() do
        local rune = Runes.Get(i)
        if rune then 
            for i=1, #indexes_of_npc do
                local entity = Meepo.List[indexes_of_npc[i]]
                local npc = entity[Meepo.NPC]
                if npc and npc ~= Heroes.GetLocal() then
                    for location, name in pairs(Meepo.BountyLocation) do
                        if KostyaUtils.Distance2Objects(npc, name[1]) <= 1100 and not Entity.IsDormant(rune) then
                            if Rune.GetRuneType(rune) == Enum.RuneType.DOTA_RUNE_BOUNTY and KostyaUtils.Distance2Objects(rune, name[1]) <= 100 and name[2] then
                                Meepo.lastTick[9] = time
                                if not Meepo.SleepReady(Menu.GetValue(sleepTime), Meepo.lastTick[9]) then 
                                    entity[Meepo.THINK] = Meepo.THINK_RUNE 
                                    Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_PICKUP_RUNE, rune, Vector(0, 0, 0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, npc)  
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    local x1, y1 = Renderer.GetScreenSize() 
    for index=1, 5, 1 do
        Meepo.IconPoses[index] = {true, true, true, true, true}
        Meepo.IconPoses[index][1], Meepo.IconPoses[index][2], Meepo.IconPoses[index][3]  = Meepo.IconPos(x1,y1, index)
    end
    
    if not Meepo.TEAM then
        Meepo.TEAM = Entity.GetTeamNum(myHero)
        if Meepo.TEAM == 3 then
            Meepo.TEAM_CONTAIN = 'dire'
            Meepo.BASE = Meepo.BuildingLocation['dire_fountain']
        else
            Meepo.BASE = Meepo.BuildingLocation['radiant_fountain']
        end
        Meepo.FillingCamps(Meepo.TEAM_CONTAIN)
    end
    if not myPlayer then 
        myPlayer = Players.GetLocal()
    end

    if Menu.IsKeyDownOnce(botToggleKey) then
        if Menu.IsEnabled(botOption) then
            Menu.SetValue(botOption, 0)
        else
            Menu.SetValue(botOption, 1)
        end

    end


    Meepo.GetGameInfo(time)

    local meepo_count = #indexes_of_npc
    if Meepo.List and Entity.IsAlive(myHero) then
        for i=1, #indexes_of_npc do
            local entity = Meepo.List[indexes_of_npc[i]]
            local npc = entity[Meepo.NPC]
            if npc then
            	local health = Entity.GetHealth(npc)
            	local health_percent = health * 100 / Entity.GetMaxHealth(npc)
            	if health_percent < Menu.GetValue(DangerHP) then
            		if eblade and Ability.IsReady(eblade) and Ability.IsCastable(eblade, NPC.GetMana(npc)) and Meepo.IsSuitableToCastSpell(myHero) then
            			if NPC.IsEntityInRange(npc, myHero, Ability.GetCastRange(eblade)) then
            				Player.HoldPosition(myPlayer, myHero)
            				Ability.CastTarget(eblade,npc)
            				break
            			end
            		end
            		if (Menu.IsEnabled(autoSave) and Menu.IsEnabled(botOption) and npc == myHero and not Menu.IsEnabled(useHero)) or (Menu.IsEnabled(autoSave) and not Menu.IsEnabled(botOption)) then
                        Meepo.FastHeal(entity) 
                    end
                elseif Menu.IsEnabled(botOption) then
                    if npc == myHero and not Menu.IsEnabled(useHero) then 

                    else
                        Meepo.Decision(entity, time, health_percent)
                        Meepo.think(entity, time, health,health_percent)
                    end
                end
            end
        end
    end


    --combo--
    if meepo_count > 0 and Menu.IsKeyDown(comboKey) then
    	Meepo.Combo(time)
    end


	if ComboIsExecuting and not (Menu.IsKeyDown(comboKey)) then --отмена каста пуфа, если клавишу отпустили
	    if Menu.IsEnabled(failSwitch) then
	        Meepo.Execute("hold")
	        ComboIsExecuting = not ComboIsExecuting
	    end
	    Engine.ExecuteCommand("dota_range_display " .. 0)
	end

    if meepo_count > 0 and Menu.IsKeyDownOnce(ComboNoBlink) then
    	Meepo.Execute("poof_to_hero")
    end

    if meepo_count > 0 and Menu.IsKeyDownOnce(healKey) and Meepo.SleepReady(0.2, Meepo.lastTick[5]) then
        Meepo.Execute("heal")
        Meepo.lastTick[5] = time    
    end

    if aghanim == 0 and (NPC.HasModifier(myHero, "modifier_item_ultimate_scepter") or NPC.HasModifier(myHero, "modifier_item_ultimate_scepter_consumed")) then 
        aghanim = 1
    end
    local ability = NPC.GetAbility(myHero, "meepo_divided_we_stand")
    local supposed_meepo_count = Ability.GetLevel(ability)+aghanim+1

    if meepo_count ~= supposed_meepo_count or meepo_count == 0 then -- заполнение таблицы с клонами
        if Ability.GetLevel(ability) > 0 then
            for i = 1, Heroes.Count() do 
                local npc = Heroes.Get(i)
                local name = NPC.GetUnitName(npc)
                if name ~= nil and Entity.IsSameTeam(myHero, npc) and Entity.IsAlive(npc) and not NPC.IsIllusion(npc) then
                    if name == 'npc_dota_hero_meepo' then
                        if not Meepo.List[Entity.GetIndex(npc)] or not Meepo.List[Entity.GetIndex(npc)][Meepo.NPC] == npc then
                            if npc == myHero then
                                Log.Write("Meepo -> New NPC: Main Meepo | index: "..Entity.GetIndex(npc))
                                Meepo.Respawn(npc, 1)
                            elseif npc ~= myHero then
                                meepo_index = meepo_index + 1
                                Log.Write("Meepo -> New NPC: Clone | index: "..Entity.GetIndex(npc))
                                Meepo.Respawn(npc, meepo_index)
                            end
                        end
                    end
                end
            end
        end
    end


    if Meepo.GAME_TIME / 60 % 1 < 0.01 then
        Meepo.CampsClean = {}
        Meepo.Runes = {}
    end
    if Meepo.SleepReady(0.3, Meepo.lastTick[8]) and (Meepo.GAME_TIME + Meepo.TOTAL_LATENCY) % 60 > 53 and Menu.IsEnabled(stackInTheForest) then
        Meepo.Execute("stack", Meepo.TOTAL_LATENCY)
        Meepo.lastTick[8] = time
    end
end

function Meepo.InBountyRange(pos)
    local range = 1500
    for name, location in pairs(Meepo.BountyLocation) do
        local dis = (location - pos):Length()
        if dis <= range then return true end
    end
    return false
end
---- EVENTS ----

function Meepo.Reset()
     Meepo.List = {}
end


function Meepo.Death(ent)
    local i = Entity.GetIndex(ent)
    if Meepo.List[i] ~= nil then
        Meepo.List[i] = nil
    end
end


function Meepo.Respawn(ent, index)
    local i = Entity.GetIndex(ent)
    Meepo.List[i] = {}
    Meepo.List[i][Meepo.NPC] = ent
    Meepo.List[i][Meepo.THINK] = Meepo.THINK_IDLE
    Meepo.List[i][Meepo.LAST_THINK] = current_time()
    Meepo.List[i][Meepo.IDLE_CHECK] = 0
    Meepo.List[i][Meepo.AFRAID_TIME] = 0
    Meepo.List[i][Meepo.DELAY_BETWEEN_ATTACK] = 0
    Meepo.List[i][Meepo.DELAY_BETWEEN_HEAL] = 0
    Meepo.List[i][Meepo.CAMP] = 0
    indexes_of_npc[#indexes_of_npc+1] = i
end

--------------------------------  CALLBACKS  --------------------------------

function Meepo.OnDraw()
    if not Engine.IsInGame() or not Menu.IsEnabled(mainOption) then return end
    if not myHero then return end
    if NPC.GetUnitName(myHero) ~= 'npc_dota_hero_meepo' or not Entity.IsAlive(myHero) or not Meepo.List then 
    	if targetParticle == 0 then
			Particle.Destroy(targetParticle)			
			targetParticle = 0
		end
    return end

    -- combo --

    if Menu.IsKeyDown(comboKey) or Menu.IsKeyDown(ComboNoBlink) then
        w, h = Input.GetCursorPos()
        Renderer.SetDrawColor(255, 255, 255, 255)
        if someonePoofingStart - current_time() > -2 then
            time = current_time()-someonePoofingStart
            if time < 1.6 then
                time = string.format("%.2f", time)
                w, h = Input.GetCursorPos()
                Renderer.DrawText(font, w - 40, h, time, 255)
            end
        else
            someonePoofingStart = 0
        end
        if enemy and enemy ~= 0 and Menu.IsKeyDown(comboKey) then
            if target_indicator == 1 then
                Renderer.DrawText(font, w + 40, h, NPC.GetUnitName(enemy), 255)
            else
                local particleEnemy = enemy
                if (not particleEnemy and targetParticle ~= 0) or not enemy then
                    Particle.Destroy(targetParticle)			
                    targetParticle = 0
                    particleEnemy = enemy
                else
                    if targetParticle == 0 and enemy then
                        targetParticle = Particle.Create("particles/ui_mouseactions/range_finder_tower_aoe.vpcf", Enum.ParticleAttachment.PATTACH_INVALID, enemy)				
                    end
                    if targetParticle ~= 0 and enemy then
                        Particle.SetControlPoint(targetParticle, 2, Entity.GetOrigin(myHero))
                        Particle.SetControlPoint(targetParticle, 6, Vector(1, 0, 0))
                        Particle.SetControlPoint(targetParticle, 7, Entity.GetOrigin(enemy))
                    end
                end
            end
        end
    else 
        if targetParticle ~= 0 then
            Particle.Destroy(targetParticle)			
            targetParticle = 0
        end
    end

    if Menu.IsEnabled(botOption) then
        Meepo.DrawCamps()
        Meepo.DrawRunes()
    end

	if Menu.IsEnabled(drawOption) then
        Meepo.DrawInfo()
    end

end


function Meepo.OnPrepareUnitOrders(orders)
    if not Engine.IsInGame() or not Menu.IsEnabled(mainOption) or not Engine.IsInGame() or not Heroes.GetLocal() or NPC.GetUnitName(Heroes.GetLocal()) ~= 'npc_dota_hero_meepo' then return true end
    if not orders.order or orders.order == 0 then return true end

    
    if orders.npc and orders.npc ~= 0 then
        if Meepo.List[Entity.GetIndex(orders.npc)] and Meepo.List[Entity.GetIndex(orders.npc)][Meepo.NPC] == orders.npc then
            Meepo.List[Entity.GetIndex(orders.npc)][Meepo.IDLE_CHECK] = current_time()
        end
    end
    return true 
end

function Meepo.OnGameStart()
	Meepo.Init()
end

function Meepo.OnGameEnd()
	Meepo.Zeroing()
end

------------------------------  AI  ------------------------------


function Meepo.Decision(entity, time, health_percent)
    if time < entity[Meepo.LAST_THINK] then return end
    if not Meepo.SleepReady(Menu.GetValue(sleepTime), entity[Meepo.IDLE_CHECK]) then 
    	entity[Meepo.THINK] = Meepo.THINK_DELAY 
    	return 
    end
    
    local npc = entity[Meepo.NPC]
    local think = entity[Meepo.THINK]

    local DISTANCE_ENEMY = 950
    local DISTANCE_DANGER = 900

    local origin = Entity.GetAbsOrigin(npc)
    local creeps = Entity.GetUnitsInRadius(npc, DISTANCE_ENEMY, Enum.TeamType.TEAM_ENEMY)
    local min_distance = 1500
    local min_distance_hero = 900
    local target = nil
    local hero_target = nil
    if not NPC.HasModifier(npc, "modifier_fountain_aura_buff") and creeps and #creeps > 0 then
        for i=1, #creeps do
        	local creep = creeps[i]
            local target_origin = Entity.GetAbsOrigin(creep)
            local distance = (origin - target_origin):Length()
            if not Entity.IsDormant(creep) and Entity.IsAlive(creep) and NPC.IsKillable(creep) and not NPC.IsWaitingToSpawn(creep) then
                if NPC.IsLaneCreep(creep) or NPC.IsHero(creep) or NPC.IsStructure(creep) and not NPC.HasModifier(creep, "modifier_vengefulspirit_command_aura_illusion") then
                    if NPC.IsHero(creep) and distance < min_distance_hero  then
                        min_distance_hero = distance
                        hero_target = creep
                    end
                    if distance < min_distance then
                        target = creep
                        min_distance = distance
                        if NPC.IsHero(creep) and distance < 1200 then
                            if Menu.IsEnabled(autoNet) and Meepo.CanNet(target) then
                                Meepo.Net(entity, target)
                            end
                            if distance < 350 and not NPC.IsStructure(creep) and Menu.GetValue(enemyInRadius) == 0 then
                                Meepo.PoofStrike(entity)
                            end
                        end
                    end
                end
            end
        end
    end
    if hero_target then
        target = hero_target
    elseif think == Meepo.THINK_TEAMFIGHT then
    	entity[Meepo.THINK] = Meepo.THINK_VISION_ATTACK
    end
    if target and think ~= Meepo.THINK_HEAL then
        if NPC.IsHero(target) then
            entity[Meepo.THINK] = Meepo.THINK_TEAMFIGHT
            Player.AttackTarget(Players.GetLocal(), npc, target)
        else
            if Menu.IsEnabled(forestMode) then
                entity[Meepo.THINK] = Meepo.THINK_FOREST
            else
                 entity[Meepo.THINK] = Meepo.THINK_VISION_ATTACK
                 Player.AttackTarget(Players.GetLocal(), npc, target)
            end
        end
    elseif not target and think == Meepo.THINK_VISION_ATTACK then
        entity[Meepo.THINK] = Meepo.THINK_IDLE
    end

    -- check danger
    if health_percent < Menu.GetValue(afraidHP) or Menu.GetValue(enemyInRadius) == 1 then
        for i = 1, Heroes.Count() do
            local enemy_local = Heroes.Get(i)
            if not NPC.IsIllusion(enemy_local) and not Entity.IsSameTeam(npc, enemy_local) and not Entity.IsDormant(enemy_local) and Entity.IsAlive(enemy_local) and (Entity.GetAbsOrigin(npc) - Entity.GetAbsOrigin(enemy_local)):Length() < DISTANCE_DANGER then
                if Menu.GetValue(enemyInRadius) == 1 then
                    entity[Meepo.THINK] = Meepo.THINK_RUN
                    entity[Meepo.AFRAID_TIME] = current_time() 
                else
                    entity[Meepo.THINK] = Meepo.THINK_HEAL
                end
            end
        end
    end
    if think == Meepo.THINK_IDLE or think == Meepo.THINK_DELAY or think == Meepo.THINK_RUNE then
        entity[Meepo.THINK] = Meepo.THINK_FOREST
    end

end


function Meepo.think(entity, time, health, health_percent)
    if time < entity[Meepo.LAST_THINK] then return end

    local npc = entity[Meepo.NPC]
    local think = entity[Meepo.THINK]

    local mana = NPC.GetMana(npc)

    if health <= 0.0 then return end


    if health_percent < Menu.GetValue(tresholdHP) or health < 175 then
        entity[Meepo.THINK] = Meepo.THINK_HEAL
    end
    if NPC.HasModifier(npc,"modifier_spawnlord_master_stomp") and health < 550 then 
        entity[Meepo.THINK] = Meepo.THINK_HEAL
    end

    if think == Meepo.THINK_HEAL or think == Meepo.THINK_RUN then
        if think == Meepo.THINK_HEAL and health_percent > 85.0 and mana * 100 / NPC.GetMaxMana(npc) > 85.0 then
            entity[Meepo.THINK] = Meepo.THINK_IDLE
        elseif think == Meepo.THINK_RUN and Meepo.SleepReady(Menu.GetValue(afraidTime), entity[Meepo.AFRAID_TIME]) and Entity.GetHeroesInRadius(npc, 900, Enum.TeamType.TEAM_ENEMY)  then
            entity[Meepo.THINK] = Meepo.THINK_IDLE
        else
            local location = Meepo.BASE
            Meepo.FastHeal(entity)
            entity[Meepo.LAST_THINK] = time + 2.5
            return
        end
    end

    if think ~= Meepo.THINK_FOREST and think ~= Meepo.THINK_ATTACK and think ~= Meepo.THINK_STACK then
        entity[Meepo.CAMP] = 0
    end

    if (Meepo.GAME_TIME)%60<=53 and think == Meepo.THINK_STACK then
        entity[Meepo.THINK] = Meepo.THINK_FOREST
    end


    local max_health = Entity.GetMaxHealth(npc)
    if think == Meepo.THINK_FOREST then
        local only_small = 2
        if max_health > 900 and health > 350 then
            only_small = 1
        end
        if max_health > 1200 and health > 450 then
            only_small = false
        end

        if NPC.HasModifier(npc, "modifier_fountain_aura_buff") then
            local nearest_location_to_clone = Meepo.ClosestCamp(entity, only_small, -228)
            if nearest_location_to_clone then 
                local origin = Entity.GetAbsOrigin(npc)
                if Meepo.FastMove(entity, nearest_location_to_clone['origin']) == false then
                    NPC.MoveTo(npc, nearest_location_to_clone['origin'])
                end
                entity[Meepo.CAMP] = nearest_location_to_clone["name"] 
            end
        end

        local nearest_location = Meepo.ClosestCamp(entity, only_small, 300)
        if nearest_location then 
            entity[Meepo.CAMP] = nearest_location["name"] 
            entity[Meepo.THINK] = Meepo.THINK_ATTACK
        end

        local location = Meepo.ClosestCamp(entity, only_small)
        if location then 
                local origin = Entity.GetAbsOrigin(npc)
                Meepo.FastMove(entity, location['origin']) 
                NPC.MoveTo(npc, location['origin'])
                entity[Meepo.CAMP] = location["name"]
                if (origin - location['origin']):Length() <= 200 then
                    entity[Meepo.THINK] = Meepo.THINK_ATTACK
                    entity[Meepo.CAMP] = location["name"]
                else
                	entity[Meepo.LAST_THINK] = time + 0.5
            	end
        else
            if Meepo.CountEnabledCamps(only_small) == Meepo.CountCleanedCamps(only_small) and not NPC.HasModifier(npc, "modifier_fountain_aura_buff") then
            	if Menu.IsEnabled(healAfterForest) then
            		if health_percent > 85.0  then
            			local shrine = Meepo.ClosestShrine(entity, only_small)
            			local origin = Entity.GetAbsOrigin(npc)
            			if (origin - shrine['origin']):Length() <= 200 then
		                    entity[Meepo.THINK] = Meepo.THINK_IDLE
		                else
		                	if Meepo.FastMove(entity, shrine['origin']) == false then
			                    NPC.MoveTo(npc, shrine['origin'])
			                end
		            	end
            		else
                		Meepo.FastHeal(entity)
                	end
                else
        			local shrine = Meepo.ClosestShrine(entity, only_small)
        			local origin = Entity.GetAbsOrigin(npc)
        			if (origin - shrine['origin']):Length() <= 200 then
	                    entity[Meepo.THINK] = Meepo.THINK_IDLE
	                else
	                	if Meepo.FastMove(entity, shrine['origin']) == false then
		                    NPC.MoveTo(npc, shrine['origin'])
		                end
	            	end
                end
            elseif Meepo.CountEnabledCamps(only_small) > Meepo.CountCleanedCamps(only_small) then
                local location = Meepo.ClosestCamp(entity, only_small, 0)
                if location then 
                    local origin = Entity.GetAbsOrigin(npc)
                    NPC.MoveTo(npc, location['origin'])
                    if entity[Meepo.CAMP] == 0 then
                        Meepo.FastMove(entity, location['origin'])
                        entity[Meepo.CAMP] = 0
                    end
                    if (origin - location['origin']):Length() <= 200 then
                        entity[Meepo.THINK] = Meepo.THINK_ATTACK
                        entity[Meepo.CAMP] = location["name"]
                    else
	                	entity[Meepo.LAST_THINK] = time + 0.5
                    end
                end
            end
        end
    end

    if entity[Meepo.THINK] == Meepo.THINK_ATTACK then
        local target_range = 700
        local target = nil
        local min_distance = 9999
        local creeps = Entity.GetUnitsInRadius(npc, target_range, Enum.TeamType.TEAM_ENEMY)
        local origin = Entity.GetAbsOrigin(npc)
        if not creeps or #creeps<1 then 
            local location = Meepo.ClosestCamp(entity, false, 350)
            entity[Meepo.CAMP] = 0
            if location then
                Meepo.CampCleaned(location) -- clean closest woodcamp if exists
            end 
            entity[Meepo.THINK] = Meepo.THINK_IDLE
            return 
        end
        local creeps_count = 0
        for i = 1, #creeps do
        	local creep = creeps[i]
            local target_origin = Entity.GetAbsOrigin(creep)
            local distance = (origin - target_origin):Length2D()
            if Entity.IsAlive(creep) and not NPC.IsWaitingToSpawn(creep) and not NPC.IsStructure(creep) then
            	if min_distance > distance then
	                target = creep
	                min_distance = distance
	            end
	            creeps_count = creeps_count+1
            end
        end
        local poof = NPC.GetAbility(npc, "meepo_poof")
        if target then
        	if not string.match(entity[Meepo.CAMP], "ancient") or (Menu.IsEnabled(usePoofOnAncient) or NPC.HasModifier(target, "modifier_spawnlord_aura_bonus"))  then
	            if creeps_count > 1 and  mana * 100 / NPC.GetMaxMana(npc) > Menu.GetValue(manaThershold) and 
	            		Ability.IsCastable(poof, mana) and Ability.IsReady(poof) and Meepo.IsSuitableToCastSpell(npc) and NPC.IsEntityInRange(npc, target, 310) then
	                Ability.CastTarget(poof, npc)
	                entity[Meepo.LAST_THINK] = time + 1.0
	                return
	            end
	        end
            Player.AttackTarget(Players.GetLocal(), npc, target)
            entity[Meepo.LAST_THINK] = time + 0.7
            return
        else
            local location = Meepo.ClosestCamp(entity, false, 350)
            entity[Meepo.CAMP] = 0
            if location then
                Meepo.CampCleaned(location) -- clean closest woodcamp if exists
            end
            if not Ability.IsInAbilityPhase(poof) then
        		entity[Meepo.THINK] = Meepo.THINK_IDLE
        	end
        	entity[Meepo.LAST_THINK] = time + 0.3
        end	
    end
   	if entity[Meepo.LAST_THINK] <=  time then
   		 entity[Meepo.LAST_THINK] = time + 0.3
   	end
end


function Meepo.Combo(time)
    if not ComboIsExecuting then
        ComboIsExecuting = true
    end
    

    enemy = Input.GetNearestHeroToCursor(Meepo.TEAM, Enum.TeamType.TEAM_ENEMY)
    if enemy and enemy ~= 0 and not NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), Menu.GetValue(nearTarget)) then
        enemy = nil
    end
    local enemyStatus = (enemy and enemy ~= 0)

    local blink = NPC.GetItem(myHero, "item_blink", true)
    local blinkStatus = (blink and Ability.IsReady(blink) and Menu.IsEnabled(optionBlink))
    if blinkStatus then
        Engine.ExecuteCommand("dota_range_display " .. 1200)
    else
        Engine.ExecuteCommand("dota_range_display " .. 0)
        blinkStatus = false
    end

    local can_earthbind = false
    if enemyStatus then 
    	if NPC.HasModifier(enemy, "modifier_phoenix_supernova_hiding") then
			for i,v in pairs(Entity.GetUnitsInRadius(enemy, 1, Enum.TeamType.TEAM_FRIEND) ) do
				enemy = v
				break
			end
		end
    	can_earthbind = Meepo.CanNet(enemy)
    end
		
    if Meepo.SleepReady(2.0, Meepo.lastTick[1])  then
        Meepo.Execute("poof_combo", enemy, can_earthbind, blinkStatus)
    end
    if enemyStatus then
		
        if blinkStatus and not NPC.IsEntityInRange(myHero, enemy, 1200) and Meepo.SleepReady(1.4, Meepo.lastTick[1]) and someonePoofingStart>0 and Menu.IsEnabled(failSwitch) then
            Meepo.Execute("hold", enemy)
        end
        local bind = NPC.GetAbility(myHero, "meepo_earthbind")
        if NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) and NPC.IsEntityInRange(myHero, enemy, 500) 
                and not NPC.IsVisible(myHero) then
            if Meepo.SleepReady(1.55, Meepo.lastTick[1]) then
                Meepo.UseItems(myHero, enemy)
                if can_earthbind then
                    Meepo.Net(myHero, enemy, bind)
                end
            end
        else
            if blinkStatus and Menu.IsKeyDown(comboKey) and someonePoofingStart>0  then
                if Meepo.SleepReady(RealBlinkDelay, Meepo.lastTick[0]) then
                    if NPC.IsEntityInRange(myHero, enemy, 1200) and not NPC.IsEntityInRange(myHero, enemy, 250) then 
                        Ability.CastPosition(blink, (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(100)))
    					Meepo.sleep(0.05)
    					if bind and Ability.IsCastable(bind, NPC.GetMana(myHero)) then 
    						Ability.CastPosition(bind, Entity.GetAbsOrigin(enemy))
    					end
                        Meepo.lastTick[0] = time + 2.0
                    elseif NPC.IsEntityInRange(myHero, enemy, 250) then
                        Meepo.lastTick[0] = time + 2.0
                    end
                end
            end
            if NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(bind)) then
                if not Meepo.UseItems(myHero, enemy, can_earthbind) and can_earthbind and not blinkStatus then
                    Meepo.Net(myHero, enemy, bind)
                end
            end
        end 
    end
    if (not enemyStatus or (not blinkStatus and not NPC.IsEntityInRange(myHero, enemy, 375))) then
        if Meepo.SleepReady(1.4, Meepo.lastTick[1]) and someonePoofingStart>0 and Menu.IsEnabled(failSwitch) then
            Meepo.Execute("hold", enemy)
        end
    end
    if enemyStatus then
    	Meepo.Execute("net", enemy, can_earthbind)
    	Meepo.Execute("attack", enemy, false, blinkStatus)
    	local PoofTarget = Meepo.Execute("find_target")
		if (PoofTarget ~= myHero) or (NPC.IsEntityInRange(myHero, enemy, 300) 
		 and not can_earthbind and Meepo.IsSuitableToCastSpell(myHero) and NPC.GetUnitName(enemy) ~= "npc_dota_phoenix_sun" and not NPC.HasState(enemy,Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)) then
        	local poofMAin = NPC.GetAbility(myHero, "meepo_poof")
            if Ability.IsCastable(poofMAin, NPC.GetMana(myHero)) and Ability.IsReady(poofMAin) then
                Ability.CastTarget(poofMAin,PoofTarget)
            end
    	end
    end
end

------------------------------  UTILS  ------------------------------

function Meepo.DrawInfo()
    local size = 30
    for i=1, #indexes_of_npc do
        local entity = Meepo.List[indexes_of_npc[i]]
        local npc = entity[Meepo.NPC]
        local coordX, coordY, offset = Meepo.IconPoses[i][1], Meepo.IconPoses[i][2], Meepo.IconPoses[i][3]
            local info = Meepo.GetInfo(npc)
            Renderer.SetDrawColor(255, 215, 0, 255)
            if info["poof"] then
                if info["poof"] == 0 then 
                    Renderer.DrawText(infoFont, coordX, coordY, "POOFING", 0)
                elseif info["poof"] > 0 then
                    Renderer.DrawText(infoFont, coordX, coordY, "POOF CD: "..string.format("%.1f", info["poof"]), 0)
                end
            end
            if info["travel"] then
                if info["travel"] > 0 then
                    Renderer.DrawText(infoFont, coordX, coordY+offset, "TRAVEL CD: "..string.format("%.1f", info["travel"]), 0)
                end
            end
            if info["visible"] then
                Renderer.DrawText(infoFont, coordX, coordY+(offset*2), "VISIBLE TO ENEMIES", 0)
            end
        local status
        if ((npc ~= myHero) or (npc == myHero and Menu.IsEnabled(useHero))) and Menu.IsEnabled(botOption) then
            status = Meepo.DebugThink(entity)
            if Menu.IsEnabled(altDrawing) then
                local origin = Entity.GetAbsOrigin(npc)
                local x, y, visible = Renderer.WorldToScreen(origin)
                Renderer.SetDrawColor(255, 215, 0, 255)
                Renderer.DrawText(font, x-size, y-size, status, 0)
            end
        else
            Renderer.SetDrawColor(255, 0, 0)
            status = "OFF"
        end
        Renderer.DrawText(infoFont, coordX, coordY-offset, status, 0)
        local mouseInRect = Input.IsCursorInRect(coordX, coordY-offset, 50, 18)
        if mouseInRect and Menu.IsEnabled(botOption) then
            Renderer.DrawOutlineRect(coordX, coordY-offset, 50, 18)
            if Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
                if npc == myHero then
                    if Menu.IsEnabled(useHero) then
                        Menu.SetValue(useHero, 0)
                    else
                        Menu.SetValue(useHero, 1)
                    end
                else
                    entity[Meepo.THINK] = Meepo.THINK_HEAL
                end
            end
        end
    end
end

function Meepo.DrawCamps()
    local boxSize = 32
    for name ,camp in pairs(Meepo.CampLocation) do
        if camp then
            local X,Y = Renderer.WorldToScreen(Meepo.RealCampLocation[name])
            if camp[4] then
                Renderer.SetDrawColor(0, 255, 0, 111)
            else
                Renderer.SetDrawColor(255, 0, 0, 111)
            end
            Renderer.DrawFilledRect(X - boxSize / 2, Y - boxSize / 2, boxSize, boxSize)
            if Input.IsCursorInRect(X - boxSize / 2, Y - boxSize / 2, boxSize, boxSize) then
                if Menu.IsKeyDownOnce(farmKey) then
                    camp[4] = not camp[4]
                end
            end
        end
    end
end

function Meepo.DrawRunes()
    local boxSize = 24
    for name ,camp in pairs(Meepo.BountyLocation) do
        if camp then
            local X,Y = Renderer.WorldToScreen(Meepo.RealBountyLocation[name])
            if camp[2] then
                Renderer.SetDrawColor(0, 255, 0, 111)
            else
                Renderer.SetDrawColor(255, 0, 0, 111)
            end
            Renderer.DrawFilledRect(X - boxSize / 2, Y - boxSize / 2, boxSize, boxSize)
            if Input.IsCursorInRect(X - boxSize / 2, Y - boxSize / 2, boxSize, boxSize) then
                if Menu.IsKeyDownOnce(farmKey) then
                    camp[2] = not camp[2]
                end
            end
        end
    end
end

function Meepo.UseItems(hero, target, canNet)
    if Meepo.CheckProtection(target) == true then return false end
    local mana = NPC.GetMana(hero)
	if not NPC.IsEntityInRange(hero,target,550) then return false end
    if Meepo.CheckProtection(target) == "LINKEN" then 
        if Meepo.SleepReady(0.6, Meepo.lastTick[7]) then 
            Meepo.PopLinken(mana,target)
            Meepo.lastTick[7] = current_time()
        end
    end
    if Meepo.CheckProtection(target) == "LINKEN" then return false end
    if eblade and Ability.IsReady(eblade) and Ability.IsCastable(eblade,mana) and Menu.GetValue(itemsOptionID["eblade"]) ~= 0 then
        if Menu.GetValue(itemsOptionID["eblade"]) == 1 then
            Ability.CastTarget(eblade,target)
            return true
        elseif Menu.GetValue(itemsOptionID["eblade"]) == 2 then
        	local totalDMG = Meepo.GetTotalDmg(target,ebladeDMG,myHero)
            if totalDMG >= Entity.GetHealth(target) + NPC.GetHealthRegen(target) then
            	Player.HoldPosition(myPlayer, myHero)
                Ability.CastTarget(eblade,target)
                return true
            end
        end
    end
    if hex and Ability.IsReady(hex) and Ability.IsCastable(hex, mana) and Menu.IsEnabled(itemsOptionID["hex"]) then
        Ability.CastTarget(hex,target)
        Meepo.lastTick[4] = current_time()
        return true
    end
    if orchid and Ability.IsReady(orchid) and Ability.IsCastable(orchid, mana) and Menu.IsEnabled(itemsOptionID["orchid"]) then
        Ability.CastTarget(orchid, target)
        return true
    end  
    if not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_HEXED) and Meepo.SleepReady(0.1, Meepo.lastTick[4]) then
        if null and Ability.IsReady(null) and Ability.IsCastable(null, mana) and Menu.IsEnabled(itemsOptionID["null"]) then
            Ability.CastTarget(null,target)
            return true
        end
        if halberd and Ability.IsReady(halberd) and Ability.IsCastable(halberd, mana) and Menu.IsEnabled(itemsOptionID["halberd"]) then
            Ability.CastTarget(halberd,target)
            return true
        end
        if diffusal and Ability.IsReady(diffusal) and Menu.IsEnabled(itemsOptionID["diffusal"]) and canNet then
            Ability.CastTarget(diffusal,target)
            return true
        end
    end
    if Meepo.SleepReady(1,  Meepo.lastTick[6]) then
        Player.AttackTarget(Players.GetLocal(), hero, target, false)
        Meepo.lastTick[6] = current_time()
        return false
    end
    return false
end

function Meepo.PopLinken(mana, target)
    if diffusal and Ability.IsReady(diffusal) and Menu.IsEnabled(popItemsOptionID["diffusal"]) then Ability.CastTarget(diffusal,target) return true end
    if forcestaff and Ability.IsReady(forcestaff) and Ability.IsCastable(forcestaff, mana) and Menu.IsEnabled(popItemsOptionID["forcestaff"]) then Ability.CastTarget(forcestaff,target) return true end
    if halberd and Ability.IsReady(halberd) and Ability.IsCastable(halberd,mana) and Menu.IsEnabled(popItemsOptionID["halberd"]) then Ability.CastTarget(halberd,target) return true end
    if eblade and Ability.IsReady(eblade) and Ability.IsCastable(eblade,mana) and Menu.IsEnabled(popItemsOptionID["eblade"]) then Ability.CastTarget(eblade,target) return true end
    if null and Ability.IsReady(null) and Ability.IsCastable(null,mana) and Menu.IsEnabled(popItemsOptionID["null"]) then Ability.CastTarget(null,target) return true end
    if orchid and Ability.IsReady(orchid) and Ability.IsCastable(orchid,mana) and Menu.IsEnabled(popItemsOptionID["orchid"]) then Ability.CastTarget(orchid,target) return true end
    if hex and Ability.IsReady(hex) and Ability.IsCastable(hex,mana) and Menu.IsEnabled(popItemsOptionID["hex"]) then Ability.CastTarget(hex,target) return true end
    return false
end

function Meepo.GetItems(hero)
    null = NPC.GetItem(hero, "item_nullifier")
    hex = NPC.GetItem(hero, "item_sheepstick")
    eblade = NPC.GetItem(hero, "item_ethereal_blade")
 	if eblade and Ability.IsReady(eblade) and Ability.IsCastable(eblade,NPC.GetMana(hero)) and Menu.GetValue(itemsOptionID["eblade"]) == 2 then
        local agility = Hero.GetAgilityTotal(myHero)
        local intellect = Hero.GetIntellectTotal(myHero)
        local intMultiplier = ((0.069 * intellect) / 100) + 1
        ebladeDMG = ((75 + (2 * agility))*1.4)*intMultiplier
    end


    diffusal = NPC.GetItem(hero, "item_diffusal_blade")
    orchid = NPC.GetItem(hero, "item_bloodthorn")
    if not orchid then
        orchid = NPC.GetItem(hero, "item_orchid")
    end
    forcestaff = NPC.GetItem(hero, "item_hurricane_pike")
    if not forcestaff then
        forcestaff = NPC.GetItem(hero, "item_force_staff")
    end
    halberd = NPC.GetItem(hero, "item_heavens_halberd")
end

function Meepo.GetInfo(npc)
    local travel = NPC.GetItem(npc, "item_travel_boots") or NPC.GetItem(npc, "item_travel_boots_2")
    local travelCD = nil
    local poof = NPC.GetAbility(npc, "meepo_poof")
    local poofCD = nil
    if poof then
        if not Ability.IsReady(poof) then
            poofCD = Ability.GetCooldown(poof) -- Ability.GetColdown(poof)
        elseif Ability.IsInAbilityPhase(poof) then
            poofCD = 0
        end
    end
    if travel then
        if not Ability.IsReady(travel) then
            travelCD = Ability.GetCooldown(travel) -- Ability.GetColdown(poof)
        end
    end
    visible = NPC.IsVisible(npc)
    local r_table = {
        ["poof"] = poofCD,
        ["travel"] = travelCD,
        ["visible"] = visible
    }
    return r_table
end


function Meepo.Execute(command, param, canNet, blinkStatus)
    if Meepo.SleepReady(1.5, Meepo.lastTick[3]) then
        someonePoofingStart = 0
    end
    if not Meepo.List then return end


    local time = current_time()
    local paramStatus = (param and param ~= 0)


    if command == "poof_combo" then 
    	local newPoof = false
    	local PoofTarget = Meepo.Execute("find_target",param)
    	local param_origin = Vector()
    	if paramStatus then
    		param_origin = Entity.GetAbsOrigin(param)
    	end
        for i=1, #indexes_of_npc do
            local npc = Meepo.List[indexes_of_npc[i]][Meepo.NPC] 
            if npc then
            	if Meepo.List[indexes_of_npc[i]][Meepo.THINK] ~= Meepo.THINK_HEAL and Entity.GetHealth(npc) > 200 then
	                if npc ~= myHero then
	                    local poof = NPC.GetAbility(npc, "meepo_poof")
	                    local rangeToEnemy = 0
	                    if paramStatus then
	                    	rangeToEnemy = (param_origin - Entity.GetAbsOrigin(npc)):Length2D()
	                    end
	                    if Ability.IsCastable(poof, NPC.GetMana(npc)) and Meepo.IsSuitableToCastSpell(npc) and Ability.IsReady(poof) and 
	                    ((paramStatus and rangeToEnemy < 300 and not canNet and NPC.GetUnitName(param) ~= "npc_dota_phoenix_sun" and not NPC.HasState(param,Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)) 
	        			or blinkStatus or (paramStatus and rangeToEnemy > 700)) then
	                       	Ability.CastTarget(poof, PoofTarget)
	                       	if paramStatus then
	                       		Player.AttackTarget(myPlayer , npc, param, true)
	                       	end
	                       	newPoof = true
	                    elseif (paramStatus and rangeToEnemy < 1000) and not Ability.IsInAbilityPhase(poof) and Meepo.SleepReady(0.3,  Meepo.List[indexes_of_npc[i]][Meepo.DELAY_BETWEEN_ATTACK]) then
	                        Player.AttackTarget(myPlayer , npc, param, false)
	                        Meepo.List[indexes_of_npc[i]][Meepo.DELAY_BETWEEN_ATTACK] = current_time()
	                    end
	            	else
	            		local poof = NPC.GetAbility(npc, "meepo_poof")
	            		local rangeToEnemy = 0
	            		if paramStatus then
	                    	rangeToEnemy = (param_origin - Entity.GetAbsOrigin(npc)):Length2D()
	                    end
	        		 	if PoofTarget ~= myHero and Ability.IsCastable(poof, NPC.GetMana(npc)) and Meepo.IsSuitableToCastSpell(npc) and Ability.IsReady(poof) and paramStatus and ((not blinkStatus and rangeToEnemy > 800) or 
	        		 	(blinkStatus and rangeToEnemy > 1250)) then
	        		 		Ability.CastTarget(poof, PoofTarget)
	        		 	end 
	            	end
	            end
	            Meepo.List[indexes_of_npc[i]][Meepo.IDLE_CHECK] = time
            end
        end
        if newPoof then 
            someonePoofingStart = time
         	Meepo.lastTick[3] = time
         	Meepo.lastTick[1] = time
            Meepo.lastTick[0] = time
        end 
    end
    if command == "find_target" then
    	local PoofTarget = myHero
   		for i=1, #indexes_of_npc do
            local npc = Meepo.List[indexes_of_npc[i]][Meepo.NPC] 
            if npc then
                local inRange = (paramStatus and NPC.IsEntityInRange(npc, param, 300))
            	if inRange then 
            		PoofTarget = npc
            		break 
            	end
            end
        end
        return PoofTarget
    end
    if command == "attack" then
    	for i=1, #indexes_of_npc do
            local npc = Meepo.List[indexes_of_npc[i]][Meepo.NPC] 
            if npc then
            	if Meepo.List[indexes_of_npc[i]][Meepo.THINK] ~= Meepo.THINK_HEAL and Entity.GetHealth(npc) > 200 then
	            	if npc ~= myHero then
	            		local inRange = (paramStatus and NPC.IsEntityInRange(npc, param, 1000))
	            		local poof = NPC.GetAbility(npc, "meepo_poof")
	            		if inRange and poof and not Ability.IsInAbilityPhase(poof) and Meepo.SleepReady(0.3,  Meepo.List[indexes_of_npc[i]][Meepo.DELAY_BETWEEN_ATTACK]) then
	            			Player.AttackTarget(myPlayer , npc, param, false)
	                        Meepo.List[indexes_of_npc[i]][Meepo.DELAY_BETWEEN_ATTACK] = current_time()
	                    end
	            	else
	            		if not blinkStatus then
	            			local inRange = (paramStatus and NPC.IsEntityInRange(npc, param, 1200))
		            		local poof = NPC.GetAbility(npc, "meepo_poof")
		            		if inRange and poof and not Ability.IsInAbilityPhase(poof) and Meepo.SleepReady(0.3,  Meepo.List[indexes_of_npc[i]][Meepo.DELAY_BETWEEN_ATTACK]) then
		            			Player.AttackTarget(myPlayer , npc, param, false)
		                        Meepo.List[indexes_of_npc[i]][Meepo.DELAY_BETWEEN_ATTACK] = current_time()
		                    end
	            		end
	            	end
	            end
            end
        end
    end
    if command == "poof_to_hero" then
    	local newPoof = false
        for i=1, #indexes_of_npc do
            local npc = Meepo.List[indexes_of_npc[i]][Meepo.NPC] 
            if npc then
            	if Meepo.List[indexes_of_npc[i]][Meepo.THINK] ~= Meepo.THINK_HEAL and Entity.GetHealth(npc) > 200 then
	                if npc ~= myHero then
	                	local poof = NPC.GetAbility(npc, "meepo_poof")
	                    if Ability.IsCastable(poof, NPC.GetMana(npc)) and Meepo.IsSuitableToCastSpell(npc) and Ability.IsReady(poof) and not Ability.IsInAbilityPhase(poof) then
	                       	Ability.CastTarget(poof, myHero)
	                       	newPoof = true
	                    end
	                end
	            end
            end
        end
        if newPoof then 
            someonePoofingStart = time
         	Meepo.lastTick[3] = time
         	Meepo.lastTick[1] = time
            Meepo.lastTick[0] = time
        end 
    end

    if command == "hold" then
    	local EnemyInRange = false
        for i=1, #indexes_of_npc do
            local npc = Meepo.List[indexes_of_npc[i]][Meepo.NPC] 
            if npc then
            	if Meepo.List[indexes_of_npc[i]][Meepo.THINK] ~= Meepo.THINK_HEAL and Entity.GetHealth(npc) > 200 then
	                if npc ~= myHero then
	                	if not paramStatus then
	                   		Player.HoldPosition(myPlayer, npc)
	                   	else
	                   		if NPC.IsEntityInRange(npc, param, 300) then
	                   			EnemyInRange = true
	                			break
	                   		end 
	                   	end
	                end
	                Meepo.List[indexes_of_npc[i]][Meepo.IDLE_CHECK] = time
	            end
            end
        end
        if not EnemyInRange and paramStatus then
        	Meepo.Execute("hold")
        end
        Meepo.lastTick[1] = time - 10
        someonePoofingStart = 0
    end
    if command == "heal" then
        local location = Meepo.BASE
        for i=1, #indexes_of_npc do
            local npc = Meepo.List[indexes_of_npc[i]][Meepo.NPC]
            if npc and Meepo.IsSuitableToCastSpell(npc) then
                if npc ~= myHero then
                   Meepo.FastHeal(Meepo.List[indexes_of_npc[i]])
                end
                if Menu.IsEnabled(botOption) then
                    Meepo.List[indexes_of_npc[i]][Meepo.IDLE_CHECK] = time
                end
            end
        end
    end
    if command == "net" then
        for i=1, #indexes_of_npc do
            local entity = Meepo.List[indexes_of_npc[i]]
            local npc = entity[Meepo.NPC]
         	local poof = NPC.GetAbility(npc, "meepo_poof")
         	local bind = NPC.GetAbility(npc, "meepo_earthbind")
            if npc and NPC.IsEntityInRange(npc, param, Ability.GetCastRange(bind)) and npc ~= myHero and not Ability.IsInAbilityPhase(poof) and canNet then
                Meepo.Net(entity, param)
            end
        end
    end
    if command == "stack" then
        local gameTime = (Meepo.GAME_TIME + param) % 60
        for i=1, #indexes_of_npc do
            local entity = Meepo.List[indexes_of_npc[i]]
            if entity[Meepo.NPC] and entity[Meepo.THINK] == Meepo.THINK_ATTACK then
                local campInfo, name = Meepo.InNeutralCamp(Entity.GetAbsOrigin(entity[Meepo.NPC]))
                if campInfo ~= nil and campInfo[3] ~= nil then
                	if campInfo[3] == math.ceil(gameTime) or campInfo[3] == math.floor(gameTime)-1 and Meepo.Execute("camp_count", name) == 1 then
		                if string.match(name, "ancient") and not Menu.IsEnabled(stackAncient) then return end 
	                    Player.HoldPosition(myPlayer, entity[Meepo.NPC])
	                    NPC.MoveTo(entity[Meepo.NPC], campInfo[2])
	                    entity[Meepo.THINK] = Meepo.THINK_STACK
	                    return
		            end
		        end
            end
        end
    end
    if command == "camp_count" and param then
        local count = 0
        for i=1, #indexes_of_npc do
            local entity = Meepo.List[indexes_of_npc[i]]
            if entity[Meepo.NPC] and entity[Meepo.CAMP] then
                if entity[Meepo.CAMP] == param then 
                    count = count + 1 
                end
            end
        end
        return count
    end
end

function Meepo.DebugThink(entity)
	local think = entity[Meepo.THINK] 
    if think == Meepo.THINK_IDLE then
        return 'IDLE'
    end
    if think == Meepo.THINK_MOVE then
        return 'MOVE'
    end
    if think == Meepo.THINK_ATTACK then
      	return 'FOREST'
        --return "ATTACK"
    end
    if think == Meepo.THINK_HEAL then
        return 'HEAL'
    end
    if think == Meepo.THINK_STACK then
        return 'STACK'
    end
    if think == Meepo.THINK_RUN then
        return 'AFRAID'
    end
    if think == Meepo.THINK_POOF_STRIKE then
        return 'POOF STRIKE'
    end
    if think == Meepo.THINK_FOREST then
        return 'FOREST'
    end
    if think == Meepo.THINK_VISION_ATTACK then
        return 'LANING'
    end
    if think == Meepo.THINK_TEAMFIGHT then
        return 'TEAMFIGHT'
    end
    if think == Meepo.THINK_DELAY then
        return 'SLEEP'  
    end
    if think == Meepo.THINK_RUNE then
        return 'RUNE'  
    end
    return 'X'
end


function Meepo.GetGameInfo(time)
    if time < gameinfo_last_update + 0.2 then return end
    Meepo.GAME_TIME = GameRules.GetGameTime() - GameRules.GetGameStartTime()
    Meepo.TOTAL_LATENCY = NetChannel.GetAvgLatency(Enum.Flow.FLOW_INCOMING) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
    local temp = Menu.GetValue(BlinkDelay)
    if temp > 3 then
    	RealBlinkDelay = 0
    else
    	RealBlinkDelay = 1.4 - (temp*0.2)
	end
	Meepo.GetItems(myHero)
    target_indicator = Menu.GetValue(targetIndicator)

    gameinfo_last_update = current_time()
end


function Meepo.FastHeal(entity)
	local myNPC = entity[Meepo.NPC]
    if NPC.HasModifier(myNPC, "modifier_fountain_aura_buff") then return true end
    local origin = Entity.GetAbsOrigin(myNPC)
    local location = Meepo.BASE
    local entity_to_base = (origin - location):Length2D()
    if entity_to_base < 1200 then
        return false
    end

    enemies = Entity.GetHeroesInRadius(myNPC, 300, Enum.TeamType.TEAM_ENEMY)
    if enemies and #enemies > 0 then
	    if enemies[1] then 
    		Meepo.Net(entity, enemies[1])
    	end
	end
    local min_distance = 100000
    local mana = NPC.GetMana(myNPC)
    local target = nil
    -- use teleport
    local travel = NPC.GetItem(myNPC, "item_travel_boots", true) or NPC.GetItem(myNPC, "item_travel_boots_2", true)
    if travel and Ability.IsCastable(travel, mana) and Ability.IsReady(travel) and Meepo.IsSuitableToCastSpell(myNPC) then
        Ability.CastPosition(travel, location)
        return true
    end
    -- check targets for poof
    local spell = NPC.GetAbility(myNPC, "meepo_poof")
    if spell and Ability.IsCastable(spell, mana) and Ability.IsReady(spell) and Meepo.IsSuitableToCastSpell(myNPC) and not Ability.IsInAbilityPhase(spell) then
        for i=1, #indexes_of_npc do
            local npc = Meepo.List[indexes_of_npc[i]][Meepo.NPC] 
            if npc and myNPC ~= npc then
                local target_origin = Entity.GetAbsOrigin(npc)
                local target_to_base = (location - target_origin):Length2D()
                if NPC.HasModifier(npc, "modifier_fountain_aura_buff") then
                    target = npc
                    min_distance = 0
                    break
                elseif min_distance > target_to_base and entity_to_base > target_to_base+350 and not Entity.GetHeroesInRadius(npc, 450, Enum.TeamType.TEAM_ENEMY) then
                    min_distance = target_to_base
                    target = npc
                end
            end
        end
        if target then
            Ability.CastTarget(spell, target)
            if not  NPC.HasModifier(myNPC,"modifier_bloodseeker_rupture") then
       	 		NPC.MoveTo(myNPC, location, true)
       	 	end
            return true
        end
    end
    if Meepo.SleepReady(0.4, entity[Meepo.DELAY_BETWEEN_HEAL]) then 
		if not NPC.HasModifier(myNPC,"modifier_bloodseeker_rupture") then
   	 		NPC.MoveTo(myNPC, location)
   	 	end
		entity[Meepo.DELAY_BETWEEN_HEAL] = current_time()
	end
    return true

end



function Meepo.CountEnabledCamps(only_small)
	local camps = Meepo.CampLocation
    if only_small == 1 then 
       	camps = Meepo.MicroCampLocation
    elseif only_small == 2 then
        camps = Meepo.MiniCampLocation
    end
    local count = 0

    for i, camp in pairs(camps) do
        if camp then
            if Meepo.CampLocation[i][4] then
                count = count+1
            end
        end
    end
    return count
end

function Meepo.CountCleanedCamps(only_small)
	local camps = Meepo.CampLocation
    if only_small == 1 then 
       	camps = Meepo.MicroCampLocation
    elseif only_small == 2 then
        camps = Meepo.MiniCampLocation
    end

    local count = 0
    for name, camp in pairs(camps) do
        if camp and Meepo.CampLocation[name][4] and Meepo.isCampCleaned(name) then
            count = count+1
        end
    end
    return count
end


function Meepo.FastMove(entity, pos)
	local myNPC = entity[Meepo.NPC]
    local origin = Entity.GetAbsOrigin(myNPC)
    local entity_to_pos = (origin - pos):Length2D()
    if entity_to_pos < 1200 then
        return false
    end
    local mana = NPC.GetMana(myNPC)
	if mana * 100 / NPC.GetMaxMana(myNPC) < Menu.GetValue(manaThershold) then return end
    local min_distance = 100000
    local target = nil

    

    local spell = NPC.GetAbility(myNPC, "meepo_poof")
    if spell and Ability.IsCastable(spell, mana) and Ability.IsReady(spell) and Meepo.IsSuitableToCastSpell(myNPC) and Meepo.List then
        for i=1, #indexes_of_npc do
            local npc = Meepo.List[indexes_of_npc[i]][Meepo.NPC] 
            if npc and myNPC ~= npc then
                local target_origin = Entity.GetAbsOrigin(npc)
                local target_to_pos = (pos - target_origin):Length2D()
                local target_poof = NPC.GetAbility(npc, "meepo_poof") 
                if min_distance > target_to_pos and entity_to_pos - 1200 > target_to_pos and not Entity.GetHeroesInRadius(npc, 700, Enum.TeamType.TEAM_ENEMY)
                 and (not target_poof or not Ability.IsInAbilityPhase(target_poof)) then
                    min_distance = target_to_pos
                    target = npc
                end
            end
        end
        if target then
            Ability.CastTarget(spell, target)
            return true
        end
    end

    return false
end


function Meepo.Net(entity, target, spell)
    if not Meepo.SleepReady(0.5, Meepo.lastTick[2]) then return end
    local npc = entity
    if type(entity) == "table" then
        npc = entity[Meepo.NPC]
    end
    if not spell then
    	spell = NPC.GetAbility(npc, "meepo_earthbind")
    end
    if not spell or not Ability.IsCastable(spell, NPC.GetMana(npc)) then return end

    local range = Ability.GetCastRange(spell)
    local radius = 220

    local enemies = Entity.GetUnitsInRadius(npc, range+radius, Enum.TeamType.TEAM_ENEMY)
    if not enemies or #enemies <= 0 then return end

    local vec1 = Entity.GetAbsOrigin(target)
    local vec2 = Meepo.GetPredictedPosition(target, 1.2)
    local mid = (vec1 + vec2):Scaled(0.5)
    
    if NPC.IsPositionInRange(npc, mid, range, 0) then
        Ability.CastPosition(spell, mid)
        Meepo.lastTick[2] = current_time()
        return
    end

end


function Meepo.PoofStrike(entity)
    if Meepo.List then
        for i=1, #indexes_of_npc do
            local npc = Meepo.List[indexes_of_npc[i]][Meepo.NPC]
            if myHero == npc and not Meepo.List[indexes_of_npc[i]][Meepo.THINK] ~= Meepo.THINK_HEAL then
                --
            else
                local health = Entity.GetHealth(npc)
                local mana = NPC.GetMana(npc)
                local spell = NPC.GetAbility(npc, "meepo_poof")
                if health * 100 / Entity.GetMaxHealth(entity[Meepo.NPC]) > Menu.GetValue(afraidHP) and mana > 80 * 2 and Ability.IsCastable(spell, mana) and Ability.IsReady(spell) and Meepo.IsSuitableToCastSpell(npc) then
                    Ability.CastTarget(spell, entity[Meepo.NPC])
                    entity[Meepo.LAST_THINK] = current_time() + 1.5
                        entity[Meepo.THINK] = Meepo.THINK_POOF_STRIKE
                    Meepo.sleep(0.03)
                end
            end
        end
    end
end


function Meepo.GetPredictedPosition(npc, delay)
    local pos = Entity.GetAbsOrigin(npc)
    if not NPC.IsRunning(npc) or not delay then return pos end
    delay = delay + Meepo.TOTAL_LATENCY

    local dir = Entity.GetRotation(npc):GetForward():Normalized()
    local speed = NPC.GetMoveSpeed(npc)

    return pos + dir:Scaled(speed * delay)
end

function Meepo.CanNet(target)
    if NPC.HasState(target,Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then return false end
    if NPC.HasState(target,Enum.ModifierState.MODIFIER_STATE_OUT_OF_GAME) then return false end
	if NPC.HasState(target,Enum.ModifierState.MODIFIER_STATE_ROOTED) then return false end
	if NPC.HasState(target,Enum.ModifierState.MODIFIER_STATE_STUNNED) then return false end
    return true
end

function Meepo.ClosestShrine(entity)
	local shrines = Meepo.ShrineLocation
	if only_small == 2 then
		shrines = Meepo.OnlyBigShrineLocation
	end
	local origin = Entity.GetAbsOrigin(entity[Meepo.NPC])
	local min_distance = 99999
	local location = nil
	for name, shrine in pairs(shrines) do
		if string.match(name, Meepo.TEAM_CONTAIN) then
			local distance = (origin - shrine):Length()
			if distance < min_distance then
	        	min_distance = distance
	            location = {
	                name = name,
	                origin = shrine,
	            }
	        end	
	    end
	end 
	return location
end

function Meepo.ClosestCamp(entity, only_small, closest_only)
    local location = nil
    local origin = Entity.GetAbsOrigin(entity[Meepo.NPC])
    local min_distance = 99999
    local camps = Meepo.CampLocation
    if only_small == 1 then 
       	camps = Meepo.MicroCampLocation
    elseif only_small == 2 then
        camps = Meepo.MiniCampLocation
    end
    if closest_only then
        if closest_only == 0 then -- независимо от кл-ва клонов на кемпе
            for i, camp in pairs(camps) do
                local distance = (origin - camp[1]):Length()
                if Meepo.CampLocation[i][4] then
                    if not Meepo.isCampCleaned(i) then
                        if distance < min_distance or entity[Meepo.CAMP] == i then
                            min_distance = distance
                            location = {
                                name = i,
                                origin = camp[1],
                            }
                            if entity[Meepo.CAMP] == i then break end
                        end
                    end
                end
            end
        elseif closest_only < 0 then -- ближайший к союзнику
            for i = 1, #indexes_of_npc do
                local npc = Meepo.List[indexes_of_npc[i]][Meepo.NPC]
                for i, camp in pairs(camps) do
                	if not Meepo.isCampCleaned(i) then
	                    local distance = (Entity.GetAbsOrigin(npc) - camp[1]):Length()
	                    if Meepo.CampLocation[i][4] then
	                        if Meepo.Execute("camp_count", i) >= Meepo.CampLocation[i][5] or Meepo.IsHeroAroundPos(Meepo.CampLocation[i][1], 350) then
	                            distance = 99999
	                        end
                            if distance < min_distance or entity[Meepo.CAMP] == i then
                                min_distance = distance
                                location = {
                                    name = i,
                                    origin = camp[1],
                                }
                                if entity[Meepo.CAMP] == i then break end
                            end
	                    end
	                end
                end
            end
        else
            for i, camp in pairs(camps) do -- ближайший по ренже из параметра
                if Meepo.CampLocation[i][4] then
                    if (origin - camp[1]):Length() <= closest_only then
                        location = {
                            name = i,
                            origin = camp[1],
                        }
                    end
                end
            end
        end
    else
        for i, camp in pairs(camps) do
            local distance = (origin - camp[1]):Length()
            if Meepo.CampLocation[i][4] then
                if not Meepo.isCampCleaned(i) then
                    if Meepo.Execute("camp_count", i) >= Meepo.CampLocation[i][5] or Meepo.IsHeroAroundPos(Meepo.CampLocation[i][1], 350) then
                        distance = 99999
                    end
                    if distance < min_distance or entity[Meepo.CAMP] == i then
                        min_distance = distance
                        location = {
                            name = i,
                            origin = camp[1],
                        }
                        if entity[Meepo.CAMP] == i then break end
                    end
                end
            end
        end
    end
    return location
end


function Meepo.CampCleaned(location)
    local name = location['name']
    if Meepo.CampsClean[name] ~= nil then return true end
    Meepo.CampsClean[name] = true
    return true
end


function Meepo.isCampCleaned(location)
    if Meepo.CampsClean[location] ~= nil then return true end
    return false
end


function Meepo.FillingCamps(string)
    for i, camp in pairs( Meepo.CampLocation ) do
        if string.match(i, string) then
            camp[4] = true
        else
            camp[4] = false
        end
    end
    
    for name ,camp in pairs(Meepo.BountyLocation) do
        if string.match(name, string) then
            camp[2] = true 
        else
            camp[2] = false
        end
    end
end



Meepo.CampLocation = {
    radiant_ancient_camp_1 = 	{Vector(-2581,-562,384), Vector(-3733, -1719, 384), 54, false, ancientMax}, -- выше мида
    
    radiant_small_camp = 		{Vector(2944,-4531,256), Vector(3451, -5980, 384), 53, false, smallMax},

    radiant_mid_camp_1 = 		{Vector(-227,-3346,384), Vector(-1488, -2525, 256), 56, false, midMax}, -- между т1 и т2 мида
    radiant_mid_camp_2 = 		{Vector(423,-4653,384), Vector(831, -3090, 384), 56, false, midMax}, -- около бот шрайна
    radiant_mid_camp_3 = 		{Vector(-3682,884,384), Vector(-4632, 1292, 384), 55, false, midMax}, -- около топ шрайна 
    radiant_mid_camp_4 = 	    {Vector(99,-1906,256), Vector(831, -3090, 384), 54, false, largeMax}, -- ниже мида

    radiant_large_camp_1 = 		{Vector(-1873,-4250,256), Vector(-1433, -2530, 256), 54, false, largeMax}, -- напротив т2 мида
    radiant_large_camp_2 = 		{Vector(4491,-4417,256), Vector(3248, -3651, 256), 55, false, largeMax}, -- около мелкого спавна
    radiant_large_camp_3 = 		{Vector(-4969,-337,384), Vector(-4720, 814, 279), 55, false, largeMax}, -- около топ шрайна
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
    dire_ancient_camp_1 = 		{Vector(4172,-376,384), Vector(1835, -626, 256), 54, false, ancientMax}, -- ниже мида

    dire_small_camp = 			{Vector(-2523,4808,256), Vector(-3283, 5941, 384), 54, false, smallMax},

    dire_mid_camp_1 = 			{Vector(-1808,4368,384), Vector(-747, 5225, 384), 55, false, midMax}, -- выше топ шрайна
    dire_mid_camp_2 = 			{Vector(-200,3376,384), Vector(330, 4285, 384), 56, false, midMax}, -- ниже топ шрайна 
    dire_mid_camp_3 = 			{Vector(2568,77,384), Vector(3617, 1074, 359), 55, false, midMax}, -- около нижнего шрайна
    dire_mid_camp_4 = 		    {Vector(-849,2305,384), Vector(1322, 2334, 256), 54, false, midMax}, -- выше мида

    dire_large_camp_1 = 		{Vector(-4195,3453,256), Vector(-3371, 5172, 384), 54, false, largeMax}, -- около мелкого спавна
    dire_large_camp_2 = 		{Vector(1284,3327,384), Vector(-197, 4670, 384), 54, false, largeMax}, -- напротив т2 мида
    dire_large_camp_3 = 		{Vector(4398,824,384), Vector(3598, 1816, 256), 55, false, largeMax} -- около нижнего шрайна
}

Meepo.RealCampLocation = {
	radiant_ancient_camp_1 = Vector(-2581,-562,384),
	dire_ancient_camp_1 = Vector(4172,-376,384),
	radiant_small_camp = Vector(2944,-4531,256),
	dire_small_camp = Vector(-2523,4808,256),
	radiant_mid_camp_1 = Vector(-227,-3346,384),
	radiant_mid_camp_2 = Vector(423,-4653,384),
	radiant_mid_camp_3 = Vector(-3682,884,384),
	radiant_mid_camp_4 = Vector(99,-1906,256),
	dire_mid_camp_1 = Vector(-1808,4368,384),
	dire_mid_camp_2 = Vector(-200,3376,384),
    dire_mid_camp_3 = Vector(2568,77,384),
	dire_mid_camp_4 = Vector(-849,2305,384),
	radiant_large_camp_1 = Vector(-1873,-4250,256),
	radiant_large_camp_2 = Vector(4491,-4417,256),
	radiant_large_camp_3 = Vector(-4969,-337,384),
	dire_large_camp_1 = Vector(-4195,3453,256),
	dire_large_camp_2 = Vector(1284,3327,384),
	dire_large_camp_3 = Vector(4398,824,384)
}
--{pos = Vector(-1873,-4250,256)
--{pos = Vector(-227,-3346,384)
--{pos = Vector(423,-4653,384)
--{pos = Vector(2944,-4531,256)
--{pos = Vector(4491,-4417,256)
--{pos = Vector(99,-1906,256)
--{pos = Vector(-4969,-337,384)
--{pos = Vector(-3682,884,384)
--{pos = Vector(-2581,-562,384)
--{pos = Vector(1284,3327,384)
--{pos = Vector(-200,3376,384)
--{pos = Vector(-1808,4368,384)
--{pos = Vector(-2523,4808,256)
--{pos = Vector(-4195,3453,256)
--{pos = Vector(-849,2305,384)
--{pos = Vector(4398,824,384)
--{pos = Vector(2568,77,384)
--{pos = Vector(4172,-376,384)
--{pos = Vector(-2373,1852,159)
Meepo.MiniCampLocation = {
    radiant_small_camp = {Vector(3178.468750, -4653.093750, 256.000000), Vector(3451, -5980, 384), 53},
    dire_small_camp = {Vector(-2826.718750, 4539.031250, 256.000000), Vector(-3283, 5941, 384), 54},
    radiant_mid_camp_1 = {Vector(-382.29974365234, -3310.7253417969, 384.0), Vector(-1488, -2525, 256), 56}, -- между т1 и т2 мида
    radiant_mid_camp_2 = {Vector(574.531250, -4546.812500, 384.000000), Vector(831, -3090, 384), 56}, -- около бот шрайна
    dire_mid_camp_1 = {Vector(-1819.156250, 4200.531250, 256.000000), Vector(-747, 5225, 384), 55 }, -- выше топ шрайна
    dire_mid_camp_2 = {Vector(-263.093750, 3470.968750, 256.000000), Vector(330, 4285, 384), 56}, -- ниже топ шрайна 
}

Meepo.MicroCampLocation = {
   
    radiant_small_camp = 		{Vector(3178.468750, -4653.093750, 256.000000), Vector(3451, -5980, 384), 53},

    radiant_mid_camp_1 = 		{Vector(-382.29974365234, -3310.7253417969, 384.0), Vector(-1488, -2525, 256), 56}, -- между т1 и т2 мида
    radiant_mid_camp_2 = 		{Vector(574.531250, -4546.812500, 384.000000), Vector(831, -3090, 384), 56}, -- около бот шрайна
    radiant_mid_camp_3 = 		{Vector(-3873.437500, 718.031250, 256.000000), Vector(-4632, 1292, 384), 55}, -- около топ шрайна 
    radiant_mid_camp_4 = 	    {Vector(99,-1906,256), Vector(831, -3090, 384), 54}, -- ниже мида

    radiant_large_camp_1 = 		{Vector(-1832.062500, -4138.125000, 256.000000), Vector(-1433, -2530, 256), 54}, -- напротив т2 мида
    radiant_large_camp_2 = 		{Vector(4420.656250, -4267.281250, 256.000000), Vector(3248, -3651, 256), 55}, -- около мелкого спавна
    radiant_large_camp_3 = 		{Vector(-4734.750000, -276.875000, 256.000000), Vector(-4720, 814, 279), 55}, -- около топ шрайна


    dire_small_camp = 			{Vector(-2826.718750, 4539.031250, 256.000000), Vector(-3283, 5941, 384), 54},

    dire_mid_camp_1 = 			{Vector(-1819.156250, 4200.531250, 256.000000), Vector(-747, 5225, 384), 55}, -- выше топ шрайна
    dire_mid_camp_2 = 			{Vector(-263.093750, 3470.968750, 256.000000), Vector(330, 4285, 384), 56}, -- ниже топ шрайна 
    dire_mid_camp_3 = 			{Vector(2754.156250, 136.812485, 384.000000), Vector(3617, 1074, 359), 55}, -- около нижнего шрайна
    dire_mid_camp_4 = 		    {Vector(-849,2305,384), Vector(1322, 2334, 256), 54}, -- выше мида

    dire_large_camp_1 = 		{Vector(-4249.656250, 3658.406250, 256.000000), Vector(-3371, 5172, 384), 54}, -- около мелкого спавна
    dire_large_camp_2 = 		{Vector(1244.250000, 3358.875000, 384.000000), Vector(-197, 4670, 384), 54}, -- напротив т2 мида
    dire_large_camp_3 = 		{Vector(4107.750000, 747.656250, 384.000000), Vector(3598, 1816, 256), 55} -- около нижнего шрайна
}



Meepo.BuildingLocation = {
    radiant_fountain = Vector(-7221.843750, -6887.031250, 512.000000),
    dire_fountain = Vector(7251.312500, 6519.687500, 512.000000)
}

Meepo.ShrineLocation = {
	radiant_top = Vector(-4538.671875, 513.73291015625, 384.0),
	radiant_bot = Vector(1473.562500, -4236.906250, 384.000000),

	dire_top = Vector(-1155.4884033203, 3650.6110839844, 384.0),
	dire_bot = Vector(3530.6909179688, 505.5205078125, 384.0)
}

Meepo.OnlyBigShrineLocation = {
	radiant_bot = Vector(1473.562500, -4236.906250, 384.000000),
	dire_top = Vector(-1155.4884033203, 3650.6110839844, 384.0),
}

Meepo.RealBountyLocation = {
    radiant_bot = Vector(3685.1374511719, -3616.259765625, 256.0),
    radiant_top = Vector(-4328.6640625, 1597.2722167969, 256.00012207031),
    dire_bot = Vector(4140.7705078125, -1756.5439453125, 256.0),
    dire_top = Vector(-3066.9020996094, 3687.6398925781, 128.0)
}

Meepo.BountyLocation = {
    radiant_bot = {Vector(3685.1374511719, -3616.259765625, 256.0)    ,false},
    radiant_top = {Vector(-4328.6640625, 1597.2722167969, 256.00012207031)    ,false},
    dire_bot = {Vector(4140.7705078125, -1756.5439453125, 256.0)    ,false},
    dire_top = {Vector(-3066.9020996094, 3687.6398925781, 128.0)    ,false}
}

function Meepo.IconPos(x,y, index) 
    if x == 1920 and y == 1080 then
        local Y = 80+(index*75)
        return 115, Y, 15
    elseif x == 1600 and y == 900 then
        local Y = 62+(index*64)
        return 97, Y, 12
    elseif (x == 1366 or 1360) and y == 768 then
        local Y  = 52+(index*53)
        if not newFont then
            infoFont =  Renderer.LoadFont("Tahoma", 13, Enum.FontWeight.MEDIUM)
            newFont = true
        end
        return 85, Y, 11
    elseif x == 1280 and y == 720 then
        local Y = 50 + (index*50)
        if not newFont then
            infoFont =  Renderer.LoadFont("Tahoma", 12, Enum.FontWeight.MEDIUM)
            newFont = true
        end
        return 78, y, 11
     elseif x == 1440 and y == 900 then
         local Y  = 62+(index*64)
         return 100, Y, 12
    elseif x == 1680 and y == 1050 then
        local Y = 73+(index*74)
        return 113, Y, 15
    elseif x == 1280 and y == 960 then
        local Y  = 67+(index*68)
        return 105, Y ,11
    elseif x == 1024 and y == 768 then 
        local Y = 52+(index*53)
        if not newFont then
            infoFont =  Renderer.LoadFont("Tahoma", 13, Enum.FontWeight.MEDIUM)
            newFont = true
        end
        return 85, Y, 11
    end
    local Y = 80+(index*75)
    Log.Write("Твоё разрешения не поддерживается. Напиши об этом автору. (".. x.."x"..y..")")
    return 115, Y, 15
end

function Meepo.sleep(n)  -- seconds
    local t0 = current_time()
    while current_time() - t0 <= n do end
end


function Meepo.IsSuitableToCastSpell(npc)
    if NPC.IsSilenced(npc) or NPC.IsStunned(npc) or not Entity.IsAlive(npc) then return false end
    if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then return false end
    if NPC.HasModifier(npc, "modifier_teleporting") then return false end
    if NPC.IsChannellingAbility(npc) then return false end
    return true
end

function Meepo.IsHeroAroundPos(pos, range)
	local heroes = 0
	if Menu.IsEnabled(FarmWithAllies) then
		heroes = Heroes.InRadius(pos, range, Meepo.TEAM, Enum.TeamType.TEAM_ENEMY)
	else
		heroes = Heroes.InRadius(pos, range, Meepo.TEAM, Enum.TeamType.TEAM_BOTH)
	end
	if heroes and #heroes > 0 then
		if Menu.IsEnabled(FarmWithAllies) then
			for i=1, #heroes do
				if NPC.GetUnitName(heroes[i]) ~= "npc_dota_hero_meepo" then
					return true
				end 
			end
		else
			return true
		end
	end
	return false
end

function Meepo.SleepReady(sleep, lastTick)
    if (current_time() - lastTick) >= sleep then
        return true
    end
    return false
end


function Meepo.CheckProtection(enemy_local)
    if NPC.IsLinkensProtected(enemy_local) then return "LINKEN" end
    local spell_shield = NPC.GetAbility(enemy_local, "antimage_spell_shield")
    if spell_shield and Ability.IsReady(spell_shield) and (NPC.HasModifier(enemy_local, "modifier_item_ultimate_scepter") or NPC.HasModifier(enemy_local, "modifier_item_ultimate_scepter_consumed")) then
        return "LINKEN"
    end
    if NPC.HasModifier(enemy_local,"modifier_dark_willow_shadow_realm_buff") then return true end
    if NPC.HasModifier(enemy_local,"modifier_skeleton_king_reincarnation_scepter_active") then return true end
    if NPC.HasModifier(enemy_local, "modifier_item_lotus_orb_active") and not Menu.IsEnabled(comboInLotus) then return true end
    if NPC.HasState(enemy_local,Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then return true end
    if NPC.HasState(enemy_local,Enum.ModifierState.MODIFIER_STATE_OUT_OF_GAME) then return true end
    return false
end

function Meepo.GetTotalDmg(target,dmg, myHero)
    if not target or not myHero then return end
    local totalDmg = (dmg * NPC.GetMagicalArmorDamageMultiplier(target))
    local rainDrop = NPC.GetItem(target, "item_infused_raindrop", true)
    if rainDrop and Ability.IsReady(rainDrop) then
        totalDmg = totalDmg - 120
    end
    local kaya = NPC.GetItem(myHero, "item_kaya", true)
    if kaya then 
        totalDmg = totalDmg * 1.1 
    end

    if NPC.HasModifier(target, "modifier_ember_spirit_flame_guard") then 
        local guard = NPC.GetAbility(target, "ember_spirit_flame_guard")
        if guard and guard~=0 then
            totalDmg = totalDmg - Ability.GetLevelSpecialValueFor(guard, "absorb_amount")
            local talant = NPC.GetAbility(target, "special_bonus_unique_ember_spirit_1")
            if talant and talant~=0 and Ability.GetLevel(talant) ~= 0 then
                totalDmg = totalDmg - Ability.GetLevelSpecialValueFor(talant, "value")
            end
        end
    end

    if NPC.HasModifier(target,"modifier_abaddon_aphotic_shield") then 
        local shield = Modifier.GetAbility(NPC.GetModifier(target, "modifier_abaddon_aphotic_shield"))
        if shield and shield ~= 0 then
            totalDmg = totalDmg - Ability.GetLevelSpecialValueForFloat(shield, "damage_absorb")
            local talant = NPC.GetAbility(Ability.GetOwner(shield), "special_bonus_unique_abaddon")
            if talant and talant~=0 and Ability.GetLevel(talant) ~= 0 then
                totalDmg = totalDmg - Ability.GetLevelSpecialValueFor(talant, "value")
            end
        end
    end

    if NPC.HasModifier(target,"modifier_item_hood_of_defiance_barrier") then 
        totalDmg = totalDmg - 325
    end

    if NPC.HasModifier(target,"modifier_item_pipe_barrier") then 
        totalDmg = totalDmg - 400
    end
    if NPC.HasModifier(target,"modifier_item_ethereal_blade_ethereal") then 
        totalDmg = totalDmg * 0.714285714
    end

    local mana_shield = NPC.GetAbility(target, "medusa_mana_shield") 
    if mana_shield and Ability.GetToggleState(mana_shield) then
        totalDmg = totalDmg * 0.4
    end

    if NPC.HasModifier(target,"modifier_nyx_assassin_burrow") then
        totalDmg = totalDmg * 0.6
    end

    if NPC.HasModifier(target,"modifier_ursa_enrage") then
        totalDmg = totalDmg * 0.2
    end

    local dispersion = NPC.GetAbility(target, "spectre_dispersion")
    if dispersion and dispersion ~= 0 and Ability.GetLevel(dispersion) > 0 then
        totalDmg = totalDmg * ((100 - Ability.GetLevelSpecialValueFor(dispersion, "damage_reflection_pct"))/100)
        local talant = NPC.GetAbility(target, "special_bonus_unique_spectre_5")
        if talant and talant~=0 and Ability.GetLevel(talant) ~= 0 then
            totalDmg = totalDmg * ((100 - Ability.GetLevelSpecialValueFor(talant, "value"))/100)
        end
    end

    if NPC.HasModifier(target, "modifier_wisp_overcharge") then 
        local overcharge = Modifier.GetAbility(NPC.GetModifier(target, "modifier_wisp_overcharge")) 
        if overcharge and overcharge ~= 0 then
            totalDmg = totalDmg * ((100 + Ability.GetLevelSpecialValueForFloat(overcharge, "bonus_damage_pct"))/100)
        end
    end

    local bristleback = NPC.GetAbility(target, "bristleback_bristleback")
    if bristleback and bristleback ~= 0 and Ability.GetLevel(bristleback) > 0 then
        totalDmg = totalDmg * ((100 - Ability.GetLevelSpecialValueFor(bristleback, "back_damage_reduction"))/100)
    end

    if NPC.HasModifier(target,"modifier_bloodseeker_bloodrage") then
        local bloodrage = Modifier.GetAbility(NPC.GetModifier(target, "modifier_bloodseeker_bloodrage")) 
        if bloodrage and bloodrage ~= 0 then
            totalDmg = totalDmg * ((100 + Ability.GetLevelSpecialValueForFloat(bloodrage, "damage_increase_pct"))/100)
        end
    end

    if NPC.HasModifier(target,"modifier_chen_penitence") then
        local penis = Modifier.GetAbility(NPC.GetModifier(target, "modifier_chen_penitence")) 
        if penis and penis ~= 0 then
            totalDmg = totalDmg * ((100 + Ability.GetLevelSpecialValueForFloat(penis, "bonus_damage_taken"))/100)
        end
    end

    if NPC.HasModifier(myHero, "modifier_bloodseeker_bloodrage") then
        local bloodrage = Modifier.GetAbility(NPC.GetModifier(myHero, "modifier_bloodseeker_bloodrage")) 
        if bloodrage and bloodrage ~= 0 then
            totalDmg = totalDmg * ((100 + Ability.GetLevelSpecialValueForFloat(bloodrage, "damage_increase_pct"))/100)
        end
    end

    local pangoCrash = NPC.GetModifier(target, "modifier_pangolier_shield_crash_buff")
    if pangoCrash and pangoCrash ~= 0 then
        local pangoStack = Modifier.GetStackCount(pangoCrash)
        totalDmg = totalDmg*((100 - pangoStack)/100)
    end

    local visageCloak = NPC.GetModifier(target, "modifier_visage_gravekeepers_cloak")
    if visageCloak and visageCloak ~= 0 then
        local visageStack = Modifier.GetStackCount(visageCloak)
        totalDmg = totalDmg * (1 - (0.2*visageStack))
    end

    if NPC.HasModifier(target, "modifier_kunkka_ghost_ship_damage_absorb") then
        local ghostShip = Modifier.GetAbility(NPC.GetModifier(target, "modifier_kunkka_ghost_ship_damage_absorb")) 
        if ghostShip and ghostShip ~= 0 then
            totalDmg = totalDmg * ((100 - Ability.GetLevelSpecialValueForFloat(ghostShip, "ghostship_absorb"))/100)
        end
    end

    if NPC.HasModifier(target, "modifier_shadow_demon_soul_catcher") then
        local soulCatcherLvl = Ability.GetLevel(Modifier.GetAbility(NPC.GetModifier(target, "modifier_shadow_demon_soul_catcher")))
        totalDmg = totalDmg * (1.1 + (0.1 * soulCatcherLvl))
    end
    return totalDmg
end

function Meepo.InNeutralCamp(pos)
    local range = 600
    for name, i in pairs(Meepo.CampLocation) do
        local dis = (i[1] - pos):Length()
        if dis <= range and not Meepo.isCampCleaned(name) then return i, name end
    end
    return nil
end

function Meepo.Init()
	if Engine.IsInGame() then
		myHero = Heroes.GetLocal()
		myPlayer = Players.GetLocal()
		heroName = NPC.GetUnitName(myHero)
	else 
		Meepo.Zeroing()
	end
end


return Meepo