defmodule BudgetApi.GraphQL.Type.Recurring do
  alias BudgetApi.Query
  alias BudgetApi.GraphQL.{Type, Helpers}
  alias GraphQL.Type.{ObjectType, List, ID, String, Float}

  def type do
    %ObjectType{
      name: "Recurring",
      description: "A recurring payment made or received.",
      fields: quote do %{
        id: %{type: %ID{}},
        frequency: %{type: %String{}},
        amount: %{type: %Float{}},
        description: %{type: %String{}},
        tags: Helpers.list(Type.Tag.type,
          name: "List of tags",
          description: "List of tags for a recurring transaction",
          resolve: {Type.Recurring, :resolve_tags}),
      } end,
    }
  end

  def resolve_tags(%{id: id}, _, _) do
    Query.Tag.base
    |> Query.Tag.for_recurring(id)
  end
end
