use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :triangle_farms, TriangleFarmsWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :triangle_farms, TriangleFarms.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("POSTGRESQL_USERNAME"),
  password: System.get_env("POSTGRESQL_PASSWORD"),
  database: "triangle_farms_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
