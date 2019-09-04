# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :grpc_health_checker,
  port: 5001,
  path: "/healthz",
  grpc_server_url: "localhost:4000",
  grpc_service_name: "grpc.health.v1.Health"
