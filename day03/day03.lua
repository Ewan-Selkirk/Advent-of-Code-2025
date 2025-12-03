local example = [[
987654321111111
811111111111119
234234234234278
818181911112111
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

function part_1()
	local joltage = 0

	for line in read_input():gmatch("[^\n]+") do
		local value = nil
		local highest_pos = nil

		for battery=1, #line - 1 do
			local digit = line:sub(battery, battery)

			if value == nil or digit > value then
				value = digit
				highest_pos = battery
			end
		end

		for battery=highest_pos + 1, #line do
			local digit = line:sub(battery, battery)

			if tostring(value):sub(2, 2) == "" or digit > tostring(value):sub(2, 2) then
				value = tostring(value):sub(1,1) .. digit
			end
		end
		joltage = joltage + value
	end

	print("[Part 1] The answer is: " .. joltage)
end

-- function part_2()
-- 	local joltage = 0

-- 	for line in read_input():gmatch("[^\n]+") do
-- 		local value = nil
-- 		local left_edge = 0

-- 		for battery=1, #line do
-- 			local orig_window_size = #line:sub(battery, battery + 3)
-- 			local window = line:sub(battery + left_edge, #value - left_edge)
-- 			local window_table = {}

-- 			-- print(window)

-- 			if orig_window_size < 4 then break end

-- 			for i in window:gmatch("%d") do window_table[#window_table + 1] = i end
-- 			local largest = math.max(table.unpack(window_table))

-- 			if left_edge == 0 then
-- 				left_edge = window:find(largest) - 1
-- 			elseif left_edge ~= 3 then
-- 				left_edge = left_edge + window:find(largest) - 1
-- 			end

-- 			if value == nil then
-- 				value = largest
-- 			else
-- 				if #value == 12 then
-- 					if largest > value:sub(12, 12) then
-- 						value = value:sub(1, 11) .. largest
-- 					end
-- 				else
-- 					value = value .. largest
-- 				end
-- 			end

-- 			print(battery, value)
-- 		end

-- 		-- print(value)
-- 		joltage = joltage + (value ~= nil and value or 0)
-- 	end

-- 	print("[Part 2] The answer is: " .. joltage)
-- end


-- I had to look up solutions to get this :'(
-- Leaving my awful attempt above to show my failure
function part_2()
	local joltage = 0

	for line in read_input():gmatch("[^\n]+") do
		local batteries_left = 12
		local last_index = 0
		local numbers = {}
		local temp_value = {}

		for d in line:gmatch("%d") do numbers[#numbers + 1] = tonumber(d) end
		local can_take = #numbers - batteries_left - last_index

		while batteries_left > 0 do
			local largest = nil

			for i = last_index + 1, last_index + 1 + can_take do
				if numbers[i] > largest then
					largest, last_index = numbers[i], i
				end
			end

			batteries_left = batteries_left - 1
			can_take = #numbers - batteries_left - last_index

			table.insert(temp_value, largest)
		end

		joltage = joltage + table.concat(temp_value)
	end

	print("[Part 2] The answer is: " .. joltage)
end

part_1()
part_2()