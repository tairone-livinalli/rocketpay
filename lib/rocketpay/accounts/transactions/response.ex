defmodule Rocketpay.Accounts.Transactions.Response do
  alias Rocketpay.Account

  defstruct [:origin_account, :destination_account]

  def build(%Account{} = origin_account, %Account{} = destination_account) do
    %__MODULE__{
      origin_account: origin_account,
      destination_account: destination_account
    }
  end
end
