defmodule BooleanFields.Schema do
  alias BooleanFields.Resolver
  use Absinthe.Schema
  use Absinthe.Relay.Schema

  import_types BooleanFields.Schema.Types

  node interface do
    resolve_type fn
      _, _ -> :user
    end
  end

  query do
    node field do
      resolve fn
        %{type: :user, id: "1"}, ctx -> Resolver.User.get(%{id: "1"}, ctx)
        _, _ -> {:error, "Not found"}
      end
    end

    field :user, :user do
      resolve &Resolver.User.get/2
    end
  end

  mutation do
    payload field :create_user do
      input do
        field :name, non_null(:string)
        field :admin, non_null(:boolean)
      end
      output do
        field :user, :user
      end
      resolve &Resolver.User.create/2
    end

    field :other_create_user, type: :user do
      arg :name, non_null(:string)
      arg :admin, non_null(:boolean)
      resolve fn args, ctx ->
        with {:ok, user} <- Resolver.User.create(args, ctx),
          do: {:ok, user[:user]}
      end
    end
  end
end
