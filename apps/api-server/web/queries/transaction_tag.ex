defmodule BudgetApi.Query.TransactionTag do
  import Ecto.Query

  alias BudgetApi.TransactionTag

  def base do
    from tt in TransactionTag
  end

  def by_transaction(query, transaction_id) do
    from tt in query,
      where: tt.transaction_id == ^transaction_id
  end

  def for_tags(query, tag_ids) do
    from tt in query,
      where: tt.tag_id in ^tag_ids
  end

  def for_tag_strings(query, tag_strings) do
    from tt in query,
      inner_join: t in assoc(tt, :tag),
      where: t.tag in ^tag_strings
  end

  def for_transaction_and_tags(query, transaction_id, tag_ids) do
    query
    |> by_transaction(transaction_id)
    |> for_tags(tag_ids)
  end

  def for_transaction_and_tag_strings(query, transaction_id, tag_strings) do
    query
    |> by_transaction(transaction_id)
    |> for_tag_strings(tag_strings)
  end
end
