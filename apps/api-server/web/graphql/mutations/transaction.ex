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
    %{amount: amount, timestamp: timestamp, description: description} = args
    tags = args.tags || []

    Workflows.transaction(fn() ->
      Workflow.Transaction.create_transaction_with_tags(amount, timestamp, description, tags)
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

    Repo.find(BudgetApi.Transaction, transaction_id)
    |> BudgetApi.GraphQL.resolve
  end

  def delete do
    %{
      type: Type.Transaction.type,
      args: %{
        id: %{type: %ID{}},
      },
      resolve: {Mutation.Transaction, :delete_resolve}
    }
  end

  def delete_resolve(_, %{id: transaction_id}, _) do
    Repo.remove(BudgetApi.Transaction, transaction_id)
    |> BudgetApi.GraphQL.resolve
  end

  def update do
    %{
      type: Type.Transaction.type,
      args: %{
        id: %{type: %ID{}},
        frequency: %{type: %String{}},
        amount: %{type: %Float{}},
        description: %{type: %String{}},
      },
      resolve: {Mutation.Transaction, :update_resolve}
    }
  end

  def update_resolve(_, %{id: transaction_id} = args, _) do
    changes = Map.take(args, [:timestamp, :amount, :description, :audited])
    Workflows.transaction(fn() ->
      Workflow.Transaction.update(transaction_id, changes)
    end)
    |> BudgetApi.GraphQL.resolve
  end
end
