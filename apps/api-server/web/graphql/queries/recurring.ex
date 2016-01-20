defmodule BudgetApi.GraphQL.Query.Recurring do
  alias BudgetApi.GraphQL.{Type, Helpers}
  alias BudgetApi.GraphQL.Query, as: GraphQLQuery
  alias BudgetApi.Query

  def by_id do
    Helpers.by_id(Type.Recurring.type,
      name: 'Recurring by id',
      description: 'Fetch a recurring transaction by its id.',
      resolve: {GraphQLQuery.Recurring, :resolve_by_id})
  end

  def paginated_list do
    Helpers.paginated_list(Type.Recurring.type,
      name: 'Recurring by id',
      description: 'Fetch a recurring transaction by its id.',
      resolve: {GraphQLQuery.Recurring, :resolve_paginated_list})
  end

  def resolve_by_id(_, %{id: id}, _) do
    Query.Recurring.by_id(id)
  end

  def resolve_paginated_list(_, args, _) do
    offset = Map.get(args, :offset, 0)
    limit = Map.get(args, :limit, 10)

    Query.Recurring.base
    |> Query.Recurring.paginated(offset, limit)
  end
end
