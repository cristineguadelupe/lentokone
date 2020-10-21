defmodule Lentokone.Game.Arrows do
  alias Lentokone.Point

  defstruct location: {0, 0}, shape: :a

  def new(options \\ []) do
    __struct__(options)
  end

end
