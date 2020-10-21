defmodule Lentokone.Game do
  alias Lentokone.Game.{Airplane, Arrow, Mountains}
  alias Lentokone.Points

  defstruct [:plane, :mountains, plane_points: [], sequence: [], game_over: false]

  def new do
    __struct__()
    |> new_plane
    |> show_plane
    |> new_sequence
    |> new_mountains
  end

  def move_plane(game, move_fn) do
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

  def move_sequence(game) do
    sequence =
      for arrow <- game.sequence do
        Arrow.left(arrow)
      end
    %{game | sequence: sequence}
  end

  def move_mountains(game) do
    %{game |  mountains: Mountains.left(game.mountains)}
  end


  def plane_right(game), do: game |> move_plane(&Airplane.right/1)
  def plane_down(game), do: game |> move_plane(&Airplane.down/1)
  def plane_up(game), do: game |> move_plane(&Airplane.up/1)

  def arrow_left(game), do: game |> move_sequence()
  def mountains_left(game), do: game |> move_mountains()

  defp new_plane(game) do
    %{game | plane: Airplane.new()}
  end
  defp show_plane(game) do
    %{game | plane_points: Airplane.show(game.plane)}
  end

  defp new_sequence(game) do
    sequence =
        for arrow <- 1..4 do
          Arrow.new(direction: Arrow.random_direction, location: {arrow + 8, 0})
        end
    %{game | sequence: sequence}
  end

  defp new_mountains(game) do
    %{game | mountains: Mountains.new()}
  end

  defp game_over?(game) do
    over = Points.terrain?(game.plane_points)
    %{game | game_over: over}
  end

end
