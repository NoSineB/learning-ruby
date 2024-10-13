Sequel.migration do
  up do
    create_table(:courses) do
      primary_key :course_id
      String :name, null: false
      String :link, null: false
      String :taught_by, null: false
      String :type, null: false
      Integer :score, null: false
    end
  end

  down do
    drop_table(:courses)
  end
end