defmodule BudgetApi.GraphQL.Schema.Recurring do
  alias GraphQL.ObjectType

  def schema do
    %ObjectType{
      name: "Recurring",
      description: "A recurring payment made or received.",
      fields: %{
        id: %{ type: "Int" },
        amount: %{ type: "Float" },
        frequency: %{ type: "String" },
        description: %{ type: "String" }
      }
    }
  end
end