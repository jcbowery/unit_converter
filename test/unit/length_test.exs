defmodule UnitConverter.LengthTest do
  use ExUnit.Case, async: true

  alias UnitConverter.Length

  @moduletag :unit_length

  @test_value 1.0

  @conversions [
    # {:from, :to, expected_result}
    {:m, :mm, 1000.0},
    {:m, :cm, 100.0},
    {:m, :m, 1.0},
    {:m, :km, 0.00},
    {:m, :in, 39.37},
    {:m, :ft, 3.28},
    {:m, :yd, 1.09},
    {:m, :mi, 0.0}
  ]

  describe "convert!/3 with standard inputs" do
    Enum.each(@conversions, fn {from, to, expected} ->
      test "converts #{@test_value} #{from} to #{to} == #{expected}" do
        result = Length.convert!(unquote(from), unquote(to), @test_value)
        assert result == unquote(expected)
      end
    end)

    test "on meter convertion -> 120cm to ft returns 3.94" do
      result = Length.convert!(:cm, :ft, 120)

      assert result == 3.94
    end
  end
end
