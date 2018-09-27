defmodule UiWeb.PageController do
  use UiWeb, :controller

  def index(conn, _params) do
    UI.Sensor.get_temp()

    render conn, "index.html"
  end
end
