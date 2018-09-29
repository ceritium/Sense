defmodule Sense.Api.V1.SessionView do
  use Sense.Web, :view

  def render("unauthorized.json", _) do
    %{error: gettext("Unauthorized")}
  end
end
