defmodule Sense.CorsAllow do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    put_resp_header(conn, "access-control-allow-origin", "*")
  end
end
