defmodule BudgetApi.GraphQL.Tag do
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

  def resolve(_, %{id: id}, _), do: make_tag(id)

  def resolve_list(_, %{offset: offset, limit: limit}, _) do
    for id <- offset..offset + limit - 1, do: make_tag("#{id}")
  end
  def resolve_list(_, %{offset: offset}, _), do: resolve_list(%{}, %{offset: offset, limit: 10}, %{})
  def resolve_list(_, %{limit: limit}, _), do: resolve_list(%{}, %{offset: 0, limit: limit}, %{})
  def resolve_list(_, _, _), do: resolve_list(%{}, %{offset: 0, limit: 10}, %{})

  defp make_tag(id) do
    %{
      id: id,
      tag: "Lorem ipsum"
    }
  end
end