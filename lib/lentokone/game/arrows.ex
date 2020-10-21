defmodule Lentokone.Game.Arrows do
  alias Lentokone.{Point, Points}

  defstruct location: {0, 0}, direction: :a

  @directions [:a, :w, :s, :d]

  def new(options \\ []) do
    __struct__(options)
  end

  def left(arrow) do
    %{arrow | location: Point.left(arrow.location)}
  end

  def show(arrow) do
    arrow
    |> to_points()
    |> Points.move(arrow.location)
  end

  def random_direction do
    Enum.random(@directions)
  end

  defp to_points(_arrow) do
    [{1, 1}]
  end


end
