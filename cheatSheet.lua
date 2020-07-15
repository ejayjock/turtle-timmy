


if turtle.detect() then
  turtle.dig()
end


cont=true
while cont do
  if turtle.detectUp() then
    turtle.digUp()
  else
    cont=false
  end
end

-- Other commands:
turtle.detectUp()
turtle.detectDown()
turtle.digUp()
turtle.digDown()



for i=1,5 do
    --turtle.digUp()
    cont=true
    while cont do
      if turtle.detectUp() then
        turtle.digUp()
      else
        cont=false
      end
    end

    turtle.up()
    --turtle.digUp()
    turtle.down()
    turtle.digDown()
    turtle.down()
    --turtle.dig()
    turtle.forward()
end





for i=1,5 do
  --turtle.digUp()
  cont=true
  while cont do
    if turtle.detectUp() then
      turtle.digUp()
    else
      cont=false
    end
  end
  turtle.up()

  -- turtle.digUp()
  cont=true
  while cont do
    if turtle.detectUp() then
      turtle.digUp()
    else
      cont=false
    end
  end

  turtle.down()
  turtle.digDown()
  turtle.down()

  -- turtle.dig()
  cont=true
  while cont do
    if turtle.detect() then
      turtle.dig()
    else
      cont=false
    end
  end
  turtle.forward()
end
