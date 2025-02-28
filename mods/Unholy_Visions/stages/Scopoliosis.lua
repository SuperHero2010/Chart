function onCreate()
addChromaticAbberationEffect('camhud', 0.001)
addChromaticAbberationEffect('camother', 0.001)	

    setObjectOrder('boyfriendGroup', 3)
    setObjectOrder('dadGroup', 2)
    setObjectOrder('gfGroup', 1)

    makeLuaSprite('ScopolioBG', 'ScopolioBG', -12000, -6500)
    addGlitchEffect('ScopolioBG', 5, 50, 0.1)
    scaleObject('ScopolioBG', 3.5, 3.5)
    setScrollFactor('ScopolioBG', 0.1, 0.1);
setObjectOrder('ScopolioBG', 0)
	
    addLuaSprite('ScopolioBG', false)
    setScrollFactor('ScopolioBG', 0.1, 0.1);

end