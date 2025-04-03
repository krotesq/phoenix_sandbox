defmodule PhoenixSandbox.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixSandboxWeb.Telemetry,
      PhoenixSandbox.Repo,
      {DNSCluster, query: Application.get_env(:phoenix_sandbox, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixSandbox.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixSandbox.Finch},
      # Start a worker by calling: PhoenixSandbox.Worker.start_link(arg)
      # {PhoenixSandbox.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixSandboxWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixSandbox.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixSandboxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
