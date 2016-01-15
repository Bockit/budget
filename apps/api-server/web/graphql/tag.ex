defmodule BudgetApi.GraphQL.Tag do
  import Ecto.Query

  alias __MODULE__, as: Tag
  alias GraphQL.Type.ObjectType
  alias GraphQL.Type.List
  alias GraphQL.Type.ID
  alias GraphQL.Type.String
  alias BudgetApi.GraphQL.Recurring
  alias BudgetApi.GraphQL.Transaction

  def schema do
    %ObjectType{
      name: "Tag",
      description: "A payment classification.",
      fields: quote do %{
        id: %{type: %ID{}},
        tag: %{type: %String{}},
        recurrings: %{
          type: %List{of_type: Recurring.schema},
          resolve: {Tag, :resolve_recurrings},
        },
        transactions: %{
          type: %List{of_type: Transaction.schema},
          resolve: {Tag, :resolve_transactions},
        },
      } end,
    }
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

  def resolve_recurrings(%{id: id}, _, _) do
    query = from r in BudgetApi.Recurring,
      inner_join: rt in assoc(r, :recurring_tags),
      where: rt.tag_id == ^id

    query
    |> BudgetApi.Repo.all
    |> Enum.map(&Recurring.serialise/1)
  end

  def resolve_transactions(%{id: id}, _, _) do
    query = from t in BudgetApi.Transaction,
      inner_join: tt in assoc(t, :transaction_tags),
      where: tt.tag_id == ^id

    query
    |> BudgetApi.Repo.all
    |> Enum.map(&Transaction.serialise/1)
  end
end
