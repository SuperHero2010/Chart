-- Event notes hooks
function onEvent(name, value1, value2)
	if name == 'Add BPM' then
	thing = value1
        green = tonumber(value2)
        makeLuaText('thebpm', "Current BPM: "..thing, 1275, 2, 200)
        setTextSize('thebpm', 25);
        addLuaText('thebpm');
        if green == 1 then
        setProperty('thebpm.color', getColorFromHex('00FF00'));
        doTweenColor("thebpm", "thebpm", "FFFFFF", 0.4, "sineInOut")
        end
        end
end