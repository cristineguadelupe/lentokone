defmodule Lentokone.Game.Skyline do
  alias Lentokone.{Point, Points}

  defstruct location: {8, 10}

  def new(options \\ []) do
    __struct__(options)
  end

  def left(skyline) do
    %{skyline | location: Point.left(skyline.location)}
  end

  def show(skyline) do
    skyline
    |> to_points()
    |> Points.move(skyline.location)
  end

  def maybe_move(true, new), do: new
  def maybe_move(false, _new), do: new()

  defp to_points(_skyline) do
    [{1, 1}]
  end
end
