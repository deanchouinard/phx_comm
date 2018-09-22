defmodule Core.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Core.Worker.start_link(arg)
      # {Core.Worker, arg},

      {Registry, keys: :unique, name: Registry.ViaTest},
      {Registry, keys: :unique, name: :my_registry},
      {Core.Worker, []},
      {EchoServer, "server one"},
      # {MySocket, []},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Core.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
