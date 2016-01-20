defmodule BudgetApi.GraphQL.Query.Transaction do
  alias BudgetApi.GraphQL.{Type, Helpers}
  alias BudgetApi.GraphQL.Query, as: GraphQLQuery
  alias BudgetApi.Query

  def by_id do
    Helpers.by_id(Type.Transaction.type,
      name: 'Transaction by id',
      description: 'Fetch a transaction by its id.',
      resolve: {GraphQLQuery.Transaction, :resolve_by_id})
  end

  def paginated_list do
    Helpers.by_id(Type.Transaction.type,
      name: 'Transaction by id',
      description: 'Fetch a transaction by its id.',
      resolve: {GraphQLQuery.Transaction, :resolve_paginated_list})
  end

  def resolve_by_id(_, %{id: id}, _) do
    Query.Transaction.by_id(id)
  end

  def resolve_paginated_list(_, args, _) do
    offset = Map.get(args, :offset, 0)
    limit = Map.get(args, :limit, 10)

    Query.Transaction.base
    |> Query.Transaction.paginated(offset, limit)
  end
end
