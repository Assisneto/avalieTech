defmodule AvalieTechWeb.PropertyLive.Index do
  use AvalieTechWeb, :live_view

  alias AvalieTech.Appraisal
  alias AvalieTech.Appraisal.Property

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :properties, Appraisal.list_properties())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Property")
    |> assign(:property, Appraisal.get_property!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Property")
    |> assign(:property, %Property{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Properties")
    |> assign(:property, nil)
  end

  @impl true
  def handle_info({AvalieTechWeb.PropertyLive.FormComponent, {:saved, property}}, socket) do
    {:noreply, stream_insert(socket, :properties, property)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    property = Appraisal.get_property!(id)
    {:ok, _} = Appraisal.delete_property(property)

    {:noreply, stream_delete(socket, :properties, property)}
  end
end
