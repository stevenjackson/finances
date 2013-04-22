Sequel.migration do
  change do
    create_table :transactions do
      primary_key :id
      String :description
      FixNum :amount
    end
  end
end
