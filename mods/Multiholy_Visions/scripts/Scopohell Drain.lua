function opponentNoteHit()
    local health = getProperty('health')

    local targetCharacter = 'scopohell'

    if getProperty('dad.curCharacter') == targetCharacter and health > 0.1 then
        setProperty('health', health - 0.023)
    end
end
