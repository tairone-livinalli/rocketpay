defmodule RocketpayWeb.AccountsView do
  alias Rocketpay.{Account}

  def render("deposit.json", %{account: %Account{id: account_id, balance: balance}}) do
    %{
      message: "Deposit done successfully.",
      account: %{
        id: account_id,
        balance: balance
      }
    }
  end

  def render("withdraw.json", %{account: %Account{id: account_id, balance: balance}}) do
    %{
      message: "Withdraw done successfully.",
      account: %{
        id: account_id,
        balance: balance
      }
    }
  end
end
