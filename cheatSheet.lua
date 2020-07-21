-- Code for today's lesson:

pastebin run xNztvMYg

turtle.detectDown()  -- returns "true" if something is below the turtle
-- other detect commands
turtle.detect()
turtle.detectUp()

not turtle.detectDown() -- will return "true" if nothing is below the turtle!

turtle.select(1) -- Selects turtle inventory, in this example it will select from the 1st slot

turtle.placeDown()

-- Previous code to add a variable depth location
print("How many blocks deep would the mine be?")
nDeep=tonumber(io.read())
