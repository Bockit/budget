defmodule BudgetApi.GraphQL.Transaction do
  import Ecto.Query
  alias GraphQL.ObjectType
  alias GraphQL.List
  alias BudgetApi.GraphQL.Tag

  def schema do
    %ObjectType{
      name: "Transaction",
      description: "A payment made or received.",
      fields: %{
        id: %{ type: "ID" },
        timestamp: %{ type: "String" },
        amount: %{ type: "Float" },
        description: %{ type: "String" },
        audited: %{ type: "Boolean" },
        tags: %{
          type: %List{of_type: Tag},
          resolve: &resolve_tags/3
        }
      }
    }
  end

  def resolve(_, %{id: id}, _) do
    BudgetApi.Repo.get!(BudgetApi.Transaction, id)
    |> serialise
  end

  def resolve_list(_, %{offset: offset, limit: limit}, _) do
    query = from t in BudgetApi.Transaction,
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

  defp serialise(model) do
    Map.take(model, [:id, :timestamp, :amount, :description, :audited])
  end

  defp resolve_tags(recurring, _, _) do
    query = from t in BudgetApi.Tag,
      inner_join: rt in assoc(t, :recurring_tags),
      where: rt.recurring_id == ^recurring.id

    query
    |> BudgetApi.Repo.all
    |> Enum.map(&serialise_tag/1)
  end

  defp serialise_tag(model) do
    Map.take(model, [:id, :tag])
  end
end
