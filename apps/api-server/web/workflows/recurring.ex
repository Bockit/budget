defmodule BudgetApi.Workflow.Recurring do
  alias BudgetApi.{Repo, Workflow, Query}
  alias BudgetApi.{Recurring, RecurringTag}

  def create(amount, frequency, description) do
    Recurring.changeset(%Recurring{}, %{
      amount: amount,
      frequency: frequency,
      description: description
    })
    |> Repo.insert
  end

  def create_recurring_tag(recurring_id, tag_id) do
    RecurringTag.changeset(%RecurringTag{}, %{
      tag_id: tag_id,
      recurring_id: recurring_id,
    })
    |> Repo.insert
  end

  def create_recurring_with_tags(amount, frequency, description, tags) do
    with {:ok, tags} <- Workflow.Tag.ensure_tags(tags),
         {:ok, recurring} <- create(amount, frequency, description),
         {:ok, _recurring_tags} <- attach_tags(recurring.id, tags),
         recurring <- Map.put(recurring, :tags, tags),
     do: {:ok, recurring}
  end

  def attach_tags(recurring_id, tags), do: do_attach_tags(recurring_id, tags, [])

  defp do_attach_tags(_, [], attached), do: {:ok, attached}
  defp do_attach_tags(recurring_id, [next|rest], attached) do
    with {:ok, recurring_tag} <- create_recurring_tag(recurring_id, next.id),
         {:ok, attached} <- do_attach_tags(recurring_id, rest, [recurring_tag|attached]),
     do: {:ok, attached}
  end

  def add_tags(recurring_id, tags) do
    with {:ok, tags} <- Workflow.Tag.ensure_tags(tags),
         filtered_tags <- unattached_tags(recurring_id, tags),
         {:ok, attached} <- attach_tags(recurring_id, filtered_tags),
     do: {:ok, attached}
  end

  defp unattached_tags(recurring_id, tags) do
    tag_ids = Enum.map(tags, &(&1.id))

    connections = Query.RecurringTag.base
    |> Query.RecurringTag.for_recurring_and_tags(recurring_id, tag_ids)
    |> Repo.all

    attached_ids = Enum.map(connections, &(&1.tag_id))
    Enum.filter(tags, &(!(&1.id in attached_ids)))
  end

  def update(recurring_id, changes) do
    with {:ok, recurring} <- Repo.find(Recurring, recurring_id),
         changeset = Ecto.Changeset.change(recurring, changes),
         {:ok, recurring} <- Repo.update(changeset),
     do: {:ok, recurring}
  end
end
