defmodule BudgetApi.GraphQL.Transaction do
  import Ecto.Query
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

  def resolve(_, %{id: id}, _) do
    BudgetApi.Repo.get!(BudgetApi.Transacition, id)
    |> serialise
  end

  def resolve_list(_, %{offset: offset, limit: limit}, _) do
    query = from t in BudgetApi.Transacition,
      offset: ^offset,
      limit: ^limit

    query |> BudgetApi.Repo.all |> Enum.map(&serialise/1)
  end
  def resolve_list(_, %{offset: offset}, _), do: resolve_list(%{}, %{offset: offset, limit: 10}, %{})
  def resolve_list(_, %{limit: limit}, _), do: resolve_list(%{}, %{offset: 0, limit: limit}, %{})
  def resolve_list(_, _, _), do: resolve_list(%{}, %{offset: 0, limit: 10}, %{})

  defp serialise(model) do
    Map.take(model, [:id, :timestamp, :amount, :description, :audited])
  end
end