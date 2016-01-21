defmodule BudgetApi.GraphQL.Mutation.Recurring do
  alias BudgetApi.{Repo, Workflows}
  alias BudgetApi.GraphQL.{Mutation, Type, Helpers}
  alias GraphQL.Type.{String, Float}

  def create do
    %{
      type: Type.Recurring.type,
      args: %{
        frequency: %{type: %String{}},
        amount: %{type: %Float{}},
        description: %{type: %String{}},
        tags: Helpers.list(%String{}),
      },
      resolve: {Mutation.Recurring, :resolve_create},
    }
  end

  def resolve_create(_, args, _) do
    %{amount: amount, frequency: frequency, description: description} = args
    tags = args.tags || []

    transaction_result = Repo.transaction(fn() ->
      result = Workflows.Recurring.create_recurring_with_tags(
        amount, frequency, description, tags
      )

      case result do
        {:ok, recurring} -> recurring
        {:error, error} -> Repo.rollback(error)
      end
    end)

    case transaction_result do
      {:ok, recurring} -> recurring
      {:error, _error} -> nil
    end
  end

  # def add_tag do
  #   %{
  #     type: Type.Recurring.type,
  #     args: %{
  #       id: %{type: %ID{}},
  #       tag: %{type: %String{}},
  #     },
  #     resolve: {Mutation.Recurring, :add_tag_resolve}
  #   }
  # end

  # def add_tag_resolve(_, args, _) do

  # end
end
