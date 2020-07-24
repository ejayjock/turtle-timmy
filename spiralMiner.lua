-- function spiralMine()
-- Spiral mine will dig a square area out using the starting point as the center of the spiral.
-- The code will mine in a spiarl until the inventory is full.

-- Code Setup Area

local fillSlot=1
local dist=1
local sqSize=10

-- Utility Functions
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
    while cont do
      if turtle.detectDown() then
        turtle.digDown()
      else
        cont=false
      end
    end
  else
    error('function clear called incorrectly')
  end
end

function mineAll(fillSlot)
  if not turtle.detectDown() then
    turtle.select(fillSlot)
    turtle.placeDown()
  end
  turtle.digDown()

  if not turtle.detect() then
    turtle.select(fillSlot)
    turtle.place()
  end
  clear('forward')

  if not turtle.detectUp() then
    turtle.select(fillSlot)
    turtle.placeUp()
  end
  clear('up')

  turtle.forward()
end

function invFull(fillMat)
  -- check if inventory is full, if throw out all but one cobble stone

end
-- Main Code

mineAll(fillSlot)
turtle.left()
mineAll(fillSlot) dist=dist+1

cont=true
local i=1
local j=1
while cont do
  for k=1,2 do
    turtle.left()
    for l=1,i do
      if dist >= sqSize*sqSize or invFull() then
        cont=false
      else
        mineAll(fillSlot) dist=dist+1
      end
    end
  end
end
