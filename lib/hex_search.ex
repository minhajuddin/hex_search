defmodule HexSearch do
  require Logger

  def main([search_term]) do
    :inets.start()
    :ssl.start()
    config = :hex_core.default_config()
    options = [sort: :downloads]

    ansi_opts = IEx.Config.ansi_docs()

    case :hex_api_package.search(config, search_term, options) do
      {:ok, {200, _, packages}} ->
        Enum.each(packages, fn p ->
          p |> render |> print(ansi_opts)
        end)

      err ->
        Logger.error("ERROR: #{inspect(err)}")
    end
  end

  def main(_) do
    IO.puts("""
    Invalid args

    Usage
        hex_search name-of-hex-package
    """)
  end

  def render(package) do
    %{
      heading:
        "name: #{package["name"]} downloads: #{package["downloads"]["all"]} licenses: #{
          Enum.join(package["meta"]["licenses"], ", ")
        }",
      body: """
      dep: {:#{package["name"]}, "~> #{hd(package["releases"])["version"]}"}

      links: #{package["meta"]["links"] |> Enum.map(fn {text, href} -> "[#{text}](#{href})" end) |> Enum.join(", ")}

      maintaners: #{Enum.join(package["meta"]["maintainers"], ", ")}

      last update: #{package["updated_at"]}

      #{package["meta"]["description"]}

      """

    }
  end

  def print(package, nil) do
    IO.puts(["# ", package.heading, ?\n])
    IO.puts(package.body)
  end

  def print(package, opts) do
    IO.ANSI.Docs.print_heading(package.heading, opts)
    IO.ANSI.Docs.print(package.body, opts)
  end
end
