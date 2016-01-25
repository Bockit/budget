defmodule BudgetApi.Workflow.Transaction do
  alias BudgetApi.{Repo, Workflow, Query}
  alias BudgetApi.{Transaction, TransactionTag}

  def create(amount, timestamp, description) do
    Transaction.changeset(%Transaction{}, %{
      amount: amount,
      timestamp: timestamp,
      description: description
    })
    |> Repo.insert
  end

  def create_transaction_tag(transaction_id, tag_id) do
    TransactionTag.changeset(%TransactionTag{}, %{
      tag_id: tag_id,
      transaction_id: transaction_id,
    })
    |> Repo.insert
  end

  def create_transaction_with_tags(amount, timestamp, description, tags) do
    with {:ok, tags} <- Workflow.Tag.ensure_tags(tags),
         {:ok, transaction} <- create(amount, timestamp, description),
         {:ok, _transaction_tags} <- attach_tags(transaction.id, tags),
         transaction <- Map.put(transaction, :tags, tags),
     do: {:ok, transaction}
  end

  def attach_tags(transaction_id, tags), do: do_attach_tags(transaction_id, tags, [])

  defp do_attach_tags(_, [], attached), do: {:ok, attached}
  defp do_attach_tags(transaction_id, [next|rest], attached) do
    with {:ok, transaction_tag} <- create_transaction_tag(transaction_id, next.id),
         {:ok, attached} <- do_attach_tags(transaction_id, rest, [transaction_tag|attached]),
     do: {:ok, attached}
  end

  def add_tags(transaction_id, tags) do
    with {:ok, tags} <- Workflow.Tag.ensure_tags(tags),
         filtered_tags <- unattached_tags(transaction_id, tags),
         {:ok, attached} <- attach_tags(transaction_id, filtered_tags),
     do: {:ok, attached}
  end

  defp unattached_tags(transaction_id, tags) do
    tag_ids = Enum.map(tags, &(&1.id))

    connections = Query.TransactionTag.base
    |> Query.TransactionTag.for_transaction_and_tags(transaction_id, tag_ids)
    |> Repo.all

    attached_ids = Enum.map(connections, &(&1.tag_id))
    Enum.filter(tags, &(!(&1.id in attached_ids)))
  end

  def update(transaction_id, changes) do
    with {:ok, transaction} <- Repo.find(Transaction, transaction_id),
         changeset = Ecto.Changeset.change(transaction, changes),
         {:ok, transaction} <- Repo.update(changeset),
     do: {:ok, transaction}
  end
end
