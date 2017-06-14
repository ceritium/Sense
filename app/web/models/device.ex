defmodule Sense.Device do
  use Sense.Web, :model

  schema "devices" do
    field :name, :string
    field :description, :string

    timestamps()

    #Associations
    belongs_to :user, Sense.User
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :user_id])
    |> validate_required([:name, :description])
  end
end
