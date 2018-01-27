defmodule TriangleFarmsWeb.LayoutView do
  use TriangleFarmsWeb, :view

  def ga_tracking_id do
    Application.get_env(:triangle_farms, :ga_tracking_id)
  end
end
