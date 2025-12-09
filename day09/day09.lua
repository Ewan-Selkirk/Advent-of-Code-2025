local example = [[
7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3
]]

function calculate_area(a, b)
	local top_left = math.abs(a[1] - b[1]) + 1
	local bottom_right = math.abs(a[2] - b[2]) + 1

	return top_left * bottom_right
end

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
	local positions = {}
	local largest = 0

	for line in read_input():gmatch("[^\n]+") do 
		local dims = {}
		for dim in line:gmatch("[^,]+") do
			table.insert(dims, dim)
		end

		positions[#positions + 1] = dims
	end

	for i=1, #positions do
		for j=1, #positions do
			if i ~= j then
				local area = calculate_area(positions[i], positions[j])
				if area > largest then largest = area end
			end
		end
	end

	print("[Part 1] The answer is: " .. largest)
end

function part_2()
	
end

part_1()
part_2()