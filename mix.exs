defmodule HexSearch.MixProject do
  use Mix.Project

  def project do
    [
      app: :hex_search,
      name: "HexSearch",
      description: description(),
      package: package(),
      docs: [
        extras: ~W(README.md)
      ],
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
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:hex_core, "> 0.0.0"}
    ]
  end

  defp description do
    """
    A simple utility that allows you to search through the hex packages.
    """
  end

  defp package do
    [
      description: description(),
      files: ~w(lib config mix.exs README.md LICENSE),
      maintainers: ["Khaja Minhajuddin"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "http://github.com/minhajuddin/hex_search",
        "Docs" => "http://hexdocs.pm/hex_search"
      }
    ]
  end
end
