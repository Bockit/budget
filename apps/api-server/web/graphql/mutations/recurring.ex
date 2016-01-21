defmodule BudgetApi.GraphQL.Mutation.Recurring do
  alias BudgetApi.{Repo, Workflows, Query}
  alias BudgetApi.GraphQL.{Mutation, Type, Helpers}
  alias GraphQL.Type.{String, Float, ID}

  def create do
    %{
      type: Type.Recurring.type,
      args: %{
        frequency: %{type: %String{}},
        amount: %{type: %Float{}},
        description: %{type: %String{}},
        tags: Helpers.list(%String{}),
      },
      resolve: {Mutation.Recurring, :create_resolve},
    }
  end

  def create_resolve(_, args, _) do
    %{amount: amount, frequency: frequency, description: description} = args
    tags = args.tags || []

    Workflows.graphql_resolving_transaction(fn() ->
      Workflows.Recurring.create_recurring_with_tags(amount, frequency, description, tags)
    end)
  end

  def add_tags do
    %{
      type: Type.Recurring.type,
      args: %{
        id: %{type: %ID{}},
        tags: Helpers.list(%String{}),
      },
      resolve: {Mutation.Recurring, :add_tags_resolve}
    }
  end

  def add_tags_resolve(_, %{id: recurring_id, tags: tags}, _) do
    Workflows.graphql_resolving_transaction(fn() ->
      with {:ok, _} <- Workflows.Recurring.add_tags(recurring_id, tags),
       do: {:ok, Query.Recurring.by_id(recurring_id)}
    end)
  end
end
