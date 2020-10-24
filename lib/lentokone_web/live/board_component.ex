defmodule LentokoneWeb.BoardComponent do
  use LentokoneWeb, :live_component

  def render(assigns) do
    ~L"""
    <svg width="800px" height="400">
      <rect x="0" y="0" width="100%" height="100%"
        style="
        fill:#100025;
        stroke:purple;
        stroke-width:5;
        fill-opacity:1.0;
        stroke-opacity:0.9" />
        <%= render_sequence(assigns) %>
        <%= render_skyline(assigns) %>
        <%= render_airplane(assigns) %>
        <%= render_clouds(assigns) %>
        <%= render_mountais(assigns) %>
      </svg>
    """
  end

  def render_airplane(%{assigns: %{game: %{plane: %{location: {x, y}, speed: speed}}}} = assigns) do
    ~L"""
    <svg x="<%= x * (25 + (speed * 5)) %>" y="<%= y * (10 + (speed * 2)) %>"
      height="100" width="100px" phx-window-keydown="keydown" phx-target=".board"
      version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
      viewBox="0 0 63 41.8" style="enable-background:new 0 0 63 41.8;" xml:space="preserve">
    <style type="text/css">
      .st0{fill-rule:evenodd;clip-rule:evenodd;fill:#FF0CC5;}
      .st1{fill-rule:evenodd;clip-rule:evenodd;fill:#910CFF;}
    </style>
    <g id="Layer_2_1_">
      <g id="Layer_25">
        <path class="st0" d="M39.6,13.3h-1.2L33.7,8c-4.6-5.1-10.3-9-16.5-6.2L16.7,2L23,13.5h-1L16,2.4c-0.1-0.2-0.1-0.5-0.1-0.7
          c0.1-0.2,0.2-0.4,0.5-0.5L16.9,1c1.9-0.9,4.1-1.2,6.1-0.9c4.5,0.6,8.4,4,11.3,7.3L39.6,13.3L39.6,13.3z"/>
        <path class="st1" d="M15.5,14c2.7-0.2,5.5-0.4,8.3-0.5c4.8-0.2,9.5-0.3,14.3-0.2c2.8,0.1,5.6,0.2,8.5,0.4c2.5,0.2,5.1,0.5,7.5,1
          c2.9,0.6,7.9,1.9,8.9,5.1c0.2,0.7,0.2,1.5,0,2.3c-1.2,3.8-8,5-11.3,5.5c-3.2,0.4-6.4,0.7-9.7,0.8c-1.2,0.1-2.4,0.1-3.5,0.1
          l0.8-0.9c12.5-0.2,23.1-1.8,23.1-6.8l0,0c0-9.1-40.5-6.7-47.5-6.1l0,0C14.1,7.7,11.4,2.2,0.9,2.3C0.9,10,1,17.8,1,25.5
          c2.9,0.4,12,1.3,22.4,1.9L23,28.2c-3.6-0.2-7.1-0.4-10.7-0.7c-3.8-0.3-7.6-0.7-11.4-1.1c-0.4,0-0.8-0.4-0.8-0.8L0,2.3
          c0-0.5,0.4-0.9,0.8-0.9c4.5,0,9.2,0.9,12,4.7C14.4,8.5,15.3,11.2,15.5,14L15.5,14z"/>
        <path class="st0" d="M26.2,21.5H44c0.2,0,0.4,0.1,0.6,0.2c0.3,0.3,0.4,0.9,0.1,1.2L34.3,34.3c-2.9,3.3-6.8,6.6-11.3,7.3
          c-2.1,0.3-4.2,0-6.2-0.9l-0.5-0.2c-0.2-0.1-0.4-0.3-0.5-0.5c-0.1-0.2,0-0.5,0.1-0.7l9.5-17.4C25.6,21.6,25.9,21.5,26.2,21.5z
          M44,22.3L33.7,33.8c-4.6,5.1-10.3,9-16.5,6.2l-0.5-0.2l9.5-17.4H44z"/>
        <path class="st0" d="M41.8,19.5v-1.4c0-0.8-0.6-1.4-1.4-1.4c-0.8,0-1.4,0.6-1.4,1.4v1.4h-0.7v-1.4c-0.1-0.7-0.6-1.2-1.3-1.3
          c-0.8-0.1-1.5,0.5-1.5,1.3v1.4h-0.7v-1.4c0-0.8-0.6-1.4-1.4-1.4c-0.8,0-1.4,0.6-1.4,1.4v1.4h-0.7v-1.4c0,0,0,0,0,0
          c0-0.8-0.6-1.4-1.4-1.4c-0.8,0-1.4,0.6-1.4,1.4v1.4h-0.7v-1.4c0-0.8-0.6-1.4-1.4-1.4c-0.8,0-1.4,0.6-1.4,1.4v1.4H24v-1.4
          c-0.1-0.7-0.6-1.2-1.3-1.3c-0.8-0.1-1.5,0.5-1.5,1.3v1.4h-0.7v-1.4c0-0.8-0.6-1.4-1.4-1.4c-0.8,0-1.4,0.6-1.4,1.4v1.3
          c0,0,0,0.1,0,0.1c0,0.2-0.2,0.3-0.4,0.3c-0.2,0-0.3-0.2-0.3-0.4v-1.4c0-0.7,0.4-1.4,1-1.8c1-0.7,2.3-0.4,3,0.6
          c0.2-0.2,0.4-0.4,0.6-0.6c1-0.7,2.3-0.4,3,0.6c0.2-0.2,0.4-0.4,0.6-0.6c1-0.7,2.3-0.4,3,0.6c0.2-0.2,0.4-0.4,0.6-0.6
          c1-0.7,2.3-0.4,3,0.6c0.4-0.6,1.1-0.9,1.8-1c0.7,0,1.4,0.4,1.8,1c0.2-0.2,0.4-0.4,0.6-0.6c1-0.7,2.3-0.4,3,0.6
          c0.4-0.6,1.1-0.9,1.8-1c0.7,0,1.4,0.4,1.7,1c0.4-0.6,1.1-1,1.9-1c1.2,0,2.1,1,2.1,2.2v1.4c0,0.2-0.2,0.4-0.4,0.4
          c-0.2,0-0.4-0.2-0.4-0.4v-1.4c0-0.8-0.6-1.4-1.4-1.4c-0.8,0-1.4,0.6-1.4,1.4v1.4C42.5,19.5,41.8,19.5,41.8,19.5z"/>
      </g>
    </g>
    </svg>
    """
  end

  def render_sequence(%{assigns: %{game: %{sequence: sequence}}} = assigns) do
    ~L"""
    <%= for arrow <- sequence do %>
      <%= render_arrow(assigns, arrow.location, arrow.direction, arrow.color) %>
    <% end %>
    """
  end

  defp render_arrow(assigns, {x, y}, :a, color) do
    ~L"""
    <svg height="100" width="100" x="<%= x * 50 %>" y="<%= y * 10 %>">
      <image width="100" height="100" xlink:href="<%= "images/left_#{color}.png" %>" />
    </svg>
    """
  end
  defp render_arrow(assigns, {x, y}, :w, color) do
    ~L"""
    <svg height="100" width="100" x="<%= x * 50 %>" y="<%= y * 10 %>">
      <image width="100" height="100" xlink:href="<%= "images/up_#{color}.png" %>" />
    </svg>
    """
  end
  defp render_arrow(assigns, {x, y}, :s, color) do
    ~L"""
    <svg height="100" width="100" x="<%= x * 50 %>" y="<%= y * 10 %>">
      <image width="100" height="100" xlink:href="<%= "images/down_#{color}.png" %>" />
    </svg>
    """
  end
  defp render_arrow(assigns, {x, y}, :d, color) do
    ~L"""
    <svg height="100" width="100" x="<%= x * 50 %>" y="<%= y * 10 %>">
      <image width="100" height="100" xlink:href="<%= "images/right_#{color}.png" %>" />
    </svg>
    """
  end

  defp render_mountais(%{assigns: %{game: %{mountains: %{location: {x, y}, type: type}}}} = assigns) do
    ~L"""
    <svg height="400" width="800" x="<%= x * 100 %>" y="<%= y %>">
      <image width="800" height="650" xlink:href="<%= "images/mountains#{type}.png" %>" />
    </svg>
    """
  end
  defp render_skyline(%{assigns: %{game: %{skyline: %{location: {x, y}, type: type}}}} = assigns) do
    ~L"""
    <svg height="400" width="400" x="<%= x * 10 %>" y="<%= y %>" opacity="0.5">
      <image width="200" height="650" xlink:href="<%= "images/skyline#{type}.png" %>" />
    </svg>
    """
  end

  def render_clouds(%{assigns: %{game: %{clouds: clouds}}} = assigns) do
    ~L"""
    <%= for cloud <- clouds do %>
      <%= render_cloud(assigns, cloud.location) %>
    <% end %>
    """
  end
  defp render_cloud(assigns, {x, y}) do
    ~L"""
    <svg height="250" width="250" x="<%= x * 10 %>" y="<%= y * 10 %>" opacity="0.1">
      <image width="250" height="250" xlink:href="images/cloud2.png" />
    </svg>
    """
  end

end
