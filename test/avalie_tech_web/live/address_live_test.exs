defmodule AvalieTechWeb.AddressLiveTest do
  use AvalieTechWeb.ConnCase

  import Phoenix.LiveViewTest
  import AvalieTech.AppraisalFixtures

  @create_attrs %{state: "some state", street_address: "some street_address", complement: "some complement", neighborhood: "some neighborhood", city: "some city", postal_code: "some postal_code", latitude: 120.5, longitude: 120.5}
  @update_attrs %{state: "some updated state", street_address: "some updated street_address", complement: "some updated complement", neighborhood: "some updated neighborhood", city: "some updated city", postal_code: "some updated postal_code", latitude: 456.7, longitude: 456.7}
  @invalid_attrs %{state: nil, street_address: nil, complement: nil, neighborhood: nil, city: nil, postal_code: nil, latitude: nil, longitude: nil}

  defp create_address(_) do
    address = address_fixture()
    %{address: address}
  end

  describe "Index" do
    setup [:create_address]

    test "lists all addresses", %{conn: conn, address: address} do
      {:ok, _index_live, html} = live(conn, ~p"/addresses")

      assert html =~ "Listing Addresses"
      assert html =~ address.state
    end

    test "saves new address", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/addresses")

      assert index_live |> element("a", "New Address") |> render_click() =~
               "New Address"

      assert_patch(index_live, ~p"/addresses/new")

      assert index_live
             |> form("#address-form", address: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#address-form", address: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/addresses")

      html = render(index_live)
      assert html =~ "Address created successfully"
      assert html =~ "some state"
    end

    test "updates address in listing", %{conn: conn, address: address} do
      {:ok, index_live, _html} = live(conn, ~p"/addresses")

      assert index_live |> element("#addresses-#{address.id} a", "Edit") |> render_click() =~
               "Edit Address"

      assert_patch(index_live, ~p"/addresses/#{address}/edit")

      assert index_live
             |> form("#address-form", address: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#address-form", address: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/addresses")

      html = render(index_live)
      assert html =~ "Address updated successfully"
      assert html =~ "some updated state"
    end

    test "deletes address in listing", %{conn: conn, address: address} do
      {:ok, index_live, _html} = live(conn, ~p"/addresses")

      assert index_live |> element("#addresses-#{address.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#addresses-#{address.id}")
    end
  end

  describe "Show" do
    setup [:create_address]

    test "displays address", %{conn: conn, address: address} do
      {:ok, _show_live, html} = live(conn, ~p"/addresses/#{address}")

      assert html =~ "Show Address"
      assert html =~ address.state
    end

    test "updates address within modal", %{conn: conn, address: address} do
      {:ok, show_live, _html} = live(conn, ~p"/addresses/#{address}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Address"

      assert_patch(show_live, ~p"/addresses/#{address}/show/edit")

      assert show_live
             |> form("#address-form", address: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#address-form", address: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/addresses/#{address}")

      html = render(show_live)
      assert html =~ "Address updated successfully"
      assert html =~ "some updated state"
    end
  end
end
