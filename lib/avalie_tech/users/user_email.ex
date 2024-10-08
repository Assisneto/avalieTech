defmodule AvalieTech.Users.UserEmail do
  import Swoosh.Email

  def experiment_email(user) do
    new()
    |> to({user.name, user.email})
    |> from({"AvalieTech", "no-reply@avalietech.com"})
    |> subject("Experimente Agora AvalieTech")
    |> html_body("<h1>Olá, #{user.name}!</h1><p>Obrigado por experimentar o AvalieTech!</p>")
    |> text_body("Olá, #{user.name}! Obrigado por experimentar o AvalieTech!")
  end
end
