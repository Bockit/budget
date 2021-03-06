defmodule BudgetApi.Query.Recurring do
  import Ecto.Query

  alias BudgetApi.Recurring

  def base do
    from r in Recurring
  end

  def for_tag(queryable, tag_id) do
    from r in queryable,
      inner_join: rt in assoc(r, :recurring_tags),
      where: rt.tag_id == ^tag_id
  end
end
