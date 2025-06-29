# test/support/feature_case.ex
defmodule UnitConverterWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use ExUnit.Case, async: true
      use Wallaby.Feature

      import Wallaby.Query
      import Phoenix.VerifiedRoutes

      @endpoint UnitConverterWeb.Endpoint
      @router UnitConverterWeb.Router
    end
  end

  setup _tags do
    {:ok, session} = Wallaby.start_session()
    {:ok, session: session}
  end
end
