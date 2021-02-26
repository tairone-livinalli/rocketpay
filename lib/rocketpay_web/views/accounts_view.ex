defmodule RocketpayWeb.AccountsView do
  alias Rocketpay.{Account}
  alias Rocketpay.Accounts.Transactions.Response, as: TransactionResponse

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

  def render("transaction.json", %{
        transaction: %TransactionResponse{
          origin_account: %Account{id: origin_id, balance: origin_balance},
          destination_account: %Account{id: destination_id, balance: destination_balance}
        }
      }) do
    %{
      message: "Transaction done successfully.",
      transaction: %{
        origin_account: %{
          id: origin_id,
          balance: origin_balance
        },
        destination_account: %{
          id: destination_id,
          balance: destination_balance
        }
      }
    }
  end
end
