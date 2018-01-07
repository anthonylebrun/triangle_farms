defmodule TriangleFarms.Calendar.EventAPI do
  alias TriangleFarms.Calendar.EventAPI.Client

  def new do
    {:ok, client} = Client.authorize
    client
  end

  def by_month(client, month, year) do
    {min_time, max_time} = calculate_month_boundaries(month, year)
    Client.list_events(client, %{timeMin: min_time, timeMax: max_time, singleEvents: true})
  end

  defp calculate_month_boundaries(month, year) when is_integer(month) and is_integer(year) do
    strfmonth = month |> Integer.to_string |> String.pad_leading(2, "0")
    min = Timex.parse!("#{year}-#{strfmonth}-01T00:00:00-05:00", "{RFC3339}")
    max = Timex.shift(min, months: 1, seconds: -1)
    {Timex.format!(min, "{RFC3339}"), Timex.format!(max, "{RFC3339}")}
  end
end
