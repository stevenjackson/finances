Sequel.migration do
  change do
    create_table? :credits do
      primary_key :id
      FixNum :transaction_id
      String :category
      FixNum :amount
    end
  end
end
