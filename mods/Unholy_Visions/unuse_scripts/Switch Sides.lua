flippedHealthBar = false --change this to false if you don't want the health bar to be flipped from the start

function onCreatePost()
    if flippedHealthBar == true then
        setProperty('iconP1.flipX', 1)
        setProperty('iconP2.flipX', 1)
        setProperty('healthBar.flipX', 1)
    end
end

function onUpdatePost()
    if flippedHealthBar == true then
        setProperty('iconP1.x', -593+getProperty('healthBar.x') + (getProperty('healthBar.width')*(remapToRange(getProperty('healthBar.percent'), 0, -100, 100, 0)*0.01))-(150 * getProperty('iconP1.scale.x'))/2 - 26*2)

        setProperty('iconP2.x', -593+getProperty('healthBar.x') + (getProperty('healthBar.width')*(remapToRange(getProperty('healthBar.percent'), 0, -100, 100, 0)*0.01))+(150 * getProperty('iconP2.scale.x')-150)/2 - 26)
    end
end

function onCountdownTick()
    if flippedHealthBar == true then
        noteTweenX('switch1', 0, defaultPlayerStrumX0, 0.001, linear)
        noteTweenX('switch2', 1, defaultPlayerStrumX1, 0.001, linear)
        noteTweenX('switch3', 2, defaultPlayerStrumX2, 0.001, linear)
        noteTweenX('switch4', 3, defaultPlayerStrumX3, 0.001, linear)
        noteTweenX('switch5', 4, defaultOpponentStrumX0, 0.001, linear)
        noteTweenX('switch6', 5, defaultOpponentStrumX1, 0.001, linear)
        noteTweenX('switch7', 6, defaultOpponentStrumX2, 0.001, linear)
        noteTweenX('switch8', 7, defaultOpponentStrumX3, 0.001, linear)
    end
end

function remapToRange(value, start1, stop1, start2, stop2)

    return start2 + (value - start1) * ((stop2 - start2) / (stop1 - start1))

end

function onEvent(name, value1, value2)
    if name == 'Switch Sides' then
        if value1 == 'True' then
            flippedHealthBar = true
        elseif value1 == 'False' then
            flippedHealthBar = false
        end
        if value2 == 'True' then
            noteTweenX('switch1', 0, defaultPlayerStrumX0, 0.001, linear)
            noteTweenX('switch2', 1, defaultPlayerStrumX1, 0.001, linear)
            noteTweenX('switch3', 2, defaultPlayerStrumX2, 0.001, linear)
            noteTweenX('switch4', 3, defaultPlayerStrumX3, 0.001, linear)
            noteTweenX('switch5', 4, defaultOpponentStrumX0, 0.001, linear)
            noteTweenX('switch6', 5, defaultOpponentStrumX1, 0.001, linear)
            noteTweenX('switch7', 6, defaultOpponentStrumX2, 0.001, linear)
            noteTweenX('switch8', 7, defaultOpponentStrumX3, 0.001, linear)
        elseif value2 == 'False' then
            noteTweenX('switch1', 0, defaultOpponentStrumX0, 0.001, linear)
            noteTweenX('switch2', 1, defaultOpponentStrumX1, 0.001, linear)
            noteTweenX('switch3', 2, defaultOpponentStrumX2, 0.001, linear)
            noteTweenX('switch4', 3, defaultOpponentStrumX3, 0.001, linear)
            noteTweenX('switch5', 4, defaultPlayerStrumX0, 0.001, linear)
            noteTweenX('switch6', 5, defaultPlayerStrumX1, 0.001, linear)
            noteTweenX('switch7', 6, defaultPlayerStrumX2, 0.001, linear)
            noteTweenX('switch8', 7, defaultPlayerStrumX3, 0.001, linear)
        end
    end
end