defmodule Sense.Measure do
  use Instream.Series
  import Instream.Query.Builder

  series do
    measurement "device_metrics"

    tag :metric_id

    field :value
  end


  def by_metric(metric) do
    from(Sense.Measure)
    |> select(["value"])
    |> where(%{device_id: Integer.to_string(metric.id)})
    |> Sense.Influx.query()
  end

  def write_measure(metric, value) do
    data = %Sense.Measure{}
    data = %{data | fields: %{data.fields | value: value}}
    data = %{data | tags: %{data.tags | metric_id: metric.id}}

    data
    |> Sense.Influx.write(async: true)
  end

  def create_database do
    "device_metrics"
    |> Instream.Admin.Database.create()
    |> Sense.Influx.execute()
  end
end
