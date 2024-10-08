defmodule AvalieTechWeb.LandingLive do
  alias AvalieTech.Mailer
  alias AvalieTech.Users.UserEmail
  use AvalieTechWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event("try_now", %{"email" => email, "name" => name}, socket) do
    user = %{name: name, email: email}

    user
    |> UserEmail.experiment_email()
    |> Mailer.deliver()

    {:noreply, socket}
  end
end
