defmodule BudgetApi.GraphQL.Schema.Tag do
  alias GraphQL.ObjectType

  def schema do
    %ObjectType{
      name: "Tag",
      description: "A payment classification.",
      fields: %{
        id: %{ type: "Int" },
        tag: %{ type: "String" }
      }
    }
  end
end