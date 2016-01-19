defmodule BudgetApi.GraphQL.Mutation.CreateRecurring do
  import Ecto.Query

  alias __MODULE__, as: CreateRecurring
  alias GraphQL.Type.String
  alias GraphQL.Type.Float
  alias GraphQL.Type.List
  alias BudgetApi.Tag
  alias BudgetApi.Recurring
  alias BudgetApi.RecurringTag

  def schema do
    %{
      type: BudgetApi.GraphQL.Recurring.schema,
      args: %{
        frequency: %{type: %String{}},
        amount: %{type: %Float{}},
        description: %{type: %String{}},
        tags: %{type: %List{ofType: %String{}}},
      },
      resolve: {CreateRecurring, :resolve},
    }
  end

  def resolve(_, args, _) do
    result = BudgetApi.Repo.transaction(fn() ->
      build_recurring(args.amount, args.frequency, args.description, args.tags)
    end)

    case result do
      {:ok, recurring} -> recurring
      {:error, _error} -> nil
    end
  end

  defp build_recurring(amount, frequency, description, tags) do
    recurring = create_recurring(amount, frequency, description)
    for tag <- ensure_tags(tags) do
      create_recurring_tag(tag.id, recurring.id)
    end
    recurring
  end

  defp create_recurring(amount, frequency, description) do
    Recurring.changeset(%Recurring{}, %{
      amount: amount,
      frequency: frequency,
      description: description,
    })
    |> BudgetApi.Repo.insert!
  end

  defp create_tag(tag) do
    Tag.changeset(%Tag{}, %{
      tag: tag
    })
    |> BudgetApi.Repo.insert!
  end

  defp create_recurring_tag(tag_id, recurring_id) do
    RecurringTag.changeset(%RecurringTag{}, %{
      tag_id: tag_id,
      recurring_id: recurring_id,
    })
    |> BudgetApi.Repo.insert!
  end

  defp ensure_tags(tags) do
    current_tags = find_tags(tags)
    current_tags_tags = Enum.map(current_tags, &(&1.tag))

    missing_tags = Enum.filter(tags, &(!(&1 in current_tags_tags)))
    created_tags = for tag <- missing_tags, do: create_tag(tag)

    current_tags ++ created_tags
  end

  defp find_tags(tags) do
    query = from t in Tag,
      where: t.tag in ^tags

    query
    |> BudgetApi.Repo.all
  end
end
