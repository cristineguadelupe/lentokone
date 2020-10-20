defmodule Lentokone.Airplane do
  alias Lentokone.Point

  defstruct location: {0, 0}, speed: 1

  def new(options \\ []) do
    __struct__(options)
  end

end
