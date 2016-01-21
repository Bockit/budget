defmodule BudgetApi.Workflows.Tag do
  import Ecto.Query

  alias BudgetApi.{Repo, Workflows}
  alias BudgetApi.Tag

  def create(tag) do
    BudgetApi.Tag.changeset(%BudgetApi.Tag{}, %{
      tag: tag
    })
    |> Repo.insert
  end

  def ensure_tags(tags) do
    current = find_tags(tags)
    current_tags = Enum.map(current, &(&1.tag))

    missing = Enum.filter(tags, &(!(&1 in current_tags)))

    with {:ok, created} <- create_tags(missing),
     do: {:ok, current ++ created}
  end

  def create_tags(tags), do: create_tags(tags, [])

  defp create_tags([], created), do: {:ok, created}
  defp create_tags([next|rest], created) do
    with {:ok, tag}     <- create(next),
         {:ok, created} <- create_tags(rest, [tag|created]),
     do: {:ok, created}
  end

  defp find_tags(tags) do
    query = from t in Tag,
      where: t.tag in ^tags

    Repo.all(query)
  end
end
