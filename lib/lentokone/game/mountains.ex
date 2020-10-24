defmodule Lentokone.Game.Mountains do
  alias Lentokone.{Point, Points}

  defstruct location: {8, 10}, type: 1

  def new(options \\ []) do
    __struct__(options)
    |> random_type()
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

  defp random_type(mountain) do
    %{mountain | type: Enum.random(1..4)}
  end

end
