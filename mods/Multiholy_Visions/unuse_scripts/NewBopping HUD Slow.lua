local zoomshit = 0;
local bopShit = false
function onEvent(eventName, value1, value2)
    if eventName == 'NewBopping HUD Slow' then
        if value1 == 'on' then
            bopShit = true
        end
        if value2 == 'off' then
            bopShit = false
        end
    end
end
function onBeatHit()
	if bopShit == true then

		if curBeat % 4 == 0 then
			setProperty('camHUD.angle', 4*1)
			doTweenAngle('hudTween', 'camHUD', 0, 2, 'backOut')
			triggerEvent('Add Camera Zoom', '0', '0.06')
		end
		if curBeat % 8 == 0 then
			setProperty('camHUD.angle', 4*-1)
			doTweenAngle('hudTween', 'camHUD', 0, 2, 'backOut')
                  triggerEvent('Add Camera Zoom', '0', '0.06')
                  
              

		end
	end
end

