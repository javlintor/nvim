-- This is a comment 
--
--
local number = 5
local string = "hello, world"
local crazy = [[ This 
is a multi line and literal ]]

local truth, lies = true, false


local nothing = nil


-- functions are first class, meaning you can make them as values
local function hello(name)
	print("Hello!", name)
end

-- functions can be higher order
local higher_order = function(value)
	return function(another)
		return value + another
	end
end

local add_one = higher_order(1)
print("add_one(2) -> ", add_one(2))

-- tables as lists
local list = {"first", 2, false, function () print("Fourth!") end }
print(list[1])

-- tables as maps
local t = {
	literal_key = "a string",
	["an expresion"] = "also works",
	[function() end] = true
}

print("literal key -> " .. t.literal_key)
print(t["an expresion"])
print(t[function() end]) -- prints nil because it is a different function (different pointers)


-- control flow
-- iteration

local favorite_accounts = { "teej_dv", "ThePrimeagen", "terminaldotshop" }
-- # is the length operator
for index = 1, #favorite_accounts do
	print(index, favorite_accounts[index])
end

for index, value in ipairs(favorite_accounts) do
	print(index, value)
end

-- iterate over a map
local reading_scores = { teej_dv = 9.5, ThePrimeagen = "N/A" }

for key, value in pairs(reading_scores) do
	print(key, value)
end

-- if
local function action(loves_coffe)
	if loves_coffe then 
		print("Checkout ssh terminal.shop")
	else 
		print("Heey")
	end
end

--falsy
action(false)
action() --same as action(nil)

--truthy
action(true)
action(0)
action(1)
action({})

-- modules
-- mecanism over policies

-- foo.lua
local M = {}
M.cool_function = function() end
return M

-- bar.lua
-- assuming foo.lua is in runtime path
local foo = require('foo')
foo.cool_function()

-- unpacking values
local return_four_values = function()
	return 1, 2, 3, 4
end

first, second, last = return_four_values()
print(first, second, last) -- 4 is discarded

-- string shorthand
local single_string = function(s)
	return s .. "WOW" -- concatenation
end

local x = single_string("hi")
local y = single_string "hi"

print(x, y)

-- table shorthand
-- default values

local setup = function(opts)
	if opts.default == nil then
		opts.default = 17
	end

	print(opts.default, opts.other)
end

setup { default = 12, other = false }
setup { other = true }

-- metatables
-- they change behaviour in tables, similar to thunder methods in Pytnon

local vector_mt = {}
vector_mt.__add = function(left, right)
	return setmetatable({
		left[1] + right[1], 
		left[2] + right[2],
		left[3] + right[3],
	}, vector_mt)
end

local v1 = setmetatable({3, 1, 5}, vector_mt)
local v2 = setmetatable({-3, 2, 2}, vector_mt)
local v3 = v1 + v2
vim.print(v3[1], v3[2], v3[3])
vim.print(v3 + v3)

-- the other cool metamethod is __index
local fib_mt = {
	__index = function(self, key)
		if key < 2 then return 1 end
		self[key] = self[key - 2] + self[key - 1]
		return self[key]
	end
}

local fib = setmetatable({}, fib_mt)
print(fib[10])
for key, value in pairs(fib) do
	print(key, value)
end


