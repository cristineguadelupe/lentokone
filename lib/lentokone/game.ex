defmodule Lentokone.Game do
  alias Lentokone.Game.{Airplane, Arrows}
  alias Lentokone.Points

  defstruct [:plane, plane_points: []]

  def new do
    __struct__()
    |> new_plane
    |> show_plane
  end

  def move(game, move_fn) do
    new =
      game.plane
      |> move_fn.()
      |> IO.inspect(label: "Plane")

    %{game | plane: new}
    |> show_plane()
  end

  def plane_right(game), do: game |> move(&Airplane.right/1)
  def plane_down(game), do: game |> move(&Airplane.down/1)

  defp new_plane(game) do
    %{game | plane: Airplane.new()}
  end
  defp show_plane(game) do
    %{game | plane_points: Airplane.show(game.plane)}
  end

end
