defmodule AvalieTech.Appraisal do
  @moduledoc """
  The Appraisal context.
  """

  import Ecto.Query, warn: false
  alias AvalieTech.Repo

  alias AvalieTech.Appraisal.{Property, AppraisalReport, Address}

  @doc """
  Returns the list of properties.

  ## Examples

      iex> list_properties()
      [%Property{}, ...]

  """
  def list_properties do
    Repo.all(Property)
  end

  @doc """
  Gets a single property.

  Raises `Ecto.NoResultsError` if the Property does not exist.

  ## Examples

      iex> get_property!(123)
      %Property{}

      iex> get_property!(456)
      ** (Ecto.NoResultsError)

  """
  def get_property!(id), do: Repo.get!(Property, id)

  @doc """
  Creates a property.

  ## Examples

      iex> create_property(%{field: value})
      {:ok, %Property{}}

      iex> create_property(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_property(attrs \\ %{}) do
    %Property{}
    |> Property.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a property.

  ## Examples

      iex> update_property(property, %{field: new_value})
      {:ok, %Property{}}

      iex> update_property(property, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_property(%Property{} = property, attrs) do
    property
    |> Property.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a property.

  ## Examples

      iex> delete_property(property)
      {:ok, %Property{}}

      iex> delete_property(property)
      {:error, %Ecto.Changeset{}}

  """
  def delete_property(%Property{} = property) do
    Repo.delete(property)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking property changes.

  ## Examples

      iex> change_property(property)
      %Ecto.Changeset{data: %Property{}}

  """
  def change_property(%Property{} = property, attrs \\ %{}) do
    Property.changeset(property, attrs)
  end

  @doc """
  Returns the list of addresses.

  ## Examples

      iex> list_addresses()
      [%Address{}, ...]

  """
  def list_addresses do
    Repo.all(Address)
  end

  @doc """
  Gets a single address.

  Raises `Ecto.NoResultsError` if the Address does not exist.

  ## Examples

      iex> get_address!(123)
      %Address{}

      iex> get_address!(456)
      ** (Ecto.NoResultsError)

  """
  def get_address!(id), do: Repo.get!(Address, id)

  @doc """
  Creates a address.

  ## Examples

      iex> create_address(%{field: value})
      {:ok, %Address{}}

      iex> create_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_address(attrs \\ %{}) do
    %Address{}
    |> Address.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a address.

  ## Examples

      iex> update_address(address, %{field: new_value})
      {:ok, %Address{}}

      iex> update_address(address, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_address(%Address{} = address, attrs) do
    address
    |> Address.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a address.

  ## Examples

      iex> delete_address(address)
      {:ok, %Address{}}

      iex> delete_address(address)
      {:error, %Ecto.Changeset{}}

  """
  def delete_address(%Address{} = address) do
    Repo.delete(address)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking address changes.

  ## Examples

      iex> change_address(address)
      %Ecto.Changeset{data: %Address{}}

  """
  def change_address(%Address{} = address, attrs \\ %{}) do
    Address.changeset(address, attrs)
  end

  @doc """
  Lista todos os relatórios de avaliação.
  """
  def list_appraisal_reports do
    Repo.all(AppraisalReport)
    |> Repo.preload([:user, :property])
  end

  @doc """
  Obtém um único relatório de avaliação.

  Falha se o relatório não for encontrado.
  """
  def get_appraisal_report!(id),
    do: Repo.get!(AppraisalReport, id) |> Repo.preload([:user, :property])

  @doc """
  Cria um relatório de avaliação.
  """
  def create_appraisal_report(attrs \\ %{}) do
    %AppraisalReport{}
    |> AppraisalReport.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Atualiza um relatório de avaliação.
  """
  def update_appraisal_report(%AppraisalReport{} = appraisal_report, attrs) do
    appraisal_report
    |> AppraisalReport.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deleta um relatório de avaliação.
  """
  def delete_appraisal_report(%AppraisalReport{} = appraisal_report) do
    Repo.delete(appraisal_report)
  end

  @doc """
  Retorna um changeset para o relatório de avaliação.
  """
  def change_appraisal_report(%AppraisalReport{} = appraisal_report) do
    AppraisalReport.changeset(appraisal_report, %{})
  end

  # def create_property_with_report(attrs \\ %{}) do
  #   Multi.new()
  #   |> Multi.insert(:property, Property.changeset(%Property{}, attrs))
  #   |> Multi.run(:appraisal_report, fn repo, %{property: property} ->
  #     report_attrs = %{
  #       user_id: attrs[:user_id],
  #       property_id: property.id,
  #       requester: attrs[:requester] || "Default Requester",
  #       request_date: attrs[:request_date] || Date.utc_today()
  #     }

  #     AppraisalReport.changeset(%AppraisalReport{}, report_attrs)
  #     |> repo.insert()
  #   end)
  #   |> Repo.transaction()
  # end
end
