defmodule TriangleFarmsWeb.PageController do
  use TriangleFarmsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
