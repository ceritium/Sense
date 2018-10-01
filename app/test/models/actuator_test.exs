defmodule Sense.ActuatorTest do
  use Sense.ModelCase
  import Sense.Factory
  alias Sense.Actuator

  @valid_attrs %{description: "some content", name: "some content", type: "button", value: 0}
  @invalid_attrs %{description: "some content", name: "some content", type: "button", value: 1000}

  test "changeset with valid attributes" do
    changeset = Actuator.changeset(%Actuator{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Actuator.changeset(%Actuator{}, @invalid_attrs)
    refute changeset.valid?
  end

  @tag :skip
  test "delete all associated measurements" do
  end
end
