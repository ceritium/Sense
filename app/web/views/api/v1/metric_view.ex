defmodule Sense.Api.V1.MetricView do
  use Sense.Web, :view

  def render("index.json", %{metrics: metrics}) do
    %{data: render_many(metrics, __MODULE__, "metric.json")}
  end

  def render("show.json", %{metric: metric}) do
    %{data: render_one(metric, __MODULE__, "metric.json")}
  end

  def render("metric.json", %{metric: metric}) do
    %{id: metric.id,
      name: metric.name,
      description: metric.description,
      device_id: metric.device_id}
  end
end
