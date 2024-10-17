defmodule AvalieTechWeb.PdfController do
  alias AvalieTechWeb.Endpoint
  alias AvalieTech.Appraisal
  alias AvalieTechWeb.PdfComponent.PdfRendererComponent
  use AvalieTechWeb, :controller
  use Phoenix.VerifiedRoutes, endpoint: AvalieTechWeb.Endpoint, router: AvalieTechWeb.Router

  def index(conn, %{"property_id" => property_id}) do
    property = Appraisal.get_property_full!(property_id)

    svg_url = static_url(conn, "/images/info.svg")
    css = static_url(conn, "/css/pdf.css")

    conn =
      assign(conn, :property, property)
      |> assign(:endpoint, Endpoint)
      |> assign(:svg_path, svg_url)
      |> assign(:css, css)

    {:ok, pdf} = to_pdf(conn.assigns)

    send_download(
      conn,
      {:binary, Base.decode64!(pdf)},
      content_type: "application/pdf",
      filename: "avaliacao.pdf"
    )
  end

  def to_pdf(assigns) do
    [
      content: content(assigns),
      size: :a4
    ]
    |> ChromicPDF.Template.source_and_options()
    |> ChromicPDF.print_to_pdf()
  end

  defp content(assigns) do
    Phoenix.HTML.Safe.to_iodata(PdfRendererComponent.render(assigns))
  end
end
