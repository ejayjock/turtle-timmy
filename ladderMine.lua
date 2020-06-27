--[[ script laddermine.lua Rev04 ]]
--[[ The purpose of this script is to use a turtle to dig a mine 2x1 mineshaft down straight down, leaving a ladder behind and spacing torches once every 4 levels to provide light.]]
--[[ How to prepare the turtle: ]]
--[[ The turtle must have a tool in its main (right) hand. It is suggested that tool be tool be a pick ax so the turtle will properly collect what it mines. ]]
--[[ The turtle should have ladders in inventory spots 1, 2 ]]
--[[ The turtle should have torches in inventory spot 3 ]]
--[[ On running the command the turtle will ask how many spaces down the mine should be. A number greater than 1 should be given.]]
--[[ Slot 16 is reserved for filler in case the turtle runs into lava or water or a natural cave.]]

-- setup variables
local nDeep
local tHand="right"
local nDug=0
local nTourch=4
local fillSlot=16

-- Request how deep the ladder mine should be dug
print("How many blocks deep would the mine be?")
nDeep=io.read()

-- Confirm input depth is a proper positive number
assert(type(nDeep) == "number","Mine depth must be a number")
assert(nDeep>0,"Mine depth must be > then 0")

-- Check to make sure there is enough ladders in slots 1 and 2
-- first, do ladders exist in slots 1 or two
ladderSlot1=turtle.getItemDetail(1).name == "minecraft:ladder"
ladderSlot2=turtle.getItemDetail(2).name == "minecraft:ladder"
assert(ladderSlot1 or ladderSlot2,"Turtle must have ladders in slots 1 or 2")

-- count ladders present in slot 1 and 2
nLadders=0;
if ladderSlot1 then nLadders=nLadders+turtle.getItemDetails.number(1) end
if ladderSlot2 then nLadders=nLadders+turtle.getItemDetails.number(2) end

-- Check to make sure number of ladders is greater then depth of the mines
assert(nLadders>=nDeep,"Only "..nLadders.." found in inventory. Turtle must have at least as many ladders as the mine is deep.")

-- Check that slot 16 has something

-- Check that slot 3 has enough tourches

-- Check turtle has enough fuel

-- Utility Functions
function digDown(tHand)
  if tHand==nil then tHand="right" end
  if turtle.detectDown() then turtle.digDown(tHand) end
end

function digForward(tHand)
  if tHand==nil then tHand="right" end
  if turtle.detect() then turtle.dig(tHand) end
end

function fill()
  if not(turtle.detect()) then
    turle.select(fillSlot)
    turtle.place()
  end
end

function fillGaps()
  for i=1,3 do
    turtle.turnLeft()
    fill()
  end
  turtle.turnLeft()
end

function selectItem(itemName)
  local cont=true
  local i=1
  while cont do
    if turtle.getItemDetail(i)==itemName then
      turtle.select(i)
      cont=false
    end
    i=i+1
    if i>16 then
      print("Warning Item "..itemNamecont.." not found in inventory!")
      cont = false
    end
  end
end


-- Ready the Turtle
digDown()
turtle.down()
nDug=nDug+1

-- Loop through instructions for each level of the mine
for i = 1,nDeep do
  -- Clear space under turtle and in front of turtle
  digDown()
  digForward()

  -- Replace any missing blocks on the exterior
  fillGaps()

  -- Put in the ladder for this level
  turtle.turnRight()
  selectItem("minecraft:ladder")
  turtle.place()
  turtle.turnLeft()

  turtle.forward()
  if math.fmod(nDug,nTourch)==0 then
    selectItem("minecraft:torch")
    turtle.place()
  end
  turtle.turnLeft() turtle.turnLeft()
  fillGaps()

  turtle.down()
  nDug=nDug+1
end

for i=1,nDeep do
  turtle.up()
end













-- Check that turtle has enough ladders in slots 1 and 2
