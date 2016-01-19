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

Sample GraphQL Queries
----------------------

* real create transaction mutation

```graphql
mutation CreateTransaction {
    createTransaction(
        timestamp: "2016-01-18T21:37:30Z"
        amount: 50.0
        description: "That was my grandfather's haunch."
        tags: ["a","b","c"]
    ) {
        amount
        id
        description
        timestamp
        audited
        tags {
            tag
        }
    }
}
```

-----

* real get transaction by id query

```graphql
query TransactionById {
    transaction(id: 21) {
        amount
        id
        description
        timestamp
        audited
        tags {
            tag
        }
    }
}
```

-----

* real create recurring mutation

```graphql
mutation CreateRecurring {
    createRecurring(
        frequency: "WEEKLY"
        amount: 50.0
        description: "That was my grandfather's haunch."
        tags: ["a","b","c"]
    ) {
        amount
        id
        description
        frequency
        tags {
            tag
        }
    }
}
```

-----

* multiple operations body

```graphql
mutation CreateRecurring {
    createRecurring(
        frequency: "WEEKLY"
        amount: 50.0
        description: "That was my grandfather's haunch."
        tags: ["a","b","c"]
    ) {
        amount
        id
        description
        frequency
        tags {
            tag
        }
    }
}

mutation CreateTransaction {
    createTransaction(
        timestamp: "2016-01-18T21:37:30Z"
        amount: 50.0
        description: "That was my grandfather's haunch."
        tags: ["a","b","c"]
    ) {
        amount
        id
        description
        timestamp
        audited
        tags {
            tag
        }
    }
}
```
