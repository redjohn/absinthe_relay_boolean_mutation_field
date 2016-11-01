defmodule BooleanFields.Resolver.User do
  require Logger

  @user %{id: "1", name: "Test User", admin: true}

  def get(_, _), do: {:ok, @user}

  def create(%{name: name, admin: admin} = args, _) do
    Logger.info "args for create: #{inspect(args)}"
    {:ok, %{user: %{id: "2", name: name, admin: admin}}}
  end

  def create(args, _) do
    Logger.info "args for create: #{inspect(args)}"
    {:error, "Name and admin are required to create a user"}
  end
end
