defmodule BooleanFields.PageController do
  use BooleanFields.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
