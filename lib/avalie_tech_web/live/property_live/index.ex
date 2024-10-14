defmodule AvalieTechWeb.PropertyLive.Index do
  use AvalieTechWeb, :live_view

  alias AvalieTech.Appraisal
  alias AvalieTech.Appraisal.Property
  alias AvalieTech.Appraisal.Address
  alias AvalieTech.Repo

  @impl true
  def mount(_params, _session, socket) do
    # Initialize with an empty changeset
    changeset =
      Property.changeset(%Property{
        address: %Address{}
      })

    socket =
      socket
      |> assign(:form, to_form(changeset))

    IO.inspect(socket.assigns.form, label: "Form Changeset")

    {:ok, stream(socket, :properties, Appraisal.list_properties())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    changeset =
      Property.changeset(%Property{
        address: %Address{}
      })

    socket
    |> assign(:page_title, "New Property")
    |> assign(:property, %Property{})
    |> assign(:form, to_form(changeset))
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    property = Appraisal.get_property!(id) |> Repo.preload(:address)
    changeset = Property.changeset(property)

    socket
    |> assign(:page_title, "Edit Property")
    |> assign(:property, property)
    |> assign(:form, to_form(changeset))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Properties")
    |> assign(:property, nil)
  end

  @impl true
  def handle_event("save", %{"property" => property_params}, socket) do
    save_property(socket, property_params)
  end

  defp save_property(socket, property_params) do
    case Appraisal.create_property(property_params) do
      {:ok, property} ->
        {:noreply, stream_insert(socket, :properties, property)}

        {:noreply,
         socket
         |> put_flash(:info, "Property created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end
end
