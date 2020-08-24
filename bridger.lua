-- Section 1: User input needed for the code to run --------

print("What slot number has bridging material?")
local slotNum=tonumber(io.read())
matName=turtle.getItemDetail(slotNum).name
print("How wide will the bridge be?")
local width=tonumber(io.read())

-- Section 2: Utility Functions ----------------------------

function isodd(numb)
  -- Will return true if numb is odd, and false if it is even.
  tst=math.fmod(numb,2)
  if tst==1 then
    return true
  else
    return false
  end
end

function selectItem(itemName)
  local cont=true
  local i=1
  while cont do
    if turtle.getItemCount(i)>0 then
      if turtle.getItemDetail(i).name==itemName then
        turtle.select(i)
        cont=false
        return true
      end
    end
    i=i+1
    if i==16 and cont then
      print("Warning Item "..itemName.." not found in inventory!")
      cont = false
      return false
    end
  end
end

function clear(direction)
  cont=true
  if direction == nil or direction == 'forward' then
    -- Loop to interate until space in front of turtle is clear
    while cont do
      if turtle.detect() then
        turtle.dig()
      else
        cont=false
      end
    end
  elseif direction == 'up' then
    -- Loop to interate until space in above turtle is clear
    while cont do
      if turtle.detectUp() then
        turtle.digUp()
      else
        cont=false
      end
    end
  elseif direction == 'down' then
    -- Loop to interate until space in below turtle is clear
      turtle.digDown()
    end
  else
    error('function clear called incorrectly')
  end
end

function countItem(itemName)
  count=0
  for i=1,16 do
    if turtle.getItemCount(i)>0 then
      if turtle.getItemDetail(i).name==itemName then
        count=count+turtle.getItemCount(i)
      end
    end
  end
  return count
end

function layBridgeSpot(matName)
  turtle.select(matName)
  clear('up')
  turtle.up()
  clear('up')
  turtle.placeUp()
  turtle.down()
  clear('down')
  turtle.down()
  clear('down')
  turtle.placeDown()
  turtle.up()
end
-- Section 3: Input Checking/correcting --------------------

if turte.getItemCount(slotNum)<1 then
  error('Indicated Item Slot does not have any material within it')
end

--check if turtle has enough Fuel
-- (width-1/2)+
travelDist=


-- Section 4: Main code Starts HERE ------------------------

-- Move turtle into starting position if the width is odd
if isodd(width) then
  turtle.turnLeft()
  for i=1,(width-1)/2 do
    clear()
    turtle.forward()
  end
  turtle.turnRight()
end

-- Calculate how large a bridge the turtle can make
local nSegments = math.floor(countItem(matName)/(2*width))

-- Create the bridge
for i=1,nSegments
  layBridgeSpot()
  for i=1,width-1 do
    turtle.turnRight()
    clear()
    turtle.forward()
    turtle.turnLeft()
    layBridgeSeg()
  end

  turtle.turnLeft()
  for i=1,width-1 do
    turtle.forward()
  end
  turtle.turnRight()

  clear()
  turtle.forward()
end

turtle.turnRight()
turtle.turnRight()
for i=1,nSegments do
  turtle.forward()
end










layBridgeSeg(matName)
