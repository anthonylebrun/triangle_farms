defmodule TriangleFarmsWeb.EventView do
  use TriangleFarmsWeb, :view

  def render("index.json", %{events: events}) do
    %{events: events}
  end
end
