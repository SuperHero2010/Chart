function onCreate()
	-- background shit
	makeLuaSprite('scope', 'scope', -3600, -2400);
	setScrollFactor('scope', 0.9, 0.9);
        scaleObject('scope', 2, 2)
	

	addLuaSprite('scope', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end