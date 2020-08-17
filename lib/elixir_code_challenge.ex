defmodule ElixirCodeChallenge do
  @moduledoc """
  Given a list of date ranges, return a list of all possible non overlapping intervals covering the same range as the input
  an interval is represented as a tuple
  {start_date, end_date}
  where each element is an erlang date tuple
  {Year, Month, Day}
  Year - Unabbreviated calendar year as an integer
  Month - 1..12
  Day - 1..31
  """

  def run(input) do
    # initial sort
    input
    |> Enum.sort(& &1 < &2)

    # remove any duplicates
    |> Enum.dedup()

    # reduce (reversing order) to fix overlaps
    |> Enum.reduce([], &fix_overlaps/2)

    # reduce again (reversing order) to fill gaps
    |> Enum.reduce([], &fill_gaps/2)
  end

  defp fix_overlaps(elem, []), do: [ elem ]

  defp fix_overlaps(elem, acc) do
    # grab current and last ranges
    {this_start, this_end} = elem
    {last_start, last_end} = List.first(acc)

    # first overlap condition: starts match
    # second overlap condition: last end overlaps this start
    this_start = if last_start == this_start or last_end >= this_start do
      # whichever condition is met, the fix is the same
      {:ok, last_end_date} = Date.from_erl(last_end)
      Date.to_erl(Date.add(last_end_date, 1))
    else
      this_start
    end

    # add to front of accumulator
    [ {this_start, this_end} | acc]
  end

  defp fill_gaps(elem, []), do: [ elem ]

  defp fill_gaps(elem, acc) do
    # grab current and last ranges
    {this_start, this_end} = elem
    {last_start, _} = List.first(acc)

    # determine whether gap exists
    {:ok, last_start_date} = Date.from_erl(last_start)
    {:ok, this_end_date} = Date.from_erl(this_end)

    gap_size = Date.diff(last_start_date, this_end_date)

    # fill gap as needed
    acc = if gap_size > 1 do
      fill_start = Date.to_erl(Date.add(this_end_date, 1))
      fill_end = Date.to_erl(Date.add(last_start_date, -1))
      [ {fill_start, fill_end} | acc ]
    else
      acc
    end

    # add to front of accumulator
    [ {this_start, this_end} | acc]
  end
end
