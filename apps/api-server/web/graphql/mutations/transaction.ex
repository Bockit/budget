defmodule BudgetApi.GraphQL.Mutation.Transaction do
  import Ecto.Query

  alias BudgetApi.GraphQL.{Mutation, Type}
  alias GraphQL.Type.{String, Float, List, ID}

  def create do
    %{
      type: BudgetApi.GraphQL.Type.Transaction.type,
      args: %{
        timestamp: %{type: %String{}},
        amount: %{type: %Float{}},
        description: %{type: %String{}},
        tags: %{type: %List{ofType: %String{}}},
      },
      resolve: {Mutation.Transaction, :resolve_create},
    }
  end

  def resolve_create(_, args, _) do
    # result = BudgetApi.Repo.transaction(fn() ->
    #   build_transaction(args.amount, args.timestamp, args.description, args.tags)
    # end)

    # case result do
    #   {:ok, transaction} -> transaction
    #   {:error, _error} -> nil
    # end
  end

  def add_tag do
    %{
      type: Type.Transaction.type,
      args: %{
        id: %{type: %ID{}},
        tag: %{type: %String{}},
      },
      resolve: {Mutation.Transaction, :resolve_add_tag}
    }
  end

  def resolve_add_tag(_, args, _) do

  end

  defp build_transaction(amount, timestamp, description, tags) do
    transaction = create_transaction(amount, timestamp, description)
    for tag <- ensure_tags(tags) do
      create_transaction_tag(tag.id, transaction.id)
    end
    transaction
  end

  defp create_transaction(amount, timestamp, description) do
    BudgetApi.Transaction.changeset(%BudgetApi.Transaction{}, %{
      amount: amount,
      timestamp: timestamp,
      description: description,
      audited: false,
    })
    |> BudgetApi.Repo.insert!
  end

  defp create_tag(tag) do
    BudgetApi.Tag.changeset(%BudgetApi.Tag{}, %{
      tag: tag
    })
    |> BudgetApi.Repo.insert!
  end

  defp create_transaction_tag(tag_id, transaction_id) do
    BudgetApi.TransactionTag.changeset(%BudgetApi.TransactionTag{}, %{
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
    query = from t in BudgetApi.Tag,
      where: t.tag in ^tags

    query
    |> BudgetApi.Repo.all
  end
end
