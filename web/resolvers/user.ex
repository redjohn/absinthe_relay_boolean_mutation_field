defmodule BooleanFields.Resolver.User do
  @user %{id: "1", name: "Test User", admin: true}

  def get(_, _), do: {:ok, @user}

  def create(%{name: name, admin: admin}, _) do
    {:ok, %{user: %{id: "2", name: name, admin: admin}}}
  end
end
