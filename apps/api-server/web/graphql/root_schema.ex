defmodule BudgetApi.GraphQL.RootSchema do
  alias GraphQL.Schema
  alias GraphQL.Type.ObjectType
  alias BudgetApi.GraphQL.{Query, Mutation}

  def schema do
    %Schema{
      query: %ObjectType{
        name: "Queries",
        description: "Personal budget api Queries",
        fields: %{
          tag: Query.Tag.by_id,
          tags: Query.Tag.paginated_list,
          recurring: Query.Recurring.by_id,
          recurrings: Query.Recurring.paginated_list,
          transaction: Query.Transaction.by_id,
          transactions: Query.Transaction.paginated_list,
        }
      },
      mutation: %ObjectType{
        name: "Mutations",
        description: "Personal budget api mutations",
        fields: %{
          createRecurring: Mutation.Recurring.create,
          updateRecurring: Mutation.Recurring.update,
          deleteRecurring: Mutation.Recurring.delete,
          addTagsToRecurring: Mutation.Recurring.add_tags,
          removeTagsFromRecurring: Mutation.Recurring.remove_tags,

          createTransaction: Mutation.Transaction.create,
          updateTransaction: Mutation.Transaction.update,
          deleteTransaction: Mutation.Transaction.delete,
          addTagsToTransaction: Mutation.Transaction.add_tags,
          removeTagsFromTransaction: Mutation.Transaction.remove_tags,
        },
      }
    }
  end
end
