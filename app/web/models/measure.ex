defmodule Sense.Measure do
  use Instream.Series
  import Instream.Query.Builder

  series do
    measurement "device_metrics"

    tag :metric_id

    field :value
  end

  def by_metric(metric) do
    results = from(Sense.Measure)
    |> select(["value"])
    |> where(%{metric_id: Integer.to_string(metric.id)})
    |> Sense.Influx.query()
    
    results[:results] |> List.first
  end

  def write_measure(metric, value) do
    data = %Sense.Measure{}
    data = %{data | fields: %{data.fields | value: value}}
    data = %{data | tags: %{data.tags | metric_id: metric.id}}

    data
    |> Sense.Influx.write(async: true)
  end

  def delete_measures(metric) do
    "DELETE FROM device_metrics WHERE metric_id = #{metric.id}"
    |> Sense.Influx.execute(method: :post)

    :ok
  end

  def create_database do
    "device_metrics"
    |> Instream.Admin.Database.create()
    |> Sense.Influx.execute()
  end

  def delete_database do
    "device_metrics"
    |> Instream.Admin.Database.create()
    |> Sense.Influx.execute()
  end
end
