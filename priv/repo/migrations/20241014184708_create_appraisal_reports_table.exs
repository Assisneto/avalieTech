defmodule AvalieTech.Repo.Migrations.CreateAppraisalReportsTable do
  use Ecto.Migration

  def change do
    create table(:appraisal_reports, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :property_id, references(:properties, type: :uuid, on_delete: :delete_all), null: false

      add :requester, :string
      add :request_date, :date
      add :inspection_date, :date
      add :report_date, :date

      add :objective, :string
      add :intended_use, :string

      add :lower_value, :decimal
      add :market_value, :decimal
      add :upper_value, :decimal

      add :general_comments, :text
      add :methodology, :text
      add :data_processing, :text

      timestamps(type: :utc_datetime)
    end

    create index(:appraisal_reports, [:user_id])
    create index(:appraisal_reports, [:property_id])
  end
end
