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
end
