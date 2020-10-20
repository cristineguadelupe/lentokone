defmodule Lentokone.Point do

  def up({x, y}) do
    {x, y-1}
  end
  def down({x, y}) do
    {x, y-1}
  end

  def left({x, y}) do
    {x-1, y}
  end
  def right({x, y}) do
    {x+1, y}
  end

end
