defmodule BudgetApi.GraphQL.RootSchema do
  alias GraphQL.Schema
  alias GraphQL.Type.{ObjectType, List, ID, Int}
  alias BudgetApi.GraphQL.{Query, Mutatation}

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
      # mutation: %ObjectType{
      #   name: "Mutations",
      #   description: "Personal budget api mutations",
      #   fields: %{
      #     createTransaction: Mutation.Transaction.create,
      #     createRecurring: Mutation.Recurring.create,
      #     addTagToTransaction: Mutation.Transaction.add_tag,
      #     addTagToRecurring: Mutation.Transaction.add_tag,
      #   },
      # }
    }
  end
end
