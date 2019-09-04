defmodule GrpcHealthChecker.Server do
  @moduledoc false

  require Logger

  # API

  def start_link(options \\ []) do
    port = Application.get_env(:grpc_health_checker, :port)

    options =
      options
      |> Keyword.put_new(:env, %{dispatch: build_config()})
      |> Keyword.put_new(:compress, true)
      |> Enum.into(%{})

    {:ok, pid} = :cowboy.start_clear(:http, [port: port], options)

    Logger.info(
      "Running #{inspect(GrpcHealthChecker.Server)} with Cowboy using http://0.0.0.0:#{port}"
    )

    {:ok, pid}
  end

  # Helpers

  def build_config do
    :cowboy_router.compile([
      {:_, [{Application.get_env(:grpc_health_checker, :path), GrpcHealthChecker.Handler, []}]}
    ])
  end
end
