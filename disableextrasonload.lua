local var1 = gui.GetValue("esp_radar");
local var2 = gui.GetValue("msc_showspec");
local var3 = gui.GetValue("msc_playerlist");
local var4 = gui.GetValue("msc_skinchanger");

function Main()
	gui.SetValue("esp_radar", 0);
	gui.SetValue("msc_showspec", 0);
	gui.SetValue("msc_playerlist", 0);
	gui.SetValue("msc_skinchanger", 0);
	callbacks.Unregister("Draw", "Disable Extra");
end

callbacks.Register("Draw", "Disable Extra", Main);