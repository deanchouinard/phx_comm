defmodule UiWeb.PageController do
  use UiWeb, :controller

  def index(conn, _params) do
    IO.puts "index"
    Core.Worker.push("hello")

    IO.puts Core.Worker.pop()
    IO.inspect Registry.lookup(Registry.ViaTest, "hello")
    render conn, "index.html"
  end
end
