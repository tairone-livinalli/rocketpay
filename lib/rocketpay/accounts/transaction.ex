defmodule Rocketpay.Accounts.Transaction do
  alias Ecto.Multi

  alias Rocketpay.Repo
  alias Rocketpay.Accounts.Operation

  def call(%{"origin" => origin_id, "destination" => destination_id, "value" => value}) do
    withdraw_params = build_params(origin_id, value)
    deposit_params = build_params(destination_id, value)

    Multi.new()
    |> Multi.merge(fn _changes -> Operation.call(withdraw_params, :withdraw) end)
    |> Multi.merge(fn _changes -> Operation.call(deposit_params, :deposit) end)
    |> run_transaction()
  end

  defp build_params(id, value), do: %{"id" => id, "value" => value}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} ->
        {:error, reason}

      {:ok, %{deposit: origin_account, withdraw: destination_account}} ->
        {:ok, %{origin_account: origin_account, withdraw: destination_account}}
    end
  end
end
