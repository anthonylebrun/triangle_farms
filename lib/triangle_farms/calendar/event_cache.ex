defmodule TriangleFarms.Calendar.EventCache do
  alias __MODULE__
  alias TriangleFarms.Calendar.EventAPI

  def by_month(month, year) do
    ConCache.get_or_store(EventCache, "#{month}-#{year}", fn() ->
      EventAPI.new |> EventAPI.by_month(month, year)
    end)
  end

  def clear do
    ConCache.ets(EventCache)
    |> :ets.tab2list
    |> Enum.map(fn ({key, _}) -> key end)
    |> Enum.each(&delete/1)
  end

  def delete(key) do
    ConCache.delete(EventCache, key)
  end
end
