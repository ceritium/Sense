defmodule Sense.UsersTest do
  use Sense.ModelCase

  alias Sense.Users

  @valid_attrs %{
    email: "fake@email.local",
    first_name: "John",
    last_name: "Doe",
    username: "johndoe"    
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Users.changeset(%Users{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Users.changeset(%Users{}, @invalid_attrs)
    refute changeset.valid?
  end
end
