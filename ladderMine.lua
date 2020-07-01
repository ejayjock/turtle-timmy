--[[ script laddermine.lua Rev12 ]]
--[[ The purpose of this script is to use a turtle to dig a mine 3x1 mineshaft straight down, leaving a ladder behind and spacing torches once every 4 levels to provide light.]]
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
local digVal=0

-- Request how deep the ladder mine should be dug
print("How many blocks deep would the mine be?")
nDeep=tonumber(io.read())

-- Confirm input depth is a proper positive number
assert(type(nDeep) == "number","Mine depth must be a number")
assert(nDeep>0,"Mine depth must be > then 0")

-- Check to make sure there is enough ladders in slots 1 and 2
-- first, do ladders exist in slots 1 or two

if turtle.getItemCount(1)~=0 then
  ladderSlot1=turtle.getItemDetail(1).name == "minecraft:ladder"
else
  ladderSlot1=false
end

if turtle.getItemCount(2)~=0 then
  ladderSlot2=turtle.getItemDetail(2).name == "minecraft:ladder"
else
  ladderSlot2=false
end
assert(ladderSlot1 or ladderSlot2,"Turtle must have ladders in slots 1 or 2")

-- count ladders present in slot 1 and 2
nLadders=0;
if ladderSlot1 then nLadders=nLadders+turtle.getItemCount(1) end
if ladderSlot2 then nLadders=nLadders+turtle.getItemCount(2) end
print('turtle found '..nLadders..' ladders in inventory.')

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
  itr=true
  while itr do
    if turtle.detect() then
      turtle.dig(tHand)
    else
      itr=false
    end
  end
end

function fill()
  if not(turtle.detect()) then
    turtle.select(fillSlot)
    turtle.place()
  end
end

function fillGaps(option)
  if option==nil or option=="end" then
    turtle.turnRight()
    fill()
    turtle.turnLeft()
    fill()
    turtle.turnLeft()
    fill()
    turtle.turnRight()
  elseif option=="center" then
    turtle.turnLeft()
    fill()
    turtle.turnLeft() turtle.turnLeft()
    fill()
    turtle.turnLeft()
  else
    error('Utility function fillGaps needs an option')
  end
end

function selectItem(itemName)
  local cont=true
  local i=1
  while cont do
    if turtle.getItemDetail(1).name==itemName then
      turtle.select(i)
      cont=false
    end
    i=i+1
    if i>16 then
      print("Warning Item "..itemName.." not found in inventory!")
      cont = false
    end
  end
end

-- Turtle Minecode
-- Ready the Turtle
print("Making Turtle Ready")
digDown()
turtle.down()
if turtle.down()==true then digVal = 1 else digVal = 0 end
nDug=nDug+digVal

-- Loop through instructions for each level of the mine
local itorch=1
for i = 1,nDeep do
  print("looping: iteration #: "..i)
  -- Clear space under turtle and in front of turtle
  digDown()
  digForward()
  turtle.forward()
  fillGaps('end') -- Replace any missing blocks on the exterior

  -- Put in the ladder for this level
  turtle.back()
  print("Placing Ladder #: ")
  selectItem("minecraft:ladder")
  turtle.place()

  turtle.turnLeft() turtle.turnLeft()

  digForward()
  turtle.forward()
  fillGaps('end')

  turtle.back()
  if itorch==nTourch then
    selectItem("minecraft:torch")
    turtle.place()
    itorch=0
  end

  turtle.turnLeft() turtle.turnLeft()

  if turtle.down()==true then digVal = 1 else digVal = 0 end
  fillGaps('center')
  nDug=nDug+digVal
  itorch=itorch+1
end

for i=1,nDug do
  turtle.up()
end













-- Check that turtle has enough ladders in slots 1 and 2
