defmodule AvalieTech.Appraisal.AppraisalReport do
  use Ecto.Schema
  import Ecto.Changeset

  alias AvalieTech.Users.User
  alias AvalieTech.Appraisal.Property

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "appraisal_reports" do
    belongs_to :user, User, type: :integer
    belongs_to :property, Property, type: :binary_id

    field :requester, :string
    field :request_date, :date
    field :inspection_date, :date
    field :report_date, :date

    field :objective, :string
    field :intended_use, :string

    field :lower_value, :decimal
    field :market_value, :decimal
    field :upper_value, :decimal

    field :general_comments, :string
    field :methodology, :string
    field :data_processing, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(appraisal_report, attrs) do
    appraisal_report
    |> cast(attrs, [
      :user_id,
      :property_id,
      :requester,
      :request_date,
      :inspection_date,
      :report_date,
      :objective,
      :intended_use,
      :lower_value,
      :market_value,
      :upper_value,
      :general_comments,
      :methodology,
      :data_processing
    ])
    |> validate_required([:user_id])
    |> validate_length(:requester, max: 255)
    |> validate_length(:objective, max: 500)
    |> validate_length(:intended_use, max: 500)
    |> validate_number(:lower_value, greater_than_or_equal_to: 0)
    |> validate_number(:market_value, greater_than_or_equal_to: 0)
    |> validate_number(:upper_value, greater_than_or_equal_to: 0)
  end
end
