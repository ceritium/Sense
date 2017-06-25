use Mix.Config

config :sense, Sense.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "sense-staging.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/manifest.json"

# Do not print debug messages in production
config :logger, level: :info

# Configure your database
config :sense, Sense.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

import_config "prod.secret.exs"
