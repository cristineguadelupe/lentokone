defmodule Lentokone.Game do
  alias Lentokone.Game.{Airplane, Arrow, Clouds, Mountains, Skyline}
  alias Lentokone.Points

  defstruct [:plane, :mountains, :skyline, clouds: [], sequence: [], game_over: false, score: 0]

  def new do
    __struct__()
    |> new_plane
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

  def move_clouds(game) do
    clouds =
      for cloud <- game.clouds do
        Clouds.left(cloud)
      end
    %{game | clouds: clouds}
  end


  def plane_right(game), do: game |> move_plane(&Airplane.right/1)
  def plane_down(game), do: game |> move_plane(&Airplane.down/1)
  def plane_up(game), do: game |> move_plane(&Airplane.up/1)

  def arrow_left(game), do: game |> move_sequence()

  def mountains_left(game), do: game |> move_mountains()
  def skyline_left(game), do: game |> move_skyline()
  def cloud_left(game), do: game |> move_clouds()

  def add_arrow(game), do: game |> new_arrow() |> clear_arrows()
  def add_cloud(game), do: game |> new_cloud() |> clear_clouds()

  defp new_plane(game) do
    %{game | plane: Airplane.new()}
  end
  def new_arrow(game) do
    arrow = Arrow.new(direction: Arrow.random_direction, location: {length(game.sequence) + 15, 0})
    %{game | sequence: game.sequence ++ [arrow]}
  end
  def new_cloud(game) do
    cloud = Clouds.new(location: Clouds.random_location())
    %{game | clouds: game.clouds ++ [cloud]}
  end


  defp new_mountains(game) do
    %{game | mountains: Mountains.new()}
  end
  defp new_skyline(game) do
    %{game | skyline: Skyline.new()}
  end

  defp game_over?(game) do
    over =
      game.plane
      |> Airplane.show()
      |> Points.terrain?()
    %{game | game_over: over}
  end

  defp count_keys(game) do
    game.sequence
    |> Enum.filter(&(&1.color == "green"))
    |> length()
  end

  defp inc_score(game) do
    %{game | score: game.score + 1}
  end

  defp inc_speed?(game) do
    game.sequence
    |> Enum.filter(&!(&1 |> Arrow.show |> Points.valid?(0)))
    |> Enum.filter(&(&1.color != "green"))
    |> length()
    |> (&(&1 > 0)).()
    |> inc_speed(game)
  end

  defp inc_speed(true, game) do
    %{game | plane: Airplane.inc_speed(game.plane)}
  end
  defp inc_speed(false, game), do: game

  defp clear_arrows(game) do
    sequence =
      game.sequence
      |> Enum.filter(&(&1 |> Arrow.show |> Points.valid?(-10)))
    %{game | sequence: sequence}
    |> inc_speed?()
  end
  defp clear_clouds(game) do
    clouds =
      game.clouds
      |> Enum.filter(&(&1 |> Clouds.show |> Points.valid?(-10)))
    %{game | clouds: clouds}
  end

end
