-- The first event mabe by me(Scarlet Eye) --
function onEvent(name, value1, value2)
	if name == 'VGRed' then
		if value1 then -- begining
		makeLuaSprite('Red', 'VGRed', 0, 0)
	    setObjectCamera('Red', 'other')
	    setObjectOrder('Red', 5)
	    addLuaSprite('Red', true)
	    doTweenAlpha('Red', 'Red', 1, value1, 'quadInOut');
	end
	    if value2 then -- end
	    makeLuaSprite('Red', 'VGRed', 0, 0)
	    setObjectCamera('Red', 'other')
	    setObjectOrder('Red', 5)
	    addLuaSprite('Red', true)
		doTweenAlpha('Red', 'Red', 0, value2, 'quadInOut');
	    end
	end
end