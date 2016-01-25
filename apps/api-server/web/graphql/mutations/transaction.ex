defmodule BudgetApi.GraphQL.Mutation.Transaction do
  alias BudgetApi.{Repo, Query, Workflow}
  alias BudgetApi.GraphQL.{Mutation, Type, Helpers}
  alias GraphQL.Type.{String, Float, ID}

  def create do
    %{
      type: Type.Transaction.type,
      args: %{
        timestamp: %{type: %String{}},
        amount: %{type: %Float{}},
        description: %{type: %String{}},
        tags: Helpers.list(%String{}),
      },
      resolve: {Mutation.Transaction, :create_resolve},
    }
  end

  def create_resolve(_, args, _) do
    %{amount: amount, frequency: frequency, description: description} = args
    tags = args.tags || []

    Workflows.transaction(fn() ->
      Workflow.Transaction.create_transaction_with_tags(amount, frequency, description, tags)
    end)
    |> BudgetApi.GraphQL.resolve
  end

  def add_tags do
    %{
      type: Type.Transaction.type,
      args: %{
        id: %{type: %ID{}},
        tags: Helpers.list(%String{}),
      },
      resolve: {Mutation.Transaction, :add_tags_resolve}
    }
  end

  def add_tags_resolve(_, %{id: transaction_id, tags: tags}, _) do
    Workflows.transaction(fn() ->
      with {:ok, _} <- Workflow.Transaction.add_tags(transaction_id, tags),
       do: Repo.find(BudgetApi.Transaction, transaction_id)
    end)
    |> BudgetApi.GraphQL.resolve
  end

  def remove_tags do
    %{
      type: Type.Transaction.type,
      args: %{
        id: %{type: %ID{}},
        tags: Helpers.list(%String{}),
      },
      resolve: {Mutation.Transaction, :remove_tags_resolve}
    }
  end

  def remove_tags_resolve(_, %{id: transaction_id, tags: tags}, _) do
    Query.TransactionTag.base
    |> Query.TransactionTag.for_transaction_and_tag_strings(transaction_id, tags)
    |> Repo.delete_all

    Query.Transaction.by_id(transaction_id)
  end
end
