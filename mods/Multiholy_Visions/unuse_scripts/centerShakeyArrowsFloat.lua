-- 🎯 FINAL VERSION: FLOAT + CENTERED SHAKE FIXED 🎯

-- Arrow Shake Variables
local arrowMoveX = 0
local arrowMoveY = 0
local isCenterShaking = false
local centerOffsetX = 0
local arrowSpacing = 112

-- Floating Variables
local canFloat = false
local floatX = false -- Enable horizontal float
local bfFloat = false -- Enable BF float
local speedY = 20
local speedX = 7
local amplitudeY = 25
local amplitudeX = 20
local ofs = 0
local yy, xx, bf_xx, bf_yy = 0, 0, 0, 0

-- Timing Variables (Milliseconds)
local triggerTimeCharacterMovement = (0 * 60 + 0.00) * 1000  -- 0:00.00
local triggerTimeArrowCentering = (7 * 60 + 39.76) * 1000    -- 7:39.76

function onCreatePost()
    -- Save default positions for floating characters
    yy = getProperty('dad.y') + ofs
    xx = getProperty('dad.x')
    bf_yy = getProperty('boyfriend.y') + ofs
    bf_xx = getProperty('boyfriend.x')

    -- Calculate center offset based on screen width
    local screenWidth = getPropertyFromClass('flixel.FlxG', 'width')
    centerOffsetX = (screenWidth - (4 * arrowSpacing)) / 2
end

function onUpdate(elapsed)
    local songPos = getPropertyFromClass('Conductor', 'songPosition') -- Time in ms

    -- ===============================
    -- CHARACTER FLOATING EFFECT (0:00.00)
    -- ===============================
    if songPos >= triggerTimeCharacterMovement then
        canFloat = true
        local seconds = songPos / 1000
        local currentBeat = (seconds) * (curBpm / 60)

        if canFloat then
            -- Horizontal floating
            if floatX then
                setProperty('dad.x', amplitudeX * math.cos(currentBeat * speedX) + xx)
                if bfFloat then
                    setProperty('boyfriend.x', amplitudeX * math.cos(currentBeat * speedX) + bf_xx)
                end
            end

            -- Vertical floating
            setProperty('dad.y', amplitudeY * math.sin(currentBeat * speedY) + yy)
            if bfFloat then
                setProperty('boyfriend.y', amplitudeY * math.sin(currentBeat * speedY) + bf_yy)
            end
        end
    end

    -- ===============================
    -- CENTERING & SHAKING ARROWS (7:39.76)
    -- ===============================
    if songPos >= triggerTimeArrowCentering then
        if isCenterShaking then
            local beatPos = songPos / 500
            for i = 0, 3 do  -- Shake opponent arrows only
                local offsetX = arrowMoveX * math.sin(beatPos * math.pi * 8 + i) + math.random(-2, 2)
                local offsetY = arrowMoveY * math.cos(beatPos * math.pi * 6 + i) + math.random(-2, 2)
                local centerX = centerOffsetX + (i * arrowSpacing)
                setPropertyFromGroup('opponentStrums', i, 'x', centerX + offsetX)
                setPropertyFromGroup('opponentStrums', i, 'y', 50 + offsetY)
            end
        else
            -- Center both opponent and player arrows at the top
            for i = 0, 3 do
                local centerX = centerOffsetX + (i * arrowSpacing)
                setPropertyFromGroup('opponentStrums', i, 'x', centerX)
                setPropertyFromGroup('opponentStrums', i, 'y', 50)
            end
            for i = 0, 3 do
                local centerX = centerOffsetX + (i * arrowSpacing)
                setPropertyFromGroup('playerStrums', i, 'x', centerX)
                setPropertyFromGroup('playerStrums', i, 'y', 50)
            end
        end
    end
end

-- 🎯 EVENT SYSTEM (Shaking Control) 🎯
function onEvent(name, value1, value2)
    if name == 'centerShakeyArrowsFloat' then
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

function onBeatHit()
    if curBeat == 2905 then
        canFloat = false
    end
end
