defmodule AvalieTechWeb.LandingLive do
  alias AvalieTech.Mailer
  alias AvalieTech.Users.UserEmail
  use AvalieTechWeb, :live_view
  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def(handle_event("try_now", %{"email" => email, "name" => name}, socket)) do
    user = %{name: name, email: email}

    email = UserEmail.experiment_email(user)

    case Mailer.deliver(email) do
      {:ok, _metadata} ->
        Logger.info("E-mail enviado com sucesso para #{user.email}")
        {:noreply, socket}

      {:error, reason} ->
        Logger.error("Falha ao enviar e-mail: #{inspect(reason)}")
        {:noreply, socket}
    end
  end
end
