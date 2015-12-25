defmodule BudgetApi.GraphQL.Transaction do
  alias GraphQL.ObjectType

  def schema do
    %ObjectType{
      name: "Transaction",
      description: "A payment made or received.",
      fields: %{
        id: %{ type: "ID" },
        timestamp: %{ type: "String" },
        amount: %{ type: "Float" },
        description: %{ type: "String" },
        audited: %{ type: "Boolean" }
      }
    }
  end

  def resolve(_, %{id: id}, _), do: make_transaction(id)

  def resolve_list(_, %{offset: offset, limit: limit}, _) do
    for id <- offset..offset + limit - 1, do: make_transaction(id)
  end
  def resolve_list(_, %{offset: offset}, _), do: resolve_list(%{}, %{offset: offset, limit: 10}, %{})
  def resolve_list(_, %{limit: limit}, _), do: resolve_list(%{}, %{offset: 0, limit: limit}, %{})
  def resolve_list(_, _, _), do: resolve_list(%{}, %{offset: 0, limit: 10}, %{})

  defp make_transaction(id) do
    %{
      id: id,
      timestamp: "2015-12-25T13:20:00+1100",
      amount: 20.0,
      description: "An individual transaction",
      audited: true
    }
  end
end