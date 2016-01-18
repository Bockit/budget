defmodule BudgetApi.GraphQL.Mutation.CreateTransaction do
  import Ecto.Query

  alias __MODULE__, as: CreateTransaction
  alias GraphQL.Type.String
  alias GraphQL.Type.Float
  alias GraphQL.Type.List
  alias BudgetApi.Tag
  alias BudgetApi.Transaction
  alias BudgetApi.TransactionTag

  def schema do
    %{
      type: BudgetApi.GraphQL.Transaction.schema,
      args: %{
        timestamp: %{type: %String{}},
        amount: %{type: %Float{}},
        description: %{type: %String{}},
        tags: %{type: %List{ofType: %String{}}},
      },
      resolve: {CreateTransaction, :resolve},
    }
  end

  def resolve(_, args, _) do
    transaction = create_transaction(args.amount, args.timestamp, args.description)
    create_tag_relations(args.tags, transaction)
    transaction
  end

  defp create_transaction(amount, timestamp, description) do
    changeset = Transaction.changeset(%Transaction{}, %{
      amount: amount,
      timestamp: timestamp,
      description: description,
      audited: false,
    })
    BudgetApi.Repo.insert!(changeset)
  end

  defp create_tag_relations(tags, transaction) do
    tags
    |> ensure_tags
    |> create_transaction_tags(transaction.id)
  end

  defp ensure_tags(tags) do
    query = from t in Tag,
      where: t.tag in tags

    found = query
    |> BudgetApi.Repo.all
    |> Enum.map(&(&1.tag))

    needed = tags
    |> Enum.filter(&(&1 in found))

    # Bulk insert
  end

  defp create_transaction_tags(tags, transaction_id) do
    # changeset = TransactionTag.changeset(%TransactionTag{}, %{
    #   tag_id: tag_id,
    #   transaction_id: transaction_id,
    # })
    # BudgetApi.Repo.insert!(changeset)

    # Bulk insert
  end
end
