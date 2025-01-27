-----------------------------------
-- Area: Southern San d'Oria
-- NPC : Amaura
-- Involved in Quest: The Medicine Woman, To Cure a Cough
-- !pos -85 -6 89 230
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:hasKeyItem(xi.ki.AMAURAS_FORMULA) == true then
        if trade:hasItemQty(920, 1) == true and trade:hasItemQty(642, 1) == true and trade:hasItemQty(846, 1) == true and trade:getItemCount() == 3 then
            player:startEvent(637)
        end
    end
end

entity.onTrigger = function(player, npc)
    local medicineWoman = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_MEDICINE_WOMAN)
    local toCureaCough = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TO_CURE_A_COUGH)

    if medicineWoman == QUEST_ACCEPTED then
        local amaurasFormulaKI = player:hasKeyItem(xi.ki.AMAURAS_FORMULA)
        local coldMedicine = player:hasKeyItem(xi.ki.COLD_MEDICINE)

        if amaurasFormulaKI == false and coldMedicine == false then
            player:startEvent(636)
        elseif amaurasFormulaKI == true then
           player:showText(npc, ID.text.AMAURA_DIALOG_COMEBACK)
        elseif coldMedicine == true then
           player:showText(npc, ID.text.AMAURA_DIALOG_DELIVER)
        else
            player:startEvent(642)
        end
    elseif player:getCharVar("DiaryPage") == 3 or toCureaCough == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.THYME_MOSS) == false and player:hasKeyItem(xi.ki.COUGH_MEDICINE) == false then
            player:startEvent(645) -- need thyme moss for cough med
        elseif player:hasKeyItem(xi.ki.THYME_MOSS) == true then
            player:startEvent(646) -- receive cough med for Nenne
        end
    else
        player:startEvent(642)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 636 and option == 0 then
        player:addKeyItem(xi.ki.AMAURAS_FORMULA)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.AMAURAS_FORMULA)
    elseif csid == 637 then
        player:tradeComplete()
        player:delKeyItem(xi.ki.AMAURAS_FORMULA)
        player:addKeyItem(xi.ki.COLD_MEDICINE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.COLD_MEDICINE)
    elseif csid == 645 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TO_CURE_A_COUGH)
    elseif csid == 646 then
        player:delKeyItem(xi.ki.THYME_MOSS)
        player:addKeyItem(xi.ki.COUGH_MEDICINE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.COUGH_MEDICINE)
    end
end

return entity
