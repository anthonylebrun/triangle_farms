defmodule TriangleFarms.Calendar do
  alias TriangleFarms.Calendar.EventCache

  def list_events_by_month(month, year) do
    EventCache.by_month(month, year)
  end

  def reset_event_cache do
    EventCache.clear
  end
end
