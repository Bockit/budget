defmodule BudgetApi.Query.RecurringTag do
  import Ecto.Query

  alias BudgetApi.RecurringTag

  def base do
    from rt in RecurringTag
  end

  def by_recurring(query, recurring_id) do
    from rt in query,
      where: rt.recurring_id == ^recurring_id
  end

  def for_tags(query, tag_ids) do
    from rt in query,
      where: rt.tag_id in ^tag_ids
  end

  def for_tag_strings(query, tag_strings) do
    from rt in query,
      inner_join: t in assoc(rt, :tag),
      where: t.tag in ^tag_strings
  end

  def for_recurring_and_tags(query, recurring_id, tag_ids) do
    query
    |> by_recurring(recurring_id)
    |> for_tags(tag_ids)
  end

  def for_recurring_and_tag_strings(query, recurring_id, tag_strings) do
    query
    |> by_recurring(recurring_id)
    |> for_tag_strings(tag_strings)
  end
end
