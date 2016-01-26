defmodule BudgetApi.Router do
  use BudgetApi.Web, :router
  import Plug.Parsers.GRAPHQL

  pipeline :api do
    plug Plug.Parsers, parsers: [:graphql]
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  scope "/api" do
    pipe_through :api

    forward "/", GraphQL.Plug.Endpoint, schema: {BudgetApi.GraphQL.RootSchema, :schema}
  end
end
