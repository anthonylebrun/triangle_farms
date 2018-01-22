defmodule TriangleFarmsWeb.EventController do
  use TriangleFarmsWeb, :controller

  plug :cast_params

  def index(%{assigns: %{month: month, year: year}} = conn, _) do
    events = TriangleFarms.Calendar.list_events_by_month(month, year)
    render conn, "index.json", events: events
  end

  defp cast_params(conn = %{params: %{"month" => month, "year" => year}}, _) do
    conn = Plug.Conn.assign(conn, :month, String.to_integer(month))
    conn = Plug.Conn.assign(conn, :year, String.to_integer(year))
    conn
  end
end
