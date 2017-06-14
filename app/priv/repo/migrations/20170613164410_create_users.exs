defmodule Sense.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :email, :string
      add :first_name, :string
      add :last_name, :string
      add :username, :string
      
      timestamps()
    end

  end
end
