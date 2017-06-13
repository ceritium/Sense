defmodule Sense.User do
  use Sense.Web, :model

  schema "user" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :username, :string
    timestamps()
  end
 
  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, user_params())
    |> validate_required([:email, :first_name, :last_name, :username])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  defp user_params do
    [
      :email,
      :first_name,
      :last_name,
      :username
    ]
  end
end
