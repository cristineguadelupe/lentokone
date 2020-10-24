defmodule Lentokone.Game.Skyline do
  alias Lentokone.{Point, Points}

  defstruct location: {80, 10}, type: 1

  def new(options \\ []) do
    __struct__(options)
    |> random_type()
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

  defp random_type(skyline) do
    %{skyline | type: Enum.random(1..3)}
  end
end
