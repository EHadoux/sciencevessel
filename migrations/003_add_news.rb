Sequel.migration do
  change do
    create_table(:news) do
      primary_key :id
      String :title, :null => false
      String :subtitle, :null => true, :default => ""
      String :text, :null => true, :default => ""
      String :url, :null => true, :default => ""
      foreign_key :ownerid, :users, :on_delete => :set_null, :on_update => :cascade
    end
  end
end