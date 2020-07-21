--[[ Code to be repeated to create a staircase mine
Series of turtle commands:
  - Dig Up
  - Move Up
  - Dig Up
  - Move down
  - dig down
  - move down
  - dig Forward
  - move forward ]]

function selectItem(name)
  -- check all inventory slots
  local item
  for slot = 1, 16 do
    item = turtle.getItemDetail(slot)
    if item ~= nil and item['name'] == name then
      turtle.select(slot)
      return true
    end
  end
  return false  -- couldn't find item
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

function fillDown(matName)
  if not turtle.detectDown() then
    selectItem(matName)
    turtle.placeDown()
  end
end



print("how deep?")
nDeep=tonumber(io.read())

print("Which number slot has filler material")
iMatLoc=tonumber(io.read())
fillMatName=turtle.getItemDetail(iMatLoc).name
print("Fill Material: "..fillMatName)

-- Stair mining code
for i=1,nDeep do
  clear('up')
  turtle.up()
  clear('up')
  turtle.down()
  turtle.digDown()
  turtle.down()
  fillDown(fillMatName)
  clear('forward')
  turtle.forward()
end
