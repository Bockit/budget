defmodule BudgetApi.GraphQL do
  defmodule Helpers do
    alias GraphQL.Type.{ID, Int, List}

    def by_id(type, metadata \\ []) do
      definition = %{
        type: type,
        args: %{
          id: %{type: %ID{}}
        },
      }
      merge(definition, metadata)
    end

    def list(type, metadata \\ []) do
      definition = %{
        type: %List{ofType: type},
      }
      merge(definition, metadata)
    end

    def paginated_list(type, metadata \\ []) do
      definition = %{
        type: %List{ofType: type},
        args: %{
          offset: %{type: %Int{}},
          limit: %{type: %Int{}},
        },
      }
      merge(definition, metadata)
    end

    defp merge(definition, metadata) do
      metadata_keys = [:name, :description, :resolve]
      to_merge = Keyword.take(metadata, metadata_keys) |> Enum.into(%{})
      Map.merge(definition, to_merge)
    end
  end

  def resolve(result) do
    case result do
      {:ok, resolution} -> resolution
      # Not sure what to do with this for now
      {:error, error} -> raise error
    end
  end
end
