function onEvent(name, value1, value2)
    if name == 'Centered Notes' then
        ohmiddlestuff = tonumber(value1)
        if ohmiddlestuff == 1 then
            -- Center opponent's arrows
            noteTweenX('oppo0', 0, 420, 0.25, 'quartInOut')
            noteTweenX('oppo1', 1, 530, 0.25, 'quartInOut')
            noteTweenX('oppo2', 2, 640, 0.25, 'quartInOut')
            noteTweenX('oppo3', 3, 750, 0.25, 'quartInOut')

            -- Player arrows remain in their position
            noteTweenX('play0', 4, 420, 0.25, 'quartInOut')
            noteTweenX('play1', 5, 530, 0.25, 'quartInOut')
            noteTweenX('play2', 6, 640, 0.25, 'quartInOut')
            noteTweenX('play3', 7, 750, 0.25, 'quartInOut')

            -- Apply rotation animations
            noteTweenAngle('opporotate0', 0, -360, 0.25, 'quartInOut')
            noteTweenAngle('opporotate1', 1, -360, 0.25, 'quartInOut')
            noteTweenAngle('opporotate2', 2, -360, 0.25, 'quartInOut')
            noteTweenAngle('opporotate3', 3, -360, 0.25, 'quartInOut')
            noteTweenAngle('playrotate0', 4, 360, 0.25, 'quartInOut')
            noteTweenAngle('playrotate1', 5, 360, 0.25, 'quartInOut')
            noteTweenAngle('playrotate2', 6, 360, 0.25, 'quartInOut')
            noteTweenAngle('playrotate3', 7, 360, 0.25, 'quartInOut')

            -- Fade notes
            noteTweenAlpha('opporo0', 0, 0.3, 0.25, 'linear')
            noteTweenAlpha('opporo1', 1, 0.3, 0.25, 'linear')
            noteTweenAlpha('opporo2', 2, 0.3, 0.25, 'linear')
            noteTweenAlpha('opporo3', 3, 0.3, 0.25, 'linear')
            noteTweenAlpha('playro0', 4, 1, 0.25, 'linear')
            noteTweenAlpha('playro1', 5, 1, 0.25, 'linear')
            noteTweenAlpha('playro2', 6, 1, 0.25, 'linear')
            noteTweenAlpha('playro3', 7, 1, 0.25, 'linear')

            -- Restore Y position
            noteTweenY('defaultOpponentStrumY0', 0, defaultOpponentStrumY0, 0.25, "expoOut")
            noteTweenY('defaultOpponentStrumY1', 1, defaultOpponentStrumY1, 0.25, "expoOut")
            noteTweenY('defaultOpponentStrumY2', 2, defaultOpponentStrumY2, 0.25, "expoOut")
            noteTweenY('defaultOpponentStrumY3', 3, defaultOpponentStrumY3, 0.25, "expoOut")
            noteTweenY('defaultPlayerStrumY0', 4, defaultPlayerStrumY0, 0.25, "expoOut")
            noteTweenY('defaultPlayerStrumY1', 5, defaultPlayerStrumY1, 0.25, "expoOut")
            noteTweenY('defaultPlayerStrumY2', 6, defaultPlayerStrumY2, 0.25, "expoOut")
            noteTweenY('defaultPlayerStrumY3', 7, defaultPlayerStrumY3, 0.25, "expoOut")
        else
            -- Reset opponent's arrows
            noteTweenX('oppo0', 0, 200, 0.25, 'quartInOut')
            noteTweenX('oppo1', 1, 310, 0.25, 'quartInOut')
            noteTweenX('oppo2', 2, 860, 0.25, 'quartInOut')
            noteTweenX('oppo3', 3, 970, 0.25, 'quartInOut')

            -- Reset player arrows
            noteTweenX('play0', 4, 420, 0.25, 'quartInOut')
            noteTweenX('play1', 5, 530, 0.25, 'quartInOut')
            noteTweenX('play2', 6, 640, 0.25, 'quartInOut')
            noteTweenX('play3', 7, 750, 0.25, 'quartInOut')

            -- Reset rotation
            noteTweenAngle('opporotate0', 0, -360, 0.25, 'quartInOut')
            noteTweenAngle('opporotate1', 1, -360, 0.25, 'quartInOut')
            noteTweenAngle('opporotate2', 2, -360, 0.25, 'quartInOut')
            noteTweenAngle('opporotate3', 3, -360, 0.25, 'quartInOut')
            noteTweenAngle('playrotate0', 4, 360, 0.25, 'quartInOut')
            noteTweenAngle('playrotate1', 5, 360, 0.25, 'quartInOut')
            noteTweenAngle('playrotate2', 6, 360, 0.25, 'quartInOut')
            noteTweenAngle('playrotate3', 7, 360, 0.25, 'quartInOut')

            -- Reset fade
            noteTweenAlpha('opporo0', 0, 1, 0.25, 'linear')
            noteTweenAlpha('opporo1', 1, 1, 0.25, 'linear')
            noteTweenAlpha('opporo2', 2, 1, 0.25, 'linear')
            noteTweenAlpha('opporo3', 3, 1, 0.25, 'linear')
            noteTweenAlpha('playro0', 4, 1, 0.25, 'linear')
            noteTweenAlpha('playro1', 5, 1, 0.25, 'linear')
            noteTweenAlpha('playro2', 6, 1, 0.25, 'linear')
            noteTweenAlpha('playro3', 7, 1, 0.25, 'linear')
        end
    end
end
