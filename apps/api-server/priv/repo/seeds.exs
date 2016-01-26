# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs

use Timex

phone_bill = BudgetApi.Repo.insert!(%BudgetApi.Recurring{
  frequency: "MONTHLY",
  amount: 50.0,
  description: "Phone Bill"
})

github = BudgetApi.Repo.insert!(%BudgetApi.Recurring{
  frequency: "MONTHLY",
  amount: 5.0,
  description: "Github"
})

christmas_food = BudgetApi.Repo.insert!(%BudgetApi.Transaction{
  timestamp: Date.from({{2015, 12, 25}, {14, 44, 30}}),
  amount: 24.53,
  description: "Christmas food!"
})

new_game = BudgetApi.Repo.insert!(%BudgetApi.Transaction{
  timestamp: Date.from({{2015, 12, 24}, {3, 30, 22}}),
  amount: 80.0,
  description: "New game"
})

utilities = BudgetApi.Repo.insert!(%BudgetApi.Tag{
  tag: "Utilities"
})

development = BudgetApi.Repo.insert!(%BudgetApi.Tag{
  tag: "Development"
})

recurring_tag = fn (recurring, tag) ->
  BudgetApi.Repo.insert!(%BudgetApi.RecurringTag{
    recurring_id: recurring.id,
    tag_id: tag.id,
  })
end

transaction_tag = fn (transaction, tag) ->
  BudgetApi.Repo.insert!(%BudgetApi.TransactionTag{
    transaction_id: transaction.id,
    tag_id: tag.id,
  })
end

recurring_tag.(phone_bill, utilities)
recurring_tag.(phone_bill, development)
recurring_tag.(github, utilities)
recurring_tag.(github, development)

transaction_tag.(christmas_food, utilities)
transaction_tag.(christmas_food, development)
transaction_tag.(new_game, utilities)
transaction_tag.(new_game, development)
