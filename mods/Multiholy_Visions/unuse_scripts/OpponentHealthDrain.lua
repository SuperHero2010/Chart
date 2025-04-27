local enabled = false
local drainAmount = 0
local healthLimit = 0.1 -- Default minimum health

function onEvent(name, value1, value2)
    if name == "OpponentHealthDrain" then
        if value1 == "on" then
            local params = {}
            for num in string.gmatch(value2, "[^,]+") do
                table.insert(params, tonumber(num))
            end
            drainAmount = params[1] or 0.02 -- Default drain
            healthLimit = params[2] or 0.1 -- Default limit
            enabled = true
        elseif value1 == "off" then
            enabled = false
        end
    end
end

function opponentNoteHit()
    local health = getProperty('health')
    if enabled and health > healthLimit then
        setProperty('health', math.max(healthLimit, health - drainAmount))
    end
end
