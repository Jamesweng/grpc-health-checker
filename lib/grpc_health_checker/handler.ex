defmodule GrpcHealthChecker.Handler do
  @moduledoc false

  @behaviour :cowboy_handler

  alias GrpcHealthChecker.Health

  # API

  def init(request, state) do
    method = :cowboy_req.method(request)
    handle(method, request, state)
  end

  def handle("GET", request, state) do
    request = gen_response(request)
    {:ok, request, state}
  end

  def handle(_method, request, state) do
    {:ok, request, state}
  end

  # Helpers

  def gen_response(request) do
    {status_code, content_type, data} = Health.check()
    headers = %{"content-type" => content_type}
    :cowboy_req.reply(status_code, headers, data, request)
  end
end
