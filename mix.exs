defmodule GrpcHealthChecker.MixProject do
  use Mix.Project

  def project do
    [
      app: :grpc_health_checker,
      version: "0.1.0",
      elixir: "~> 1.8",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      name: "gRPC Health Checker",
      source_url: "https://github.com/hiveetoolkit/grpc-health-checker",
      description: description(),
      package: package(),
      docs: docs(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.html": :test,
        "coveralls.json": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    Elixir Cowboy server to expose health checking endpoints in gRPC servers
    """
  end

  defp package do
    [
      maintainers: ["Christopher Enytc"],
      licenses: ["MIT"],
      links: %{
        "Github" => "https://github.com/hiveetoolkit/grpc-health-checker"
      }
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, github: "elixir-grpc/cowboy", tag: "grpc-2.6.3"},
      {:jason, "~> 1.0"},
      {:protobuf, "~> 0.6.2", override: true},
      {:grpc, github: "elixir-grpc/grpc", tag: "v0.4.0"},
      {:credo, "~> 1.1", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.11.2", only: :test, runtime: false},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:inch_ex, "~> 2.0", only: [:dev, :test], runtime: false}
    ]
  end
end
