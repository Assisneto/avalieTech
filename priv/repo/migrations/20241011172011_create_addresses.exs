defmodule AvalieTech.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :street_address, :string
      add :complement, :string
      add :neighborhood, :string
      add :house_number, :string, null: false
      add :city, :string
      add :state, :string
      add :postal_code, :string
      add :latitude, :float
      add :longitude, :float
      add :property_id, references(:properties, on_delete: :delete_all, type: :uuid), null: false
      timestamps(type: :utc_datetime)
    end
  end
end
