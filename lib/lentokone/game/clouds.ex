defmodule Lentokone.Game.Clouds do
  alias Lentokone.{Point, Points}

  defstruct location: {0, 0}

  def new(options \\ []) do
    __struct__(options)
  end

  def left(clouds) do
    %{clouds | location: Point.left(clouds.location)}
  end

  def show(clouds) do
    clouds
    |> to_points()
    |> Points.move(clouds.location)
  end

  def maybe_move(true, new), do: new
  def maybe_move(false, _new), do: new(location: random_location())

  def random_location do
    x = Enum.random(60..250)
    y = Enum.random(0..25)
    {x, y}
  end

  defp to_points(_clouds) do
    [{1, 1}]
  end

end
