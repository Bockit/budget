defmodule BudgetApi.Query.Recurring do
  import Ecto.Query

  alias BudgetApi.Recurring

  def base do
    from r in Recurring
  end

  def by_id(id) do
    BudgetApi.Repo.get!(Recurring, id)
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
end
