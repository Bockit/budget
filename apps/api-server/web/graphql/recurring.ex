defmodule BudgetApi.GraphQL.Recurring do
  alias GraphQL.ObjectType

  def schema do
    %ObjectType{
      name: "Recurring",
      description: "A recurring payment made or received.",
      fields: %{
        id: %{ type: "ID" },
        frequency: %{ type: "String" },
        amount: %{ type: "Float" },
        description: %{ type: "String" }
      }
    }
  end

  def resolve(_, %{id: id}, _), do: make_recurring(id)

  def resolve_list(_, %{offset: offset, limit: limit}, _) do
    for id <- offset..offset + limit - 1, do: make_recurring(id)
  end
  def resolve_list(_, %{offset: offset}, _), do: resolve_list(%{}, %{offset: offset, limit: 10}, %{})
  def resolve_list(_, %{limit: limit}, _), do: resolve_list(%{}, %{offset: 0, limit: limit}, %{})
  def resolve_list(_, _, _), do: resolve_list(%{}, %{offset: 0, limit: 10}, %{})

  defp make_recurring(id) do
    %{
      id: id,
      frequency: "WEEKLY",
      amount: 20.0,
      description: "A recurring transaction"
    }
  end
end