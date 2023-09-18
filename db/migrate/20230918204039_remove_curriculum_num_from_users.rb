class RemoveCurriculumNumFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :curriculum_num, :integer
  end
end
