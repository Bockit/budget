defmodule BudgetApi.Transaction do
  use BudgetApi.Web, :model

  schema "transactions" do
    field :timestamp, Timex.Ecto.DateTime
    field :amount, :float, default: 0.0
    field :description, :string
    field :audited, :boolean, default: false

    has_many :transaction_tags, BudgetApi.TransactionTag
    has_many :tags, through: [:transaction_tags, :tag]

    timestamps
  end

  @required_fields ~w(timestamp amount description audited)
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
