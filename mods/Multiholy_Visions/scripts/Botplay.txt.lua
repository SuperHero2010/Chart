function onUpdate()
    -- Get the current Botplay text
    local botplayText = getProperty('botplayTxt.text')

    -- If the text is not "BOTPLAY", force reset it
    if botplayText ~= "BOTPLAY" then
        setProperty('botplayTxt.text', "BOTPLAY")
    end
end
