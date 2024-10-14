defmodule AvalieTech.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :street_address, :string
      add :complement, :string
      add :neighborhood, :string
      add :city, :string
      add :state, :string
      add :postal_code, :string
      add :latitude, :float
      add :longitude, :float
      add :property_id, references(:properties, on_delete: :delete_all), null: false
      timestamps(type: :utc_datetime)
    end
  end
end
