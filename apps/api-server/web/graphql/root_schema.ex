defmodule BudgetApi.GraphQL.RootSchema do
  alias GraphQL.Schema
  alias GraphQL.Type.ObjectType
  alias GraphQL.Type.List
  alias GraphQL.Type.ID
  alias GraphQL.Type.Int
  alias BudgetApi.GraphQL.Tag
  alias BudgetApi.GraphQL.Recurring
  alias BudgetApi.GraphQL.Transaction

  defp list(name, schema, resolve) do
    %{
      type: %List{ofType: schema},
      name: name,
      args: %{
        offset: %{type: %Int{}},
        limit: %{type: %Int{}},
      },
      resolve: resolve,
    }
  end

  defp id(name, schema, resolve) do
    %{
      type: schema,
      name: name,
      args: %{
        id: %{type: %ID{}}
      },
      resolve: resolve,
    }
  end

  def schema do
    %Schema{
      query: %ObjectType{
        name: "Queries",
        description: "Personal budget api Queries",
        fields: %{
          tag: id("Tag", Tag.schema, {Tag, :resolve_single}),
          tags: list("Tags", Tag.schema, {Tag, :resolve_list}),

          recurring: id("Recurring", Recurring.schema, {Recurring, :resolve_single}),
          recurrings: list("Recurrings", Recurring.schema, {Recurring, :resolve_list}),

          transaction: id("Transaction", Transaction.schema, {Transaction, :resolve_single}),
          transactions: list("Transactions", Transaction.schema, {Transaction, :resolve_list}),
        }
      },
      mutation: %ObjectType{
        name: "Mutations",
        description: "Personal budget api mutations",
        fields: %{
          createTransaction: BudgetApi.GraphQL.Mutation.CreateTransaction.schema,
          createRecurring: BudgetApi.GraphQL.Mutation.CreateRecurring.schema,

          # addTagToTransaction: BudgetApi.GraphQL.Mutation.AddTagToTransaction.schema,
          # addTagToRecurring: BudgetApi.GraphQL.Mutation.AddTagToRecurring.schema,
        },
      }
    }
  end

  def resolve(_, %{echo: echo}, _) do
    %{message: echo}
  end
end
