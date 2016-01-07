defmodule BudgetApi.GraphQL.Tag do
  import Ecto.Query

  alias __MODULE__, as: Tag
  alias GraphQL.ObjectType
  alias GraphQL.List
  alias BudgetApi.GraphQL.Recurring
  alias BudgetApi.GraphQL.Transaction

  def base_schema do
    %ObjectType{
      name: "Tag",
      description: "A payment classification.",
      fields: %{
        id: %{type: "ID"},
        tag: %{type: "String"},
      },
    }
  end

  def schema(0) do
    base_schema
  end
  def schema(depth) do
    Map.put(base_schema, :fields, Map.merge(base_schema.fields, %{
      recurrings: %{
        type: %List{of_type: Recurring.schema(depth - 1)},
        resolve: &Tag.resolve_recurrings/3,
      },
      transactions: %{
        type: %List{of_type: Transaction.schema(depth - 1)},
        resolve: &Tag.resolve_transactions/3,
      },
    }))
  end

  def resolve_single(_, %{id: id}, _) do
    BudgetApi.Tag
    |> BudgetApi.Repo.get!(id)
    |> serialise
  end

  def resolve_list(_, %{offset: offset, limit: limit}, _) do
    query = from t in BudgetApi.Tag,
      offset: ^offset,
      limit: ^limit

    query
    |> BudgetApi.Repo.all
    |> Enum.map(&serialise/1)
  end
  def resolve_list(_, %{offset: offset}, _) do
    resolve_list(%{}, %{offset: offset, limit: 10}, %{})
  end
  def resolve_list(_, %{limit: limit}, _) do
    resolve_list(%{}, %{offset: 0, limit: limit}, %{})
  end
  def resolve_list(_, _, _) do
    resolve_list(%{}, %{offset: 0, limit: 10}, %{})
  end

  def serialise(model) do
    Map.take(model, [:id, :tag])
  end

  defp resolve_recurrings(%{id: id}, _, _) do
    query = from r in BudgetApi.Recurring,
      inner_join: rt in assoc(r, :recurring_tags),
      where: rt.tag_id == ^id

    query
    |> BudgetApi.Repo.all
    |> Enum.map(&Recurring.serialise/1)
  end

  defp resolve_transactions(%{id: id}, _, _) do
    query = from t in BudgetApi.Transaction,
      inner_join: tt in assoc(t, :transaction_tags),
      where: tt.tag_id == ^id

    query
    |> BudgetApi.Repo.all
    |> Enum.map(&Transaction.serialise/1)
  end
end