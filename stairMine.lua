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

for i=1,5 do
  turtle.digUp()
  turtle.up()
  turtle.digUp() -- This will be a problem
  turtle.down()
  turtle.digDown()
  turtle.down()
  turtle.dig()  -- This is where sand is causing a problem.
  turtle.forward()
end

-- Utility Functions
function clear(direction,hand)
usageStatment="function clear(direction,hand) will dig in the direction specified in the input, using the tool found in the turtle hand until the specified space is empty. Direction may be 'up','down','forward'. If no direction is inut forward will be assumed. Variable hand must be 'left' or 'right'. If hand is omitted it will default to the tool in the right hand".

-- todo: put in a bedrock check.

  args={...};

  if args[2] == nil then
    hand='right'
  elseif args[2]~='left' or args[2]~='right' then
    error(usageStatment)
  end

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
