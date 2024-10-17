defmodule AvalieTechWeb.ChartComponent do
  use Phoenix.Component
  alias Contex.{Dataset, Plot, BarChart}

  def chart(assigns) do
    data = [
      %{mes: "Janeiro", vendas: 30},
      %{mes: "Fevereiro", vendas: 45},
      %{mes: "Março", vendas: 10},
      %{mes: "Abril", vendas: 60}
    ]

    dataset = Dataset.new(data)

    # Forneça o mapeamento e as opções ao criar o BarChart
    bar_chart =
      BarChart.new(
        dataset,
        mapping: %{category_col: :mes, value_cols: [:vendas]},
        data_labels: true
      )

    # Ajuste a ordem dos parâmetros em Plot.new/3
    plot =
      Plot.new(600, 400, bar_chart)
      |> Plot.titles("Vendas Mensais", "Em milhares de reais")
      |> Plot.axis_labels("Mês", "Valor")

    {:safe, svg} = Plot.to_svg(plot)

    assigns = assign(assigns, svg: svg)

    ~H"""
    <div>
      <%= Phoenix.HTML.raw(@svg) %>
    </div>
    """
  end
end
