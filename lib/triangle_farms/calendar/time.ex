defmodule TriangleFarms.Calendar.Time do
  @format "{RFC3339}"

  defdelegate now, to: Timex
  defdelegate shift(t, opts), to: Timex
  defdelegate to_unix(t), to: Timex

  def parse(to_parse, format \\ @format) do
    Timex.parse!(to_parse, format)
  end

  def format(to_format, format \\ @format) do
    Timex.format!(to_format, format)
  end
end
