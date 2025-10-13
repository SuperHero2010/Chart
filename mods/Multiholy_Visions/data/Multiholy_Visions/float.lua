canFloat = false
floatX = false
bfFloat = false
speedY = 20
speedX = 7
amplitudeY = 25
amplitudeX = 20
ofs = 0
yy = 0
xx = 0
bf_xx = 0
bf_yy = 0

function onCreatePost()
    yy = getProperty('dad.y') + ofs
    xx = getProperty('dad.x')
    bf_yy = getProperty('boyfriend.y') + ofs
    bf_xx = getProperty('boyfriend.x')
end

function onUpdate()
    if not canFloat then return end  -- Skip entire update if not floating

    local songPos = getSongPosition()
    local currentBeat = (songPos / 1000) * (curBpm / 60)  -- Cleaner calculation

    if floatX then
        setProperty('dad.x', amplitudeX * math.cos(currentBeat * speedX) + xx)
        if bfFloat then
            setProperty('boyfriend.x', amplitudeX * math.cos(currentBeat * speedX) + bf_xx)
        end
    end

    setProperty('dad.y', amplitudeY * math.sin(currentBeat * speedY) + yy)
    if bfFloat then
        setProperty('boyfriend.y', amplitudeY * math.sin(currentBeat * speedY) + bf_yy)
    end
end

function onBeatHit()
    if curBeat == 2905 then
        canFloat = false
    end
end
