local playerCombo = 0 -- Player's combo counter
local enemyCombo = 0 -- Enemy's combo counter
local playerMiss = 0 -- Player's missed notes
local enemyMiss = 0 -- Enemy's missed notes

function onCreatePost()
    -- Get screen dimensions
    local screenWidth = getPropertyFromClass('flixel.FlxG', 'width')
    local screenHeight = getPropertyFromClass('flixel.FlxG', 'height')
    
    -- Adjusted Y position to ensure combo text doesn't overlap with the health bar
    local yOffset = screenHeight - 100 -- Move the combo text higher above the health bar

    -- Create text objects for player and enemy COMBO counters
    makeLuaText("enemyComboText", "COMBO: 0", 300, 50, yOffset) -- Enemy combo at bottom-left
    setTextSize("enemyComboText", 24)
    setTextBorder("enemyComboText", 2, "000000") -- Black border
    setTextColor("enemyComboText", "FFFFFF") -- White text
    setObjectCamera("enemyComboText", "hud")
    addLuaText("enemyComboText")

    makeLuaText("playerComboText", "COMBO: 0 | MISS: 0", 400, screenWidth - 450, yOffset) -- Increased width for player combo
    setTextSize("playerComboText", 24)
    setTextBorder("playerComboText", 2, "000000") -- Black border
    setTextColor("playerComboText", "FFFFFF") -- White text
    setObjectCamera("playerComboText", "hud")
    addLuaText("playerComboText")
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if not isSustainNote then
        -- Increment player combo for normal notes
        playerCombo = playerCombo + 1
        updateComboText("playerComboText", playerCombo, playerMiss)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if not isSustainNote then
        -- Increment enemy combo for normal notes
        enemyCombo = enemyCombo + 1
        updateComboText("enemyComboText", enemyCombo)
    end
end

function noteMissPress()
    -- Increment player miss counter when a note is missed
    playerMiss = playerMiss + 1
    updateComboText("playerComboText", playerCombo, playerMiss)
end

function noteMiss(id, direction, noteType, isSustainNote)
    -- Increment player miss counter for missed notes
    if not isSustainNote then
        playerMiss = playerMiss + 1
        updateComboText("playerComboText", playerCombo, playerMiss)
    end
end

function updateComboText(comboText, comboCount, missCount)
    -- Update the combo text with pressed and missed notes
    missCount = missCount or 0
    if comboText == "playerComboText" then
        setTextString(comboText, "COMBO: " .. comboCount .. " | MISS: " .. missCount)
    else
        setTextString(comboText, "COMBO: " .. comboCount)
    end
end
