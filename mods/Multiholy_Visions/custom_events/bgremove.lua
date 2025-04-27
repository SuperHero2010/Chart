function onEvent(name, value1, value2)
    if name == 'bgremove' then
        if value1 ~= '' and getProperty(value1..'.exists') then
            removeLuaSprite(value1, true)
        end
    end
end
