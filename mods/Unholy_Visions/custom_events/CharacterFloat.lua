function onEvent(name, value1, value2)
	if name == "CharacterFloat" then
    doTweenY(dadTweenY, 'dad', value1, value2, 'QuartInOut')
  end
end