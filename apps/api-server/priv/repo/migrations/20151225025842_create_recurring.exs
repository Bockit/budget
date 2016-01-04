defmodule BudgetApi.Repo.Migrations.CreateRecurring do
  use Ecto.Migration

  def change do
    create table(:recurrings) do
      add :frequency, :string
      add :amount, :float
      add :description, :string

      timestamps
    end

  end
end
