defmodule BooleanFields.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation

  node object :user do
    field :id, :id
    field :name, :string
    field :admin, :boolean
  end
end
