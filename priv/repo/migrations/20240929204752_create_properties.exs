defmodule AvalieTech.Repo.Migrations.CreateProperties do
  use Ecto.Migration

  def change do
    create table(:properties, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :property_type, :string
      add :owner, :text
      add :registration, :text
      add :land_area, :integer
      add :built_area, :integer
      add :common_area, :integer
      add :garage_area, :integer
      add :storage_area, :integer
      add :total_area, :integer
      add :ideal_fraction, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
