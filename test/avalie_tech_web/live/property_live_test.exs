defmodule AvalieTechWeb.PropertyLiveTest do
  use AvalieTechWeb.ConnCase

  import Phoenix.LiveViewTest
  import AvalieTech.AppraisalFixtures

  @create_attrs %{
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
  @update_attrs %{
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

  defp create_property(_) do
    property = property_fixture()
    %{property: property}
  end

  describe "Index" do
    setup [:create_property]

    test "lists all properties", %{conn: conn, property: property} do
      {:ok, _index_live, html} = live(conn, ~p"/appraisal")

      assert html =~ "Listing Properties"
      assert html =~ property.owner
    end

    test "saves new property", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/appraisal")

      assert index_live |> element("a", "Novo Imóvel") |> render_click() =~ "Novo Imóvel"

      assert_patch(index_live, ~p"/appraisal/new")

      assert index_live
             |> form("#property-form", property: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#property-form", property: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/appraisal")

      html = render(index_live)
      assert html =~ "Property created successfully"
      assert html =~ "some owner"
    end

    test "updates property in listing", %{conn: conn, property: property} do
      {:ok, index_live, _html} = live(conn, ~p"/appraisal")

      assert index_live |> element("#properties-#{property.id} a", "Edit") |> render_click() =~
               "Edit Property"

      assert_patch(index_live, ~p"/appraisal/#{property}/edit")

      assert index_live
             |> form("#property-form", property: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#property-form", property: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/appraisal")

      html = render(index_live)
      assert html =~ "Property updated successfully"
      assert html =~ "some updated owner"
    end

    test "deletes property in listing", %{conn: conn, property: property} do
      {:ok, index_live, _html} = live(conn, ~p"/appraisal")

      assert index_live |> element("#properties-#{property.id} a", "Excluir") |> render_click()
      refute has_element?(index_live, "#properties-#{property.id}")
    end
  end

  describe "Show" do
    setup [:create_property]

    test "displays property", %{conn: conn, property: property} do
      {:ok, _show_live, html} = live(conn, ~p"/appraisal/#{property}")

      assert html =~ "Show Property"
      assert html =~ property.owner
    end

    test "updates property within modal", %{conn: conn, property: property} do
      {:ok, show_live, _html} = live(conn, ~p"/appraisal/#{property}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Property"

      assert_patch(show_live, ~p"/appraisal/#{property}/show/edit")

      assert show_live
             |> form("#property-form", property: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#property-form", property: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/appraisal/#{property}")

      html = render(show_live)
      assert html =~ "Property updated successfully"
      assert html =~ "some updated owner"
    end
  end
end
