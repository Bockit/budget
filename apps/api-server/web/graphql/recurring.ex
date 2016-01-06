defmodule BudgetApi.GraphQL.Recurring do
  import Ecto.Query
  alias GraphQL.ObjectType
  alias GraphQL.List
  alias BudgetApi.GraphQL.Tag

  def schema do
    %ObjectType{
      name: "Recurring",
      description: "A recurring payment made or received.",
      fields: %{
        id: %{ type: "ID" },
        frequency: %{ type: "String" },
        amount: %{ type: "Float" },
        description: %{ type: "String" },
        tags: %{
          type: %List{ of_type: Tag.schema },
          resolve: &resolve_tags/3
        }
      }
    }
  end

  def resolve(_, %{id: id}, _) do
    BudgetApi.Repo.get!(BudgetApi.Recurring, id)
    |> serialise
  end

  def resolve_list(_, %{offset: offset, limit: limit}, _) do
    query = from t in BudgetApi.Recurring,
      offset: ^offset,
      limit: ^limit

    query
    |> BudgetApi.Repo.all
    |> Enum.map(&serialise/1)
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

  def serialise(model) do
    Map.take(model, [:id, :frequency, :amount, :description])
  end

  defp resolve_tags(%{id: id}, _, _) do
    query = from t in BudgetApi.Tag,
      inner_join: rt in assoc(t, :recurring_tags),
      where: rt.recurring_id == ^id

    query
    |> BudgetApi.Repo.all
    |> Enum.map(&BudgetApi.GraphQL.Tag.serialise/1)
  end
end
