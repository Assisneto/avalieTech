defmodule AvalieTech.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AvalieTechWeb.Telemetry,
      AvalieTech.Repo,
      {ChromicPDF, Application.get_env(:avalie_tech, ChromicPDF)},
      {DNSCluster, query: Application.get_env(:avalie_tech, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AvalieTech.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AvalieTech.Finch},
      # Start a worker by calling: AvalieTech.Worker.start_link(arg)
      # {AvalieTech.Worker, arg},
      # Start to serve requests, typically the last entry
      AvalieTechWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AvalieTech.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AvalieTechWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
