local arrowMoveX = 0
local arrowMoveY = 0
local defaultNotePos = {}
local isShaking = false

function onCreatePost()
    -- Save default positions of all arrows
    for i = 0, 7 do
        local x = getPropertyFromGroup('strumLineNotes', i, 'x')
        local y = getPropertyFromGroup('strumLineNotes', i, 'y')
        table.insert(defaultNotePos, {x, y})
    end
end

function onUpdate(elapsed)
    if isShaking then
        local songPos = getSongPosition() / 500 -- Get song position in seconds, adjust speed
        for i = 0, 3 do -- Only shake opponent arrows (index 0-3)
            -- Create shaking effect using sinusoidal oscillation
            local offsetX = arrowMoveX * math.sin(songPos * math.pi * 8 + i) -- Faster horizontal shake
            local offsetY = arrowMoveY * math.cos(songPos * math.pi * 6 + i) -- Vertical shake variation

            -- Apply shake offsets
            setPropertyFromGroup('opponentStrums', i, 'x', defaultNotePos[i + 1][1] + offsetX)
            setPropertyFromGroup('opponentStrums', i, 'y', defaultNotePos[i + 1][2] + offsetY)
        end
    end
end

function onEvent(name, value1, value2)
    if name == 'shakey arrows' then
        if value1 == 'normal' then
            -- Disable shaking and reset to default positions
            isShaking = false
            for i = 0, 3 do
                setPropertyFromGroup('opponentStrums', i, 'x', defaultNotePos[i + 1][1])
                setPropertyFromGroup('opponentStrums', i, 'y', defaultNotePos[i + 1][2])
            end
        elseif value1 == 'little' then
            -- Moderate shake
            arrowMoveX = 8
            arrowMoveY = 8
            isShaking = true
        elseif value1 == 'medium' then
            -- Intense shake
            arrowMoveX = 20
            arrowMoveY = 20
            isShaking = true
        elseif value1 == 'large' then
            -- Extreme shake
            arrowMoveX = 40
            arrowMoveY = 40
            isShaking = true
        end
    end
end
