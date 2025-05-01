function onCreate()
    -- Change death character
    setPropertyFromClass('GameOverSubstate', 'characterName', 'bfeyedead')

    -- Ensure sounds exist before setting them
    if checkFileExists('sounds/bf-eye-dead.ogg') then
        setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'bf-eye-dead')
    else
        debugPrint("Warning: bf-eye-dead.ogg is missing!")
    end

    if checkFileExists('sounds/explosion.ogg') then
        setPropertyFromClass('GameOverSubstate', 'endSoundName', 'explosion')
    else
        debugPrint("Warning: explosion.ogg is missing!")
    end

    -- Check if empty.ogg is missing
    if checkFileExists('sounds/empty.ogg') then
        setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'empty')
    else
        setPropertyFromClass('GameOverSubstate', 'loopSoundName', '') -- Avoid crash
    end
end

-- Function to check if file exists
function checkFileExists(filePath)
    local file = io.open(filePath, "r")
    if file then
        file:close()
        return true
    else
        return false
    end
end
