{:ok, _} = Application.ensure_all_started(:ex_machina)

ExUnit.configure(formatters: [JUnitFormatter, ExUnit.CLIFormatter])
ExUnit.configure(exclude: [:skip])
ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(Sense.Repo, :manual)
