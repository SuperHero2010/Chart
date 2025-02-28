function onEvent(name, value1, value2)
    if name == 'Lyrics' then
        setTextString('lyric', value1)
        setTextColor('lyric', value2)
    end
end

function onCreate()
    makeLuaText('lyric', '', screenWidth, 0, 145)
 if getPropertyFromClass('ClientPrefs', 'downScroll') == true then
     setProperty('lyric.y', 545)
end
    addLuaText('lyric')
    setTextSize('lyric', 40)
end