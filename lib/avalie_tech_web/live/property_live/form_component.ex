defmodule AvalieTechWeb.PropertyLive.FormComponent do
  use AvalieTechWeb, :live_component

  alias AvalieTech.Appraisal

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage property records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="property-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:owner]} type="text" label="Owner" />
        <.input field={@form[:registration_number]} type="text" label="Registration number" />
        <.input field={@form[:address_id]} type="text" label="Address" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Property</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{property: property} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Appraisal.change_property(property))
     end)}
  end

  @impl true
  def handle_event("validate", %{"property" => property_params}, socket) do
    changeset = Appraisal.change_property(socket.assigns.property, property_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"property" => property_params}, socket) do
    save_property(socket, socket.assigns.action, property_params)
  end

  defp save_property(socket, :edit, property_params) do
    case Appraisal.update_property(socket.assigns.property, property_params) do
      {:ok, property} ->
        notify_parent({:saved, property})

        {:noreply,
         socket
         |> put_flash(:info, "Property updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_property(socket, :new, property_params) do
    case Appraisal.create_property(property_params) do
      {:ok, property} ->
        notify_parent({:saved, property})

        {:noreply,
         socket
         |> put_flash(:info, "Property created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
