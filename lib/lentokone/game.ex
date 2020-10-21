defmodule Lentokone.Game do
  alias Lentokone.Game.{Airplane, Arrow}
  alias Lentokone.Points

  defstruct [:plane, plane_points: [], sequence: [], game_over: false]

  def new do
    __struct__()
    |> new_plane
    |> show_plane
    |> new_sequence
  end

  def move(game, move_fn) do
    old = game.plane
    new =
      game.plane
      |> move_fn.()

    moved =
      new
      |> Airplane.show()
      |> Points.valid?()
      |> Airplane.maybe_move(old, new)

    %{game | plane: moved}
    |> show_plane()
    |> game_over?()
  end

  def move(game) do
    sequence =
      for arrow <- game.sequence do
        Arrow.left(arrow)
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
          Arrow.new(direction: Arrow.random_direction, location: {arrow, 0})
        end
    %{game | sequence: sequence}
  end

  defp game_over?(game) do
    over = Points.terrain?(game.plane_points)
    %{game | game_over: over}
  end

end
