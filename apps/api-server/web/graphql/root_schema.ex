defmodule BudgetApi.GraphQL.Schema.Root do
  alias GraphQL.Schema
  alias GraphQL.ObjectType
  alias GraphQL.List

  alias BudgetApi.GraphQL.Schema.Tag
  alias BudgetApi.GraphQL.Schema.Recurring
  alias BudgetApi.GraphQL.Schema.Transaction

  def schema do
    %Schema{
      query: %ObjectType{
        name: "RootQueryType",
        description: "The root query",
        fields: %{
          tag: %{
            type: %List{of_type: Tag.schema},
            resolve: &resolve_tags/3
          },
          recurring: %{
            type: %List{of_type: Recurring.schema},
            resolve: &resolve_recurring/3
          },
          transaction: %{
            type: %List{of_type: Transaction.schema},
            resolve: &resolve_transactions/3
          }
        }
      }
    }
  end

  defp resolve_tags(_, %{id: id}, _) do
    %{
      id: id,
      tag: "head off the cnbc headline"
    }
  end
  defp resolve_tags(_, _, _) do
    for id <- 1..3, do: resolve_tags(nil, %{id: id}, nil)
  end

  defp resolve_recurring(_, %{id: id}, _) do
    %{
      id: id,
      amount: 20.10,
      frequency: "daily",
      description: "I did that one!"
    }
  end
  defp resolve_recurring(_, _, _) do
    for id <- 1..4, do: resolve_recurring(nil, %{id: id}, nil)
  end

  defp resolve_transactions(_, %{id: id}, _) do
    %{
      id: id,
      timestamp: "2015-12-22T10:53:00+1100",
      amount: 20.10,
      description: "It's just tres awkward",
      audited: true
    }
  end
  defp resolve_transactions(_, _, _) do
    for id <- 1..8, do: resolve_transactions(nil, %{id: id}, nil)
  end
end