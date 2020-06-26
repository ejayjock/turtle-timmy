--[[ script laddermine.lua ]]
--[[ The purpose of this script is to use a turtle to dig a mine 2x1 mineshaft down straight down, leaving a ladder behind and spacing torches once every 4 levels to provide light.]]
--[[ How to prepare the turtle: ]]
--[[ The turtle must have a tool in its main (right) hand. It is suggested that tool be tool be a pick ax so the turtle will properly collect what it mines. ]]
--[[ The turtle should have ladders in inventory spots 1, 2 ]]
--[[ The turtle should have torches in inventory spot 3 ]]
--[[ On running the command the turtle will ask how many spaces down the mine should be. A number greater than 1 should be given.]]

-- setup variables
local nDeep

-- Request how deep the ladder mine should be dug
print("How many blocks deep would the mine be?")
nDeep=io.read()

-- Confirm input depth is a proper positive number
assert(type(nDeep) == "number","Mine depth must be a number")
assert(nDeep>0,"Mine depth must be > then 0")

-- Check to make sure there is enough ladders in slots 1 and 2




-- Check that turtle has enough ladders in slots 1 and 2
