defmodule Sense.Repo.Migrations.CreateActuator do
  use Ecto.Migration

  def change do
    create table(:actuators) do
      add :name, :string
      add :description, :string
      add :value, :integer
      add :type, :string
      add :device_id, references(:devices, on_delete: :delete_all), null: false

      timestamps()
    end
    create index(:actuators, [:device_id])

  end
end
