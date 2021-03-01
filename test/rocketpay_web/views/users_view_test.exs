defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase

  import Phoenix.View

  alias Rocketpay.{Account, User}
  alias RocketpayWeb.UsersView

  test "renders create.json" do
    name = "Tairone"
    password = "123456"
    nickname = "Tai"
    email = "taironelivinalli@hotmail.com"
    age = 25
    {:ok, balance} = Decimal.cast("0.00")

    params = %{
      name: name,
      password: password,
      nickname: nickname,
      email: email,
      age: age
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} =
      Rocketpay.create_user(params)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created",
             user: %{
               account: %{balance: ^balance, id: ^account_id},
               email: ^email,
               id: ^user_id,
               name: ^name,
               nickname: ^nickname
             }
           } = response
  end
end
