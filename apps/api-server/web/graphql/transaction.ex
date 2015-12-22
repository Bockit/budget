defmodule BudgetApi.GraphQL.Schema.Transaction do
  alias GraphQL.ObjectType

  def schema do
    %ObjectType{
      name: "Transaction",
      description: "A payment made or received.",
      fields: %{
        id: %{ type: "Int" },
        timestamp: %{ type: "String" },
        amount: %{ type: "Float" },
        description: %{ type: "String" },
        audited: %{ type: "Boolean" }
      }
    }
  end
end