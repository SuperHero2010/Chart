function onCreate()
    local speed = getProperty('playbackRate') -- Get current PlayState speed
    local fadeInTime = 0.5 / speed -- Adjust fade-in time
    local waitTime = 1 / speed -- Adjust time before fade-out
    local fadeOutTime = 0.5 / speed -- Adjust fade-out time

    -- Create an intro image
    makeLuaSprite('introImage', 'Tutorial', 0, 0) -- Replace 'Tutorial' with your actual image
    setObjectCamera('introImage', 'hud') -- Keep it on the HUD
    screenCenter('introImage', 'xy') -- Center the image
    setProperty('introImage.alpha', 0) -- Start with invisible image
    addLuaSprite('introImage', true)

    -- Fade in over scaled time
    doTweenAlpha('fadeInIntro', 'introImage', 1, fadeInTime, 'linear')

    -- Wait before fading out
    runTimer('startFadeOut', fadeInTime + waitTime)
end

function onTimerCompleted(tag, loops, loopsLeft)
    local speed = getProperty('playbackRate')
    local fadeOutTime = 1 / speed -- Adjust fade-out time

    if tag == 'startFadeOut' then
        -- Fade out over adjusted time
        doTweenAlpha('fadeOutIntro', 'introImage', 0, fadeOutTime, 'linear')
        runTimer('removeIntroImage', fadeOutTime) -- Wait before removing
    elseif tag == 'removeIntroImage' then
        removeLuaSprite('introImage', false) -- Remove after fade-out
    end
end
