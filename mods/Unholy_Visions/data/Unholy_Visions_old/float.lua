canFloat = false
floatX = false --if you want your char to float left and right set this to true
bfFloat = false -- if bf floats
speedY = 20 --how fast it will go up and down
speedX = 7 --how fast it will go left and right
amplitudeY = 25 --how far up and down it will go in pixels
amplitudeX = 20 --how far left and right  it will go in pixels
ofs = 0 --how far up or down you want the character to be
yy = 0 --dont change this
xx = 0 --or this
bf_xx = 0 --or this
bf_yy = 0 --or this

function onCreatePost()
    yy = getProperty('dad.y')+ofs
    xx = getProperty('dad.x')
  bf_yy = getProperty('boyfriend.y')+ofs
    bf_xx = getProperty('boyfriend.x')
    canFloat = true
end

function onUpdate()
    songPos = getSongPosition()
    local currentBeat = (songPos/5000)*(curBpm/110)
    if canFloat then
        if floatX then
            setProperty('dad.x', amplitudeX*math.cos(currentBeat*speedX)+xx)
      if bfFloat then
        setProperty('boyfriend.x', (amplitudeX*math.cos(currentBeat*speedX)+bf_xx)*-1)
      end
        end
    setProperty('dad.y', amplitudeY*math.sin(currentBeat*speedY)+yy)
    if bfFloat then
          setProperty('boyfriend.y', (amplitudeY*math.sin(currentBeat*speedY)+bf_yy)*-1)
    end
    end
end

function onBeatHit()
    if curBeat == 2905 then
        canFloat = false
defP1X = 80
defP2X = 300
noteScale = 112
function onUpdate(elapsed)
    songPos = getSongPosition()
    currentBeat = (songPos / 600) * (bpm / 130)
        for i=0,3 do
            setPropertyFromGroup('strumLineNotes',i,'x', (defP1X+noteScale*i) + 120 * math.sin(currentBeat/3) + 40)
        end
        for i=4,7 do
            setPropertyFromGroup('strumLineNotes',i,'x', (defP2X+noteScale*i) - 120 * math.sin(currentBeat/3) - 40)
        end

end
end
end