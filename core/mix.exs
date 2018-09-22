defmodule Core.MixProject do
  use Mix.Project

  def project do
    [
      app: :core,
      version: "0.1.0",
      elixir: "~> 1.7",
      #xref: [exclude: [Core.Worker]],
      #xref: [exclude: [Core.Worker, {Core.Worker, :pop, 0}]],
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :runtime_tools, :websocket_client],
      mod: {Core.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:phoenix_channel_client, "~> 0.3"},
      {:jason, "~> 1.0"}, #optional. You can use your own JSON serializer
      {:ui, path: "../ui"},
      {:websocket_client, "~> 1.3"}
    ]
  end
end
