defmodule BudgetApi.Recurring do
  use BudgetApi.Web, :model

  schema "recurrings" do
    field :frequency, :string
    field :amount, :float, default: 0.0
    field :description, :string

    has_many :tags, BudgetApi.Tag

    timestamps
  end

  @required_fields ~w(frequency amount description)
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
