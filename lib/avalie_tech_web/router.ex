defmodule AvalieTechWeb.Router do
  use AvalieTechWeb, :router

  import AvalieTechWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {AvalieTechWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AvalieTechWeb do
  end

  ## Authentication routes

  scope "/", AvalieTechWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{AvalieTechWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
      live "/properties/new", PropertyLive.Index, :new
      live "/properties/:id/edit", PropertyLive.Index, :edit
      live "/", LandingLive
      live "/properties/:id", PropertyLive.Show, :show
      live "/properties/:id/show/edit", PropertyLive.Show, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", AvalieTechWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{AvalieTechWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
      live "/properties", PropertyLive.Index, :index
      live "/home", HomeLive.Index, :index
    end
  end

  scope "/", AvalieTechWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{AvalieTechWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
