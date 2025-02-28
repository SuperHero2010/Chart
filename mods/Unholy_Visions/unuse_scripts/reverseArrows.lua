-- Store original positions of the arrows
local originalPositions = {}

function onCreatePost()
    -- Store the original positions for all arrows (8 total)
    for i = 0, 7 do
        originalPositions[i] = {
            x = getPropertyFromGroup('strumLineNotes', i, 'x'),
            y = getPropertyFromGroup('strumLineNotes', i, 'y')
        }
    end
end

function reverseArrows(reverse)
    if reverse == "true" then
        -- Swap the positions of the opponent and player's up arrows (index 1 and 5)
        local tempUpX = originalPositions[1].x
        setPropertyFromGroup('strumLineNotes', 1, 'x', originalPositions[5].x)  -- Opponent's up -> Player's up
        setPropertyFromGroup('strumLineNotes', 5, 'x', tempUpX)  -- Player's up -> Opponent's up

        -- Swap the positions of the opponent and player's down arrows (index 0 and 4)
        local tempDownX = originalPositions[0].x
        setPropertyFromGroup('strumLineNotes', 0, 'x', originalPositions[4].x)  -- Opponent's down -> Player's down
        setPropertyFromGroup('strumLineNotes', 4, 'x', tempDownX)  -- Player's down -> Opponent's down

        -- Swap the positions of the opponent and player's left arrows (index 2 and 6)
        local tempLeftX = originalPositions[2].x
        setPropertyFromGroup('strumLineNotes', 2, 'x', originalPositions[6].x)  -- Opponent's left -> Player's left
        setPropertyFromGroup('strumLineNotes', 6, 'x', tempLeftX)  -- Player's left -> Opponent's left

        -- Swap the positions of the opponent and player's right arrows (index 3 and 7)
        local tempRightX = originalPositions[3].x
        setPropertyFromGroup('strumLineNotes', 3, 'x', originalPositions[7].x)  -- Opponent's right -> Player's right
        setPropertyFromGroup('strumLineNotes', 7, 'x', tempRightX)  -- Player's right -> Opponent's right

    else
        -- Restore all arrows to their original positions
        for i = 0, 7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', originalPositions[i].x)
            setPropertyFromGroup('strumLineNotes', i, 'y', originalPositions[i].y)
        end
    end
end

-- Event hook for triggering the reverse action
function onEvent(name, value1, value2)
    if name == "reverseArrows" then
        reverseArrows(value1)  -- Use value1 ("true" or "false") to flip arrows
    end
end
