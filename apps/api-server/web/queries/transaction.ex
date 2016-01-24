defmodule BudgetApi.Query.Recurring do
  import Ecto.Query

  alias BudgetApi.Recurring

  def base do
    from r in Recurring
  end

  def for_tag(queryable, tag_id) do
    from t in queryable,
      inner_join: tt in assoc(r, :transaction_tags),
      where: tt.tag_id == ^tag_id
  end
end
