defmodule ElixirCodeChallengeTest do
  use ExUnit.Case

  test "Contiguous ranges should not be combined" do
    input = [
      {{2020, 1, 1}, {2020, 6, 30}},
      {{2020, 7, 1}, {2020, 12, 31}}
    ]

    assert ElixirCodeChallenge.run(input) == input
  end

  test "Duplicate ranges should be collapsed" do
    input = [
      {{2020, 1, 1}, {2020, 6, 30}},
      {{2020, 7, 1}, {2020, 12, 31}},
      {{2020, 1, 1}, {2020, 6, 30}}
    ]

    assert ElixirCodeChallenge.run(input) == [
             {{2020, 1, 1}, {2020, 6, 30}},
             {{2020, 7, 1}, {2020, 12, 31}}
           ]
  end

  test "Overlapping ranges are split up into non overlapping ranges" do
    input = [
      {{2020, 1, 1}, {2020, 12, 31}},
      {{2020, 1, 1}, {2020, 6, 30}}
    ]

    assert ElixirCodeChallenge.run(input) == [
             {{2020, 1, 1}, {2020, 6, 30}},
             {{2020, 7, 1}, {2020, 12, 31}}
           ]
  end

  test "Sort ranges" do
    input = [
      {{2020, 7, 1}, {2020, 12, 31}},
      {{2020, 1, 1}, {2020, 6, 30}}
    ]

    assert ElixirCodeChallenge.run(input) == [
             {{2020, 1, 1}, {2020, 6, 30}},
             {{2020, 7, 1}, {2020, 12, 31}}
           ]
  end

  test "Fill in Gaps" do
    input = [
      {{2020, 1, 1}, {2020, 4, 30}},
      {{2020, 7, 1}, {2020, 12, 31}}
    ]

    assert ElixirCodeChallenge.run(input) == [
             {{2020, 1, 1}, {2020, 4, 30}},
             {{2020, 5, 1}, {2020, 6, 30}},
             {{2020, 7, 1}, {2020, 12, 31}}
           ]
  end
end
