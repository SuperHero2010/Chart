local originalPositions = {}

function onCreatePost()
    for i = 0, 7 do
        originalPositions[i] = {
            x = getPropertyFromGroup('strumLineNotes', i, 'x'),
            y = getPropertyFromGroup('strumLineNotes', i, 'y')
        }
    end
end

function onEvent(name, value1, value2)
    if name == "toggleAllComponents" then
        local reverse = (value1 == "true")
        -- Reverse arrows
        for i = 0, 3 do
            setPropertyFromGroup('strumLineNotes', i, 'x', originalPositions[i + 4].x)
            setPropertyFromGroup('strumLineNotes', i, 'y', originalPositions[i + 4].y)
        end
        for i = 4, 7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', originalPositions[i - 4].x)
            setPropertyFromGroup('strumLineNotes', i, 'y', originalPositions[i - 4].y)
        end

        -- Reverse health bar
        setProperty('healthBar.flipX', reverse)

        -- Reverse icons
        setProperty('iconP1.flipX', reverse)
        setProperty('iconP2.flipX', reverse)
    end
end
