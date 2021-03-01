defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase

  alias Rocketpay.{Account, User}

  describe "AccountsController" do
    setup %{conn: conn} do
      name = "Tairone"
      password = "123456"
      nickname = "Tai"
      email = "taironelivinalli@hotmail.com"
      age = 25

      params = %{
        name: name,
        password: password,
        nickname: nickname,
        email: email,
        age: age
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic cm9ja2V0cGF5OmVsaXhpcg==")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when a valid request is made, should make a deposit", %{
      conn: conn,
      account_id: account_id
    } do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{
               "account" => %{"balance" => "50.00", "id" => ^account_id},
               "message" => "Deposit done successfully."
             } = response
    end

    test "when an invalid value is sent, should return an invalid value error", %{
      conn: conn,
      account_id: account_id
    } do
      params = %{"value" => "invalid value"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid value."}

      assert expected_response == response
    end
  end
end
