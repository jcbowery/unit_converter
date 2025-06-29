defmodule UnitConverterWeb.ConverterController do
  use UnitConverterWeb, :controller

  alias UnitConverter.Length

  def home(conn, _params) do
    redirect(conn, to: ~p"/length")
  end

  def length(conn, _params) do
    render(conn, :length, [])
  end

  def result(conn, %{"from_unit" => from_unit, "to_unit" => to_unit, "length" => length}) do
    from_unit = String.to_atom(from_unit)
    to_unit = String.to_atom(to_unit)
    {length, _} = Float.parse(length)
    to_value = Length.convert!(from_unit, to_unit, length)
    from_value_str = :io_lib.format("~.2f", [length]) |> to_string()

    params = %{
      fromValue: from_value_str,
      fromUnit: from_unit,
      toUnit: to_unit,
      toValue: to_value
    }

    render(conn, :result, params)
  end
end
