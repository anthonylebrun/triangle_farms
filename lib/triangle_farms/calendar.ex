defmodule TriangleFarms.Calendar do
  alias TriangleFarms.Calendar.EventAPI

  def list_events_by_month(month, year) do
    EventAPI.new |> EventAPI.by_month(month, year)
  end
end
