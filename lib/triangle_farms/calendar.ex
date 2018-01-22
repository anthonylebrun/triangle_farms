defmodule TriangleFarms.Calendar do
  alias TriangleFarms.Calendar.EventCache

  def list_events_by_month(month, year) do
    EventCache.by_month(month, year)
  end
end
