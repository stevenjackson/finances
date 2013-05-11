Sequel.migration do
  change do
    create_table? :account_balances do
        primary_key :id
        FixNum :account_id
        FixNum :balance
        Time   :date
    end
  end
end
