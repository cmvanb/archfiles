--------------------------------------------------------------------------------
-- Lookup
--------------------------------------------------------------------------------

local colors = {}

local _named = {}

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

