defmodule BudgetApi.GraphQL.Type.Transaction do
  alias GraphQL.Type.{ObjectType, List, ID, String, Float, Boolean}
  alias BudgetApi.{Query, GraphQL, Repo}
  alias BudgetApi.GraphQL.{Type, Helpers}

  def type do
    %ObjectType{
      name: "Transaction",
      description: "A payment made or received.",
      fields: quote do %{
        id: %{type: %ID{}},
        timestamp: %{type: %String{}},
        amount: %{type: %Float{}},
        description: %{type: %String{}},
        audited: %{type: %Boolean{}},
        tags: Helpers.list(Type.Tag.type,
          name: "List of tags",
          description: "List of tags for a transaction",
          resolve: {Type.Transaction, :resolve_tags}),
      } end,
    }
  end

  def resolve_tags(%{id: id}, _, _) do
    Query.Tag.base
    |> Query.Tag.for_transaction(id)
    |> Repo.find_all
    |> GraphQL.resolve
  end
end
