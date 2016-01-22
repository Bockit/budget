defmodule BudgetApi.Query.Recurring do
  import Ecto.Query

  alias BudgetApi.{Recurring,RecurringTag}

  def base do
    from r in Recurring
  end

  def by_id(id) do
    BudgetApi.Repo.get(Recurring, id)
  end

  def paginated(query, offset, limit) do
    query = from r in query,
      offset: ^offset,
      limit: ^limit

    BudgetApi.Repo.all(query)
  end

  def for_tag(query, tag_id) do
    from r in query,
      inner_join: rt in assoc(r, :recurring_tags),
      where: rt.tag_id == ^tag_id

    BudgetApi.Repo.all(query)
  end

  def relationship_for_recurring_and_tags(recurring_id, tags) do
    query = from rt in RecurringTag,
      where: rt.recurring_id == ^recurring_id,
      inner_join: t in assoc(rt, :tag),
      where: t.tag in ^tags
  end

  def attached_tags(recurring_id, tag_ids) do
    query = from rt in RecurringTag,
      where: rt.recurring_id == ^recurring_id,
      where: rt.tag_id in ^tag_ids

    BudgetApi.Repo.all(query)
  end
end
