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
        tags: %{ type: %List{ of_type: Tag.schema } }
      }
    }
  end

  def resolve(_, %{id: id}, _) do
    query = from r in BudgetApi.Recurring,
      where: r.id == ^id,
      preload: :tags

    [recurring] = BudgetApi.Repo.all(query)
    serialise(recurring)
  end

  def resolve_list(_, %{offset: offset, limit: limit}, _) do
    query = from t in BudgetApi.Recurring,
      offset: ^offset,
      limit: ^limit,
      preload: :tags

    query
    |> BudgetApi.Repo.all
    |> Enum.map(&serialise/1)
  end
  def resolve_list(_, %{offset: offset}, _), do: resolve_list(%{}, %{offset: offset, limit: 10}, %{})
  def resolve_list(_, %{limit: limit}, _), do: resolve_list(%{}, %{offset: 0, limit: limit}, %{})
  def resolve_list(_, _, _), do: resolve_list(%{}, %{offset: 0, limit: 10}, %{})

  defp serialise(model) do
    serialised = model
    |> Map.take([:id, :frequency, :amount, :description, :tags])
    |> Map.update!(:tags, &serialise_tags/1)

    serialised
  end

  defp serialise_tags(tags) do
    Enum.map(tags, &serialise_tag/1)
  end

  defp serialise_tag(model) do
    Map.take(model, [:id, :tag])
  end
end
