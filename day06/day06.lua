local example = [[
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
]]

function read_input()
	local file = io.open("input", "r")
	if not file then 
		print("Failed to find an input file!")
		return nil 
	end

	local content = file:read "*a"
	file:close()

	return content
end

function sum_table(t, o)
	local temp_value = 0
	for _, v in pairs(t) do
		if o == "+" then
			temp_value = temp_value + tonumber(v)
		else
			if temp_value == 0 then
				temp_value = tonumber(v)
			else
				temp_value = temp_value * (tonumber(v) > 0 and tonumber(v) or 1)
			end
		end
	end

	return temp_value
end

function part_1()
	local calculation = 0
	local lines = {}

	local elements = {}
	local operations = {}

	for l in read_input():gmatch("[^\n]+") do lines[#lines + 1] = l end

	for line=1, #lines do
		if line == #lines then
			for op in lines[line]:gmatch("%p") do
				operations[#operations + 1] = op
			end
		else
			local elem_index = 1

			for value in lines[line]:gmatch("%d+") do
				if elements[elem_index] == nil then
					elements[elem_index] = {value}
				else
					elements[elem_index][line] = value
				end

				elem_index = elem_index + 1
			end
		end
	end

	for i=1, #elements do
		calculation = calculation + sum_table(elements[i], operations[i])
	end

	print("[Part 1] The answer is: " .. calculation)
end

-- This is embarrassingly shit oh my GOD
function part_2()
	local calculation = 0
	local max_height = 0
	local lines = {}

	local digits = {}
	local operations = {}

	local max_widths = {}
	local starts = {}

	local function search_table(t, e)
		for k, v in pairs(t) do
			if v == e then
				return true, k
			end
		end

		return false, -1
	end

	for l in read_input():gmatch("[^\n]+") do lines[#lines + 1] = l end
	for o = 1, #lines[#lines] do
		local char = lines[#lines]:sub(o, o)

		if char ~= " " then
			local width = 1
			table.insert(operations, char)

			while lines[#lines]:sub(o + width, o + width) == " " do
				width = width + 1
			end

			table.insert(starts, o)
			table.insert(max_widths, width - 1)
		end
	end

	max_height = #lines - 1
	max_widths[#max_widths] = max_widths[#max_widths] + 1

	-- oh my god just let it go at this point
	for x=1, #lines[1] do
		local temp_table = {}

		for y=1, max_height do
			table.insert(temp_table, lines[y]:sub(x, x))
		end

		table.insert(digits, temp_table)
	end

	local final_final_table_final_v3_final_fuck_final = {}
	for k, v in pairs(starts) do
		local temp_table = {}

		for i=0, max_widths[k] - 1 do
			table.insert(temp_table, tonumber(table.concat(digits[v + i])))
		end

		table.insert(final_final_table_final_v3_final_fuck_final, temp_table)
	end

	for k, v in pairs(final_final_table_final_v3_final_fuck_final) do
		calculation = calculation + sum_table(v, operations[k])
	end

	-- This day can absolutely go fuck itself
	-- Check a look the graveyard of awful ideas
	-- This day took 7 hours... I need a drink...

	--[[for k, v in pairs(starts) do
		local temp_table = {}

		for i=v, v + max_widths[k] do
			print(k, read_input():sub(i, i))

			if i ~= v + max_widths[k] then
				table.insert(temp_table[], {read_input():sub(i, i)})
			end
		end

		table.insert(digits, temp_table)
	end]]

	--[[max_height = #lines - 1
	for y=1, max_height do
		local elem_index = 1

		for x=1, #lines[y] do
			if x % (max_width + 1) ~= 0 then 
				if digits[elem_index] == nil then
					digits[elem_index] = {lines[y]:sub(x, x)}
				else
					digits[elem_index][y] = lines[y]:sub(x, x)
				end

				elem_index = elem_index + 1
			end
		end
	end]]

	--[[local final_table = {}
	for i=1, #digits do
		if digits[i] ~= nil then
			local value = tonumber(table.concat(digits[i]))

			if value ~= nil then final_table[#final_table + 1] = value end
		end
	end

	local c = 1
	for _, w in pairs(max_widths) do
		while c < (#final_table // w) + 1 do
			local final_final_table_final_v3_final_fuck_final = {}
			for i=1, max_height do
				table.insert(final_final_table_final_v3_final_fuck_final, final_table[i + (max_width * (c - 1))])
			end

			print(table.unpack(final_final_table_final_v3_final_fuck_final))
			-- print(operations[c])

			calculation = calculation + sum_table(final_final_table_final_v3_final_fuck_final, operations[c])
			c = c + 1
		end
	end]]

	print("[Part 2] The answer is: " .. calculation)
end

part_1()
part_2()