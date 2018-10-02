defmodule Sense.Api.V1.ActuatorView do
  use Sense.Web, :view

  def render("index.json", %{actuators: actuators}) do
    %{data: render_many(actuators, __MODULE__, "actuator.json")}
  end

  def render("show.json", %{actuator: actuator}) do
    %{data: render_one(actuator, __MODULE__, "actuator.json")}
  end

  def render("actuator.json", %{actuator: actuator}) do
    %{id: actuator.id,
      name: actuator.name,
      description: actuator.description,
      type: actuator.type,
      value: actuator.value,
      device_id: actuator.device_id}
  end
end
