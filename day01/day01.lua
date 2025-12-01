local example = [[
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
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

function wrap_number(in_number, change)
	local new_number = in_number + change
	local passed_zero = 0

	if new_number <= 0 then
		passed_zero = passed_zero + math.abs(new_number // 100)

		if new_number % 100 == 0 then
			passed_zero = passed_zero + 1
		end

		if in_number == 0 then
			passed_zero = passed_zero - 1
		end

	elseif new_number > 99 then
		passed_zero = passed_zero + (new_number // 100)
	end

	return new_number % 100, passed_zero
end

function part_1()
	local zero = 0
	local number = 50

	for line in read_input():gmatch("(.-)\n") do
		local operation = line:sub(1, 1)
		local amount = tonumber(line:sub(2, -1))

		if operation == "L" then
			number = wrap_number(number, -amount)
		elseif operation == "R" then
			number = wrap_number(number, amount)
		end

		if number == 0 then
			zero = zero + 1
		end
	end

	print("[Part 1] The password is: " .. zero)
end

function part_2()
	local zero = 0
	local number = 50

	for line in read_input():gmatch("(.-)\n") do
		local operation = line:sub(1, 1)
		local amount = tonumber(line:sub(2, -1))

		if operation == "L" then
			number, passed = wrap_number(number, -amount)
			zero = zero + passed
		elseif operation == "R" then
			number, passed = wrap_number(number, amount)
			zero = zero + passed
		end
	end

	print("[Part 2] The password is: " .. zero)
end

part_1()
part_2()