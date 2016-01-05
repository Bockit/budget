defmodule BudgetApi.RecurringTag do
  use BudgetApi.Web, :model

  schema "recurrings_tags" do
    belongs_to :recurring, BudgetApi.Recurring
    belongs_to :tag, BudgetApi.Tag

    has_many :tags, BudgetApi.Tag
    has_many :recurring_tags, through: [:tags, :tag]
  end

  @required_fields ~w(recurring_id tag_id)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end