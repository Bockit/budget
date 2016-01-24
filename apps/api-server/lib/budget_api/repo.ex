defmodule BudgetApi.Repo do
  use Ecto.Repo, otp_app: :budget_api

  def paginated(queryable, offset, limit) do
    queryable = from r in queryable,
      offset: ^offset,
      limit: ^limit

    BudgetApi.Repo.find_all(queryable)
  end

  def find_all(queryable, opts \\ []) do
    case all(queryable, opts) do
      [] -> {:error, "No results"}
      results -> {:ok, results}
    end
  end

  def find_one(queryable, id, opts \\ []) do
    case get(queryable, id, opts) do
      nil -> {:error, "Not found"}
      result -> {:ok, result}
    end
  end

  def remove_all(queryable, opts \\ []) do
    case delete_all(queryable, id, opts \\ []) do
      nil -> {:error, "RETURNING in DELETE not supported in this database"},
      {count, models} -> {:ok, count, models}
    end
  end
end
