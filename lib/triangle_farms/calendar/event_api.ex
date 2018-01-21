defmodule TriangleFarms.Calendar.EventAPI do
  alias TriangleFarms.Calendar.EventAPI.Client
  alias TriangleFarms.Calendar.{Event, Time}

  def new! do
    {:ok, client} = Client.authorize
    client
  end

  def by_month(client, month, year) do
    {min_time, max_time} = calculate_month_boundaries(month, year)
    opts = %{timeMin: min_time, timeMax: max_time, singleEvents: true}
    Client.list_events(client, opts) |> to_calendar_events
  end

  defp calculate_month_boundaries(month, year) when is_integer(month) and is_integer(year) do
    strfmonth = month |> Integer.to_string |> String.pad_leading(2, "0")
    min = Time.parse("#{year}-#{strfmonth}-01T00:00:00-05:00")
    max = Time.shift(min, months: 1, seconds: -1)
    {Time.format(min), Time.format(max)}
  end

  defp to_calendar_events(items) do
    Enum.map(items, &to_event/1)
  end

  defp to_event(event = %{"summary" => summary, "description" => desc, "location" => loc}) do
    start_at = event |> get_in(["start", "dateTime"]) |> Time.parse
    end_at = event |> get_in(["end", "dateTime"]) |> Time.parse
    %Event{
      name: summary,
      description: desc,
      location: loc,
      start_at: start_at,
      end_at: end_at
    }
  end
end
