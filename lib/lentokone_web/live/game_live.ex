defmodule LentokoneWeb.GameLive do
  use LentokoneWeb, :live_view

  alias Lentokone.Game
  alias LentokoneWeb.BoardComponent

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(500, :tick)
      :timer.send_interval(1000, :sequence)
    end
    {:ok, new_game(socket)}
  end

  def new_game(socket) do
    assign(socket, game: Game.new())
  end

  def plane_right(%{assigns: %{game: game}} = socket) do
    assign(socket, game: Game.plane_right(game))
  end
  def plane_down(%{assigns: %{game: game}} = socket) do
    assign(socket, game: Game.plane_down(game))
  end

  def arrow_left(%{assigns: %{game: game}} = socket) do
    assign(socket, game: Game.arrow_left(game))
  end

  def render(assigns) do
    ~L"""
      <section class="phx-hero">
        <h1>Plane Plane Revolution!</h1>
      </section>
      <div class="board">
        <%= live_component(@socket, BoardComponent, id: :board, assigns: assigns) %>
      </div>
    """
  end

  def handle_info(:tick, socket) do
    {:noreply, socket |> plane_down |> plane_right}
  end
  def handle_info(:sequence, socket) do
    {:noreply, socket |> arrow_left }
  end

  def handle_event("keydown", %{"key" => "ArrowRight"}, socket) do
    {:noreply, socket |> plane_right}
  end

end
