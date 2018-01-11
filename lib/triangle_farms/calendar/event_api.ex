defmodule TriangleFarms.Calendar.EventAPI do
  alias TriangleFarms.Calendar.EventAPI.Client
  alias TriangleFarms.Calendar.Time

  def new do
    case Client.authorize do
      {:ok, client} ->
        client
      {:error, msg} ->
        # Do error handling
    end
  end

  def by_month(client, month, year) do
    {min_time, max_time} = calculate_month_boundaries(month, year)
    Client.list_events(client, %{timeMin: min_time, timeMax: max_time, singleEvents: true})
  end

  defp calculate_month_boundaries(month, year) when is_integer(month) and is_integer(year) do
    strfmonth = month |> Integer.to_string |> String.pad_leading(2, "0")
    min = Time.parse("#{year}-#{strfmonth}-01T00:00:00-05:00")
    max = Time.shift(min, months: 1, seconds: -1)
    {Time.format(min), Time.format(max)}
  end
end
