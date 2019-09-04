defmodule GrpcHealthChecker.Health do
  @moduledoc false

  require Logger

  alias Grpc.Health.V1.Health.Stub
  alias Grpc.Health.V1.HealthCheckRequest

  def check do
    request =
      HealthCheckRequest.new(
        service: Application.get_env(:grpc_health_checker, :grpc_service_name)
      )

    with {:ok, channel} <-
           GRPC.Stub.connect(
             Application.get_env(:grpc_health_checker, :grpc_server_url),
             interceptors: [GRPC.Logger.Client]
           ),
         {:ok, reply} <-
           Stub.check(channel, request) do
      response = Jason.encode!(%{"status" => reply.status})
      content_type = "application/json"

      case reply.status do
        :SERVING -> {200, content_type, response}
        :NOT_SERVING -> {503, content_type, response}
        _ -> {500, content_type, response}
      end
    else
      error ->
        Logger.error(error)
        response = Jason.encode!(%{"error" => "Internal Server Error"})
        {500, "application/json", response}
    end
  end
end
