local dodging = false -- Check if player can dodge
local dodgeTime = 1.0 -- Time to dodge (in seconds)
local dodgeStart = 0   -- Time when dodge starts

function onEvent(name, value1, value2)
    if name == "DodgeEvent" then
        -- Show "Dodge" image
        makeLuaSprite('dodgeImage', 'Dodge', screenWidth / 2 - 100, screenHeight / 2 - 100)
        setObjectCamera('dodgeImage', 'hud')
        addLuaSprite('dodgeImage', true)

        -- Play warning sound
        playSound('warning', 1) -- Replace 'warning' with your sound file

        -- Set dodge state
        dodging = true
        dodgeStart = os.clock() -- Start time

        -- Start a timer for auto-fail if not dodged
        runTimer('failDodge', dodgeTime, 1)
    end
end

function onUpdate()
    if dodging and keyJustPressed('space') then
        dodging = false
        removeLuaSprite('dodgeImage', false) -- Remove Dodge Image
        cancelTimer('failDodge') -- Stop fail timer

        -- Show laser effect on the **left side** of BF
        local laserX = getProperty('boyfriend.x') - 100 -- Adjusted left position
        local laserY = getProperty('boyfriend.y') - 50
        makeLuaSprite('laser', 'laser', laserX, laserY)
        addLuaSprite('laser', true)
        
        -- Play laser sound
        playSound('laser_shoot', 1) -- Replace 'laser_shoot' with your laser sound file

        -- Fade laser effect
        doTweenAlpha('laserFade', 'laser', 0, 0.5, 'linear')

        -- Move BF right & return
        doTweenX('bfDodgeRight', 'boyfriend', getProperty('boyfriend.x') + 100, 0.2, 'linear')
        runTimer('bfReturn', 0.3)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'failDodge' and dodging then
        -- If player didn't dodge, BF dies
        setProperty('health', 0)
        playSound('bf_death', 1) -- Replace 'bf_death' with your BF death sound
    elseif tag == 'bfReturn' then
        -- BF returns to original position
        doTweenX('bfReturnTween', 'boyfriend', getProperty('boyfriend.x') - 100, 0.2, 'linear')
    end
end
