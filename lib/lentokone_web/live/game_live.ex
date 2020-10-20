defmodule LentokoneWeb.GameLive do
  use LentokoneWeb, :live_view
  alias LentokoneWeb.BoardComponent

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <section class="phx-hero">
        <h1>Plane Plane Revolution!</h1>
        <%= live_component(@socket, BoardComponent, id: :board, assigns: assigns) %>
      </section>
    """
  end

end
