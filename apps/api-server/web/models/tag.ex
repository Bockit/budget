defmodule BudgetApi.Tag do
  use BudgetApi.Web, :model

  schema "tags" do
    field :tag, :string

    has_many :recurring, BudgetApi.Recurring
    has_many :transaction, BudgetApi.Transaction

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
