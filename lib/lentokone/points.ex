defmodule Lentokone.Points do
  alias Lentokone.Point

  def move(points, change) do
    points
    |> Enum.map(&Point.move(&1, change))
  end
end
