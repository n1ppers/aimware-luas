local pCheckbox = gui.Checkbox(gui.Reference("MISC", "General", "Log Events"), "lua_eventlogs", "Alternative Event Logs", 0);

hitPlayerName = "";
hitDmg = "";
hitSpot = "";
hitHealthRemaining = "";
hitAttackerName = "";

buyPlayerName = "";
buyItemName = "";

bombPlayerName = "";
bombSite = "";

hostagePlayerName = "";

local hurt_time = 0;
local alpha = 0;

local eventArray = {};
eventMsg = "";

function HitGroup( INT_HITGROUP )
    if INT_HITGROUP == 0 then
        return "body";
    elseif INT_HITGROUP == 1 then
        return "head";
    elseif INT_HITGROUP == 2 then
        return "chest";
    elseif INT_HITGROUP == 3 then
        return "stomach";
    elseif INT_HITGROUP == 4 then 
        return "left arm";
    elseif INT_HITGROUP == 5 then 
        return "right arm";
    elseif INT_HITGROUP == 6 then 
        return "left leg";
    elseif INT_HITGROUP == 7 then 
        return "right leg";
    elseif INT_HITGROUP == 10 then 
        return "body";
    end
end

function EventLogger( Event, Entity )
    if not pCheckbox:GetValue() then
		return;
	end
	
	if ( Event:GetName() == 'player_hurt' ) then
        local ME = client.GetLocalPlayerIndex();

        local INT_UID = Event:GetInt( 'userid' );
        local INT_ATTACKER = Event:GetInt( 'attacker' );
        local INT_DMG = Event:GetString( 'dmg_health' );
        local INT_HEALTH = Event:GetString( 'health' );
        local INT_HITGROUP = Event:GetInt( 'hitgroup' );

        local INDEX_ATTACKER = client.GetPlayerIndexByUserID( INT_ATTACKER );
        local INDEX_VICTIM = client.GetPlayerIndexByUserID( INT_UID );
        local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
		local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );

        hitPlayerName = NAME_Victim;
        hitDmg = INT_DMG;
        hitSpot = INT_HITGROUP;
        hitHealthRemaining = INT_HEALTH;
		hitAttackerName = NAME_Attacker;
		
	    hurt_time = globals.RealTime();
		
		if ( INDEX_ATTACKER == ME and INDEX_Victim ~= ME ) then           
			eventMsg = string.format( "Hit %s in the %s for %s damage (%s health remaining) \n", hitPlayerName, HitGroup(hitSpot), hitDmg, hitHealthRemaining);
            client.Command("echo [AIMWARE.net]" .. eventMsg, true)
			table.insert(eventArray, eventMsg);
        else
            eventMsg = string.format( "%s given %s damage for %s in the %s (%s health remaining) \n", hitAttackerName, hitDmg, hitPlayerName, HitGroup(hitSpot), hitHealthRemaining);
			client.Command("echo [AIMWARE.net]" .. eventMsg, true)
			table.insert(eventArray, eventMsg);
		end
    end
	if ( Event:GetName() == 'item_purchase' ) then
        local INT_UID = Event:GetInt('userid');
        local STR_ITEMNAME = Event:GetString('weapon');
		local NAME_Victim = client.GetPlayerNameByUserID(INT_UID);
		
		buyPlayerName = NAME_Victim;
        buyItemName = STR_ITEMNAME;
		hurt_time = globals.RealTime();
		eventMsg = string.format("%s bought %s \n", buyPlayerName, buyItemName);
		client.Command("echo [AIMWARE.net]" .. eventMsg, true)
		table.insert(eventArray, eventMsg);
    end
	if ( Event:GetName() == 'bomb_planted' ) then
        local INT_UID = Event:GetInt('userid');
        local INT_SITE = Event:GetInt('site');
		local NAME_Victim = client.GetPlayerNameByUserID(INT_UID);
		
		bombPlayerName = NAME_Victim;
        if INT_SITE == 425 or INT_SITE == 317 or INT_SITE == 334 or INT_SITE == 506 or INT_SITE == 93 or INT_SITE == 152 or INT_SITE == 278 or INT_SITE == 260 or INT_SITE == 210 then
			bombSite = "A";
		elseif INT_SITE == 426 or INT_SITE == 318 or INT_SITE == 335 or INT_SITE == 507 or INT_SITE == 94 or INT_SITE == 153 or INT_SITE == 279 or INT_SITE == 261 or INT_SITE == 211 then
			bombSite = "B";
		else 
			bombSite = "unknown";
		end
		
		hurt_time = globals.RealTime();
		
		eventMsg = string.format("%s has planted bomb at %s site \n", bombPlayerName, bombSite);
        client.Command("echo [AIMWARE.net]" .. eventMsg, true)
		table.insert(eventArray, eventMsg);
    end
	if ( Event:GetName() == 'hostage_follows' ) then
        local INT_UID = Event:GetInt('userid');
		local NAME_Victim = client.GetPlayerNameByUserID(INT_UID);
		
		hostagePlayerName = NAME_Victim;
		
		hurt_time = globals.RealTime();
		
		eventMsg = string.format("Hostage begin following %s \n", hostagePlayerName);
        client.Command("echo [AIMWARE.net]" .. eventMsg, true)
		table.insert(eventArray, eventMsg);
    end
end

function DrawLogs()
	local font = draw.CreateFont("Consolas", 12, 1500);
	
	local screenCenterX, screenCenterY = draw.GetScreenSize();
    
    local step = 255 / 1.3 * globals.FrameTime()

    if hurt_time + 2.5 > globals.RealTime() then
        alpha = 255
    else
        alpha = alpha - step
    end
	
    local b1gcounter = 0;
	for i,y in ipairs(eventArray) do
        if y ~= nil then
            draw.SetFont(font);
			draw.Color( 255, 255, 255, alpha)
            if (alpha > 0 ) then
                if pCheckbox:GetValue() then
					draw.Text( 5, 5 + b1gcounter * 10, y );
                end
				b1gcounter = b1gcounter + 1;
            end
		end
	end
   
	if ( alpha < 0 ) then
		table.remove( eventArray, i );
	end
end

function GuiStuff()
	if pCheckbox:GetValue() then
		gui.SetValue("msc_logevents", 0);
		gui.SetValue("msc_logevents_console", 0);
		gui.SetValue("msc_logevents_damage", 0);
		gui.SetValue("msc_logevents_purchases", 0);
	end
end

client.AllowListener( 'player_hurt' );
client.AllowListener( 'item_purchase' );
client.AllowListener( 'bomb_planted' );
client.AllowListener( 'hostage_follows' );
callbacks.Register( 'Draw', 'GuiStuff', GuiStuff );
callbacks.Register( 'Draw', 'DrawLogs', DrawLogs );
callbacks.Register( 'FireGameEvent', 'EventsLogger', EventLogger );