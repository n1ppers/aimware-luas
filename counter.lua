local shots = 0;
local hits = 0;
local misses = 0;

function Events( Event, Entity )
	local weapon = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon");
	local name = weapon:GetName();
	
	if (name ~= "knife" and name ~= "knife t" and name ~= "bayonet" and name ~= "knife flip"
		and name ~= "knife gut" and name ~= "knife karambit" and name ~= "knife m9 bayonet"
		and name ~= "knife tactical" and name ~= "knife falchion" and name ~= "knife survival bowie"
		and name ~= "knife butterfly" and name ~= "knife push" and name ~= "knife ursus"
		and name ~= "knife gypsy jackknife" and name ~= "knife stiletto" and name ~= "knife widowmaker") then
		if ( Event:GetName() == 'player_hurt' ) then
			local ME = client.GetLocalPlayerIndex();

			local INT_UID = Event:GetInt( 'userid' );
			local INT_ATTACKER = Event:GetInt( 'attacker' );

			local INDEX_ATTACKER = client.GetPlayerIndexByUserID( INT_ATTACKER );
			local INDEX_VICTIM = client.GetPlayerIndexByUserID( INT_UID );
			
			if ( INDEX_ATTACKER == ME and INDEX_Victim ~= ME) then           
				hits = hits + 1;
			end
		end
		if ( Event:GetName() == 'weapon_fire' ) then
			local ME = client.GetLocalPlayerIndex();
			
			local INT_UID = Event:GetInt('userid');

			local INDEX_VICTIM = client.GetPlayerIndexByUserID( INT_UID );
			
			if ( INDEX_VICTIM == ME ) then           
				shots = shots + 1;
			end
		end
	end
	if ( Event:GetName() == 'round_start' ) then
		shots = 0;
		hits = 0;
		missed = 0;
    end
end

function DrawMissedShots()
	local font = draw.CreateFont("Consolas", 12, 765);
	
	local w, h = draw.GetScreenSize();
    	
	if entities.GetLocalPlayer() ~= nil then
		if shots == 36 or hits == 21 or misses == 21 then
			shots = 0;
			hits = 0;
			missed = 0;
		end
		
		local weapon = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon");
		local name = weapon:GetName();
		
		if (name ~= "knife" and name ~= "knife t" and name ~= "bayonet" and name ~= "knife flip"
			and name ~= "knife gut" and name ~= "knife karambit" and name ~= "knife m9 bayonet"
			and name ~= "knife tactical" and name ~= "knife falchion" and name ~= "knife survival bowie"
			and name ~= "knife butterfly" and name ~= "knife push" and name ~= "knife ursus"
			and name ~= "knife gypsy jackknife" and name ~= "knife stiletto" and name ~= "knife widowmaker") then
			misses = shots - hits;
		else
			misses = misses;
		end
		
		draw.SetFont(font);
		draw.Color( 255, 255, 255, 255)
		draw.Text((w / 2) + 15, h / 2, "fired=" .. shots);
		draw.Text((w / 2) + 15, (h / 2) + 16, "hits=" .. hits);
		draw.Text((w / 2) + 15, (h / 2) + 32, "missed=" .. misses);
		draw.Text((w / 2) + 15, (h / 2) + 48, name);
	end
end

client.AllowListener( 'player_hurt' );
client.AllowListener( 'weapon_fire' );
client.AllowListener( 'round_start' );
callbacks.Register( 'Draw', 'DrawMissedShots', DrawMissedShots );
callbacks.Register( 'FireGameEvent', 'Events', Events );