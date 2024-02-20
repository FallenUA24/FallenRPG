if GameMode == nil then
    GameMode = class({})
end

function GameMode:InitGameMode()
    print("vse ok - ?")
    ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(self, 'OnGameRulesStateChange'), self)
    ListenToGameEvent('entity_killed', Dynamic_Wrap(self, 'OnEntityKilled'), self)
end

function GameMode:OnGameRulesStateChange()
    local newState = GameRules:State_Get()

    if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        GameMode:EntityKilled()
    end
end

function GameMode:OnEntityKilled(keys)

    local unit = EntIndexToHScript(keys.entindex_killed)
    local unit_name = unit:GetUnitName()
    
    if unit_name == "npc_final_boss" then
        GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)      
    end
end

GameMode:InitGameMode()