defmodule BooleanFields.UserResolverTest do
  use BooleanFields.ConnCase

  test "relay style mutation works with boolean" do
    query = """
      mutation TestCreateUser($input: CreateUserInput!) {
        createUser(input: $input) {
          user {
            id
            name
            admin
          }
        }
      }
    """
    variables = %{
      "input" => %{
        "client_mutation_id" => "0",
        "name" => "a new user",
        "admin" => true,
      }
    }

    conn = build_conn
    conn = post conn, "/graphql", %{query: query, variables: variables}
    response = json_response(conn, 200)
    assert %{
      "data" => %{
        "createUser" => %{
          "user" => %{
            "id" => _,
            "name" => _,
            "admin" => true,
          },
        },
      },
    } = response

    vars = variables |> Map.get("input") |> Map.put("admin", false)
    conn = post conn, "/graphql", %{query: query, variables: Map.put(variables, "input", vars)}
    response = json_response(conn, 200)
    assert %{
      "data" => %{
        "createUser" => %{
          "user" => %{
            "id" => _,
            "name" => _,
            "admin" => false,
          },
        },
      },
    } = response
  end

  test "non relay style mutation works with boolean" do
    query = """
      mutation TestCreateUser($admin: Boolean!, $name: String!) {
        otherCreateUser(admin: $admin, name: $name) {
          id
          name
          admin
        }
      }
    """
    variables = %{
      "name" => "a new user",
      "admin" => true,
    }

    conn = build_conn
    conn = post conn, "/graphql", %{query: query, variables: variables}
    response = json_response(conn, 200)
    assert %{
      "data" => %{
        "otherCreateUser" => %{
          "id" => _,
          "name" => _,
          "admin" => true,
        },
      },
    } = response

    vars = variables |> Map.put("admin", false)
    conn = post conn, "/graphql", %{query: query, variables: vars}
    response = json_response(conn, 200)
    assert %{
      "data" => %{
        "otherCreateUser" => %{
          "id" => _,
          "name" => _,
          "admin" => false,
        },
      },
    } = response
  end
end
