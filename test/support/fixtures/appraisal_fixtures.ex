defmodule AvalieTech.AppraisalFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AvalieTech.Appraisal` context.
  """

  @doc """
  Generate a property.
  """
  def property_fixture(attrs \\ %{}) do
    {:ok, property} =
      attrs
      |> Enum.into(%{
        built_area: 42,
        common_area: 42,
        garage_area: 42,
        ideal_fraction: 42,
        land_area: 42,
        owner: "some owner",
        property_type: "some property_type",
        registration: "some registration",
        storage_area: 42,
        total_area: 42
      })
      |> AvalieTech.Appraisal.create_property()

    property
  end
end
