class ChangeToCommenter < ActiveRecord::Migration
  def change
    remove_column :comments, :author_id
    add_column :comments, :commenter_id, :integer, null: false
  end
end
