defmodule BudgetApi.GraphQL.Type.Tag do
  alias BudgetApi.Query
  alias BudgetApi.GraphQL.{Type, Helpers}
  alias GraphQL.Type.{ObjectType, List, ID, String}

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
  end

  def resolve_transactions(%{id: id}, _, _) do
    Query.Transaction.base
    |> Query.Transaction.for_tag(id)
  end
end
