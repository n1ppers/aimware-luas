local MSC_PART_REF = gui.Reference( "MISC", "ENHANCEMENT", "Hitmarkers" );

local AWMetallicHitsound = gui.Checkbox( MSC_PART_REF, "lua_arenahitsound", "ArenaSwitch Hitsound", 0 );
local pHitmarker = gui.Checkbox( MSC_PART_REF, "lua_hitmarker", "Alternative Hitmarker", 0 );

local hurt_time = 0;
local alpha = 0;

function MetallicHitsound( Event )
	if gui.GetValue( "msc_hitmarker_enable" ) then
		gui.SetValue( "msc_hitmarker_volume", 0 );
	end
	if ( Event:GetName() == "player_hurt" ) then
		local ME = client.GetLocalPlayerIndex();

		local INT_UID = Event:GetInt( "userid" );
		local INT_ATTACKER = Event:GetInt( "attacker" );

		local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
		local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
			
		local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
		local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );

		if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
			hurt_time = globals.RealTime();
			if AWMetallicHitsound:GetValue() then
				client.Command( "play buttons\\arena_switch_press_02.wav", true );
			end
		end
	end
end

function DrawHitmarker( Event )
	local w, h = draw.GetScreenSize();
	local centerX = w / 2;
	local centerY = h / 2;
	
	local lineSize = 12;
	
	local step = 255 / 0.15 * globals.FrameTime()

	if hurt_time + 0.35 > globals.RealTime() then
		alpha = 255
	else
		alpha = alpha - step
	end
		
	draw.Color( 255, 255, 255, alpha)
	if (alpha > 0 ) then
		if pHitmarker:GetValue() then
			draw.Line(centerX - lineSize, centerY - lineSize, centerX - (lineSize / 2), centerY - (lineSize / 2));
			draw.Line(centerX - lineSize, centerY + lineSize, centerX - (lineSize / 2), centerY + (lineSize / 2));
			draw.Line(centerX + lineSize, centerY + lineSize, centerX + (lineSize / 2), centerY + (lineSize / 2));
			draw.Line(centerX + lineSize, centerY - lineSize, centerX + (lineSize / 2), centerY - (lineSize / 2));
		end
	end
end

client.AllowListener( "player_hurt" );
callbacks.Register( "FireGameEvent", "Metallic Hitsound", MetallicHitsound );
callbacks.Register( 'Draw', 'DrawHitmarker', DrawHitmarker );