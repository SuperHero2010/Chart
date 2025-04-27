function opponentNoteHit()
    local health = getProperty('health')

    local targetCharacter = 'oldscopohell'

    if getProperty('dad.curCharacter') == targetCharacter and health > 0.1 then
        setProperty('health', health - 0.0115)
    end
end
