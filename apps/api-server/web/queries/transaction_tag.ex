defmodule BudgetApi.Query.TransactionTag do
  import Ecto.Query

  alias BudgetApi.TransactionTag

  def base do
    from tt in TransactionTag
  end

  def by_recurring(query, transaction_id) do
    from tt in query,
      where: rt.transaction_id == ^transaction_id
  end

  def for_tags(query, tag_ids) do
    from tt in query,
      where: rt.tag_id in ^tag_ids
  end

  def for_tag_strings(query, tag_strings) do
    from tt in query,
      inner_join: t in assoc(tt, :tag),
      where: t.tag in ^tag_strings
  end

  def for_recurring_and_tags(query, recurring_id, tag_ids) do
    query
    |> by_recurring(recurring_id)
    |> for_tags(tags_ids)
  end

  def for_recurring_and_tag_strings(query, recurring_id, tag_strings) do
    query
    |> by_recurring(recurring_id)
    |> for_tag_strings(tag_strings)
  end
end
