-- Code for today's lesson:

pastebin run xNztvMYg

-- part one turtle.inspect()
turtle.inspect()
turtle.inspectUp()
turtle.inspectDown()



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
return false
end
