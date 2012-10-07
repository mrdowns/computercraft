-- width and length denote the number of trees there are on each side, 4 spaces apart
width = 3
length = 3
spacing = 3 -- number of spaces between trees, not counting the trees themselves
turnRight = true

-- assumes turtle is at second block from bottom of tree
function collectTree ()
  turtle.select(4)

  local height = 0

  if turtle.detect() then
    turtle.dig()
    turtle.forward()
    turtle.digDown()
  else
    turtle.forward()
  end

  while turtle.detectUp() do
    turtle.digUp()
    if turtle.up() then
      height = height + 1
    else
      break
    end
  end

  while height > 0 do
    if turtle.down() then
      height = height - 1
    else
      break
    end
  end
end

-- assumes we're in position above the dirt block
function plantSapling ()
  turtle.select(1)
  turtle.placeDown()
end

-- assumes turtle is above sapling
function chopForward (spaces)
  for i = 1, spaces do 
    if turtle.detect() then
      turtle.dig()
    end

    turtle.forward() 
  end
end

-- assumes we're starting in the correct position, in front of the first tree
function harvestColumn ()
  for i = 1, length do
    collectTree()
    plantSapling()

    if i < length then
      chopForward(spacing)
    end
  end
end

function turnAccordingly ()
  if turnRight then
    turtle.turnRight()
  else
    turtle.turnLeft()
  end
end

function nextColumn ()
  turtle.forward()

  turnAccordingly()

  chopForward(spacing + 1) -- we didn't move over the sapling, so add one

  turnAccordingly()

  turnRight = not turnRight
end

-- assumes position on top of last sapling
-- will only work if turtle ends up in opposite corner from start
function home ()
  turnAccordingly()

  chopForward(1)

  turnAccordingly()

  chopForward((spacing * (length - 1)) + length)

  turnAccordingly()

  chopForward((spacing * (width - 1)) + width)

  turnAccordingly()
end

function cycle ()
  for i = 1, width do
    harvestColumn()
    if i < width then
      nextColumn()
    else
      home()
    end
  end
end

cycle()

