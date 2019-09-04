# gRPC Health Checker

> Elixir Cowboy server to expose health checking endpoints in gRPC servers

[![Maintenance](https://img.shields.io/maintenance/yes/2019.svg)]()
[![License](https://img.shields.io/github/license/hiveetoolkit/grpc-health-checker.svg)](https://github.com/hiveetoolkit/grpc-health-checker/blob/master/LICENSE)
![Travis (.org)](https://img.shields.io/travis/hiveetoolkit/grpc-health-checker)
[![codecov](https://codecov.io/gh/hiveetoolkit/grpc-health-checker/branch/master/graph/badge.svg)](https://codecov.io/gh/hiveetoolkit/grpc-health-checker)
![GitHub release (latest SemVer including pre-releases)](https://img.shields.io/github/v/release/hiveetoolkit/grpc-health-checker?include_prereleases)
![GitHub Release Date](https://img.shields.io/github/release-date/hiveetoolkit/grpc-health-checker)
![GitHub last commit](https://img.shields.io/github/last-commit/hiveetoolkit/grpc-health-checker)

## Installation

In the `mix.exs`:

```elixir
def deps do
  [
    {:grpc_health_checker, github: "hiveetoolkit/grpc-health-checker", tag: "v0.1.0"}
  ]
end
```

In the `application.ex` or where you put the supervision tree

```elixir
import Supervisor.Spec

children = [
  supervisor(GrpcHealthChecker.Supervisor, [])
]

opts = [strategy: :one_for_one, name: Example.Supervisor]
Supervisor.start_link(children, opts)
```

## Configuration

After installation, you will need to edit your `config/config.ex` to add the configurations for the gRPC Health Checker.

```elixir
config :grpc_health_checker,
  port: 5001,
  path: "/healthz",
  grpc_server_url: "localhost:4000",
  grpc_service_name: "grpc.health.v1.Health"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/hiveetoolkit/grpc-health-checker](https://github.com/hiveetoolkit/grpc-health-checker). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://contributor-covenant.org) code of conduct.

1. Fork it [hiveetoolkit/grpc-health-checker](https://github.com/hiveetoolkit/grpc-health-checker/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Support

If you have any problem or suggestion please open an issue [here](https://github.com/hiveetoolkit/grpc-health-checker/issues).

## License

Check [here](LICENSE).