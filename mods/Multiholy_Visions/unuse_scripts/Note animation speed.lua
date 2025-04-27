local animationSpeed = 0.5 -- Set the desired animation speed (default is 1.0)

-- Ensure the animation speed is applied after all other scripts have executed
function onUpdatePost()
    -- Iterate through all active notes
    for i = 0, getProperty('notes.length') - 1 do
        local isPressed = getPropertyFromGroup('notes', i, 'isPressed')

        -- Apply animation speed only to pressed notes
        if isPressed then
            setPropertyFromGroup('notes', i, 'animationRate', animationSpeed)
        else
            -- Reset animation speed for unpressed notes to normal speed
            setPropertyFromGroup('notes', i, 'animationRate', 1.0)
        end
    end
end

-- Handle good note hit (slower animation when good note is hit)
function goodNoteHit(id, direction, noteType, isSustainNote)
    setPropertyFromGroup('notes', id, 'animationRate', animationSpeed)
end

-- Reset animation speed for missed notes
function noteMiss(id)
    setPropertyFromGroup('notes', id, 'animationRate', 1.0)
end

-- Ensure compatibility with other scripts by only modifying note properties without interfering with others
function onCreatePost()
    -- Initialization or additional setup if necessary
end
