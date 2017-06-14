defmodule Sense.Repo.Migrations.CreateMetric do
  use Ecto.Migration

  def change do
    create table(:metrics) do
      add :name, :string
      add :description, :string
      add :device_id, references(:devices, on_delete: :delete_all), null: false

      timestamps()
    end
    create index(:metrics, [:device_id])

  end
end
