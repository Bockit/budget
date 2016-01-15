defmodule BudgetApi.GraphQL.Mutation.CreateTransaction do
  import Ecto.Query

  alias __MODULE__, as: CreateTransaction
  alias GraphQL.Type.String
  alias GraphQL.Type.Float
  alias GraphQL.Type.List
  alias BudgetApi.GraphQL.Transaction

  def schema do
    %{
      type: Transaction.schema,
      args: %{
        timestamp: %{type: %String{}},
        amount: %{type: %Float{}},
        description: %{type: %String{}},
        tags: %{type: %List{of_type: %String{}}}
      },
      resolve: {CreateTransaction, :resolve},
    }
  end

  def resolve(_, args, _) do
    IO.inspect(args.timestamp)
    IO.inspect(args.amount)
    IO.inspect(args.description)
    IO.inspect("tags", args.tags)

    %{
      id: 11,
      timestamp: "2016-01-15T23:12:30Z",
      amount: 50.0,
      description: "Lorem ipsum dolor sit amert",
      audited: true,
      tags: []
    }
  end
end
