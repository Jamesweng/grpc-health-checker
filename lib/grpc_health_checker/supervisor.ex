defmodule GrpcHealthChecker.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      worker(GrpcHealthChecker.Server, [[name: GrpcHealthChecker.Server]])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GrpcHealthChecker.Supervisor]
    Supervisor.init(children, opts)
  end
end
