defmodule PhoenixSandbox.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_sandbox,
    adapter: Ecto.Adapters.Postgres
end
