local addon, ns = ...
local LegendaryRoulette = {}
local frame = CreateFrame("frame");
local lootchat = ChatTypeInfo["LOOT"];

function LegendaryRoulette:Update(state)
	
	while true do
		-- save old values
		local classID, specID = C_LootJournal.GetClassAndSpecFilters();
		
		-- get all legendaries for current class
		-- C_LootJournal.SetClassAndSpecFilters(select(3,UnitClass('player')), GetSpecializationInfo(GetSpecialization()))
		C_LootJournal.SetClassAndSpecFilters(select(3,UnitClass('player')), 0)
		local legendaries = C_LootJournal.GetFilteredLegendaries();
		
		-- reset to old values
		C_LootJournal.SetClassAndSpecFilters(classID, specID)
		
		local legendary = legendaries[math.random(1, #legendaries)]
		local itemInfo = GetItemInfo(legendary.itemID)
		
		if itemInfo ~= nil then
			LegendaryItemAlertSystem:AddAlert(legendary.link)
						
			DEFAULT_CHAT_FRAME:AddMessage(format(LOOT_ITEM_PUSHED_SELF, legendary.link), lootchat.r, lootchat.g, lootchat.b)
			break;
		end
	end

end

SLASH_LEGENDARYROULETTE1 = '/leg';
function SlashCmdList.LEGENDARYROULETTE(msg, editbox)
	LegendaryRoulette:Update(msg)
end


frame:SetScript("OnEvent", frame.OnEvent);

frame:RegisterEvent("ADDON_LOADED");