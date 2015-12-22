# BudgetApi

To start your Phoenix app:

  1. Install dependencies with `mix deps.get`
  2. Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  3. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix


```Elixir
%GraphQL.Schema{
  mutation: nil,
  query: %GraphQL.ObjectType{
    description: "The root query",
    fields: %{
      recurring: %{
        resolve: #Function<1.90974583/3 in BudgetApi.GraphQL.Schema.Root.schema/0>,
        type: %GraphQL.List{
          of_type: %GraphQL.ObjectType{
            description: "A recurring payment made or received.",
            fields: %{
              amount: %{type: "Float"}, 
              description: %{type: "String"},
              frequency: %{type: "String"}, 
              id: %{type: "Int"}
            },
            name: "Recurring"
          }
        }
      },
      tag: %{
        resolve: #Function<0.90974583/3 in BudgetApi.GraphQL.Schema.Root.schema/0>,
        type: %GraphQL.List{
          of_type: %GraphQL.ObjectType{
            description: "A payment classification.",
            fields: %{
              id: %{type: "Int"}, 
              tag: %{type: "String"}
            }, 
            name: "Tag"
          }
        }
      },
      transaction: %{
        resolve: #Function<2.90974583/3 in BudgetApi.GraphQL.Schema.Root.schema/0>,
        type: %GraphQL.List{
          of_type: %GraphQL.ObjectType{
            description: "A payment made or received.",
            fields: %{
              amount: %{type: "Float"}, 
              audited: %{type: "Boolean"},
              description: %{type: "String"}, 
              id: %{type: "Int"},
              timestamp: %{type: "String"}
            }, 
            name: "Transaction"
          }
        }
      }
    },
    name: "RootQueryType"
  }
}
```