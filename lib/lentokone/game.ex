defmodule Lentokone.Game do
  alias Lentokone.Game.{Airplane, Arrows}
  alias Lentokone.Points

  defstruct [:plane, plane_points: [], sequence: [], sequence_points: []]

  def new do
    __struct__()
    |> new_plane
    |> show_plane
    |> new_sequence
  end

  def move(game, move_fn) do
    new =
      game.plane
      |> move_fn.()

    %{game | plane: new}
    |> show_plane()
  end

  def move(game) do
    sequence =
      for arrow <- game.sequence do
        Arrows.left(arrow)
      end
    %{game | sequence: sequence}
  end

  def plane_right(game), do: game |> move(&Airplane.right/1)
  def plane_down(game), do: game |> move(&Airplane.down/1)
  def plane_up(game), do: game |> move(&Airplane.up/1)

  def arrow_left(game), do: game |> move()

  defp new_plane(game) do
    %{game | plane: Airplane.new()}
  end
  defp show_plane(game) do
    %{game | plane_points: Airplane.show(game.plane)}
  end

  defp new_sequence(game) do
    sequence =
        for arrow <- 1..4 do
          Arrows.new(direction: Arrows.random_direction, location: {arrow, 0})
        end
    %{game | sequence: sequence}
  end

end
