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