defmodule UnitConverterWeb.ConverterControllerTest do
  use UnitConverterWeb.ConnCase

  test "GET /length", %{conn: conn} do
    conn = get(conn, ~p"/length")
    response = html_response(conn, 200)

    option_values = [
      "mm",
      "cm",
      "m",
      "km",
      "in",
      "ft",
      "yd",
      "mi"
    ]

    Enum.each(option_values, fn val ->
      # Count how many times <option value="val"> appears in the response
      regex = ~r/<option\s+value="#{val}">/i
      count = Regex.scan(regex, response) |> length()
      assert count == 2, "Expected 2 occurrences of <option value=\"#{val}\"> but found #{count}"
    end)
  end

  test "GET / redirects to /length", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert redirected_to(conn) == "/length"
  end
end
