
-- turtle functions

local function dig_and_move_forward()
    while (turtle.detect()) do
      assert(turtle.dig())
    end
    assert(turtle.forward())
end
local function dig_and_move_down()
    while (turtle.detectDown()) do
      assert(turtle.digDown())
    end
    assert(turtle.down())
end
local function dig_and_move_up()
    while (turtle.detectUp()) do
      assert(turtle.digUp())
    end
    assert(turtle.up())
end

local function checkFuel()
  if (turtle.getFuelLevel() < turtle.getFuelLimit()) then
    turtle.refuel()
  end
  if (turtle.getFuelLevel() == 0 and not turtle.refuel()) then
    error("No Fuel!")
  end
end

return {
  dig_and_move_forward = dig_and_move_forward,
  dig_and_move_down = dig_and_move_down,
  dig_and_move_up = dig_and_move_up,
  checkFuel = checkFuel,
}
