defmodule AvalieTech.Appraisal.Property do
  use Ecto.Schema
  import Ecto.Changeset

  alias AvalieTech.Appraisal.Address

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "properties" do
    field :owner, :string
    field :registration_number, :string

    has_one :address, Address, on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(property, attrs \\ %{}) do
    property
    |> cast(attrs, [:owner, :registration_number])
    |> validate_required([:owner, :registration_number])
    |> cast_assoc(:address, required: true)
  end
end
