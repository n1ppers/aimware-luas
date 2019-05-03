local msc_ref = gui.Reference( "VISUALS", "MISC", "World" );
local lua_combobox = gui.Combobox( msc_ref, "lua_skyboxppicker", "Custom SkyBox",
                        "Default", "sky125", "clear_night_sky", "clearsky", "sky_descent",
						"sky_sunrise_01", "sky108", "sky110", "sky111", "sky112", "sky113",
						"sky114", "sky115", "sky116" );

function SkyBox()
    draw.SetFont( debugFont );
    local skybox_old = client.GetConVar("sv_skyname");    
    local skybox_new = (lua_combobox:GetValue());
    
        if ( skybox_new == 0 and gui.GetValue("msc_restrict") ~= 1) then
            client.SetConVar("sv_skyname" , skybox_old)
            
        elseif (skybox_new == 1 and gui.GetValue("msc_restrict") ~= 1) then
            client.SetConVar("sv_skyname" , "sky125")   
            
        elseif (skybox_new == 2 and gui.GetValue("msc_restrict") ~= 1) then
            client.SetConVar("sv_skyname" , "clear_night_sky")  

        elseif (skybox_new == 3 and gui.GetValue("msc_restrict") ~= 1) then
            client.SetConVar("sv_skyname" , "clearsky")  			
                    
		elseif (skybox_new == 4 and gui.GetValue("msc_restrict") ~= 1) then
            client.SetConVar("sv_skyname" , "sky_descent")  	
			
		elseif (skybox_new == 5 and gui.GetValue("msc_restrict") ~= 1) then
            client.SetConVar("sv_skyname" , "sky_sunrise_01")   
            
        elseif (skybox_new == 6 and gui.GetValue("msc_restrict") ~= 1) then
            client.SetConVar("sv_skyname" , "sky108")  

        elseif (skybox_new == 7 and gui.GetValue("msc_restrict") ~= 1) then
            client.SetConVar("sv_skyname" , "sky110")  			
                    
		elseif (skybox_new == 8 and gui.GetValue("msc_restrict") ~= 1) then
            client.SetConVar("sv_skyname" , "sky111")  	
			
		elseif (skybox_new == 9 and gui.GetValue("msc_restrict") ~= 1) then
            client.SetConVar("sv_skyname" , "sky112")  

        elseif (skybox_new == 10 and gui.GetValue("msc_restrict") ~= 1) then
            client.SetConVar("sv_skyname" , "sky113")  			
                    
		elseif (skybox_new == 11 and gui.GetValue("msc_restrict") ~= 1) then
            client.SetConVar("sv_skyname" , "sky114")  	
			
		elseif (skybox_new == 12 and gui.GetValue("msc_restrict") ~= 1) then
            client.SetConVar("sv_skyname" , "sky115")  			
                    
		elseif (skybox_new == 13 and gui.GetValue("msc_restrict") ~= 1) then
            client.SetConVar("sv_skyname" , "sky116")  
        
	    end

end

callbacks.Register("Draw", "SkyBox", SkyBox)