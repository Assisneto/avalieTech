defmodule AvalieTech.Appraisal.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :state, :string
    field :street_address, :string
    field :complement, :string
    field :neighborhood, :string
    field :city, :string
    field :postal_code, :string
    field :latitude, :float
    field :longitude, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:street_address, :complement, :neighborhood, :city, :state, :postal_code, :latitude, :longitude])
    |> validate_required([:street_address, :complement, :neighborhood, :city, :state, :postal_code, :latitude, :longitude])
  end
end
