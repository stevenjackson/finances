Sequel.migration do
  change do
    create_table? :accounts do
        primary_key :id
        String :name
        FixNum :balance
    end
  end
end
