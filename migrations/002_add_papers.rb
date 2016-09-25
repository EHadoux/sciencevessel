Sequel.migration do
  change do
    create_table(:papers) do
      primary_key :id
      String :title, :null => false
      String :authors, :null => false
      String :url, :null => true, :default => ""
      Integer :year, :null => false
      String :book, :null => false
      String :tags, :null => true, :default => ""
      foreign_key :ownerid, :users, :on_delete => :set_null, :on_update => :cascade
    end
  end
end