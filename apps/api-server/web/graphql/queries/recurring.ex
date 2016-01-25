defmodule BudgetApi.GraphQL.Query.Recurring do
  alias BudgetApi.{Repo, Query, GraphQL}
  alias BudgetApi.GraphQL.{Type, Helpers}

  def by_id do
    Helpers.by_id(Type.Recurring.type,
      name: 'Recurring by id',
      description: 'Fetch a recurring transaction by its id.',
      resolve: {GraphQL.Query.Recurring, :by_id_resolve})
  end

  def by_id_resolve(_, %{id: id}, _) do
    with {:ok, recurring} <- Repo.find(id),
     do: {:ok, recurring}
    |> GraphQL.resolve
  end

  def paginated_list do
    Helpers.paginated_list(Type.Recurring.type,
      name: 'Paginated recurrings',
      description: 'Fetch a list of recurrings given an offset and an id.',
      resolve: {GraphQL.Query.Recurring, :paginated_list_resolve})
  end

  def paginated_list_resolve(_, args, _) do
    offset = Map.get(args, :offset, 0)
    limit = Map.get(args, :limit, 10)

    Query.Recurring.base
    |> Repo.paginated(offset, limit)
    |> GraphQL.resolve
  end
end
