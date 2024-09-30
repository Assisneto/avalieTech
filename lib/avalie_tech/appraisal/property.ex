defmodule AvalieTech.Appraisal.Property do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "properties" do
    field :owner, :string
    field :property_type, :string
    field :registration, :string
    field :land_area, :integer
    field :built_area, :integer
    field :common_area, :integer
    field :garage_area, :integer
    field :storage_area, :integer
    field :total_area, :integer
    field :ideal_fraction, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(property, attrs) do
    property
    |> cast(attrs, [
      :property_type,
      :owner,
      :registration,
      :land_area,
      :built_area,
      :common_area,
      :garage_area,
      :storage_area,
      :total_area,
      :ideal_fraction
    ])
    |> validate_required([
      :property_type,
      :owner,
      :registration,
      :land_area,
      :built_area,
      :common_area,
      :garage_area,
      :storage_area,
      :total_area,
      :ideal_fraction
    ])
  end
end
