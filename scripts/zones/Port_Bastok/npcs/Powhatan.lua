-----------------------------------
-- Area: Port Bastok
--  NPC: Powhatan
-- Starts & Ends Quest: Welcome to Bastok, Guest of Hauteur
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
require("scripts/globals/quests")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local WelcometoBastok = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.WELCOME_TO_BASTOK)
    local GuestofHauteur = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.GUEST_OF_HAUTEUR)

    if (WelcometoBastok ~= QUEST_COMPLETED) then
        local wtbStatus = player:getCharVar("WelcometoBastok_Event")

        if (WelcometoBastok == QUEST_AVAILABLE) then
            player:startEvent(50)
        else
            if (wtbStatus == 0) then
                player:startEvent(51)
            elseif (wtbStatus == 1) then
                player:startEvent(53)
            end
        end
    elseif (GuestofHauteur ~= QUEST_COMPLETED and WelcometoBastok == QUEST_COMPLETED and player:getFameLevel(BASTOK) >= 3 and player:getMainLvl() >= 31) then
        local gohStatus = player:getCharVar("GuestofHauteur_Event")

        if (GuestofHauteur == QUEST_AVAILABLE) then
            player:startEvent(55)
        else
            if (gohStatus == 0) then
                player:startEvent(56)
            elseif (gohStatus == 1) then
                player:startEvent(58)
            end
        end
    else
        player:messageSpecial(ID.text.POWHATAN_DIALOG_1)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 50 and option == 0) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.WELCOME_TO_BASTOK)
    elseif (csid == 53) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16565)
        else
            player:addTitle(xi.title.BASTOK_WELCOMING_COMMITTEE)
            player:addItem(16565)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16565) -- Spatha
            player:setCharVar("WelcomeToBastok_Event", 0)
            player:addFame(BASTOK, 80)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.WELCOME_TO_BASTOK)
        end
    elseif (csid == 55 and option == 0) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.GUEST_OF_HAUTEUR)
    elseif (csid == 58) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12300)
        else
            player:addTitle(xi.title.BASTOK_WELCOMING_COMMITTEE)
            player:addItem(12300)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12300) -- Targe
            player:delKeyItem(xi.ki.LETTERS_FROM_DOMIEN)
            player:setCharVar("GuestofHauteur_Event", 0)
            player:addFame(BASTOK, 80)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.GUEST_OF_HAUTEUR)
        end
    end

end

return entity
