defmodule Sense.MetricTest do
  use Sense.ModelCase
  import Sense.Factory
  alias Sense.Metric

  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Metric.changeset(%Metric{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Metric.changeset(%Metric{}, @invalid_attrs)
    refute changeset.valid?
  end

  @tag :skip
  test "delete all associated measurements" do
  end
end
