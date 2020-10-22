defmodule Lentokone.Points do
  alias Lentokone.Point

  def move(points, change) do
    points
    |> Enum.map(&Point.move(&1, change))
  end

  def valid?(points) do
    Enum.any?(points, &Point.in_bounds?/1)
  end
  def valid?(points, limit) do
    Enum.any?(points, &Point.in_bounds?(&1, limit))
  end

  def terrain?(points) do
    Enum.any?(points, &Point.terrain?/1)
  end

end
