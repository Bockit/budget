defmodule BudgetApi.Repo do
  use Ecto.Repo, otp_app: :budget_api
  import Ecto.Query

  def paginated(queryable, offset, limit) do
    queryable = from r in queryable,
      offset: ^offset,
      limit: ^limit

    find_all(queryable)
  end

  def find_all(queryable, opts \\ []) do
    allow_empty = Keyword.get(opts, :allow_empty, false)

    case BudgetApi.Repo.all(queryable, opts) do
      [] ->
        if allow_empty do
          {:ok, []}
        else
          {:error, "No results"}
        end
      results -> {:ok, results}
    end
  end

  def find(queryable, id, opts \\ []) do
    case BudgetApi.Repo.get(queryable, id, opts) do
      nil -> {:error, "Not found"}
      result -> {:ok, result}
    end
  end

  def remove_all(queryable, opts \\ []) do
    case BudgetApi.Repo.delete_all(queryable, opts) do
      nil -> {:error, "RETURNING in DELETE not supported in this database"}
      {count, models} -> {:ok, count, models}
    end
  end
end
