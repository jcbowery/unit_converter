defmodule UnitConverterWeb.ConvertLengthTest do
  use UnitConverterWeb.FeatureCase

  @tag :browser
  feature "convert length values", %{session: session} do
    from_dropdown = Query.data("qa", "fromUnit")
    to_dropdown = Query.data("qa", "toUnit")
    value_field = Query.data("qa", "value")

    session
    |> visit(~p"/length")
    |> fill_in(from_dropdown, with: "Millimeter")
    |> fill_in(to_dropdown, with: "Meter")
    |> fill_in(value_field, with: 1000)
    |> click(Query.button("Convert"))
    |> assert_has(Query.css("p", text: "1000.00mm = 1.0m"))
  end
end
