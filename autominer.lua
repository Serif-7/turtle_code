

-- mine a L by W rectangle D blocks deep
-- can mine up or down
local D = 2
local L = 2
local W = 2 -- width must be even
local DIRECTION = "up" -- can be "up" or "down"

-- turtle should be placed one block outside of the rectangle
-- on the bottom right
--[[ 
 _______
|       |
|       |
|       |
|_______| (turtle is here)
--]]


--[[
  TODO:
  auto storage
  auto refuel with found coal
]]--

function dig_and_move_forward()
    while (turtle.detect()) do
      assert(turtle.dig())
    end
    assert(turtle.forward())
end
function dig_and_move_down()
    while (turtle.detectDown()) do
      assert(turtle.digDown())
    end
    assert(turtle.down())
end
function dig_and_move_up()
    while (turtle.detectUp()) do
      assert(turtle.digUp())
    end
    assert(turtle.up())
end


-- dig n blocks forward
function dig_forward_N(n)
  for i = 1, n do
    dig_and_move_forward()
  end
end

function checkFuel()
  if (turtle.getFuelLevel() < turtle.getFuelLimit()) then
    turtle.refuel()
  end
end
function digRectangle(length, width)
  assert(width % 2 == 0) -- even numbers only, for ease of implementation
  local function orient(i, n)
    -- do nothing if at end of loop
   if (i == n) then return end
   if (i % 2 == 0) then
     turtle.turnLeft()
     dig_and_move_forward()
     turtle.turnLeft()
   else
     turtle.turnRight()
     dig_and_move_forward()
     turtle.turnRight()
   end
  end

  for i = 1, width do
    checkFuel()
    dig_forward_N(length - 1)
    -- needs to go 1 block further on the first iteration
    if (i == 1) then
      dig_and_move_forward()
    end
    -- setup for next dig
    orient(i, width)
  end
  -- return to starting position
  turtle.turnRight()
  for i = 1, width - 1 do
    dig_and_move_forward()
  end
  turtle.turnLeft()
  dig_and_move_forward()
  turtle.turnLeft()
  turtle.turnLeft()
end

-- dig down by depth blocks
function digCuboid(depth, length, width, dir)
  local function return_to_start()
    if dir == "down" then
      for i = 1, depth do
          turtle.up()
      end
    else
      for i = 1, depth do
          turtle.down()
      end
    end
  end
  
  for i = 1, depth do
  	digRectangle(length, width)
  	if (i ~= depth) then
  	  if (dir == "down" and depth > 1) then
        dig_and_move_down()
      elseif (dir == "up" and depth > 1) then
        dig_and_move_up()
      end
    end
  end
  return_to_start()
end

function main()
  if (turtle.getFuelLevel() > 0) then
    digCuboid(D, L, W, DIRECTION)
  else
    assert(turtle.refuel())
    digCuboid(D, L, W, DIRECTION)
  end
end

main()

