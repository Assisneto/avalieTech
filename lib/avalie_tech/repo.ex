defmodule AvalieTech.Repo do
  use Ecto.Repo,
    otp_app: :avalie_tech,
    adapter: Ecto.Adapters.Postgres
end
