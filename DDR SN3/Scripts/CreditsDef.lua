--loader for a simple file format used to define the credits list

CreditsDef = {}

--takes a line of input and a reference to the current variables
--returns a boolean indicating if this line should be ignored and the text or nil if there isn't any.
local function line_action(line, variables)
	line = trim_whitespace(line)
	if line == "" then
		--section separator
		return false, nil
	end
	local first_char = line:sub(1,1)
	if first_char == '!' then
		--comment
		return true, nil
	elseif first_char == '=' then
		--variable usage
		local value = variables[line:sub(2)]
		if value then
			return false, value
		else
			error("variable "..value.." was not defined yet")
		end
	elseif line:find('=') then
		--text and variable definition
		local text, var_name = line:match("([^=]*)=(.*)")
		if variables[var_name] then
			error("attempted to redefine variable "..var_name)
		end
		variables[var_name] = text
		return false, text
	else
		--plain old text
		return false, line
	end
end

--input: path to the file to read
--output: a table of tables, each containing strings.
function CreditsDef.Load(file)
	local output = {{}}
	local current_section = output[1]
	local name_variables = {BLANK=""}
	local results
	local line_counter = 0
	while not file:AtEOF() do
		line_counter = line_counter + 1
		results = {pcall(line_action,file:GetLine(),name_variables)}
		if results[1] then
			if not results[2] then
				local text = results[3]
				if not text then
					if #current_section > 0 then
						local new_index = #output+1
						output[new_index] = {}
						current_section = output[new_index]
					end
				else
					current_section[#current_section+1] = text
				end
			end
		else
			error(string.format("line %d: %s",line_counter,results[2]))
		end
	end
	if #(output[#output]) == 0 then
		output[#output] = nil
	end
	return output
end