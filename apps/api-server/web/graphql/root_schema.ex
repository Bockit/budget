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

  @schema_depth 5
  def schema do
    tag = Tag.schema(@schema_depth)
    recurring = Recurring.schema(@schema_depth)
    transaction = Transaction.schema(@schema_depth)

    %Schema{
      query: %ObjectType{
        name: "RootQueryType",
        description: "The root query",
        fields: %{
          tag: id("Tag", tag, &Tag.resolve_single/3),
          tags: list("Tags", tag, &Tag.resolve_list/3),

          recurring: id("Recurring", recurring, &Recurring.resolve_single/3),
          recurrings: list("Recurrings", recurring, &Recurring.resolve_list/3),

          transaction: id("Transaction", transaction, &Transaction.resolve_single/3),
          transactions: list("Transactions", transaction, &Transaction.resolve_list/3)
        }
      }
    }
  end
end