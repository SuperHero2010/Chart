-- Default animation speed (1.0 = normal)
local animationSpeed = 1.0

-- Event handler for adjusting animation speed
function onEvent(name, value1, value2)
    if name == "AdjustNoteAnimationSpeed" then
        -- Parse the animation speed from value1 (default to 1.0 if invalid)
        animationSpeed = tonumber(value1) or 1.0
    end
end

-- Apply the animation speed dynamically to all notes
function onUpdatePost()
    for i = 0, getProperty('notes.length') - 1 do
        setPropertyFromGroup('notes', i, 'animationRate', animationSpeed)
    end
end

-- Apply the speed to good notes as well
function goodNoteHit(id, direction, noteType, isSustainNote)
    setPropertyFromGroup('notes', id, 'animationRate', animationSpeed)
end

-- Maintain or reset the speed for missed notes
function noteMiss(id)
    setPropertyFromGroup('notes', id, 'animationRate', animationSpeed)
end
