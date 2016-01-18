defmodule BudgetApi.GraphQL.Transaction do
  import Ecto.Query

  alias __MODULE__, as: Transaction
  alias GraphQL.Type.ObjectType
  alias GraphQL.Type.List
  alias GraphQL.Type.ID
  alias GraphQL.Type.String
  alias GraphQL.Type.Float
  alias GraphQL.Type.Boolean
  alias BudgetApi.GraphQL.Tag

  def schema do
    %ObjectType{
      name: "Transaction",
      description: "A payment made or received.",
      fields: quote do %{
        id: %{type: %ID{}},
        timestamp: %{type: %String{}},
        amount: %{type: %Float{}},
        description: %{type: %String{}},
        audited: %{type: %Boolean{}},
        tags: %{
          type: %List{ofType: Tag.schema},
          resolve: {Transaction, :resolve_tags},
        },
      } end,
    }
  end

  def resolve_single(_, %{id: id}, _) do
    BudgetApi.Repo.get!(BudgetApi.Transaction, id)
  end

  def resolve_list(_, %{offset: offset, limit: limit}, _) do
    query = from t in BudgetApi.Transaction,
      offset: ^offset,
      limit: ^limit

    query
    |> BudgetApi.Repo.all
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

  def resolve_tags(%{id: id}, _, _) do
    query = from t in BudgetApi.Tag,
      inner_join: rt in assoc(t, :recurring_tags),
      where: rt.recurring_id == ^id

    query
    |> BudgetApi.Repo.all
  end
end
