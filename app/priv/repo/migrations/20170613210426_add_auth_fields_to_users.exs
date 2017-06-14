defmodule Sense.Repo.Migrations.AddAuthFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :encrypted_password, :string, null: false
    end
  end
end
