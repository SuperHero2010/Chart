local arrowMoveX = 0
local arrowMoveY = 0
local isCenterShaking = false
local centerOffsetX = 0
local arrowSpacing = 112
local triggerTimeArrowCentering = (7 * 60 + 39.76) * 1000 -- 7:39.76 (center arrows)

function onCreatePost()
    local screenWidth = getPropertyFromClass('flixel.FlxG', 'width')
    centerOffsetX = (screenWidth - (4 * arrowSpacing)) / 2
end

function onUpdate(elapsed)
    local songPos = getSongPosition()

    -- Execute arrow centering actions at 7:39.76
    if songPos >= triggerTimeArrowCentering then
        local centerX = 640 -- Middle of the screen
        local arrowY = 50 -- Keep arrows at the top

        for i = 0, 3 do
            -- Opponent's arrows
            setPropertyFromGroup('opponentStrums', i, 'x', centerX - (2 * arrowSpacing) + (i * arrowSpacing))
            setPropertyFromGroup('opponentStrums', i, 'y', arrowY)

            -- Player's arrows
            setPropertyFromGroup('playerStrums', i, 'x', centerX - (2 * arrowSpacing) + (i * arrowSpacing))
            setPropertyFromGroup('playerStrums', i, 'y', arrowY)
        end
    end

    -- Handle shaking when active
    if isCenterShaking then
    local songPos = getSongPosition() / 500
    for i = 0, 3 do
        local offsetX = arrowMoveX * math.sin(songPos * math.pi * 8 + i)
        local offsetY = arrowMoveY * math.cos(songPos * math.pi * 6 + i)

        -- Apply shake to opponent arrows
        setPropertyFromGroup('opponentStrums', i, 'x', getPropertyFromGroup('opponentStrums', i, 'x') + offsetX)
        setPropertyFromGroup('opponentStrums', i, 'y', getPropertyFromGroup('opponentStrums', i, 'y') + offsetY)
    end
end
end

function onEvent(name, value1, value2)
    if name == 'centerShakeyArrows' then
        if value1 == 'normal' then
            isCenterShaking = false
        elseif value1 == 'little' then
            arrowMoveX = 8
            arrowMoveY = 8
            isCenterShaking = true
        elseif value1 == 'medium' then
            arrowMoveX = 12
            arrowMoveY = 12
            isCenterShaking = true
        elseif value1 == 'large' then
            arrowMoveX = 20
            arrowMoveY = 20
            isCenterShaking = true
        end
    end
end
