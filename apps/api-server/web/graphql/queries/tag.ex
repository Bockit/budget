defmodule BudgetApi.GraphQL.Query.Tag do
  alias BudgetApi.GraphQL.{Type, Helpers}
  alias BudgetApi.GraphQL.Query, as: GraphQLQuery
  alias BudgetApi.Query

  def by_id do
    Helpers.by_id(Type.Tag.type,
      name: 'Tag by id',
      description: 'Fetch a tag by its id.',
      resolve: {GraphQLQuery.Tag, :resolve_by_id})
  end

  def paginated_list do
    Helpers.by_id(Type.Tag.type,
      name: 'Tag by id',
      description: 'Fetch a tag by its id.',
      resolve: {GraphQLQuery.Tag, :resolve_paginated_list})
  end

  def resolve_by_id(_, %{id: id}, _) do
    with {:ok, tag} <- Query.Tag.by_id(id),
     do: tag
  end

  def resolve_paginated_list(_, args, _) do
    offset = Map.get(args, :offset, 0)
    limit = Map.get(args, :limit, 10)

    Query.Tag.base
    |> Query.Tag.paginated(offset, limit)
  end
end
