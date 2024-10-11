defmodule AvalieTech.Appraisal.Property do
  use Ecto.Schema
  import Ecto.Changeset

  schema "properties" do
    field :owner, :string
    field :registration_number, :string
    field :address_id, Ecto.UUID

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(property, attrs) do
    property
    |> cast(attrs, [:owner, :registration_number, :address_id])
    |> validate_required([:owner, :registration_number, :address_id])
  end
end
