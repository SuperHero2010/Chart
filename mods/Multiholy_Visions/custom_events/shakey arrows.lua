local defaultNotePos = {};
local spin = false;
local arrowMoveX = 0;
local arrowMoveY = 0;

function onSongStart()
    for i = 0,7 do
        x = getPropertyFromGroup('strumLineNotes', i, 'x')

        y = getPropertyFromGroup('strumLineNotes', i, 'y')

        table.insert(defaultNotePos, {x,y})
      --  debugPrint("{" .. x .. "," .. y .. "}" .. " i:".. i)
    end
end

function onUpdate(elapsed)
    songPos = getPropertyFromClass('Conductor',  'songPosition');

    currentBeat = (songPos / 50) * (bpm / 10)

    if  spin == true then
        for i = 0,3 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + arrowMoveX * math.sin((currentBeat + i*0.1) * math.pi))

            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 2][2] + arrowMoveY * math.cos((currentBeat + i*0.1) * math.pi))
        end
    end
end

function onEvent(name,value1,value2)
	if name == 'shakey arrows' then 
		
		if value1 == 'normal' then
                spin = false;
		end
		if value1 == 'little' then
            spin = true;
            arrowMoveX = 4;
            arrowMoveY = 4;
        end
            if value1 == 'medium' then
                spin = true;
                arrowMoveX = 15;
                arrowMoveY = 15;
            end
                if value1 == 'large' then
                    spin = true;
                    arrowMoveX = 35;
                    arrowMoveY = 25;
		end
	end
end
