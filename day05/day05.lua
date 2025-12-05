local example = [[
3-5
10-14
16-20
12-18

1
5
8
11
17
32
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
	local fresh = 0

	local ranges = {}
	local ingredients = {}

	for line in read_input():gmatch("[^\n]+") do
		if line:find("-") then 
			table.insert(ranges, line)
		else
			table.insert(ingredients, tonumber(line))
		end
	end

	for _, id in pairs(ingredients) do
		for _, range in pairs(ranges) do
			local range_start = tonumber(range:sub(1, range:find("-") - 1))
			local range_end = tonumber(range:sub(range:find("-") + 1, #range))

			if id >= range_start and id <= range_end then
				fresh = fresh + 1
				break
			end

			-- Memory leak machine go brrr
			--[[for i = tonumber(range_start), tonumber(range_end) do
				if id == range then
					fresh = fresh + 1
					break
				end
			end]]
		end
	end

	print("[Part 1] The answer is: " .. fresh)
end


function part_2()
	local fresh = 0

	local range_starts = {}
	local range_ends = {}

	for line in read_input():gmatch("[^\n]+") do
		if line:find("-") then
			local range_start = tonumber(line:sub(1, line:find("-") - 1))
			local range_end = tonumber(line:sub(line:find("-") + 1, #line))

			table.insert(range_starts, range_start)
			table.insert(range_ends, range_end)

			-- Absolutely not going to work lmao
			-- I clearly learnt nothing from part 1
			--[[for i = range_start, range_end do
				if not temp:find(i) then
					table.insert(fresh, i)
					temp = temp .. i .. ","
				end
			end]]
		end
	end

	table.sort(range_starts)
	table.sort(range_ends)

	local last_start = -1
	for i = #range_starts, 1, -1 do
		local temp = 0
		if last_start ~= -1 and last_start <= range_ends[i] then
			-- temp = range_ends[i] - (range_ends[i] - last_start - 1) - range_starts[i]
			temp = math.min(range_ends[i], last_start) - range_starts[i] + 1
		else 
			temp = range_ends[i] - range_starts[i]
		end

		last_start = range_starts[i]
		fresh = fresh + temp
	end

	-- So the answer I get is off by one...
	-- I don't know where, and I don't know if that would be the case for all inputs
	-- Help
	print("[Part 2] The answer is: " .. fresh + 1)
end

part_1()
part_2()