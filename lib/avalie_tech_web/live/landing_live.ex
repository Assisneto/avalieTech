defmodule AvalieTechWeb.LandingLive do
  use AvalieTechWeb, :live_view
  alias AvalieTech.Mailer
  alias AvalieTech.Users.UserEmail
  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, form_submitted: false)}
  end

  @impl true
  def handle_event("try_now", %{"email" => email, "name" => name}, socket) do
    user = %{name: name, email: email}

    email = UserEmail.experiment_email(user)

    case Mailer.deliver(email) do
      {:ok, _metadata} ->
        Logger.info("E-mail enviado com sucesso para #{user.email}")
        {:noreply, assign(socket, form_submitted: true)}

      {:error, reason} ->
        Logger.error("Falha ao enviar e-mail: #{inspect(reason)}")
        {:noreply, socket}
    end
  end

  def handle_event("close_thank_you", _, socket) do
    {:noreply, assign(socket, form_submitted: false)}
  end
end
