defmodule AvalieTech.Users.UserEmail do
  import Swoosh.Email

  use Phoenix.Swoosh,
    template_root: "lib/avalie_tech_web/templates",
    template_path: "user_emails"

  use Phoenix.VerifiedRoutes, endpoint: AvalieTechWeb.Endpoint, router: AvalieTechWeb.Router

  def experiment_email(user) do
    new()
    |> to({user.name, user.email})
    |> from({"AvalieTech", "avalietech@gmail.com"})
    |> subject("Bem-vindo ao AvalieTech!")
    |> render_body("experiment_email.html", %{
      user: user,
      url: path(@endpoint, ~p"/users/register")
    })
  end
end
