print("How deep?")
local nDeeep=tonumber(io.read())

print("how many blocks on a side?")
local sqaresize=tonumber(io.read())

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

function isodd(numb)
  -- Will return true if numb is odd, and false if it is even.
  tst=math.fmod(numb,2)
  if tst==1 then
    return true
  else
    return false
  end
end

-- turtle goes down nDeeep levels
for v=1,nDeeep do
  turtle.digDown()
  turtle.down()
end
-- turtle mines out the square
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

-- turtle goes back to starting point
turtle.turnLeft()
for k=1,sqaresize+1 do
  turtle.forward()
end

-- turtle goes back up.
for o=1,nDeeep do
  turtle.digUp()
  turtle.up()
end
