Sequel.migration do
  change do
    create_table :debits do
      primary_key :id
      FixNum :transaction_id
      String :category
      FixNum :amount
    end
  end
end
