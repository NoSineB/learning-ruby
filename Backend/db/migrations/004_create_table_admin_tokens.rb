Sequel.migration do
  up do
    create_table(:tokens) do
      primary_key :token_id
      String :token, null: false  
    end
  end

  down do
    drop_table(:tokens)
  end
end