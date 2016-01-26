defmodule BudgetApi.Repo.Migrations.AddTransactionTimestampIndex do
  use Ecto.Migration

  def change do
    create index(:transactions, [:timestamp])
  end
end
