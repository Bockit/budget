defmodule Workflows do
  alias BudgetApi.Repo

  def transaction(function) do
    Repo.transaction(fn() ->
      case function.() do
        {:ok, result} -> result
        {:error, error} -> Repo.rollback(error)
      end
    end)
  end

  def graphql_resolving_transaction(function) do
    case transaction(function) do
      {:ok, result} -> result
      {:error, _error} -> nil
    end
  end
end
