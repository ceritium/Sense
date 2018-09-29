defmodule Sense.MeasureTest do
  use Sense.ModelCase
  import Sense.Factory
  alias Sense.{Measure}

  setup do
    Measure.delete_database
    Measure.create_database
  end
  
  test "create a measure for a metric" do
    metric = insert(:metric)
    assert Sense.Measure.write_measure(metric, 1) == :ok
  end

  test "create a measure for a metric with specified timestamp" do
    metric = insert(:metric)
    timestamp = (DateTime.utc_now |> DateTime.to_unix) - 1000
    assert Sense.Measure.write_measure(metric, 1, false, timestamp) == :ok
    target_measure = Sense.Measure.by_metric(metric) |> List.first
    {:ok, target_date, _0} = DateTime.from_iso8601(target_measure[:timestamp])
    assert  DateTime.to_unix(target_date) == timestamp
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
