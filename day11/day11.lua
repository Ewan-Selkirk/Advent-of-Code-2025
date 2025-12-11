local example_1 = [[
aaa: you hhh
you: bbb ccc
bbb: ddd eee
ccc: ddd eee fff
ddd: ggg
eee: out
fff: out
ggg: out
hhh: ccc fff iii
iii: out
]]

local example_2 = [[
svr: aaa bbb
aaa: fft
fft: ccc
bbb: tty
tty: ccc
ccc: ddd eee
ddd: hub
hub: fff
eee: dac
dac: fff
fff: ggg hhh
ggg: out
hhh: out
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

function table.find(in_table, value)
	for _, v in pairs(in_table) do 
		if v == value then return true end
	end

	return false
end

function find_out(labels, servers, part_2, path, depth)
	part_2 = part_2 or false
	path = path or {}
	depth = depth or 1

	local counter = 0
	for _, v in pairs(labels) do
		if v == "out" then 
			if not part_2 or (part_2 and table.find(path, "fft") and table.find(path, "dac")) then
				return 1 
			else
				return 0
			end
		end

		if part_2 then
			path[depth] = v
			depth = depth + 1
		end

		counter = counter + find_out(servers[v], servers, part_2, path, depth)
	end

	return counter
end

function part_1()
	local servers = {}
	local paths = 0

	for line in read_input():gmatch("[^\n]+") do
		local key = nil
		local connections = {}
		local index = 1

		for con in line:gmatch("[^(.+): ]+") do
			if index == 1 then
				key = con
			else
				table.insert(connections, con)
			end

			index = index + 1
		end

		servers[key] = connections
	end

	paths = paths + find_out(servers["you"], servers)
	print("[Part 1] The answer is: " .. paths)
end

function part_2()
	local servers = {}
	local paths = 0

	for line in example_2:gmatch("[^\n]+") do
		local key = nil
		local connections = {}
		local index = 1

		for con in line:gmatch("[^(.+): ]+") do
			if index == 1 then
				key = con
			else
				table.insert(connections, con)
			end

			index = index + 1
		end

		servers[key] = connections
	end

	paths = paths + find_out(servers["svr"], servers, true)
	print("[Part 2] The answer is: " .. paths)
end

part_1()
part_2()