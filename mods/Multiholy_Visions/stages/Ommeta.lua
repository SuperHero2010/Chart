function onCreate()

    setObjectOrder('boyfriendGroup', 3)
    setObjectOrder('dadGroup', 2)
    setObjectOrder('gfGroup', 1)

    makeLuaSprite('OmmetaBG', 'OmmetaBG', -12000, -6500)
    addGlitchEffect('OmmetaBG', 2, 4, 0.1)
    scaleObject('OmmetaBG', 3.5, 3.5)
    setScrollFactor('OmmetaBG', 0.1, 0.1);
setObjectOrder('OmmetaBG', 0)
	
    addLuaSprite('ScopoBG', false)
    setScrollFactor('ScopoBG', 0.1, 0.1);

end