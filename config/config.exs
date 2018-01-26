# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
# config :triangle_farms,
#   ecto_repos: [TriangleFarms.Repo]

# Configures the endpoint
config :triangle_farms, TriangleFarmsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("TF_SECRET_KEY_BASE"),
  render_errors: [view: TriangleFarmsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TriangleFarms.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure google api credentials
config :triangle_farms, TriangleFarms.Calendar.EventAPI.Client,
  email: "admin-332@triangle-farms.iam.gserviceaccount.com",
  scope: "https://www.googleapis.com/auth/calendar.readonly",
  audience: "https://www.googleapis.com/oauth2/v4/token",
  calendar: "small.ag_jpual3bce0io357u2bql9jptg4@group.calendar.google.com"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
