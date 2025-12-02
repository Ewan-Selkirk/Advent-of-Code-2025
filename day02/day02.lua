local example = [[
11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
1698522-1698528,446443-446449,38593856-38593862,565653-565659,
824824821-824824827,2121212118-2121212124
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

function check_pattern_simple(number)
	local num_string = tostring(number)

	if (#num_string == 1) then return 0 end

	local start_ = num_string:sub(1, #num_string // 2)
	local end_ = num_string:sub(#num_string // 2 + 1, #num_string)

	if (start_ == end_) then return number end

	return 0
end

function check_pattern_complex(number)
	local num_string = tostring(number)

	for i=#num_string, 1, -1 do
		local sub = num_string:sub(1, i)
		local _, count = num_string:gsub(sub, "")

		if count >= 2 then
			-- Little bit of brute forcing tehe
			for x=2, 10 do
				if (num_string == sub:rep(x)) then
					return number
				end
			end
		end
	end

	return 0
end

function part_1()
	local invalid = 0

	for value in read_input():gmatch("[^,]+") do
		local range = {}
		for r in value:gmatch("[^-]+") do
			table.insert(range, tonumber(r))
		end

		for i=range[1],range[2] do
			invalid = invalid + check_pattern_simple(i)
		end
	end

	print("[Part 1] The answer is: " .. invalid)
end

function part_2()
	local invalid = 0

	for value in read_input():gmatch("[^,]+") do
		local range = {}
		for r in value:gmatch("[^-]+") do
			table.insert(range, tonumber(r))
		end

		for i=range[1],range[2] do
			invalid = invalid + check_pattern_complex(i)
		end
	end

	print("[Part 2] The answer is: " .. invalid)
end

part_1()
part_2()