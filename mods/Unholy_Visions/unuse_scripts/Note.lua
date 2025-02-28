local holding = {}
local longNoteHealthGain = 0.01 -- Health gained per frame for hitting long notes
local normalNoteHealthGain = 0.002 -- Health gained for hitting normal notes
local missedNoteHealthDeduction = 0.01 -- Health deducted for missing normal notes
local longNoteMissDeductionRate = 1 -- Health deducted per frame for missed long notes

function onUpdatePost()
    for char, isHolding in pairs(holding) do
        if isHolding then
            if char == "boyfriend" then
                setProperty('health', math.min(getProperty('health') + longNoteHealthGain, 2))
            end
        end
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        holding["boyfriend"] = true
    else
        setProperty('health', math.min(getProperty('health') + normalNoteHealthGain, 2))
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        holding["dad"] = true
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
    if isSustainNote then
        local noteLength = getPropertyFromGroup('notes', id, 'sustainLength') or 0
        local framesMissed = math.ceil(noteLength / 16.6667)
        local healthDeduction = framesMissed * longNoteMissDeductionRate
        setProperty('health', math.max(getProperty('health') - healthDeduction, 0))
    else
        setProperty('health', math.max(getProperty('health') - missedNoteHealthDeduction, 0))
    end
end

function noteMissPress()
    holding["boyfriend"] = false
end

function onKeyRelease()
    holding["boyfriend"] = false
end
