defmodule HexSearch.MixProject do
  use Mix.Project

  def project do
    [
      app: :hex_search,
      version: "0.1.0",
      elixir: "~> 1.6",
      escript: [main_module: HexSearch],
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:hex_core, "> 0.0.0"}
    ]
  end
end
