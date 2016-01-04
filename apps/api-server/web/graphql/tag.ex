defmodule BudgetApi.GraphQL.Tag do
  import Ecto.Query
  alias GraphQL.ObjectType

  def schema do
    %ObjectType{
      name: "Tag",
      description: "A payment classification.",
      fields: %{
        id: %{ type: "ID" },
        tag: %{ type: "String" }
      }
    }
  end

  def resolve(_, %{id: id}, _) do
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
  def resolve_list(_, %{offset: offset}, _), do: resolve_list(%{}, %{offset: offset, limit: 10}, %{})
  def resolve_list(_, %{limit: limit}, _), do: resolve_list(%{}, %{offset: 0, limit: limit}, %{})
  def resolve_list(_, _, _), do: resolve_list(%{}, %{offset: 0, limit: 10}, %{})

  defp serialise(model) do
    Map.take(model, [:id, :tag])
  end
end