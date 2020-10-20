# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lentokone,
  ecto_repos: [Lentokone.Repo]

# Configures the endpoint
config :lentokone, LentokoneWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oZW2q92QTa7gNVTrMv+zTeGtag4r7yzzx0DYHQuVerVI7DG1tHrArzfWiEDoJ7rW",
  render_errors: [view: LentokoneWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Lentokone.PubSub,
  live_view: [signing_salt: "eadLGivT"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
