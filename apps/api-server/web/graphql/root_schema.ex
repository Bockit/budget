defmodule BudgetApi.GraphQL.RootSchema do
  alias GraphQL.Schema
  alias GraphQL.ObjectType
  alias GraphQL.List

  alias BudgetApi.GraphQL.Tag
  alias BudgetApi.GraphQL.Recurring
  alias BudgetApi.GraphQL.Transaction

  @list_args %{
    offset: %{type: "Int"},
    limit: %{type: "Int"}
  }

  @id_args %{
    id: %{type: "ID"}
  }

  def schema do
    %Schema{
      query: %ObjectType{
        name: "RootQueryType",
        description: "The root query",
        fields: %{
          tag: %{
            type: Tag.schema,
            args: @id_args,
            resolve: &Tag.resolve/3
          },
          tags: %{
            type: %List{of_type: Tag.schema},
            args: @list_args,
            resolve: &Tag.resolve_list/3
          },

          recurring: %{
            type: Recurring.schema,
            args: @id_args,
            resolve: &Recurring.resolve/3
          },
          recurrings: %{
            type: %List{of_type: Recurring.schema},
            args: @list_args,
            resolve: &Recurring.resolve_list/3
          },

          transaction: %{
            type: %List{of_type: Transaction.schema},
            args: @id_args,
            resolve: &Transaction.resolve/3
          },
          transactions: %{
            type: %List{of_type: Transaction.schema},
            args: @list_args,
            resolve: &Transaction.resolve_list/3
          }
        }
      }
    }
  end
end