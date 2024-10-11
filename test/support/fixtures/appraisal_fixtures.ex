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
        address_id: "7488a646-e31f-11e4-aace-600308960662",
        owner: "some owner",
        registration_number: "some registration_number"
      })
      |> AvalieTech.Appraisal.create_property()

    property
  end

  @doc """
  Generate a address.
  """
  def address_fixture(attrs \\ %{}) do
    {:ok, address} =
      attrs
      |> Enum.into(%{
        city: "some city",
        complement: "some complement",
        latitude: 120.5,
        longitude: 120.5,
        neighborhood: "some neighborhood",
        postal_code: "some postal_code",
        state: "some state",
        street_address: "some street_address"
      })
      |> AvalieTech.Appraisal.create_address()

    address
  end
end
