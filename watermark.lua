local WatermarkCheckbox = gui.Checkbox(gui.Reference("VISUALS", "Shared"), "lua_watermark", "Watermark", 1);
local abs_frame_time = globals.AbsoluteFrameTime;
local frame_rate = 0.0;
local ping = 0.0;

local function get_abs_fps()
    frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * abs_frame_time();
    return math.floor((1.0 / frame_rate) + 0.5);
end

function Watermark()
	if WatermarkCheckbox:GetValue() then
		local font = draw.CreateFont("Arial", 17, 450);
		local w, h = draw.GetScreenSize();
		
		if entities.GetLocalPlayer() ~= nil then
			ping = entities.GetPlayerResources():GetPropInt("m_iPing", client.GetLocalPlayerIndex());
		else
			ping = 0;
		end
		
		draw.Color(180, 45, 170, 255);
		draw.RoundedRectFill(w - 9, 28, 1583, 14);
		
		draw.SetFont(font);
		draw.Color(225, 225, 225, 255);
		draw.Text(w - 330, 12, "AIMWARE.net | " .. os.date("%X") .. " | " .. "FPS: ");
		draw.Text(w - 117, 12, get_abs_fps());
		draw.Text(w - 91, 12, " | Ping: " .. ping);
	end
end

callbacks.Register("Draw", "Watermarkk", Watermark);