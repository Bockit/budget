defmodule BudgetApi.GraphQL.Type.Tag do
  alias GraphQL.Type.{ObjectType, ID, String}
  alias BudgetApi.{GraphQL, Query, Repo}
  alias BudgetApi.GraphQL.{Type, Helpers}

  def type do
    %ObjectType{
      name: "Tag",
      description: "A payment classification.",
      fields: quote do %{
        id: %{type: %ID{}},
        tag: %{type: %String{}},
        recurrings: Helpers.list(Type.Recurring.type,
          name: "List of recurrings",
          description: "List of recurring transactions for a tag.",
          resolve: {Type.Tag, :resolve_recurrings}),
        transactions: Helpers.list(Type.Transaction.type,
          name: "List of transactions",
          description: "List of transactions for a tag.",
          resolve: {Type.Tag, :resolve_transactions}),
      } end,
    }
  end

  def resolve_recurrings(%{id: id}, _, _) do
    Query.Recurring.base
    |> Query.Recurring.for_tag(id)
    |> Repo.find_all
    |> GraphQL.resolve
  end

  def resolve_transactions(%{id: id}, _, _) do
    Query.Transaction.base
    |> Query.Transaction.for_tag(id)
    |> Repo.find_all
    |> GraphQL.resolve
  end
end
