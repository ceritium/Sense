use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sense, Sense.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :sense, Sense.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("PG_USERNAME"),
  password: System.get_env("PG_USERNAME"),
  database: "sense_test",
  hostname: System.get_env("PG_HOST"),
  pool: Ecto.Adapters.SQL.Sandbox

config :comeonin,
  bcrypt_log_rounds: 1
