local activeStages = {}

function onEvent(name, value1, value2)
    if name == 'stage test' then
        if value1 ~= '' and not activeStages[value1] then
            addLuaScript('stages/'..value1)
            loadScript(value1, true)
            activeStages[value1] = true  -- Mark as loaded
        end

        if value2 ~= '' and activeStages[value2] then
            removeLuaScript('stages/'..value2)
            removeLuaSprite(value2, true)
            activeStages[value2] = nil  -- Mark as removed
        end
    end
end
