

function keepStuff()
  local eBook = "minecraft:enchanted_book"
  local bow = "minecraft:bow"
  local fRod = "minecraft:fishing_rod"
  local bowl = "minecraft:bowl"
  local leather = "minecraft:leather"
  local pFish = "minecraft:pufferfish"
  local tFish = "minecraft:tropical_fish"
  local nameTag = "minecraft:name_tag"

  local grp1=false
  local grp2=false
  local goodDrop=true
  local item
  for i=1,16 do
    if not(turtle.getItemCount(i)==0) then
      item=turtle.getItemDetail(i)
      grp1=(item.name==eBook)
      grp2=(item.name==bow or item.name==fRod or item.name==bowl or item.name==leather or item.name==pFish or
           item.name==tFish or item.name==nameTag)
      if grp1 then
        turtle.select(i)
        turtle.turnLeft()
        goodDrop=turtle.drop()
        turtle.turnRight()
        grp1=false
      elseif grp2 then
        turtle.select(i)
        turtle.turnRight()
        goodDrop=turtle.drop()
        turtle.turnLeft()
        grp2=false
      else
        turtle.select(i)
        turtle.dropDown()
      end

      if not(goodDrop) then
        select(i)
        turtle.dropDown()
        cstFull=false
      end
    end
  end
end

local go = true

while go do
  print("Entering Function keepStuff")
  keepStuff()
  sleep(20)
end
