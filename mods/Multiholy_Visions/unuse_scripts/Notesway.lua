function onEvent(name, value1, value2)
    if name == 'Notesway' then

function onStepHit()
    if curstep == 1000 then
        canFloat = false
    end
end

defP1X = 80
defP2X = 300
noteScale = 112
function onUpdate(elapsed)
    songPos = getSongPosition()
    currentBeat = (songPos / 'value1') * (bpm / 'value2')
        for i=0,3 do
            setPropertyFromGroup('strumLineNotes',i,'x', (defP1X+noteScale*i) + 300 * math.sin(currentBeat/3) + 350)
        end
        for i=4,7 do
            setPropertyFromGroup('strumLineNotes',i,'x', (defP2X+noteScale*i) - 300 * math.sin(currentBeat/3) - 350)
        end
end