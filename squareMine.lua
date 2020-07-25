function nocobblestone()
  cob="minecraft:cobblestone"
  local item
  for i=1,16 do
      item=turtle.getItemDetail(i)
      if not(turtle.getItemCount(i)==0) then
        if item.name==cob then
          turtle.select(i)
          turtle.drop()
        end
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

function isodd(numb)
  -- Will return true if numb is odd, and false if it is even.
  tst=math.fmod(numb,2)
  if tst==1 then
    return true
  else
    return false
  end
end

print("How far down should the turtle start?")
local nDeep=tonumber(io.read())

print("How big should the squre be on each side")
local sqSize=tonumber(io.read())

for j=1,sqSize do
  for i=1,sqSize do
    clear('up')
    clear('forward')
    clear('down')
    turtle.forward()
  end

  if isodd(j) then
    turtle.turnRight()
  else
    turtle.turnLeft()
  end

  clear('up')
  clear('forward')
  clear('down')
  turtle.forward()
  nocobblestone()

  if isodd(j) then
    turtle.turnRight()
  else
    turtle.turnLeft()
  end

end
