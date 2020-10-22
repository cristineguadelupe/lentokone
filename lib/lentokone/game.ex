defmodule Lentokone.Game do
  alias Lentokone.Game.{Airplane, Arrow, Mountains, Skyline}
  alias Lentokone.Points

  defstruct [:plane, :mountains, :skyline, plane_points: [], sequence: [], game_over: false, score: 0]

  def new do
    __struct__()
    |> new_plane
    |> show_plane
    |> new_mountains
    |> new_skyline
  end

  def key(game) do
    game.sequence
    |> Enum.filter(&(&1.color != "green"))
    |> hd()
    |> (&(&1.direction)).()
  end

  def right_key(game) do
    sequence =
      game.sequence
      |> List.update_at(count_keys(game), &(%{&1 | color: "green"}))

    %{game | sequence: sequence}
    |> inc_score()
    |> plane_up()
  end

  def wrong_key(game) do
    sequence =
      game.sequence
      |> List.update_at(count_keys(game), &(%{&1 | color: "red"}))

    %{game | sequence: sequence}
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

  def add_arrow(game), do: game |> new_arrow()

  defp new_plane(game) do
    %{game | plane: Airplane.new()}
  end
  defp show_plane(game) do
    %{game | plane_points: Airplane.show(game.plane)}
  end

  def new_arrow(game) do
    arrow = Arrow.new(direction: Arrow.random_direction, location: {length(game.sequence) + 15, 0})
    %{game | sequence: game.sequence ++ [arrow]}
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

  def count_keys(game) do
    game.sequence
    |> Enum.filter(&(&1.color == "green"))
    |> length()
  end

  def inc_score(game) do
    %{game | score: game.score + 1}
  end


end
