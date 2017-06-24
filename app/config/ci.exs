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
  username: "ubuntu",
  password: "",
  database: "circle_test",
  hostname: "127.0.0.1",
  pool: Ecto.Adapters.SQL.Sandbox

config :guardian, Guardian,
  secret_key: "X3wcGjfsfnyH7zo7F3xL7FEekuvPflZMSIwwO2albcCECHNIV261QuBau8drgjCv"

# Reduce the number of bcrypt rounds so it does not slow down test suite.
# By default bcrypt_log_rounds is 12 and pbkdf2_rounds 160_000
config :comeonin,
  bcrypt_log_rounds: 1
