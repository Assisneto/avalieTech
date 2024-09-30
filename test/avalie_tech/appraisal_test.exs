defmodule AvalieTech.AppraisalTest do
  use AvalieTech.DataCase

  alias AvalieTech.Appraisal

  describe "properties" do
    alias AvalieTech.Appraisal.Property

    import AvalieTech.AppraisalFixtures

    @invalid_attrs %{
      owner: nil,
      property_type: nil,
      registration: nil,
      land_area: nil,
      built_area: nil,
      common_area: nil,
      garage_area: nil,
      storage_area: nil,
      total_area: nil,
      ideal_fraction: nil
    }

    test "list_properties/0 returns all properties" do
      property = property_fixture()
      assert Appraisal.list_properties() == [property]
    end

    test "get_property!/1 returns the property with given id" do
      property = property_fixture()
      assert Appraisal.get_property!(property.id) == property
    end

    test "create_property/1 with valid data creates a property" do
      valid_attrs = %{
        owner: "some owner",
        property_type: "some property_type",
        registration: "some registration",
        land_area: 42,
        built_area: 42,
        common_area: 42,
        garage_area: 42,
        storage_area: 42,
        total_area: 42,
        ideal_fraction: 42
      }

      assert {:ok, %Property{} = property} = Appraisal.create_property(valid_attrs)
      assert property.owner == "some owner"
      assert property.property_type == "some property_type"
      assert property.registration == "some registration"
      assert property.land_area == 42
      assert property.built_area == 42
      assert property.common_area == 42
      assert property.garage_area == 42
      assert property.storage_area == 42
      assert property.total_area == 42
      assert property.ideal_fraction == 42
    end

    test "create_property/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Appraisal.create_property(@invalid_attrs)
    end

    test "update_property/2 with valid data updates the property" do
      property = property_fixture()

      update_attrs = %{
        owner: "some updated owner",
        property_type: "some updated property_type",
        registration: "some updated registration",
        land_area: 43,
        built_area: 43,
        common_area: 43,
        garage_area: 43,
        storage_area: 43,
        total_area: 43,
        ideal_fraction: 43
      }

      assert {:ok, %Property{} = property} = Appraisal.update_property(property, update_attrs)
      assert property.owner == "some updated owner"
      assert property.property_type == "some updated property_type"
      assert property.registration == "some updated registration"
      assert property.land_area == 43
      assert property.built_area == 43
      assert property.common_area == 43
      assert property.garage_area == 43
      assert property.storage_area == 43
      assert property.total_area == 43
      assert property.ideal_fraction == 43
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
end
