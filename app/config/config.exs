# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sense,
  ecto_repos: [Sense.Repo]

# Configures the endpoint
config :sense, Sense.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PyTTLl4iRtRYSqupQFbuSxES8Tqfh2nt3emusA3Y3IMFzOgfPSNaGeksv+IgwRL4",
  render_errors: [view: Sense.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Sense.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :sense, Sense.Influx,
  database:  "device_metrics",
  host:      System.get_env("INFLUXDB_HOST"),
  http_opts: [ insecure: true ],
  pool:      [ max_overflow: 0, size: 1 ],
  port:      8086,
  scheme:    "http",
  writer:    Instream.Writer.Line

config :guardian, Guardian,
  issuer: "Sense.#{Mix.env}",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: Sense.GuardianSerializer,
  secret_key: to_string(Mix.env) <> "SuperS3CR3tSeNS3ToK3n"
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
