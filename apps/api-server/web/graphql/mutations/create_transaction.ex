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
    result = BudgetApi.Repo.transaction(fn() ->
      build_transaction(args.amount, args.timestamp, args.description, args.tags)
    end)

    case result do
      {:ok, transaction} -> transaction
      {:error, _error} -> nil
    end
  end

  defp build_transaction(amount, timestamp, description, tags) do
    transaction = create_transaction(amount, timestamp, description)
    for tag <- ensure_tags(tags) do
      create_transaction_tag(tag.id, transaction.id)
    end
    transaction
  end

  defp create_transaction(amount, timestamp, description) do
    Transaction.changeset(%Transaction{}, %{
      amount: amount,
      timestamp: timestamp,
      description: description,
      audited: false,
    })
    |> BudgetApi.Repo.insert!
  end

  defp create_tag(tag) do
    Tag.changeset(%Tag{}, %{
      tag: tag
    })
    |> BudgetApi.Repo.insert!
  end

  defp create_transaction_tag(tag_id, transaction_id) do
    TransactionTag.changeset(%TransactionTag{}, %{
      tag_id: tag_id,
      transaction_id: transaction_id,
    })
    |> BudgetApi.Repo.insert!
  end

  defp ensure_tags(tags) do
    current_tags = find_tags(tags)
    current_tags_tags = Enum.map(current_tags, &(&1.tag))

    missing_tags = Enum.filter(tags, &(!(&1 in current_tags_tags)))
    created_tags = for tag <- missing_tags, do: create_tag(tag)

    current_tags ++ created_tags
  end

  defp find_tags(tags) do
    query = from t in Tag,
      where: t.tag in ^tags

    query
    |> BudgetApi.Repo.all
  end
end
