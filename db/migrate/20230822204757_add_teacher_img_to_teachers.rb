class AddTeacherImgToTeachers < ActiveRecord::Migration[6.1]
  def change
    add_column :teachers, :teacher_img, :string, null: false
  end
end
