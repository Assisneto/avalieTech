defmodule AvalieTechWeb.PropertyLive.Index do
  use AvalieTechWeb, :live_view

  alias AvalieTech.Appraisal
  alias AvalieTech.Appraisal.{Property, AppraisalReport}
  alias AvalieTech.Appraisal.Address

  @impl true
  def mount(_params, _session, socket) do
    changeset =
      Property.changeset(%Property{
        address: %Address{},
        appraisal_reports: [
          %AppraisalReport{
            methodology: "Método comparativo direto de dados de marcado"
          }
        ]
      })

    socket =
      socket
      |> assign(:form, to_form(changeset))
      |> assign(:show_invoice_link, false)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
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
    user_id = socket.assigns.current_user.id

    appraisal_reports = Map.get(property_params, "appraisal_reports", %{})

    updated_appraisal_reports =
      appraisal_reports
      |> Enum.map(fn {_, report} ->
        Map.put(report, "user_id", user_id)
      end)

    updated_property_params =
      Map.put(property_params, "appraisal_reports", updated_appraisal_reports)

    case Appraisal.create_property(updated_property_params) do
      {:ok, property} ->
        {:noreply,
         socket
         |> put_flash(:info, "Property created successfully")
         |> redirect(to: ~p"/generate?property_id=#{property.id}")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end
end
