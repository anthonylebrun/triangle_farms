defmodule TriangleFarms.Application do
  use Application

  @concache_config [
    name: TriangleFarms.Calendar.EventCache,
    ttl_check_interval: :timer.hours(1),
    global_ttl: :timer.hours(24)
  ]

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      # supervisor(TriangleFarms.Repo, []),
      # Start the endpoint when the application starts
      supervisor(TriangleFarmsWeb.Endpoint, []),
      # Start your own worker by calling: TriangleFarms.Worker.start_link(arg1, arg2, arg3)
      # worker(TriangleFarms.Worker, [arg1, arg2, arg3]),
      supervisor(ConCache, [[], @concache_config])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TriangleFarms.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TriangleFarmsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
