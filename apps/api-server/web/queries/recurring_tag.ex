defmodule BudgetApi.Query.Recurring do
  import Ecto.Query

  alias BudgetApi.RecurringTag

  def base do
    from rt in RecurringTag
  end

  def by_recurring(query, recurring_id) do
    from rt in query,
      where: rt.recurring_id == ^recurring_id,
  end

  def for_tags(query, tag_ids) do
    from rt in query,
      where: rt.tag_id in ^tag_ids,
  end

  def for_tag_strings(query, tags) do
    from rt in query,
      inner_join: t in assoc(rt, :tag),
      where: t.tag in ^tags
  end

  def for_recurring_and_tags(query, recurring_id, tag_ids) do
    query
    |> by_recurring(recurring_id)
    |> for_tags(tags_ids)
  end

  def for_recurring_and_tag_strings(query, recurring_id, tags) do
    query
    |> by_recurring(recurring_id)
    |> for_tag_strings(tags)
  end

end
