defmodule LentokoneWeb.GameLive do
  use LentokoneWeb, :live_view

  alias Lentokone.Game
  alias LentokoneWeb.BoardComponent

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(400, :tick)
      :timer.send_interval(250, :sequence)
      :timer.send_interval(300, :mountains)
      :timer.send_interval(300, :skyline)
      :timer.send_interval(75, :clouds)
    end
    {:ok, new_game(socket)}
  end

  def new_game(socket) do
    assign(socket, game: Game.new())
  end
  def add_arrow(%{assigns: %{game: game}} = socket) do
    assign(socket, game: Game.add_arrow(game))
  end
  def add_cloud(%{assigns: %{game: game}} = socket) do
    assign(socket, game: Game.add_cloud(game))
  end

  def plane_right(%{assigns: %{game: game}} = socket) do
    assign(socket, game: Game.plane_right(game))
  end
  def plane_up(%{assigns: %{game: game}} = socket) do
    assign(socket, game: Game.plane_up(game))
  end
  def plane_down(%{assigns: %{game: game}} = socket) do
    assign(socket, game: Game.plane_down(game))
  end

  def arrow_left(%{assigns: %{game: game}} = socket) do
    assign(socket, game: Game.arrow_left(game))
  end
  def cloud_left(%{assigns: %{game: game}} = socket) do
    assign(socket, game: Game.cloud_left(game))
  end
  def mountains_left(%{assigns: %{game: game}} = socket) do
    assign(socket, game: Game.mountains_left(game))
  end
  def skyline_left(%{assigns: %{game: game}} = socket) do
    assign(socket, game: Game.skyline_left(game))
  end

  def key(%{assigns: %{game: game}} = socket) do
    assign(socket, key: Game.key(game))
  end
  def check_key(%{assigns: %{game: game, key: key}} = socket, key) do
    assign(socket, game: Game.right_key(game))
  end
  def check_key(%{assigns: %{game: game}} = socket, _key) do
    assign(socket, game: Game.wrong_key(game))
  end

  def render(assigns) do
    ~L"""
      <section class="phx-hero">
        <h1>Plane Plane Revolution!</h1>
        <hr>
        <h2> <%= inspect(@game.score) %> </h2>
      </section>
      <div class="board">
        <%= live_component(@socket, BoardComponent, id: :board, assigns: assigns) %>
      </div>
    """
  end

  def handle_info(:tick, socket) do
    {:noreply, socket |> plane_down }
  end
  def handle_info(:sequence, socket) do
    {:noreply, socket |> arrow_left |> add_arrow }
  end
  def handle_info(:mountains, socket) do
    {:noreply, socket |> mountains_left }
  end
  def handle_info(:skyline, socket) do
    {:noreply, socket |> skyline_left }
  end
  def handle_info(:clouds, socket) do
    {:noreply, socket |> cloud_left |> add_cloud}
  end

  def handle_event("keydown", %{"key" => "ArrowRight"}, socket) do
    {:noreply, socket |> key |> check_key(:d)}
  end
  def handle_event("keydown", %{"key" => "ArrowLeft"}, socket) do
    {:noreply, socket |> key |> check_key(:a)}
  end
  def handle_event("keydown", %{"key" => "ArrowUp"}, socket) do
    {:noreply, socket |> key |> check_key(:w)}
  end
  def handle_event("keydown", %{"key" => "ArrowDown"}, socket) do
    {:noreply, socket |> key |> check_key(:s)}
  end

end
