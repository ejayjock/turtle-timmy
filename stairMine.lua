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
    turtle.digUp()
    turtle.down()
    turtle.digDown()
    turtle.down()
    turtle.dig()
    turtle.forward()
  end
