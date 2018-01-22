defmodule TriangleFarms.Calendar.EventCache do
  alias __MODULE__
  alias TriangleFarms.Calendar.EventAPI

  def by_month(month, year) do
    ConCache.get_or_store(EventCache, "#{month}-#{year}", fn ->
      EventAPI.new! |> EventAPI.by_month(month, year)
    end)
  end

  def clear do
    EventCache |> ConCache.ets |> :ets.tab2list |> delete_keys
  end

  def delete(key) do
    ConCache.delete(EventCache, key)
  end

  defp delete_keys(cache_values) do
    for {key, _} <- cache_values, do: delete(key)
  end
end
