local example = [[
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
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

function check_surrounding(grid, row, column)
	local count = 0

	local inner_grid = {}
	for y = -1, 1 do
		for x = -1, 1 do
			if not (column + y < 1 or column + y > #grid or row + x < 1 or row + x > #grid[1]) then
				inner_grid[#inner_grid + 1] = grid[column + y][row + x]
			end
		end
	end

	-- Subtract 1 as it insists upon itself
	if select(2, table.concat(inner_grid):gsub("@", "")) - 1 < 4 then
		return 1
	else
		return 0
	end
end

function part_1()
	local rolls = 0
	local grid = {}

	for line in read_input():gmatch("[^\n]+") do
		local row = {}

		for char in line:gmatch(".") do row[#row + 1] = char end
		table.insert(grid, row)	
	end

	for y = 1, #grid do
		for x = 1, #grid[y] do
			if grid[y][x] ~= "." then rolls = rolls + check_surrounding(grid, x, y) end
		end
	end

	print("[Part 1] The answer is: " .. rolls)
end


function part_2()
	local rolls = 0
	local grid = {}

	for line in read_input():gmatch("[^\n]+") do
		local row = {}

		for char in line:gmatch(".") do row[#row + 1] = char end
		table.insert(grid, row)	
	end

	local still_going = true
	while still_going do
		local removed = 0
		for y = 1, #grid do
			for x = 1, #grid[y] do
				if grid[y][x] ~= "." then 
					local can_be_removed = check_surrounding(grid, x, y)
					if can_be_removed == 1 then 
						grid[y][x] = "."
						removed = removed + 1
					end
				end
			end
		end

		if removed == 0 then still_going = false end

		rolls = rolls + removed
	end

	print("[Part 2] The answer is: " .. rolls)
end

part_1()
part_2()