function onCreate()
addChromaticAbberationEffect('camhud', 0.002)
addChromaticAbberationEffect('camother', 0.002)	

    setObjectOrder('boyfriendGroup', 3)
    setObjectOrder('dadGroup', 2)
    setObjectOrder('gfGroup', 1)

    makeLuaSprite('BangerBG', 'BangerBG', -12000, -6500)
    addGlitchEffect('BangerBG', 3, 30, 0.1)
    scaleObject('BangerBG', 3.5, 3.5)
    setScrollFactor('BangerBG', 0.1, 0.1);
setObjectOrder('BangerBG', 0)
	
    addLuaSprite('BangerBG', false)
    setScrollFactor('BangerBG', 0.1, 0.1);

end