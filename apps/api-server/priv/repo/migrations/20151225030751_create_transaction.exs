defmodule BudgetApi.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :timestamp, :datetime
      add :amount, :float
      add :description, :string
      add :audited, :boolean, default: false

      timestamps
    end

  end
end
