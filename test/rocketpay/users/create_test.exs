defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase

  alias Rocketpay.User
  alias Rocketpay.Account
  alias Rocketpay.Users.Create

  describe "users.create.call/1" do
    test "when all params are valid, returns an user with an account" do
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

      {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Create.call(params)

      assert(
        %User{
          id: ^user_id,
          name: ^name,
          nickname: ^nickname,
          email: ^email,
          account: %Account{id: ^account_id, balance: ^balance}
        } = user
      )
    end

    test "when there is no password param provided, returns an password can't be blank error" do
      name = "Tairone"
      nickname = "Tai"
      email = "taironelivinalli@hotmail.com"
      age = 25

      params = %{
        name: name,
        nickname: nickname,
        email: email,
        age: age
      }

      {:error, changeset} = Create.call(params)

      expected_error = %{password: ["can't be blank"]}

      assert expected_error == errors_on(changeset)
    end

    test "when there is no nickname param provided, returns an nickname can't be blank error" do
      name = "Tairone"
      password = "123456"
      email = "taironelivinalli@hotmail.com"
      age = 25

      params = %{
        name: name,
        password: password,
        email: email,
        age: age
      }

      {:error, changeset} = Create.call(params)

      expected_error = %{nickname: ["can't be blank"]}

      assert expected_error == errors_on(changeset)
    end

    test "when there is no name param provided, returns an name can't be blank error" do
      nickname = "Tai"
      password = "123456"
      email = "taironelivinalli@hotmail.com"
      age = 25

      params = %{
        nickname: nickname,
        password: password,
        email: email,
        age: age
      }

      {:error, changeset} = Create.call(params)

      expected_error = %{name: ["can't be blank"]}

      assert expected_error == errors_on(changeset)
    end

    test "when there is no email param provided, returns an email can't be blank error" do
      name = "Tairone"
      nickname = "Tai"
      password = "123456"
      age = 25

      params = %{
        nickname: nickname,
        password: password,
        name: name,
        age: age
      }

      {:error, changeset} = Create.call(params)

      expected_error = %{email: ["can't be blank"]}

      assert expected_error == errors_on(changeset)
    end

    test "when there is no age param provided, returns an age can't be blank error" do
      name = "Tairone"
      password = "123456"
      nickname = "Tai"
      email = "taironelivinalli@hotmail.com"

      params = %{
        nickname: nickname,
        password: password,
        email: email,
        name: name
      }

      {:error, changeset} = Create.call(params)

      expected_error = %{age: ["can't be blank"]}

      assert expected_error == errors_on(changeset)
    end

    test "when the age param provided is under 18, returns an age can't be blank error" do
      name = "Tairone"
      password = "123456"
      nickname = "Tai"
      email = "taironelivinalli@hotmail.com"
      age = 15

      params = %{
        nickname: nickname,
        password: password,
        email: email,
        name: name,
        age: age
      }

      {:error, changeset} = Create.call(params)

      expected_error = %{age: ["must be greater than or equal to 18"]}

      assert expected_error == errors_on(changeset)
    end
  end
end
