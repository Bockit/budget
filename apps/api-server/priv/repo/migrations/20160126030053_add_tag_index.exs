defmodule BudgetApi.Repo.Migrations.AddTagIndexAndUnique do
  use Ecto.Migration

  def change do
    create index(:tags, [:tag], unique: true)
  end
end
