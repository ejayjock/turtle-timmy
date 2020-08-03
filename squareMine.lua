-- Section 1: User input needed for the code to run --------

print("How deep?")
local nDeeep=tonumber(io.read())

print("how many blocks on a side?")
local sqaresize=tonumber(io.read())

-- Section 2: Utility Functions ----------------------------

function nojunk()
  local cob="minecraft:cobblestone"
  local stone="minecraft:stone"
  local dirt="minecraft:dirt"
  local gravel="minecraft:gravel"
  local sand="minecraft:sand"
  local sandstone="minecraft:sandstone"
  local dump=false
  local item
  for i=1,16 do
      if not(turtle.getItemCount(i)==0) then
        item=turtle.getItemDetail(i)
        dump=(item.name==cob or item.name==stone or item.name==dirt or item.name==gravel or item.name==sand or item.name==sandstone)
        if dump then
          turtle.select(i)
          turtle.drop()
        end
      end
  end
end

function clearUp()
  cont=true
  while cont do
    if turtle.detectUp() then
      turtle.digUp()
    else
      cont=false
    end
  end
end

function clear()
  cont=true
  while cont do
    if turtle.detect() then
      turtle.dig()
    else
      cont=false
    end
  end
end

-- If input numb is odd it will return a True
function isodd(numb)
  -- Will return true if numb is odd, and false if it is even.
  tst=math.fmod(numb,2)
  if tst==1 then
    return true
  else
    return false
  end
end

-- Checks to see if inventory is approaching full
-- It will return True if 1 or less slots are available
function invenCheck()
  local emptySlots=0
  for i=1,16 do
    if turtle.getItemCount(i)==0 then
      emptySlots=emptySlots+1
    end
  end

  -- If 1 or less slots are empty
  if emptySlots>1 then
    return false
  else
    return true
  end
end

-- Stacks similar items to maximimize inventory space
function orgInv()
  print('Organizing Inventory Slots')
  for i=1,16 do
    print('Checking Slot Number'..i)
    turtle.select(i)
    for j=1,16 do
      if not(i==j) then
        if turtle.getItemCount()>0 then
          if turtle.compareTo(j) then
            turtle.select(j)
            turtle.transferTo(i)
            turtle.select(i)
          end
        end
      end
    end
  end
end

-- Section 3: Input Checking/correcting --------------------

-- Code fails if square size is odd
-- This will add one to the squaresize if it is odd
if isodd(sqaresize) then
  sqaresize = sqaresize+1
end

-- Fuel Check
travelDist = 2*nDeeep + sqaresize*sqaresize
if turtle.getFuelLevel()<travelDist then
  error('Turtle does not have enough Fuel.')
end

-- Section 4: Main code Starts HERE ------------------------

-- Part 1: turtle goes down nDeeep levels
for v=1,nDeeep do
  turtle.digDown()
  turtle.down()
end

-- Part 2: turtle mines out the square
for j=1,sqaresize do
  for i=1,sqaresize do
    clearUp()
    clear()
    turtle.digDown()
    turtle.forward()
  end

  if isodd(j) then
    turtle.turnRight()
  else
    turtle.turnLeft()
  end

  clearUp()
  clear()
  turtle.digDown()
  turtle.forward()
  nojunk()

  if isodd(j) then
    turtle.turnRight()
  else
    turtle.turnLeft()
  end
end

-- Part 3: turtle goes back to starting point
turtle.turnLeft()
for k=1,sqaresize do
  turtle.forward()
end

-- Part 4: turtle goes back up.
for o=1,nDeeep do
  turtle.digUp()
  turtle.up()
end
