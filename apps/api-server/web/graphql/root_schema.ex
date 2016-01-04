defmodule BudgetApi.GraphQL.RootSchema do
  alias GraphQL.Schema
  alias GraphQL.ObjectType
  alias GraphQL.List

  alias BudgetApi.GraphQL.Tag
  alias BudgetApi.GraphQL.Recurring
  alias BudgetApi.GraphQL.Transaction

  defp list(name, schema, resolve) do
    %{
      type: %List{of_type: schema},
      name: name,
      args: %{
        offset: %{type: "Int"},
        limit: %{type: "Int"}
      },
      resolve: resolve
    }
  end

  defp id(name, schema, resolve) do
    %{
      type: schema,
      name: name,
      args: %{
        id: %{type: "ID"}
      },
      resolve: resolve
    }
  end

  def schema do
    %Schema{
      query: %ObjectType{
        name: "RootQueryType",
        description: "The root query",
        fields: %{
          tag: id("Tag", Tag.schema, &Tag.resolve/3),
          tags: list("Tags", Tag.schema, &Tag.resolve_list/3),

          recurring: id("Recurring", Recurring.schema, &Recurring.resolve/3),
          recurrings: list("Recurrings", Recurring.schema, &Recurring.resolve_list/3),

          transaction: id("Transaction", Transaction.schema, &Transaction.resolve/3),
          transactions: list("Transactions", Transaction.schema, &Transaction.resolve_list/3)
        }
      }
    }
  end
end