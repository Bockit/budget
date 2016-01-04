defmodule BudgetApi.RecurringTest do
  use BudgetApi.ModelCase

  alias BudgetApi.Recurring

  @valid_attrs %{amount: "120.5", description: "some content", frequency: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Recurring.changeset(%Recurring{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Recurring.changeset(%Recurring{}, @invalid_attrs)
    refute changeset.valid?
  end
end
