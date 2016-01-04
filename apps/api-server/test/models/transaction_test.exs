defmodule BudgetApi.TransactionTest do
  use BudgetApi.ModelCase

  alias BudgetApi.Transaction

  @valid_attrs %{amount: "120.5", audited: true, description: "some content", timestamp: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Transaction.changeset(%Transaction{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Transaction.changeset(%Transaction{}, @invalid_attrs)
    refute changeset.valid?
  end
end
