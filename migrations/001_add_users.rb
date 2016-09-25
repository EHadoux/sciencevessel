Sequel.migration do
  change do
    create_table(:users) do
      Integer :githubid, :primary_key => true
      String :nickname, :null => false, :unique => true
      String :email, :null => false, :unique => true
      TrueClass :admin, :null => false, :default => false
    end
  end
end