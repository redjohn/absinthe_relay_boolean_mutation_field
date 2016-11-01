defmodule GraphqlLogger do
  require Logger

  @moduledoc """
  A plug that logs information related to graphql requests
  """
  @behaviour Plug

  def init(opts), do: opts

  def call(conn, _) do
    vars = (conn |> Map.get(:body_params) |> Map.get("variables"))
    printable_vars = if vars && String.trim(vars) != "" do
      inspect(Poison.decode!(vars))
    else
      ""
    end
    Logger.info("Variables: #{printable_vars}")
    conn
  end
end

