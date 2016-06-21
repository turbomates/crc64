defmodule CRC64.Mixfile do
  use Mix.Project

  def project do
    [app: :crc64,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     compilers: [:elixir_make] ++ Mix.compilers,
     deps: deps]
  end

  def application, do: [applications: []]
  defp deps, do: [{:elixir_make, "~> 0.2.0"}]
end
