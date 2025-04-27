local bopShit = false
local beatDirection = -1 -- Start to the left
local playbackSpeed = 1
local bopMode = "fast"
local boomspeed = 4 -- Default, controlled by Cam Boom Speed
local lastStep = -1

function onEvent(eventName, value1, value2)
    if eventName == 'NewBopping HUD Faster' then
        if value1 == 'on' then
            bopShit = true
            playbackSpeed = getProperty('playbackRate')
            bopMode = value2 ~= '' and value2 or "fast"
        elseif value2 == 'off' then
            bopShit = false
            bopMode = "off"

            -- Reset camera
            cancelTween('hudTween')
            setProperty('camHUD.angle', 0)
            setProperty('camHUD.zoom', 1)
        end
    elseif eventName == "Cam Boom Speed" then
        boomspeed = tonumber(value1) or 4 -- Sync bopping speed, fallback to 4 if invalid
    end
end

function onStepHit()
    if bopShit and curStep ~= lastStep and curStep % (boomspeed * 2) == 0 then
        local angle = 1.5 * beatDirection -- Softer bop to avoid excessive shaking
        local zoomAmount = (bopMode == "fast") and 0.01 or 0.001
        local tweenSpeed = (bopMode == "fast") and (0.25 / playbackSpeed) or (0.35 / playbackSpeed)

        -- Apply camera movement
        setProperty('camHUD.angle', angle)
        doTweenAngle('hudTween', 'camHUD', 0, tweenSpeed, 'circOut')

        -- Apply zoom effect
        triggerEvent('Add Camera Zoom', '0', zoomAmount)

        -- Flip direction for next step
        beatDirection = -beatDirection
        lastStep = curStep  -- Track last processed step
    end
end
