defmodule BudgetApi.Query.Tag do
  import Ecto.Query

  alias BudgetApi.Tag

  def base do
    from r in Tag
  end

  def for_recurring(queryable, recurring_id) do
    from r in queryable,
      inner_join: rt in assoc(r, :recurring_tags),
      where: rt.recurring_id == ^recurring_id
  end

  def for_transaction(queryable, transaction_id) do
    from r in queryable,
      inner_join: tt in assoc(r, :transaction_tags),
      where: tt.transaction_id == ^transaction_id
  end
end
