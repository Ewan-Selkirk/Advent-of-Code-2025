local example = [[
.......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
...............
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

function walk_grid(line, column, in_lines, in_splits, part_2)
	part_2 = part_2 or false

	for i=line + 1, #in_lines do
		local char = in_lines[i]:sub(column, column)

		if char == "^" then
			if #in_splits > 0 and not part_2 then
				for _, v in pairs(in_splits) do
					if v == (i .. "," .. column) then
						return in_splits
					end
				end
			end

			if not part_2 then
				table.insert(in_splits, i .. "," .. column)
			end

			if column - 1 >= 1 then walk_grid(i, column - 1, in_lines, in_splits, part_2) end
			if column + 1 <= #in_lines[i] then walk_grid(i, column + 1, in_lines, in_splits, part_2) end

			return in_splits
		end

		if i == #in_lines and part_2 then
			in_splits[column] = in_splits[column] + 1
			return in_splits
		end
	end
end

function part_1()
	local lines = {}
	local splits = {}

	for line in read_input():gmatch("[^\n]+") do lines[#lines + 1] = line end

	local start = lines[1]:find("S")
	splits = walk_grid(1, start, lines, splits)

	print("[Part 1] The answer is: " .. #splits)
end

-- Works for the example, doesn't work with an actual input
function part_2()
	local lines = {}
	local splits = {}

	for line in example:gmatch("[^\n]+") do lines[#lines + 1] = line end
	for i=1, #lines[1] do splits[i] = 0 end

	local start = lines[1]:find("S")
	splits = walk_grid(1, start, lines, splits, true)

	local sum = 0
	for k, v in pairs(splits) do
		sum = sum + v
	end

	print("[Part 2] The answer is: " .. sum)
end

part_1()
part_2()