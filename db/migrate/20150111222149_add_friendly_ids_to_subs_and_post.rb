class AddFriendlyIdsToSubsAndPost < ActiveRecord::Migration
  def change
    add_column :subs, :slug, :string
    add_column :posts, :slug, :string
  end
end
