# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BudgetApi.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

BudgetApi.Repo.insert!(%BudgetApi.Recurring{
  frequency: "MONTHLY",
  amount: 50.0,
  description: "Phone Bill"
})

BudgetApi.Repo.insert!(%BudgetApi.Recurring{
  frequency: "MONTHLY",
  amount: 5.0,
  description: "Github"
})

BudgetApi.Repo.insert!(%BudgetApi.Tag{
  tag: "Utilities"
})

BudgetApi.Repo.insert!(%BudgetApi.Tag{
  tag: "Development"
})

{ :ok, timestamp } = Ecto.DateTime.cast({{2015, 12, 25}, {14, 44, 30}})
BudgetApi.Repo.insert!(%BudgetApi.Transaction{
  timestamp: timestamp,
  amount: 24.53,
  description: "Christmas food!"
})

{ :ok, timestamp } = Ecto.DateTime.cast({{2015, 12, 24}, {3, 30, 22}})
BudgetApi.Repo.insert!(%BudgetApi.Transaction{
  timestamp: timestamp,
  amount: 80.0,
  description: "New game"
})
