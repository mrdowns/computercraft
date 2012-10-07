length = 10
width = 10
collected = 0
turnRight = true

function collectForward ()

  if turtle.detect() then
    turtle.dig()
    collected = collected + 1
  end

  turtle.forward()

  if turtle.detectDown() then
    turtle.digDown()
    collected = collected + 1
  end

end

function forwardColumn ()

  -- 2 here, because we've done one on column shift already
  for i = 2, length do

    collectForward()

  end

end

function nextColumn () 

  if turnRight then
    turtle.turnRight()
    collectForward()
    turtle.turnRight()
  else
    turtle.turnLeft()
    collectForward()
    turtle.turnLeft()
  end

  turnRight = not turnRight
  
end

function doGrid ()

  -- the turtle must facing the first column, far left of the farm
  collectForward()

  for i = 1, width do

    forwardColumn()
    
    if i < width then
      nextColumn()
    end

  end

  -- return to origin
  turtle.forward()
  turtle.turnRight()
  for i = 1, width - 1 do
    turtle.forward()
  end
  turtle.turnRight()

end

function ensureFuel ()

  necessaryFuel = (width * length) + width

  print("current fuel level: "..turtle.getFuelLevel())
  print("necessary fuel level: "..necessaryFuel)

  turtle.turnLeft()

  -- keep trying to suck things out of the fuel chest until we have enough
  while turtle.getFuelLevel() < necessaryFuel do
    print("waiting for fuel...")
    turtle.suck()
    turtle.refuel()
    sleep(15)
  end

  print("refueled")

  turtle.turnRight()

end

function unload ()

  for i=1,15 do
    turtle.select(i)
    turtle.dropDown()
  end

end

function cycle ()

  -- assumes:
  -- the drop off chest is below
  -- the refuel chest is to the left
  -- turtle starts at back left corner of farm
  -- 16 is the fuel slot
  -- 1 is the sugar cane slot
  while true do
    turtle.select(16)

    ensureFuel()

    turnRight = true

    turtle.select(1)

    doGrid()

    print("collected "..collected)

    collected = 0

    unload()

    sleep(10)
  end

end

cycle()

