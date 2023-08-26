class AddTeacherAddressToTeacher < ActiveRecord::Migration[6.1]
  def change
    add_column :teachers, :teacher_address, :string, null: false
  end
end
