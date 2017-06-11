defmodule Sense.PageController do
  use Sense.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
