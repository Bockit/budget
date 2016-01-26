defmodule BudgetApi.GraphQL do
  use Timex

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

  defmodule Type.DateTime do
    defstruct name: "DateTime", description:
      """
      The `DateTime` scalar type represents a datetime value, specifying a
      year, month, day, hour, minute and second in the UTC timezone. The
      `DateTime` type appears in a json response as a String in
      ISO 8601 format (UTC), and expects ISO 8601 (any timezone) on input.

      Internally, the date value is converted to the erlang tuple of tuples
      format `{{year, month, day}, {hour, minute, second}}`.
      """
  end

  defimpl GraphQL.Types, for: Type.DateTime do
    def parse_value(_, value) do
      IO.inspect(DateFormat.parse!(value, "{ISO}"))
    end

    def serialize(_, value) do
      DateFormat.format!(value, "{ISOz}")
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
