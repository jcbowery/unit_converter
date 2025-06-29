defmodule UnitConverter.Length do
  @conversion_chart %{
    # Metric (in meters)
    mm: 0.001,
    cm: 0.01,
    m: 1,
    km: 1000,

    # Imperial (in meters)
    in: 0.0254,
    ft: 0.3048,
    yd: 0.9144,
    mi: 1609.34
  }

  @spec convert!(atom, atom, number) :: number
  def convert!(from_unit, to_unit, value) do
    task =
      Task.async(fn ->
        from_factor = Map.fetch!(@conversion_chart, from_unit)
        to_factor = Map.fetch!(@conversion_chart, to_unit)

        value_in_meters = value * from_factor

        (value_in_meters / to_factor)
        |> Float.round(2)
      end)

    case Task.await(task, 3000) do
      converted_value ->
        converted_value
    end
  end
end
