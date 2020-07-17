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

  -- Utility Functions
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

function clearForward()
  cont=true
  while cont do
    if turtle.detect() then
      turtle.dig()
    else
      cont=false
    end
  end
end

function clear(direction)
  args={...}

  cont=true
  if args[1] == nil or args[1] == 'forward' then
    -- Loop to interate until space in front of turtle is clear
    while cont
      if turtle.detect() then
        turtle.dig()
      else
        cont=false
      end
    end
  elseif args[1] == 'up' then
    -- Loop to interate until space in above turtle is clear
    while cont
      if turtle.detectUp() then
        turtle.digUp()
      else
        cont=false
      end
    end
  elseif args[1] == 'down' then
    -- Loop to interate until space in below turtle is clear
    while cont
      if turtle.detectDown() then
        turtle.digDown()
      else
        cont=false
      end
    end
  else
    error(usageStatment)
  end
end

for i=1,5 do
  clearUp()
  turtle.up()
  clearUp()
  turtle.down()
  turtle.digDown()
  turtle.down()
  clear()
  turtle.forward()
end
