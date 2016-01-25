defmodule BudgetApi.Query.Transaction do
  import Ecto.Query

  alias BudgetApi.Transaction

  def base do
    from r in Transaction
  end

  def for_tag(queryable, tag_id) do
    from t in queryable,
      inner_join: tt in assoc(t, :transaction_tags),
      where: tt.tag_id == ^tag_id
  end
end
