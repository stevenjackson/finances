Sequel.migration do
  change do
    alter_table :debits do
      add_column :date_applied, :time, :default => Time.new
    end
    alter_table :credits do
      add_column :date_applied, :time, :default => Time.new
    end
  end
end
