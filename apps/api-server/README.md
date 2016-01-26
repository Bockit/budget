Budget API
==========

This is the GraphQL API for the Budget webapp.

Setup
-----

1. If necessary, create a `dev.secret.exs` to overwrite database settings, etc.
E.g.: 
    ```elixir
    use Mix.Config

    # Configure your database
    config :budget_api, BudgetApi.Repo,
      adapter: Ecto.Adapters.Postgres,
      username: "james",
      password: "",
      database: "budget_api_dev",
      hostname: "localhost",
      pool_size: 20
    ```

2. `mix deps.get` to install dependencies.
3. `mix ecto.create` to create the dev database.
4. `mix ecto.migrate` to run the migrations against the dev database.
5. `mix run priv/repo/seeds.exs` to seed the dev database.

Usage
-----

Run the server with `mix phoenix.server`. It should be running on port 4000.

It provides the graphql endpoint `/api`. You can:

**GET**
```
http://127.0.0.1:4000/api?query={tags{tag}}
```

**POST** with the `Content-Type: application/graphql` header and body as follows:
```graphql
query GetTags {
    tags {
        tag
    }
}
```

If you wish to run a mutation:

**POST** with content-type application/graphql and body as follows:
```graphql
mutation CreateRecurring {
    createRecurring(
        amount: 51.2
        description: "My first recurring transaction"
        frequency: "WEEKLY"
        tags: ["Utilities"]
    ) {
        id
    }
}
```

I recommend an addon such as Postman for running GraphQL queries and mutations.

In the future, you will be able to point Graphiql at `/api` and things should "just work".
