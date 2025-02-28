function onCreate()
addChromaticAbberationEffect('camhud', 0.002)
addChromaticAbberationEffect('camother', 0.002)	
addChromaticAbberationEffect('camgame', 0.001)	

    addVCREffect('camgame')

    setObjectOrder('boyfriendGroup', 3)
    setObjectOrder('dadGroup', 2)
    setObjectOrder('gfGroup', 1)

    makeLuaSprite('ScopoBG', 'ScopoBG', -12000, -6500)
    addGlitchEffect('ScopoBG', 1, 3, 0.1)
    scaleObject('ScopoBG', 3.5, 3.5)
    setScrollFactor('ScopoBG', 0.1, 0.1);
setObjectOrder('ScopoBG', 0)
	
    addLuaSprite('ScopoBG', false)
    setScrollFactor('ScopoBG', 0.1, 0.1);

end