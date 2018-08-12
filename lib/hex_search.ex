defmodule HexSearch do
  require Logger

  def main([search_term]) do
    :inets.start()
    :ssl.start()
    config = :hex_core.default_config()
    options = [sort: :downloads]

    case :hex_api_package.search(config, search_term, options) do
      {:ok, {200, _, packages}} ->
        packages
        |> Enum.each(&print/1)

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

  def print(package) do
    IO.puts("""
    >> dep: {:#{package["name"]}, "~> #{hd(package["releases"])["version"]}"}

    maintaners: #{Enum.join(package["meta"]["maintainers"], ", ")}
    links: #{
    package["meta"]["links"]
    |> Enum.map(fn {text, href} -> "[#{text}](#{href})" end)
    |> Enum.join(", ")
    }
    """)

    IO.puts(package["meta"]["description"])
    IO.puts("---\n")
  end
end
