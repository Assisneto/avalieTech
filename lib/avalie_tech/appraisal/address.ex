defmodule AvalieTech.Appraisal.Address do
  use Ecto.Schema
  import Ecto.Changeset

  alias AvalieTech.Appraisal.Property

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "addresses" do
    field :state, :string
    field :street_address, :string
    field :house_number, :string
    field :complement, :string
    field :neighborhood, :string
    field :city, :string
    field :postal_code, :string
    field :latitude, :float
    field :longitude, :float

    belongs_to :property, Property, type: Ecto.UUID

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [
      :street_address,
      :house_number,
      :complement,
      :neighborhood,
      :city,
      :state,
      :postal_code,
      :latitude,
      :longitude
    ])
    |> validate_required([:street_address, :house_number, :city, :state, :postal_code])
    |> validate_length(:state, is: 2, message: "deve ter exatamente 2 letras")
    |> validate_format(:state, ~r/^[A-Za-z]{2}$/, message: "deve conter apenas letras")
    |> validate_length(:postal_code, is: 8, message: "deve ter exatamente 8 números")
    |> validate_format(:postal_code, ~r/^\d{8}$/, message: "deve conter apenas números")
    |> update_change(:state, &String.upcase/1)
  end
end
