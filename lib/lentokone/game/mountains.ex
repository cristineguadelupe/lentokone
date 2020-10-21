defmodule Lentokone.Game.Mountains do
  alias Lentokone.{Point, Points}

  defstruct location: {8, 20}

  def new(options \\ []) do
    __struct__(options)
  end

  def left(mountain) do
    %{mountain | location: Point.left(mountain.location)}
  end

  def show(mountain) do
    mountain
    |> to_points()
    |> Points.move(mountain.location)
  end

  defp to_points(_mountain) do
    [{1, 1}]
  end

end
