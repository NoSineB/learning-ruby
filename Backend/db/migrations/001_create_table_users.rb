Sequel.migration do
  up do
    create_table(:users) do
      primary_key :user_id
      String :name, null: false
      String :email, null: false
      String :hashed_password, null: false
      Integer :score, null: false, default: 0
    end
  end

  down do
    drop_table(:users)
  end
end