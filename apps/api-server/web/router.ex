defmodule BudgetApi.Router do
  use BudgetApi.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  scope "/api" do
    pipe_through :api

    forward "/", GraphQL.Plug.Endpoint, schema: {BudgetApi.GraphQL.Schema.Root, :schema}
  end
end
