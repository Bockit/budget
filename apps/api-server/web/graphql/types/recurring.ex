defmodule BudgetApi.GraphQL.Type.Recurring do
  alias GraphQL.Type.{ObjectType, ID, String, Float}
  alias BudgetApi.{Query, GraphQL, Repo}
  alias BudgetApi.GraphQL.{Type, Helpers}

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
    |> Repo.find_all(allow_empty: true)
    |> GraphQL.resolve
  end
end
