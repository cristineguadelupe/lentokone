defmodule Lentokone.Point do

  def up({x, y}) do
    {x, y-1}
  end
  def down({x, y}) do
    {x, y+1}
  end

  def left({x, y}) do
    {x-1, y}
  end
  def right({x, y}) do
    {x+1, y}
  end

  def move({x, y}, {change_x, change_y}) do
    {x + change_x, y + change_y}
  end

  def in_bounds?({x, _y}) when x < 1, do: false
  def in_bounds?({_x, y}) when y > 35, do: false
  def in_bounds?({_x, y}) when y < 1, do: false
  def in_bounds?(_point), do: true

  def in_bounds?({x, _y}, limit) when x < limit, do: false
  def in_bounds?(_point, _limit), do: true

  def terrain?({_x, y}) when y > 22, do: true
  def terrain?(_point), do: false

end
