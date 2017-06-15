defmodule Sense.MeasureTest do
  use Sense.ModelCase
  import Sense.Factory
  alias Sense.{Metric, Measure}

  setup do
    Measure.delete_database
    Measure.create_database
  end
  
  @valid_attrs %{tag: "1", value: 1}
  @invalid_attrs %{}

  test "create a measure for a metric" do
    metric = insert(:metric)
    assert Sense.Measure.write_measure(metric, 1) == :ok
  end

  test "delete all measures for a metric" do
    metric = insert(:metric)
    Sense.Measure.write_measure(metric, 1)
    assert Sense.Measure.delete_measures(metric) == :ok
  end

  test "query metric's measurements with by_metric" do
    metric = insert(:metric)
    Sense.Measure.write_measure(metric, 2)
    Sense.Measure.write_measure(metric, 1)
    
    assert Sense.Measure.by_metric(metric)
  end
end
