defmodule BudgetApi.Repo do
  use Ecto.Repo, otp_app: :budget_api

  def paginated(query, offset, limit) do
    query = from r in query,
      offset: ^offset,
      limit: ^limit

    BudgetApi.Repo.all(query)
  end
end
