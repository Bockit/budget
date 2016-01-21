defmodule BudgetApi.Workflows.Recurring do
  alias BudgetApi.{Repo, Workflows}
  alias BudgetApi.{Recurring, RecurringTag}

  def create(amount, frequency, description) do
    BudgetApi.Recurring.changeset(%Recurring{}, %{
      amount: amount,
      frequency: frequency,
      description: description
    })
    |> Repo.insert
  end

  def create_recurring_tag(recurring_id, tag_id) do
    BudgetApi.RecurringTag.changeset(%RecurringTag{}, %{
      tag_id: tag_id,
      recurring_id: recurring_id,
    })
    |> Repo.insert
  end

  def create_recurring_with_tags(amount, frequency, description, tags) do
    with {:ok, tags} <- Workflows.Tag.ensure_tags(tags),
         {:ok, recurring} <- create(amount, frequency, description),
         {:ok, _recurring_tags} <- attach_tags(recurring, tags),
         recurring <- Map.put(recurring, :tags, tags),
     do: {:ok, recurring}
  end

  def attach_tags(recurring, tags), do: attach_tags(recurring, tags, [])

  defp attach_tags(_, [], attached), do: {:ok, attached}
  defp attach_tags(recurring, [next|rest], attached) do
    with {:ok, recurring_tag} <- create_recurring_tag(recurring.id, next.id),
         {:ok, attached} <- attach_tags(recurring, rest, [recurring_tag|attached]),
     do: {:ok, attached}
  end
end
