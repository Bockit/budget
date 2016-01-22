defmodule BudgetApi.Query.Transaction do
  import Ecto.Query

  alias BudgetApi.Transaction

  def base do
    from r in Transaction
  end

  def by_id(id) do
    BudgetApi.Repo.get(Transaction, id)
  end

  def paginated(query, offset, limit) do
    query = from t in query,
      offset: ^offset,
      limit: ^limit

    BudgetApi.Repo.all(query)
  end

  def for_tag(query, tag_id) do
    from t in query,
      inner_join: tt in assoc(t, :transaction_tags),
      where: tt.tag_id == ^tag_id

    BudgetApi.Repo.all(query)
  end
end
