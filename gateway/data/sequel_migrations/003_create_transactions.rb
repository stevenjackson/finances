Sequel.migration do
  change do
    create_table :transactions do
      primary_key :id
      FixNum :account_id
      String :fit_id
      String :description
      FixNum :amount
      FixNum :amount_in_pennies
      String :nick_name
      Time   :posted_at
      String :type
    end
  end
end
