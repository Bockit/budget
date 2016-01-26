defmodule BudgetApi.GraphQL.Mutation.Recurring do
  alias GraphQL.Type.{String, Float, ID}
  alias BudgetApi.{Repo, Query, Workflow}
  alias BudgetApi.GraphQL.{Mutation, Type, Helpers}

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
    tags = Map.get(args, :tags, [])

    Workflows.transaction(fn() ->
      Workflow.Recurring.create_recurring_with_tags(amount, frequency, description, tags)
    end)
    |> BudgetApi.GraphQL.resolve
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
    Workflows.transaction(fn() ->
      with {:ok, _} <- Workflow.Recurring.add_tags(recurring_id, tags),
       do: Repo.find(BudgetApi.Recurring, recurring_id)
    end)
    |> BudgetApi.GraphQL.resolve
  end

  def remove_tags do
    %{
      type: Type.Recurring.type,
      args: %{
        id: %{type: %ID{}},
        tags: Helpers.list(%String{}),
      },
      resolve: {Mutation.Recurring, :remove_tags_resolve}
    }
  end

  def remove_tags_resolve(_, %{id: recurring_id, tags: tags}, _) do
    Query.RecurringTag.base
    |> Query.RecurringTag.for_recurring_and_tag_strings(recurring_id, tags)
    |> Repo.delete_all

    Repo.find(BudgetApi.Recurring, recurring_id)
    |> BudgetApi.GraphQL.resolve
  end

  def delete do
    %{
      type: Type.Recurring.type,
      args: %{
        id: %{type: %ID{}},
      },
      resolve: {Mutation.Recurring, :delete_resolve}
    }
  end

  def delete_resolve(_, %{id: recurring_id}, _) do
    Repo.remove(BudgetApi.Recurring, recurring_id)
    |> BudgetApi.GraphQL.resolve
  end

  def update do
    %{
      type: Type.Recurring.type,
      args: %{
        id: %{type: %ID{}},
        frequency: %{type: %String{}},
        amount: %{type: %Float{}},
        description: %{type: %String{}},
      },
      resolve: {Mutation.Recurring, :update_resolve}
    }
  end

  def update_resolve(_, %{id: recurring_id} = args, _) do
    changes = Map.take(args, [:frequency, :amount, :description])
    Workflows.transaction(fn() ->
      Workflow.Recurring.update(recurring_id, changes)
    end)
    |> BudgetApi.GraphQL.resolve
  end
end
