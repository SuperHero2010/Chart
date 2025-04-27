local zoomshit = 0;
local bopShit = false
function onEvent(eventName, value1, value2)
    if eventName == 'NewBopping HUD Fast' then
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

		if curBeat % 1 == 0 then
			setProperty('camHUD.angle', 2*1)
			doTweenAngle('hudTween', 'camHUD', 0, 2.8, 'backOut')
			triggerEvent('Add Camera Zoom', '0', '0.001')
		end
		if curBeat % 2 == 0 then
			setProperty('camHUD.angle', 2*-1)
			doTweenAngle('hudTween', 'camHUD', 0, 2.8, 'backOut')
                  triggerEvent('Add Camera Zoom', '0', '0.001')
                  
              

		end
	end
end

