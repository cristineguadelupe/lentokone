defmodule Lentokone.Game.Mountains do
  alias Lentokone.{Point, Points}

  defstruct location: {8, 10}

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

  def maybe_move(true, new), do: new
  def maybe_move(false, _new), do: new()

  defp to_points(_mountain) do
    [{1, 1}]
  end

end
