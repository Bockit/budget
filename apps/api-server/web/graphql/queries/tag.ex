defmodule BudgetApi.GraphQL.Query.Tag do
  alias BudgetApi.{Repo, Query, GraphQL}
  alias BudgetApi.GraphQL.{Type, Helpers}

  def by_id do
    Helpers.by_id(Type.Tag.type,
      name: 'Tag by id',
      description: 'Fetch a tag by its id.',
      resolve: {GraphQL.Query.Tag, :by_id_resolve})
  end

  def by_id_resolve(_, %{id: id}, _) do
    with {:ok, tag} <- Repo.find(id),
     do: {:ok, tag}
    |> GraphQL.resolve
  end

  def paginated_list do
    Helpers.paginated_list(Type.Tag.type,
      name: 'Paginated tags',
      description: 'Fetch a list of tags given an offset and an id.',
      resolve: {GraphQL.Query.Tag, :paginated_list_resolve})
  end

  def paginated_list_resolve(_, args, _) do
    offset = Map.get(args, :offset, 0)
    limit = Map.get(args, :limit, 10)

    Query.Tag.base
    |> Repo.paginated(offset, limit)
    |> GraphQL.resolve
  end
end
