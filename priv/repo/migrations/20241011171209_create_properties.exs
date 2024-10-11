defmodule AvalieTech.Repo.Migrations.CreateProperties do
  use Ecto.Migration

  def change do
    create table(:properties) do
      add :owner, :string
      add :registration_number, :string
      add :address_id, :uuid

      timestamps(type: :utc_datetime)
    end
  end
end
