--------------------------------------------------------------------------------
-- Lookup
--------------------------------------------------------------------------------

local colors = {}

local _named = {}

local ansi_lookup = {
    ['black']     = 0,
    ['red']       = 1,
    ['green']     = 2,
    ['yellow']    = 3,
    ['blue']      = 4,
    ['magenta']   = 5,
    ['cyan']      = 6,
    ['white']     = 7,
    ['brblack']   = 8,
    ['brred']     = 9,
    ['brgreen']   = 10,
    ['bryellow']  = 11,
    ['brblue']    = 12,
    ['brmagenta'] = 13,
    ['brcyan']    = 14,
    ['brwhite']   = 15
}

function colors.name_to_ansi_index(name)
    if string.sub(name, 1, 5) == 'ansi_' then
        name = string.sub(name, 6, -1)
    else
        error('colors.name_to_ansi_index expects string with format: `ansi_{name}`, received: `' .. name .. '`', 2)
    end

    if string.len(name) <= 0 then
        error('colors.name_to_ansi_index expects string with format: `ansi_{name}`, received empty string.', 2)
    end

    local result = ansi_lookup[name]

    if result == nil then
        error('colors.name_to_ansi_index did not find `' .. name .. '`, expected format is: `ansi_{name}`.', 2)
    end

    return result
end

function colors.index_to_name(index)
    if index < 0 or index > 15 then
        error('colors.index_to_name expects integer 0 -> 15, received: ' .. index, 2)
    end
    return _named['i' .. index]
end

function colors.named(name)
    return _named[name]
end

function colors.hash(name)
    return '#' .. _named[name]
end

function colors.zerox(name)
    return '0x' .. _named[name]
end

--------------------------------------------------------------------------------
-- Entry point
--------------------------------------------------------------------------------

function colors.print_colors()
    parse_colors()

    -- TODO: Use terminal escape codes to colorize output
    for k, v in pairs(_named) do
        print(k .. ": " .. v)
    end
end

--------------------------------------------------------------------------------
-- Parser
--------------------------------------------------------------------------------

function colors.parse_colors()
    colorsFile = os.getenv('XDG_CONFIG_HOME') .. '/colors/colors'

    local f = io.open(colorsFile, 'r')

    if f == nil then
        error('Could not open file: ' .. colorsFile)
    end

    local lines = io.lines(colorsFile) 

    for line in lines do
        local key = nil
        local value = nil
        local assignment_op = false
        local lookup = false

        for i = 1, #line do
            local c = line:byte(i)

            -- Space, keep reading
            if c == string.byte(' ') then
                goto continue

            -- Hash after assignment, char is ignored, but continue parsing value.
            -- Hash before assignment, line is skipped.
            elseif c == string.byte('#') then
                if assignment_op == true then
                    goto continue
                else
                    key = nil
                    value = nil
                    break
                end

            -- Quote, only allowed after assignment
            elseif c == string.byte('\'') then
                if assignment_op == true then
                    goto continue
                else
                    error('Unable to continue parsing, expected character [' .. c .. '] only after assignment.')
                end

            -- Dollar, only allowed after assignment
            elseif c == string.byte('$') then
                if assignment_op == true then
                    lookup = true
                    goto continue
                else
                    error('Unable to continue parsing, expected character [' .. c .. '] only after assignment.')
                end

            -- Alphanumeric or underscore, append to either key or value
            elseif string.match(string.char(c), '[%w_]') ~= nil then
                if assignment_op == false then
                    if key == nil then
                        key = ''
                    end
                    key = key .. string.char(c)
                else
                    if value == nil then
                        value = ''
                    end
                    value = value .. string.char(c)
                end

            -- Assignment operator reached, keep reading for value
            elseif c == string.byte('=') then
                if assignment_op == false then
                    assignment_op = true
                    goto continue
                end

            else
                error('Unable to continue parsing, unexpected character [' .. c .. '].')

            end

            -- Lua doesn't have the typical continue operator, so we use `goto`.
            ::continue::
        end

        -- Assign value
        if key ~= nil and value ~= nil then
            if lookup == true then
                _named[key] = _named[value]
            else
                _named[key] = value
            end
        end

    end
end

return colors

