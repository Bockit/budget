defmodule BudgetApi.Query.Tag do
  import Ecto.Query

  alias BudgetApi.Tag

  def base do
    from r in Tag
  end

  def by_id(id) do
    BudgetApi.Repo.get(Tag, id)
  end

  def paginated(query, offset, limit) do
    query = from t in query,
      offset: ^offset,
      limit: ^limit

    BudgetApi.Repo.all(query)
  end

  def for_recurring(query, recurring_id) do
    from r in query,
      inner_join: rt in assoc(r, :recurring_tags),
      where: rt.recurring_id == ^recurring_id

    BudgetApi.Repo.all(query)
  end

  def for_transaction(query, transaction_id) do
    from r in query,
      inner_join: tt in assoc(r, :transaction_tags),
      where: tt.transaction_id == ^transaction_id

    BudgetApi.Repo.all(query)
  end
end
