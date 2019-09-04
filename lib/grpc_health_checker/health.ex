defmodule GrpcHealthChecker.Health do
  @moduledoc false

  require Logger

  def check do
    request_struct = Application.fetch_env!(:grpc_health_checker, :grpc_request_struct)
    stub = Application.fetch_env!(:grpc_health_checker, :grpc_stub)

    request =
      request_struct.new(service: Application.get_env(:grpc_health_checker, :grpc_service_name))

    with {:ok, channel} <-
           GRPC.Stub.connect(
             Application.get_env(:grpc_health_checker, :grpc_server_url),
             interceptors: [GRPC.Logger.Client]
           ),
         {:ok, reply} <-
           stub.check(channel, request) do
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
