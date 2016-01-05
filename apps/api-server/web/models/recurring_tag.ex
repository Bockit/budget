defmodule BudgetApi.RecurringTag do
  use BudgetApi.Web, :model

  @primary_key false

  schema "recurrings_tags" do
    belongs_to :recurring, BudgetApi.Recurring, references: :id
    belongs_to :tag, BudgetApi.Tag, references: :id
  end

  @required_fields ~w(recurring_id tag_id)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
