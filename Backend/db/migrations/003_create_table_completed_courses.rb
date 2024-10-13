Sequel.migration do
  up do
    create_table(:user_course) do
      foreign_key :user_id, :users
      foreign_key :course_id, :courses
    end
  end

  down do
    drop_table(:user_course)
  end
end