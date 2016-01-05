defmodule BudgetApi.Tag do
  use BudgetApi.Web, :model

  schema "tags" do
    field :tag, :string

    has_many :recurring_tags, BudgetApi.RecurringTag
    has_many :recurrings, through: [:recurring_tags, :recurring]

    has_many :transaction_tags, BudgetApi.TransactionTag
    has_many :transactions, through: [:transaction_tags, :transaction]

    timestamps
  end

  @required_fields ~w(tag)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
