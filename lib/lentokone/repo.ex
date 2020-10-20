defmodule Lentokone.Repo do
  use Ecto.Repo,
    otp_app: :lentokone,
    adapter: Ecto.Adapters.Postgres
end
