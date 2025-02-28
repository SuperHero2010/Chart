function onEvent(name, value1, value2)
    if name == "reverseArrowsNoArchive" then
        if value1 == "true" then
            -- Swap the positions of left and right arrows dynamically
            for i = 0, 3 do
                local oppositeIndex = i + 4
                local currentX = getPropertyFromGroup('strumLineNotes', i, 'x')
                local currentY = getPropertyFromGroup('strumLineNotes', i, 'y')
                local oppositeX = getPropertyFromGroup('strumLineNotes', oppositeIndex, 'x')
                local oppositeY = getPropertyFromGroup('strumLineNotes', oppositeIndex, 'y')
                
                -- Swap their positions
                setPropertyFromGroup('strumLineNotes', i, 'x', oppositeX)
                setPropertyFromGroup('strumLineNotes', i, 'y', oppositeY)
                setPropertyFromGroup('strumLineNotes', oppositeIndex, 'x', currentX)
                setPropertyFromGroup('strumLineNotes', oppositeIndex, 'y', currentY)
            end
        elseif value1 == "false" then
            -- Swap them back dynamically to their default positions
            for i = 0, 3 do
                local oppositeIndex = i + 4
                local currentX = getPropertyFromGroup('strumLineNotes', i, 'x')
                local currentY = getPropertyFromGroup('strumLineNotes', i, 'y')
                local oppositeX = getPropertyFromGroup('strumLineNotes', oppositeIndex, 'x')
                local oppositeY = getPropertyFromGroup('strumLineNotes', oppositeIndex, 'y')
                
                -- Swap their positions back
                setPropertyFromGroup('strumLineNotes', i, 'x', oppositeX)
                setPropertyFromGroup('strumLineNotes', i, 'y', oppositeY)
                setPropertyFromGroup('strumLineNotes', oppositeIndex, 'x', currentX)
                setPropertyFromGroup('strumLineNotes', oppositeIndex, 'y', currentY)
            end
        end
    end
end
