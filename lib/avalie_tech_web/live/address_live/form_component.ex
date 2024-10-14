defmodule AvalieTechWeb.AddressLive.FormComponent do
  use AvalieTechWeb, :live_component

  alias AvalieTech.Appraisal

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage address records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="address-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:street_address]} type="text" label="Street address" />
        <.input field={@form[:complement]} type="text" label="Complement" />
        <.input field={@form[:neighborhood]} type="text" label="Neighborhood" />
        <.input field={@form[:city]} type="text" label="City" />
        <.input field={@form[:state]} type="text" label="State" />
        <.input field={@form[:postal_code]} type="text" label="Postal code" />
        <.input field={@form[:latitude]} type="number" label="Latitude" step="any" />
        <.input field={@form[:longitude]} type="number" label="Longitude" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Address</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{address: address} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Appraisal.change_address(address))
     end)}
  end

  @impl true
  def handle_event("validate", %{"address" => address_params}, socket) do
    changeset = Appraisal.change_address(socket.assigns.address, address_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"address" => address_params}, socket) do
    save_address(socket, socket.assigns.action, address_params)
  end

  defp save_address(socket, :edit, address_params) do
    case Appraisal.update_address(socket.assigns.address, address_params) do
      {:ok, address} ->
        notify_parent({:saved, address})

        {:noreply,
         socket
         |> put_flash(:info, "Address updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_address(socket, :new, address_params) do
    case Appraisal.create_address(address_params) do
      {:ok, address} ->
        notify_parent({:saved, address})

        {:noreply,
         socket
         |> put_flash(:info, "Address created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
