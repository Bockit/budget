defmodule Workflows do
  def transaction(function) do
    Repo.transaction(fn() ->
      case function.() do
        {:ok, recurring} -> recurring
        {:error, error} -> Repo.rollback(error)
      end
    end)
  end

  def graphql_resolving_transaction(function) do
    case transaction(function) do
      {:ok, resolution} -> resolution
      {:error, _error} -> nil
    end
  end
end
