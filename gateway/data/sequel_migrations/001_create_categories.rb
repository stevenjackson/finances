Sequel.migration do
  change do
    create_table :categories do
        primary_key :id
        String :name
        FixNum :budget
    end
  end
end
