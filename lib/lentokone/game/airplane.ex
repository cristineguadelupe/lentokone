defmodule Lentokone.Game.Airplane do
  alias Lentokone.{Point, Points}

  defstruct location: {40, 0}, speed: 1

  def new(options \\ []) do
    __struct__(options)
  end

  def right(airplane) do
    %{airplane | location: Point.right(airplane.location)}
  end
  def up(airplane) do
    %{airplane | location: Point.up(airplane.location)}
  end
  def down(airplane) do
    %{airplane | location: Point.down(airplane.location)}
  end

  def show(airplane) do
    airplane
    |> to_points()
    |> Points.move(airplane.location)
  end

  def maybe_move(true, _old, new), do: new
  def maybe_move(false, old, _new), do: old

  defp to_points(_airplane) do
    [{1, 1}]
  end

end
