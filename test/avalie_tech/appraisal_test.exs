defmodule AvalieTech.AppraisalTest do
  use AvalieTech.DataCase

  alias AvalieTech.Appraisal

  describe "properties" do
    alias AvalieTech.Appraisal.Property

    import AvalieTech.AppraisalFixtures

    @invalid_attrs %{owner: nil, registration_number: nil, address_id: nil}

    test "list_properties/0 returns all properties" do
      property = property_fixture()
      assert Appraisal.list_properties() == [property]
    end

    test "get_property!/1 returns the property with given id" do
      property = property_fixture()
      assert Appraisal.get_property!(property.id) == property
    end

    test "create_property/1 with valid data creates a property" do
      valid_attrs = %{owner: "some owner", registration_number: "some registration_number", address_id: "7488a646-e31f-11e4-aace-600308960662"}

      assert {:ok, %Property{} = property} = Appraisal.create_property(valid_attrs)
      assert property.owner == "some owner"
      assert property.registration_number == "some registration_number"
      assert property.address_id == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_property/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Appraisal.create_property(@invalid_attrs)
    end

    test "update_property/2 with valid data updates the property" do
      property = property_fixture()
      update_attrs = %{owner: "some updated owner", registration_number: "some updated registration_number", address_id: "7488a646-e31f-11e4-aace-600308960668"}

      assert {:ok, %Property{} = property} = Appraisal.update_property(property, update_attrs)
      assert property.owner == "some updated owner"
      assert property.registration_number == "some updated registration_number"
      assert property.address_id == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_property/2 with invalid data returns error changeset" do
      property = property_fixture()
      assert {:error, %Ecto.Changeset{}} = Appraisal.update_property(property, @invalid_attrs)
      assert property == Appraisal.get_property!(property.id)
    end

    test "delete_property/1 deletes the property" do
      property = property_fixture()
      assert {:ok, %Property{}} = Appraisal.delete_property(property)
      assert_raise Ecto.NoResultsError, fn -> Appraisal.get_property!(property.id) end
    end

    test "change_property/1 returns a property changeset" do
      property = property_fixture()
      assert %Ecto.Changeset{} = Appraisal.change_property(property)
    end
  end

  describe "addresses" do
    alias AvalieTech.Appraisal.Address

    import AvalieTech.AppraisalFixtures

    @invalid_attrs %{state: nil, street_address: nil, complement: nil, neighborhood: nil, city: nil, postal_code: nil, latitude: nil, longitude: nil}

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Appraisal.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Appraisal.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      valid_attrs = %{state: "some state", street_address: "some street_address", complement: "some complement", neighborhood: "some neighborhood", city: "some city", postal_code: "some postal_code", latitude: 120.5, longitude: 120.5}

      assert {:ok, %Address{} = address} = Appraisal.create_address(valid_attrs)
      assert address.state == "some state"
      assert address.street_address == "some street_address"
      assert address.complement == "some complement"
      assert address.neighborhood == "some neighborhood"
      assert address.city == "some city"
      assert address.postal_code == "some postal_code"
      assert address.latitude == 120.5
      assert address.longitude == 120.5
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Appraisal.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      update_attrs = %{state: "some updated state", street_address: "some updated street_address", complement: "some updated complement", neighborhood: "some updated neighborhood", city: "some updated city", postal_code: "some updated postal_code", latitude: 456.7, longitude: 456.7}

      assert {:ok, %Address{} = address} = Appraisal.update_address(address, update_attrs)
      assert address.state == "some updated state"
      assert address.street_address == "some updated street_address"
      assert address.complement == "some updated complement"
      assert address.neighborhood == "some updated neighborhood"
      assert address.city == "some updated city"
      assert address.postal_code == "some updated postal_code"
      assert address.latitude == 456.7
      assert address.longitude == 456.7
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Appraisal.update_address(address, @invalid_attrs)
      assert address == Appraisal.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Appraisal.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Appraisal.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Appraisal.change_address(address)
    end
  end
end
