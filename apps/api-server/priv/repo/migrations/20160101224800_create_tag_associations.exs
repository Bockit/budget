defmodule BudgetApi.Repo.Migrations.CreateTagAssociations do
  use Ecto.Migration

  def change do
    create table(:recurrings_tags, primary_key: false) do
      add :tag_id, references(:tags)
      add :recurring_id, references(:recurrings)
    end

    create table(:transactions_tags, primary_key: false) do
      add :tag_id, references(:tags)
      add :transaction_id, references(:transactions)
    end
  end
end
