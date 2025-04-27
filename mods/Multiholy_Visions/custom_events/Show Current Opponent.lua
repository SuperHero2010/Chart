-- Event notes hooks
function onEvent(name, value1, value2)
	if name == 'Show Current Opponent' then
        green = tonumber(value2)
        makeLuaText('theoppo', "Current Opponent: "..value1, 1275, 2, 175)
        setTextSize('theoppo', 25);
        addLuaText('theoppo');
        if green == 1 then
        setProperty('theoppo.color', getColorFromHex('00FF00'));
        doTweenColor("theoppo", "theoppo", "FFFFFF", 0.4, "sineInOut")
        end
        end
end