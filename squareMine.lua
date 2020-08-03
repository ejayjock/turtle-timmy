print("How deep?")
local nDeeep=tonumber(io.read())

print("how many blocks on a side?")
local sqaresize=tonumber(io.read())

-- Selects inventory slot of name passed in.
-- If material is found it returns a true.
-- If material is not found it returns a false
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

-- Gets rid of non-valuable materials while mining
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

-- function to look through inventory and stack items where possible.
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

-- keeps digging the block above it until it is clear
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

-- keeps digging the block in front of it until it is clear
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

-- Returns true if the number passed in is odd
function isodd(numb)
  -- Will return true if numb is odd, and false if it is even.
  tst=math.fmod(numb,2)
  if tst==1 then
    return true
  else
    return false
  end
end

-- Returns true if the inventory is full
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
    while not turtle.forward() do end
  end

  if isodd(j) then
    turtle.turnRight()
  else
    turtle.turnLeft()
  end

  clearUp()
  clear()
  turtle.digDown()
  while not turtle.forward() do end
  nojunk()
  if invenCheck() then  --check if inventory is full
    orgInv() -- consolodate similar inventory
  end

  if isodd(j) then
    turtle.turnRight()
  else
    turtle.turnLeft()
  end
end

-- turtle goes back to starting point
turtle.turnLeft()
for k=1,sqaresize do
  while not turtle.forward() do end
end

-- turtle goes back up.
for o=1,nDeeep do
  turtle.digUp()
  turtle.up()
end
