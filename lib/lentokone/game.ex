defmodule Lentokone.Game do
  alias Lentokone.Game.{Airplane, Arrow, Mountains, Skyline}
  alias Lentokone.Points

  defstruct [:plane, :mountains, :skyline, :key, plane_points: [], sequence: [], game_over: false]

  def new do
    __struct__()
    |> new_plane
    |> show_plane
    |> new_sequence
    |> new_mountains
    |> new_skyline
  end

  def key(game) do
    hd(game.sequence)
    |> (&(&1.direction)).()
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
    |> new_sequence?()
  end

  def move_mountains(game) do
    new =
      game.mountains
      |> Mountains.left()

    moved =
      new
      |> Mountains.show()
      |> Points.valid?(-10)
      |> Mountains.maybe_move(new)

      %{game |  mountains: moved}
  end

  def move_skyline(game) do
    new =
      game.skyline
      |> Skyline.left()

    moved =
      new
      |> Skyline.show()
      |> Points.valid?(-10)
      |> Skyline.maybe_move(new)

      %{game |  skyline: moved}
  end


  def plane_right(game), do: game |> move_plane(&Airplane.right/1)
  def plane_down(game), do: game |> move_plane(&Airplane.down/1)
  def plane_up(game), do: game |> move_plane(&Airplane.up/1)

  def arrow_left(game), do: game |> move_sequence()

  def mountains_left(game), do: game |> move_mountains()
  def skyline_left(game), do: game |> move_skyline()

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
  defp new_skyline(game) do
    %{game | skyline: Skyline.new()}
  end

  defp game_over?(game) do
    over = Points.terrain?(game.plane_points)
    %{game | game_over: over}
  end

  defp new_sequence?(false, game), do: game
  defp new_sequence?(true, game) do
    new_sequence(game)
  end

  defp new_sequence?(game) do
    for arrow <- game.sequence do
      arrow
      |> Arrow.show()
      |> Points.valid?()
    end
    |> Enum.all?(&(&1 == false))
    |> new_sequence?(game)
  end

end
