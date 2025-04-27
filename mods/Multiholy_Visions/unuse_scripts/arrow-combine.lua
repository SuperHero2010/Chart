local playerPositions = {}
local opponentPositions = {}
local isCentered = false -- Default state

function onCreatePost()
    -- Store original positions
    for i = 0, 3 do
        playerPositions[i] = {
            x = getPropertyFromGroup('playerStrums', i, 'x'),
            y = getPropertyFromGroup('playerStrums', i, 'y')
        }
        opponentPositions[i] = {
            x = getPropertyFromGroup('opponentStrums', i, 'x'),
            y = getPropertyFromGroup('opponentStrums', i, 'y')
        }
    end
end

function onEvent(name, value1, value2)
    if name == "arrow-combine" then
        if value1 == "on" then
            isCentered = true
            centerBothArrows()
        elseif value1 == "off" then
            isCentered = false
            resetArrowPositions()
        end
    end
end

function centerBothArrows()
    local screenWidth = 1280
    local arrowSpacing = 112
    local centerX = (screenWidth - (4 * arrowSpacing)) / 2 -- Adjust for centering
    local arrowY = 50 -- Move both arrows to the top

    -- **Move Opponent's Arrows**
    for i = 0, 3 do
        setPropertyFromGroup('opponentStrums', i, 'x', centerX + (i * arrowSpacing))
        setPropertyFromGroup('opponentStrums', i, 'y', arrowY)
    end

    -- **Move Player's Arrows**
    for i = 0, 3 do
        setPropertyFromGroup('playerStrums', i, 'x', centerX + (i * arrowSpacing))
        setPropertyFromGroup('playerStrums', i, 'y', arrowY)
    end
end

function resetArrowPositions()
    -- **Reset Opponent Arrows**
    for i = 0, 3 do
        setPropertyFromGroup('opponentStrums', i, 'x', opponentPositions[i].x)
        setPropertyFromGroup('opponentStrums', i, 'y', opponentPositions[i].y)
    end

    -- **Reset Player Arrows**
    for i = 0, 3 do
        setPropertyFromGroup('playerStrums', i, 'x', playerPositions[i].x)
        setPropertyFromGroup('playerStrums', i, 'y', playerPositions[i].y)
    end
end
