defmodule BudgetApi.GraphQL.Mutation.Recurring do
  import Ecto.Query

  alias BudgetApi.GraphQL.{Mutation, Type}
  alias GraphQL.Type.{String, Float, List, ID}

  def create do
    %{
      type: Type.Recurring.type,
      args: %{
        frequency: %{type: %String{}},
        amount: %{type: %Float{}},
        description: %{type: %String{}},
        tags: %{type: %List{ofType: %String{}}},
      },
      resolve: {Mutation.Recurring, :create_resolve},
    }
  end

  def create_resolve(_, args, _) do
    # result = BudgetApi.Repo.transaction(fn() ->
    #   build_recurring(args.amount, args.frequency, args.description, args.tags)
    # end)

    # case result do
    #   {:ok, recurring} -> recurring
    #   {:error, _error} -> nil
    # end
  end

  def add_tag do
    %{
      type: Type.Recurring.type,
      args: %{
        id: %{type: %ID{}},
        tag: %{type: %String{}},
      },
      resolve: {Mutation.Recurring, :resolve_add_tag}
    }
  end

  def resolve_add_tag(_, args, _) do

  end

  defp build_recurring(amount, frequency, description, tags) do
    recurring = create_recurring(amount, frequency, description)
    for tag <- ensure_tags(tags) do
      create_recurring_tag(tag.id, recurring.id)
    end
    recurring
  end

  defp create_recurring(amount, frequency, description) do
    BudgetApi.Recurring.changeset(%BudgetApi.Recurring{}, %{
      amount: amount,
      frequency: frequency,
      description: description,
    })
    |> BudgetApi.Repo.insert!
  end

  defp create_tag(tag) do
    BudgetApi.Tag.changeset(%BudgetApi.Tag{}, %{
      tag: tag
    })
    |> BudgetApi.Repo.insert!
  end

  defp create_recurring_tag(tag_id, recurring_id) do
    BudgetApi.RecurringTag.changeset(%BudgetApi.RecurringTag{}, %{
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
    query = from t in BudgetApi.Tag,
      where: t.tag in ^tags

    query
    |> BudgetApi.Repo.all
  end
end
