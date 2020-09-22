

function sortStuff()
  -- grp1 -- fuel for furnace
  local bow = "minecraft:bow"

  -- grp2 -- armor for smelting
  local gHlmt = "mincraft:golden_helmet"
  local gChstPlt = "minecraft:golden_chestplate"
  local gPnts = "minecraft:golden_leggings"
  local gBts = "minecraft:golden_boots"
  local cHlmt = "mincraft:chainmail_helmet"
  local cChstPlt = "minecraft:chainmail_chestplate"
  local cPnts = "minecraft:chainmail_leggings"
  local cBts = "minecraft:chainmail_boots"
  local iHlmt = "mincraft:iron_helmet"
  local iChstPlt = "minecraft:iron_chestplate"
  local iPnts = "minecraft:iron_leggings"
  local iBts = "minecraft:iron_boots"

  -- grp3 -- bownes
  local arrow = "minecraft:arrow"

  -- grp 4 -- arrows
  local bone = "minecraft:bone"



  local grp1=false
  local grp2=false
  local grp3=false
  local grp4=false
  local goodDrop=true
  local item
  for i=1,16 do
    if not(turtle.getItemCount(i)==0) then
      item=turtle.getItemDetail(i)
      grp1=(item.name==bow)
      grp2=(item.name==gHlmt or item.name==gChstPlt or   item.name==gPnts or item.name==gBts or item.name==cHlmt or item.name==cChstPlt or   item.name==cPnts or item.name==cBts or item.name==iHlmt or item.name==iChstPlt or   item.name==iPnts or item.name==iBts)
      grp3=item.name==arrows
      grp4=item.name==bone

      if grp1 then
        turtle.select(i)
        turtle.turnRight()
        turtle.turnRight()
        goodDrop=turtle.drop()
        turtle.turnRight()
        turtle.turnRight()
        grp1=false
      elseif grp2 then
        turtle.select(i)
        turtle.turnRight()
        goodDrop=turtle.drop()
        turtle.turnLeft()
        grp2=false
      elseif grp3 then
        turtle.select(i)
        goodDrop=turtle.drop()
        grp3=false
      elseif grp4 then
        turtle.select(i)
        turtle.turnLeft()
        goodDrop=turtle.drop()
        turtle.turnRight()
        grp4=false
      end

      if not(goodDrop) then
        select(i)
        turtle.dropDown()
        goodDrop=true
      end
    end
  end
end

local go = true

while go do
  print("Executing function sortStuff")
  sortStuff()
  print("Sleeping")
  sleep(5)
end
