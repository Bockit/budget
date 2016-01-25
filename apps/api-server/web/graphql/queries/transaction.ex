defmodule BudgetApi.GraphQL.Query.Transaction do
  alias BudgetApi.{GraphQL, Repo, Query}
  alias BudgetApi.GraphQL.{Type, Helpers}

  def by_id do
    Helpers.by_id(Type.Transaction.type,
      name: 'Transaction by id',
      description: 'Fetch a transaction by its id.',
      resolve: {GraphQL.Query.Transaction, :by_id_resolve})
  end

  def by_id_resolve(_, %{id: id}, _) do
    with {:ok, transaction} <- Repo.find(BudgetApi.Transaction, id),
     do: {:ok, transaction}
    |> GraphQL.resolve
  end

  def paginated_list do
    Helpers.by_id(Type.Transaction.type,
      name: 'Paginated transactions',
      description: 'Fetch a list of transactions given an offset and an id.',
      resolve: {GraphQL.Query.Transaction, :paginated_list_resolve})
  end

  def paginated_list_resolve(_, args, _) do
    offset = Map.get(args, :offset, 0)
    limit = Map.get(args, :limit, 10)

    Query.Transaction.base
    |> Repo.paginated(offset, limit)
    |> GraphQL.resolve
  end
end
