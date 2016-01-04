defmodule BudgetApi.TransactionTag do
  use BudgetApi.Web, :model

  schema "transactions_tags" do
    belongs_to :transaction, BudgetApi.Transaction
    belongs_to :tag, BudgetApi.Tag
  end

  @required_fields ~w(transaction_id tag_id)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
